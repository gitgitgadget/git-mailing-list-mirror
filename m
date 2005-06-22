From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 16:16:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 01:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlESx-0006SS-Cq
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 01:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVFVXWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVFVXS5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 19:18:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbVFVXOG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 19:14:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MNDtjA000861
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 16:13:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MNDsIH011547;
	Wed, 22 Jun 2005 16:13:55 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42B9E536.60704@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
>
> 2) download a linux kernel tree for the very first time
> 
> $ mkdir -p linux-2.6/.git
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> \          <- word-wrapped backslash; sigh
>      .git/

Gaah. I should do a "git-clone-script" or something that does this, and 
then you could just do

	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
	
Anybody?

> # make some modifications
> $ patch -sp1 < /tmp/my.patch
> $ diffstat -p1 < /tmp/my.patch
> 
> # NOTE: add '--add' and/or '--remove' if files were added or removed
> $ git-update-cache <list of all files changed>
> 
> # check in changes
> $ git commit

A few notes on these things:

	git-apply --index /tmp/my.patch

will not only apply the patch (unified patches only!), but will do the
index updates for you while it's at it, so if the patch contains new files
(or it deletes files), you don't need to worry about it.

Also, you can do

	git commit <list-of-files-to-commit>

as a shorthand for

	git-update-cache <list-of-files-to-commit>
	git commit

which some people will probably find more natural.

> 6) List all changes in working dir, in diff format.
> 
> $ git-diff-cache -p HEAD

Or, perhaps preferably:

	git diff HEAD

since that is shorter ad will also show renames.

> 8) List all changesets:
> 
> $ git-whatchanged

No, if you just want the changesets listed, then

	git log

is a lot better, since it shows merges.

"git-whatchanged" is useful if you actually want to see what the commits 
_changed_, and then you often want to use the "-p" flag to see it as 
patches. Also, it's worth pointing out the fact that you can limit it to 
certain subdirectories (or individual files) etc, ie:

	git-whatchanged -p drivers/net

since that is often what people want.

But if you just want the log, "git log" is faster and simpler and more 
correct.

> 16) obtain a diff between current branch, and master branch
> 
> In most trees WITH BRANCHES, .git/refs/heads/master contains the current 
> 'vanilla' upstream tree, for easy diffing and merging.  (in trees 
> without branches, 'master' simply contains your latest changes)
> 
> $ git-diff-tree -p master HEAD

Again, I think is possibly more naturally expressed with "git diff":

	git diff master..HEAD

which just says "show the differences from 'master' to 'HEAD'" and will
also show renames etc.

(A plain "git diff" will show just the difference to the index file, in 
case you care).

		Linus
