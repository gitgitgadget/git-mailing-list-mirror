From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: resolving merge conflicts?
Date: Thu, 26 May 2005 22:15:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505262202050.17402@ppc970.osdl.org>
References: <429698A0.1020008@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 07:12:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbX8P-0005aI-KV
	for gcvg-git@gmane.org; Fri, 27 May 2005 07:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVE0FNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 01:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVE0FNp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 01:13:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:45270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbVE0FNm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 01:13:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4R5DdjA004703
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 22:13:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4R5Dccg002773;
	Thu, 26 May 2005 22:13:38 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <429698A0.1020008@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Jeff Garzik wrote:
> 
> So is there a doc or something that describes how to resolve merge 
> conflicts?

Dang. Not really. I've always done them just by hand.

> Presumably I look at .merge_file_*, and make sure that all necessary 
> changes make it into the copy of the file in the working directory... 
> then what?  How to continue the merge?

Start from that, and when you're happy with it, just do "git-update-cache"  
when the file is to your liking, and re-do

	git-merge-cache git-merge-one-file-script -a

if you forget where you were and what other files you need to do by hand
(which I always do, not that I've seen a lot of merge problems).

Also, I assume that this is something cogito does better. But even the 
git-merge-one-script could probably be nicer. 

Quite frankly, a more friendly git-resolve-script would probably do

	git-merge-cache -o git-merge-one-file-script -a

(the "-o" flag causes it to merge as much as it can automatically, instead 
of exiting at the first one), and git-merge-one-file-script should 
probably on failure do

	echo "ERROR: Leaving conflict merge in $4."
	mv "$src2" "$4"
	exit 1

instead of leaving it in the temporary file. The temp-file is good for a
graphical thing (which was kind of what I was hoping for), though, so it
probably depends on how you continue with the merge.

(I also like the temp-file just because _if_ you have dirty data in your 
tree, overwriting it with the failed merge is pretty damn impolite, but of 
course, you shouldn't try to merge with dirty data, and you may prefer the 
one that is _practically_ more friendly even if it's a bit unsafe. It's a 
trade-off)

		Linus
