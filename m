From: Yann Dirson <ydirson@altern.org>
Subject: git-clone wrongly setting branch.*.merge ? (Was: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".)
Date: Sat, 3 Feb 2007 00:56:55 +0100
Message-ID: <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 00:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD8Hx-0004Sn-HY
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbXBBX5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbXBBX5u
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:57:50 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:50720 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbXBBX5t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:57:49 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9DB3F4A042;
	Sat,  3 Feb 2007 00:57:48 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DEE471F080; Sat,  3 Feb 2007 00:56:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38541>

On Fri, Feb 02, 2007 at 07:07:06PM +0100, Yann Dirson wrote:
> On Fri, Feb 02, 2007 at 09:58:06AM +0000, Catalin Marinas wrote:
> > On 01/02/07, Yann Dirson <ydirson@altern.org> wrote:
> > >Previously we were just assuming that the remote from which we
> > >just failed defined a local branch whose name was the same as the
> > >remote def, and that this branch was the parent.  While this is true
> > >for the most common case (branch "origin" from remote "origin"), it is
> > >quite an unflexible assumption.
> > 
> > The t1200-push-modified.sh test fails after applying this patch. It
> > looks like the 3rd test fails to pull the changes from 'foo' into
> > 'bar'.

With current GIT HEAD, plain git-clone creates the following config
(when cloning a repo with HEAD pointing to branch "downstream":


[remote "origin"]
        url = /export/work/yann/git/stgit/tmp/.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "downstream"]
        remote = origin
        merge = refs/heads/downstream
                ^^^^^^^^^^^^^^^^^^^^^

I would have expected "merge = remotes/origin/downstream" instead, and
this setting confuses the rebase-after-pull logic, causing it to
rebase the stack onto its own base (no-op).

Isn't that a git-clone bug ?

Now, it looks like without this patch, the post-fetch rebasing only
worked by chance, even more than I thought.

Best regards, 
-- 
Yann.
