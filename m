From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git commit (or git-commit-script) question
Date: Fri, 19 Aug 2005 10:36:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508191028190.3412@g5.osdl.org>
References: <4306119C.8000600@jstenback.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 19:38:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Ani-0007fA-0c
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 19:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVHSRgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 13:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVHSRgm
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 13:36:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932687AbVHSRgl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 13:36:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7JHaejA028894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 Aug 2005 10:36:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7JHaaXA027974;
	Fri, 19 Aug 2005 10:36:38 -0700
To: Johnny Stenback <jst@jstenback.com>
In-Reply-To: <4306119C.8000600@jstenback.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 19 Aug 2005, Johnny Stenback wrote:
> 
> That made me assume that if I do:
> 
>    git-commit-script somedir
> 
> it would *only* commit the changes I've made in "somedir", but it 
> appears to commit *all* files that have changed (and shows all files in 
> the list of changed files in the commit message it displays in the 
> editor), as if it's completely ignoring the <path> argument.
> 
> Known problem? I got this using git that I pulled from kernel.org 
> earlier this morning.

It works for me. You _should_ see something like

	#
	# Updated but not checked in:
	#   (will commit)
	#
	#       modified: somedir/somefile
	#
	#
	# Changed but not updated:
	#   (use git-update-cache to mark for commit)
	#
	#	modified: otherdir/anotherfile
	#

which basically means that it will commit "somedir/somefile", but _not_ 
commit "otherdir/anotherfile".

However, one thing to look out for is that if you've marked any files for 
update (with git-update-cache) those will always be committed regardless 
of what arguments you give to "git commit". You can reset the index with 
"git reset" if you decided that you don't want to commit after all.

(For example, if you do a "git commit --all", but decide not to commit 
after all by writing an empty commit message, that will already have 
marked all the files to be committed, so next time, even if you then use 
"git commit somedir", all the files in all the _other_ dirs have already 
been marked for update, so you'll see everything being committed).

			Linus
