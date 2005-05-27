From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 13:17:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271307510.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
 <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
 <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:14:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DblCu-00023u-CC
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVE0UP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVE0UP0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:15:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:25821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262572AbVE0UPT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 16:15:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RKF6jA003074
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 13:15:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RKF4xq006989;
	Fri, 27 May 2005 13:15:05 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050527195552.GA6541@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Thomas Glanzmann wrote:

> > You merge by hand and resolve if they have conflicts, just like
> > what you already do in two head merge case.
> 
> I see. Does that mean that 'git-ls-files --unmerged' will report upto 9
> stages per file?

No, you must always merge trees one by one against each other. The
simplest ordering is to merge trees 1-2 first, then the result of that
with 3, then the result of _that_ with 4 etc etc, but you can - if you
really want to - do 1-2 and 3-4 separately and then merge those two
together.

The ordering does actually end up mattering a bit when it comes to
deciding on parenthood, but in the end you will have used the same most
remote common parent for _one_ of the merges anyway, so assuming all the
merges were automatically resolved by the regular 3-way thing, I claim
that it doesn't really matter noticeably (*).

Regardless, you'd end up with seven "git-read-tree -m x y z" invocations
(plus possibly a few git-merge-cache calls), and one final commit.

		Linus

(*) I bet you could find some case where the ordering either generates a
create-create conflict or it doesn't, depending on how you pair things up. 

But I also claim that you'd be crazy to do a octopus merge for something 
like that anyway, and that the reason to do one is that you've had five 
totally disjoint things you've been working on - like updating five 
different drivers or five different filesystems in different branches, and 
there are no conflicts however you turn.

