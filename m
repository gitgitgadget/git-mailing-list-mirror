From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Mon, 16 May 2011 08:08:25 -0400
Message-ID: <20110516120825.GA24418@sigill.intra.peff.net>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
 <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
 <20110516103829.GA23889@sigill.intra.peff.net>
 <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Mon May 16 14:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLwbD-00037X-79
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 14:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab1EPMIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 08:08:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44545
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab1EPMI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 08:08:29 -0400
Received: (qmail 13723 invoked by uid 107); 16 May 2011 12:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 08:10:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 08:08:25 -0400
Content-Disposition: inline
In-Reply-To: <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173728>

On Mon, May 16, 2011 at 12:49:07PM +0200, Philipp Metzler wrote:

> [phil@Silberpfeil git]$ git commit -uall
> # On branch master
> nothing to commit (working directory clean)

Hmm, nothing. That's odd.

> [phil@Silberpfeil git]$ git commit -a
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	t/t9154/
> #	t/t9601/
> #	t/t9602/
> #	t/t9603/
> #	t/t9700/
> #	t/valgrind/
> #	templates/
> #	vcs-svn/
> #	xdiff/
> nothing added to commit but untracked files present (use "git add" to track)

And now totally different output from before, and from the previous run.

So this is really strange. The fact that the list of directories is
_different_ from your previous posting implies to me that it is not
something about those particular files, but rather some weird race
condition in the creation of those directories or the index.

But then the fact that we see them with no "-u", but don't see them with
"-uall" implies some weird heisenbug in git's directory traversal. What
happens if you do "git commit --all -uall"? I'd like to see if the thing
that switches the behavior is the presence of "--all" or the absence of
a "-u" option.

-Peff
