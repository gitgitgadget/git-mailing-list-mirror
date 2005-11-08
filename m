From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Diff between the non-head git work dir and non-git kernel sources
Date: Wed, 09 Nov 2005 01:52:42 +0200
Message-ID: <43713A4A.9000101@cc.jyu.fi>
References: <43711088.6070701@cc.jyu.fi> <7vacgeeqb3.fsf@assigned-by-dhcp.cox.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 00:54:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdGm-0001zo-2a
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 00:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVKHXwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 18:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVKHXwt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 18:52:49 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:26846 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S1030407AbVKHXwt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 18:52:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id jA8NqlJ5022581
	for <git@vger.kernel.org>; Wed, 9 Nov 2005 01:52:47 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id jA8Nqi6L022575
	for <git@vger.kernel.org>; Wed, 9 Nov 2005 01:52:44 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id A55393F1DB
	for <git@vger.kernel.org>; Wed,  9 Nov 2005 01:52:43 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vacgeeqb3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11369>

Junio, thanks for the help, I think the problems are now vanished :-)

Junio C Hamano wrote:

>lamikr <lamikr@cc.jyu.fi> writes:
>
>Let me understand what trees are involved.  I am not sure from
>your description.
>
> 1. You based your own development on some kernel snapshot.
>
> 2. The kernel snapshot you based 1. is "some version".
>
> 3. Mvista has d24aff0b commit that contains their changes to
>    a kernel snapshot (the same "some version" as 2).
>
> 4. Mvista now has different version, descendant of 3.  This is
>    the top of omap tree you cloned.
>
>         --------------------------->[2] yours
>        /
>     [1]------------->[3]----------->[4] omap tip
>
>Is this the commit history graph you have?
>  
>
Almost like this.
a) I used 2.6.14-rc5.tar.bz2 as a base
b) Then I applied
       2.6.14-rc5.tar.bz2 and 
http://www.muru.com/linux/omap/patches/patch-2.6.14-rc5-omap1.bz2
    on top of that. This is a snapshot from the OMAP git tree.   [1]
c) I merged my own development to these sources --> [2]
d) I manually applied all patches released to omap tree between 
patch-2.6.14-rc5-omap1.bz2 and
commit-id d24aff0bd3e788d69a45a9d1b1eecda88d847a41   --> [5]

So the relation between kernel version [5] that I have in non git tree 
is basically following and current omap git tree is
following kind.

         ---my changes-->[2]----->[5] my source tree (non git)
        /                         /
     [1]----------------------->[3]---------->[4] omap git (currently in 2.6.14 level)



I needed to change git working directory from state [4] to state [3] so 
that I could create the
diff between [3] and [5].  (And then try to merge it back on top of [4]...)

>>I would now like to revert the sources in git working dir to state that 
>>was after this d24aff0bd3e788d69a45a9d1b1eecda88d847a41 commit
>>and then make the diff between that kernel source version and my non-git 
>>source version.
>>    
>>
>
>You lost me here.  Presumably the ultimate goal of what you are
>doing is either one of the following:
>
>(1) port your good changes between [1] and [2] on top of [4], or
>  
>
Yes, my goal is to have in future a own local git branch that follows 
mvistas git tree.
(and mvistas tree follows mainline) For this I have found good looking 
documentation.

>(2) port progresses in omap tree between [3] and [4] (or perhaps
>    [1] and [4], including changes betwen [1] and [3]) on top of
>    your tree [2].
>
>But I am not sure what you mean by the above paragraph.  You
>sound as if you want to find out the differences between [3]
>("revert it to d24aff") and [2] ("your non-git source").
>
>If that is what you want instead, assuming you have your kernel
>tree in linux-lamikr and omap tree in linux-omap:
>
>	$ cd linux-omap
>        $ git checkout -b snapshot-d24aff0b d24aff0b
>  
>
This was the thing I wanted to know and it worked. I made something 
wrong in my own attempts and I always failed to revert to own version. 
(Propaply because I tried to create tag names)

>Another possibility would be to move your development to .git;
>if you know the commit id of [1], then you can branch from that
>commit and replay your development trail step by step up to [2].
>This obviously requires that you used some SCM to keep track
>your development trail between [1] and [2].
>
>Once you have done that (and assuming your branch is called
>lamikr), you could compare omap and your tip with:
>
>	$ git checkout lamikr
>	$ git diff lamikr origin
>
>Or even merge omap tip into your branch:
>
>	$ git checkout lamikr
>	$ git pull . origin
>
>all inside linux-omap/ directory.
>  
>
Well, I already started diff running in the background by using the 
first solution but I will also try this one for the comparison.

Mika
