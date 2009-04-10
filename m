From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Fri, 10 Apr 2009 13:14:58 -0400
Message-ID: <20090410171458.GA26478@sigill.intra.peff.net>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 10 19:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsKLF-0001gr-7L
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 19:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760281AbZDJRPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 13:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757685AbZDJRPB
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 13:15:01 -0400
Received: from peff.net ([208.65.91.99]:53213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991AbZDJRPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 13:15:01 -0400
Received: (qmail 26769 invoked by uid 107); 10 Apr 2009 17:15:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 10 Apr 2009 13:15:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Apr 2009 13:14:58 -0400
Content-Disposition: inline
In-Reply-To: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116266>

On Thu, Apr 09, 2009 at 05:33:02PM +0200, Michael J Gruber wrote:

> Use the new shorten_unambiguous_ref() for simplifying the output of
> upstream branch names. This affects status and checkout.

Yeah, this is the spot I was thinking about when I mentioned "use it in
other places" earlier in the thread. So

Acked-by: Jeff King <peff@peff.net>

> I haven't seen more obvious place for using shorten_unambiguous_ref().
> prettify_ref() is a natural candidate but is mostly used for
> prettyfying refs on the remote side. git branch is covered by Jeff's
> patch already.

Hmm. I was thinking we might be able to just do away with prettify_ref,
but I didn't consider the fact that we need to prettify remote things. I
think you could still unambiguously prettify the local half of those
callsites, though.

Given that the two functions are closely related, should we perhaps
rename them to

  const char *shorten_ref(const char *);
  const char *shorten_ref_unambiguous(const char *);

? The implementations are quite different, with prettify_ref not really
respecting the ref lookup rules, but rather just considering a few
pre-determined bits of the hierarchy as uninteresting. It shouldn't be
that hard to have them both use the same implementation, like:

  const char *shorten_ref(const char *, int unambiguous);

-Peff
