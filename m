From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 09:32:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605160906150.3866@g5.osdl.org>
References: <20060516055815.GA4572@c165.ib.student.liu.se>
 <7vhd3qebuv.fsf@assigned-by-dhcp.cox.net> <20060516065452.GA5540@c165.ib.student.liu.se>
 <Pine.LNX.4.64.0605160821570.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 18:33:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg2U7-0003LN-Di
	for gcvg-git@gmane.org; Tue, 16 May 2006 18:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWEPQcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWEPQcr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 12:32:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751866AbWEPQcq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 12:32:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GGWDtH005158
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 09:32:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GGWCEv012598;
	Tue, 16 May 2006 09:32:13 -0700
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <Pine.LNX.4.64.0605160821570.3866@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20125>



On Tue, 16 May 2006, Linus Torvalds wrote:
> 
> I don't think you can be more specific, or do a better job. The definition 
> of "most recent" is arbitrary, of course - and going by commit date is 
> just _one_ way to order them, but it happens to be an easy one, and one 
> that is as good as any other choice.

Side note: since LCA's are (by definition) never going to have a direct 
graph relationship, there is obviously no ordering enforced by the graph 
itself. So they're all unordered in the graph sense, but you could use 
other measures of "distance" in the graph.

Example other orderings that we _could_ do, and I considered (some purely 
graph based, others based on content):

 - order by number of commits between the LCA and the two commits that we 
   are trying to find the LCA for (the "tips").
 - order by diff size between the LCA and the tips
 - order by lack of conflicts between the LCA and the tips.

however, none of the alternate orderings really seem to make a lot of 
sense.

The date-based one trumps them all by being straightforward and simple to 
both implement and explain. And iirc, I actually verified that it happened 
to pick the "better" one for at least one of my tests when using the old 
stupid straigth three-way merge, so I think it was actually objectively a 
good measure at least once.

Anybody who cares can obviously always just do "git-merge-base --all" and 
do their own sorting for the (relatively unlikely) case that you get more 
than one parent.

Anyway, just out of interest I just did some statistics using some shell 
scripts:

 - For the current kernel tree, of 1857 merges, only 17 had more than one 
   merge base (and none had more than two):

   1840 o
     17 oo

 - In contrast, for git (current master branch), the numbers are 35 out of 
   540, and there are lots of merges with many LCA's:

    505 o
     15 oo
     13 ooo
      2 oooo
      3 ooooo
      2 ooooooo

I think the difference is that Junio does a lot of these branches where he 
keeps on pulling from them, and never syncs back (which is a great 
workflow). In contrast, the kernel tends to try to avoid that because the 
history gets messy enough as it is ;)

Anyway, the two commits that apparently have seven (!) LCA's in the git 
tree should probably be checked out. They are probably a good thing to see 
if git-merge-base really _really_ does the right thing, and whether they 
really are true LCA's.

They are commits ad0b46bf.. and e6a933bd.. respectively.

		Linus
