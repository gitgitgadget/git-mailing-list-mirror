From: Jeff King <peff@peff.net>
Subject: Re: Syntax check via update hook?
Date: Wed, 20 May 2009 11:22:24 -0400
Message-ID: <20090520152224.GB22426@coredump.intra.peff.net>
References: <wsprejtm71.fsf@usg.edu> <20090509144711.GA3926@sigill.intra.peff.net> <wsd4aem8rh.fsf@usg.edu> <20090514065544.GC10411@coredump.intra.peff.net> <wsd4abfonx.fsf@usg.edu> <ws7i0bu7sq.fsf@usg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Plaksin <happy@usg.edu>
X-From: git-owner@vger.kernel.org Wed May 20 17:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6nco-0001Fa-CS
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 17:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbZETPW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbZETPWZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 11:22:25 -0400
Received: from peff.net ([208.65.91.99]:38561 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110AbZETPWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 11:22:25 -0400
Received: (qmail 9107 invoked by uid 107); 20 May 2009 15:22:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 May 2009 11:22:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2009 11:22:24 -0400
Content-Disposition: inline
In-Reply-To: <ws7i0bu7sq.fsf@usg.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119615>

On Wed, May 20, 2009 at 11:13:09AM -0400, Mark Plaksin wrote:

> Well, it's oh so close!  If we make changes that don't pass the syntax
> check and try to push them the hook rejects the changes.  If we then
> make a change that will pass the syntax check, leave the others broken,
> and push, 'git diff-tree' doesn't list the previously rejected files so
> the hook accepts the push.  Is there any way to get 'git diff-tree' to
> list all of the files?

Ah, yeah, that was my mistake. If you are looking at the whole tree,
then you only need to look at what is being pushed, as it contains the
changes for all of the commits being pushed. But if you are going to ask
for a diff, you want to see not just the final commit, but the diff
between what is in the ref now and what you are proposing to push.

The old commit is passed as the second argument to the hook. So you
should be able to just do:

  git diff-tree "$2" "$3"

-Peff
