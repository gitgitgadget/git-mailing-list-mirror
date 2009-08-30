From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Sun, 30 Aug 2009 05:55:09 -0400
Message-ID: <20090830095509.GB30922@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
 <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 11:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhh8D-0003fK-5e
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZH3JzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 05:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZH3JzL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:55:11 -0400
Received: from peff.net ([208.65.91.99]:48447 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbZH3JzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 05:55:11 -0400
Received: (qmail 16775 invoked by uid 107); 30 Aug 2009 09:55:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 05:55:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 05:55:09 -0400
Content-Disposition: inline
In-Reply-To: <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127405>

On Sat, Aug 29, 2009 at 03:34:45PM -0700, Junio C Hamano wrote:

> I am slightly in favor of leaving the things as they are, as the error
> message is quite clear.

Hmm. Thinking about it a bit more, I think "add as empty content" is
probably the best. It scares me a little because it is losing
information during the stash, but consider it from the user's
perspective.

Their work-in-progress is being interrupted, so they need to stash. They
try "git stash" and the current version comes back with an error. Now
what? If they know what to do, they can manually "git rm --cached" each
of the offending files (and I say manually because there isn't a
parseable list of them anywhere). But they probably don't know what to
do, which means trying to find the information in the documentation.

And all of this while they are trying to quickly switch contexts to
whatever it was that caused them to stash in the first place. So I
expect the most useful thing would be a "git stash -f" that adds them as
empty. And it's reasonably safe, because we're not losing information in
the transition from index to stash tree without the user first having
been notified.

On the other hand, it may be sufficient to just do the transformation
with a "-f", which will save users even more time, and we can put a note
in the documentation about how stash interacts with -N. I don't know
whether people will actually care or not (and your patch already does
the unconditional form, so it's less work :) ).

-Peff
