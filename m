From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 08:53:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> <7vzmupud54.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:52:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ9m0-0005iw-Ql
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVETPve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVETPve
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:51:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:52933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261478AbVETPvX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 11:51:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KFpIU3028946
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 08:51:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KFpHer018113;
	Fri, 20 May 2005 08:51:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmupud54.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Junio C Hamano wrote:
>
> Keep git-diff-tree output sorted in cache order on dir/file swap.

No, this is wrong.

Or rather, it is incomplete - it gets only a small subset of the 
interesting cases right.

You need to really teach diff-tree about directory sorting, because it is 
more complicated than you think.

The sorting does _not_ just affect files/directories with the same names.  
It affects files and directories that have the same _beginning_.

The only correct way to do name sorting is the one that fsck does in
"verify_order()". To realize why, you need to realize that "A" (the
directory) sorts _after_ a filename "A file", because '/' sorts after ' '.  

In contrast, "A" (the directory) sorts _before_ "ABBA" (the band), because
'/' sorts before 'B'.

-- 
Side note:

Btw, right now I depend on "memcmp()" doing comparisons as "unsigned
char", which is supposed to be true, but I don't know whether it's 
entirely portable. So it might be that I should implement my own 
"namecmp()" entirely from scratch.

Does anybody know if some broken system does "memcmp" ordering on signed 
chars?

		Linus
