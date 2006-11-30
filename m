X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 15:40:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301520370.3513@woody.osdl.org>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
 <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 23:42:20 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Carl Worth <cworth@cworth.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vlklsfsgz.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32833>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpvXI-0004r7-4w for gcvg-git@gmane.org; Fri, 01 Dec
 2006 00:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967982AbWK3Xlm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967983AbWK3Xlm
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 18:41:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14761 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967982AbWK3Xll (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 18:41:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUNexjQ019967
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 15:41:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUNewo1024332; Thu, 30 Nov
 2006 15:40:58 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Junio C Hamano wrote:
> 
> I sense that you are inviting me to argue for reverting the
> other "git commit" braindead which is spelled "--only" (and
> worse yet, it is the default).  I am very tempted.

I actually really like the current defaults for "git commit".

And I say that despite the fact that the defaults are _different_ from the 
original ones.

I like the fact that when you do "git commit filename", it really will 
commit _only_ that file, not the other files you added. It's logical.

So you can do

	echo a > file-a
	echo b > file-b
	git add file-a file-b

	git commit file-a

and it will only commit one of them. Now, admittedly, the status message 
that you get is slightly misleading (it says that "file-b" is untracked, 
which is not strictly true or at least somewhat confusing - it's untracked 
only within the context of that one commit), but this is all logically 
consistent.

And it's wonderful for noticing "Oh, sh*t, I forgot to commit that 
previous change, let's commit that other file first!". You can do things 
like this _despite_ the fact that you've added other files to the list of 
files to be committed.

The current semantics for "git commit" are really powerful, and really 
flexible. Yes, there are different "cases", but they all have their place:

 - "git commit" on its own:

    This is for things where you prepared things earlier: notably a merge, 
    for example. But it might be the "--amend" case too, where you simply 
    don't want to change any of the working tree, just the commit message.

   The fact that it has a nice fallback for the "nothing to commit" case 
   which basically just prints out the same thing as "git status" is just 
   gravy.

 - "git commit explicit/file anotherfile"

   This is great (and I use it) exactly for when you have random other 
   additions in your tree that are brewing, and you just want to commit a 
   particular fix that takes precedence. You may be in the middle of 
   something else, but you found a critical bug that needs to be fixed, 
   and while you _could_ do it on another branch, it's just a lot more 
   convenient to specify exactly what you want to commit.

 - "git commit -a"

   Sure, this is the common case, but just how painful is it to type those 
   extra few characters? And not defaulting to this is just sensible, 
   considering that "-a" really is not _that_ special, and the above two 
   cases simply aren't that unusual either. And it's just good to make 
   people have to _think_ about the fact that it commits everything that 
   have dirty.

At least for me, it turns out that the only mode I _never_ use personally 
is the "git commit -i" thing, which was actually the original behaviour, 
and which you'd think that I would encourage for that reason. But no. Of 
all the modes of "git commit", that's the one I think is the least 
important, and least interesting.

Of course, during a merge, you do need "-i" if you list files, but I think 
"-a" subsumes almost all cases (you _can_ use "-i file-list" or totally 
manually decide to have some extra edits you did that you don't want to 
commit together with the merge, but that's such a special case that I 
doubt anybody does it, so I don't think it's a big deal).

Anyway, we have "-i", and we don't force anybody to use it, so the fact 
that it's a bit odd and not that useful doesn't really matter. It 
certainly "fits" in the git commit family as another case, it's just not 
one of the important cases.

