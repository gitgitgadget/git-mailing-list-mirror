From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 16:35:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
 <Pine.LNX.4.63.0508271855100.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 01:36:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9ACt-0003GR-55
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 01:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVH0XfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 19:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVH0XfX
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 19:35:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbVH0XfX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 19:35:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7RNZGjA005729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Aug 2005 16:35:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7RNZFnl021451;
	Sat, 27 Aug 2005 16:35:16 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508271855100.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7857>



On Sat, 27 Aug 2005, Daniel Barkalow wrote:
> 
> What I missed was that the effect of causes_df_conflict is to give "no
> merge" for the entry, rather than giving an error overall. So I do need an
> equivalent.

Daniel, 
 I'm not 100% sure what you're trying to do, but one thing that might work 
out is to just having multiple "stage 3" entries with the same pathname.

We current use 4 stages:
 - stage 0 is "resolved"
 - stage 1 is "original"
 - stage 2 is "one branch"
 - stage 3 is "another branch"

But if we allowed duplicate entries per stage, I think we could easily 
just fold stage 2/3 into one stage, and just have <n> entries in stage 2. 
That would immediately mean that a three-way merge could be <n> way.

The only rule would be that when you add a entry to stage 2, you must 
always add it after any previous entry that is already in stage 2. That 
should be easy.

In fact, this extension might even allow us to solve the "multiple merge
base" problem: we could allow multiple entries in "stage 1" too, ie one
entry per merge base (and just collapse identical entries - there's no 
ordering involved in stage 1 entries).

So you could merge "n" trees with "m" bases, and all without really 
changing the current logic much at all.

Maybe I'm missing something (like what you're trying to do in the first 
place), but this _seems_ doable.

Of course, "git-merge-one-file" gets more interesting as a result.

			Linus
