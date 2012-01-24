From: Jeff King <peff@peff.net>
Subject: Re: {Spam?} push pull not working
Date: Tue, 24 Jan 2012 14:41:54 -0500
Message-ID: <20120124194153.GB19534@sigill.intra.peff.net>
References: <1327431631.21582.209.camel@thor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Rick Bragg <lists@gmnet.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 20:42:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpmFn-00033S-QR
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 20:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab2AXTl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 14:41:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43501
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2AXTl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 14:41:56 -0500
Received: (qmail 12079 invoked by uid 107); 24 Jan 2012 19:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jan 2012 14:48:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2012 14:41:54 -0500
Content-Disposition: inline
In-Reply-To: <1327431631.21582.209.camel@thor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189059>

On Tue, Jan 24, 2012 at 02:00:31PM -0500, Rick Bragg wrote:

> I cloned a repo from /home/me/repo1 to /home/me/repo2.  Then made
> changes and a new commit on repo1, then from repo1 did "git
> push /home/me/repo2 and it says Everything is up-to-date.  How could
> this be?

It's hard to say, since you didn't show us the exact commands you ran.

One possible cause is that you made your commit on a detached HEAD, not
on a branch, and therefore pushing branches will have no effect. You can
check this by running "git status", which will report either your
current branch or "not currently on any branch".

Another possible cause is that git is not trying to push the branches
that you think it is.

For example, imagine repo1 has two branches, "master" and "foo", and the
"master" branch is checked out. When you clone it, the resulting repo2
will have remote-tracking branches for both "master" and "foo", but will
only checkout the "master" branch. Now imagine you make commits on
"foo" in repo1, and then try to push. Git's default behavior is to push
only branches which match (by name) a branch on the destination. So we
would attempt to push "master" (which is up to date), but not "foo".

You can see which branches are being considered in the push with "git
push -vv". If you want to push all branches, you can use "git push
--all", or read up on refspecs in "git help push". If you want to change
git-push's default behavior, read up on "push.default" in "git help
config".

-Peff
