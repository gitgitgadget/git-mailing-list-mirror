From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 11:50:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161140141.26803@g5.osdl.org>
References: <20050916101138.99906352682@atlas.denx.de>
 <Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:52:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGLHr-0001fP-PH
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbVIPSuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbVIPSuN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:50:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4300 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161263AbVIPSuL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 14:50:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GIo8Bo006853
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 11:50:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GIo6bo006609;
	Fri, 16 Sep 2005 11:50:07 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <Pine.LNX.4.58.0509161114540.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8706>



On Fri, 16 Sep 2005, Linus Torvalds wrote:
> 
> > b) Is there any way to find out what I did wrong in the first place?
> 
> Well, it probably isn't even an error, but there are nice tools to check 
> it out. For example, you can just list the commits it lists to gitk, and 
> you'll get a nice graphical view of where they are in the tree. That 
> probably makes you go "Duh, yes, I did a 'git reset' to undo those".

Doing exactly that:

	gitk 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770 \
		8493c04f1b8c9da0c5dc83091cabbcd0b98954ed \
		e1bcd2a5d53bceef2679737474487e32d87e7f2c \
		c1b779fbce762c970e3ace4332bb6ddc0de65e61

says that three of the commits were the same one, redone:

	Added support for mtddevnum and mtddevname variables.

in one form or another (quick look at the diffs says that one was 
apparently re-done because you forgot the changelog entry, I didn't look 
any closer).

So I suspect that's you just undoing a commit, and redoing it. I assume
that somewhere in the _reachable_ tree is one final commit that actually
did that, but I didn't bother to search for it (but that's easy too if you
want to:just go "gitk --all" and then search for that "Added support for
mtddevnum"...)

The fourth commit is 8493c

	Rebased: Rewrite of NAND code based on what is in 2.6.12 Linux kernel

and considering that you seem to have other undo's in the tree, I'll just
assume this is one more, but you would know.

		Linus
