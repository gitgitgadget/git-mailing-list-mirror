From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-reset and clones
Date: Fri, 17 Mar 2006 22:21:41 +0100
Message-ID: <441B2865.5090505@op5.se>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>	 <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net> <1142623141.17536.225.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, paul@hibernia.jakma.org,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 17 22:22:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKMOJ-0003j2-38
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 22:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWCQVVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 16:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWCQVVo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 16:21:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:6531 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932794AbWCQVVn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 16:21:43 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E92536BD04; Fri, 17 Mar 2006 22:21:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1142623141.17536.225.camel@cashmere.sps.mot.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17671>

I'm in sort of shallow waters, hoping that Junio or Linus will come 
along and pull me off the shores in case I mis-step and say something 
stupid that would have made an amusing pictograph had it been done right 
by a cartoonist.

Jon Loeliger wrote:
> On Thu, 2006-03-16 at 20:10, Junio C Hamano wrote:
> 
> 
>>You used to have something like this:
>>
>>
>>                 o---o---o---A
>>                /            ^ your HEAD used to point at here
>>    ---o---o---o
>>
>>and you forgot other people already have the commit chain up to
>>commit A.   But you rewound and did cleanups:
>>
>>                 o---o---o---A
>>                /
>>    ---o---o---o---o---o---B
>>                           ^ your HEAD now points at here
>>
>>People who track your HEAD have A and your updated head B does
>>not fast forward.  Oops.
>>
>>The recovery consists of two steps.  The first step is more
>>important.  To find what commits you lost that others already
>>may have.  You may be lucky and remember A's commit object name,
>>but when I did that I had to ask around on the list X-<.
>>
>>The second step is a single command:
>>
>>	$ git merge -s ours 'Graft the lost side branch back in' \
>>		HEAD A
>>
>>where A is the object name of that commit.  On your current
>>branch, this creates a merge commit between A and B (your
>>current HEAD), taking the tree object from B.
>>
>>                 o---o---o---A
>>                /             \
>>    ---o---o---o---o---o---B---M
> 
> 
> Junio,
> 
> Can you explain a bit more why the "ours" strategy
> comes into play here?  I _think_ I understand, but
> I'd like to hear a bit more explanation, please.
> How is this different from just merging in A directly?
> 

"Ours" is an algorithm you can invent yourself and pass as the defautl 
merge strategy (useful if you know you'll always keep upstream as-is or 
some such).

> 
>>You want to keep the contents of the cleaned-up HEAD, so that is
>>why you are taking the tree from B.
> 
> 
> And the "ours" strategy effectively says, "Favor the B
> side of things when pulling in the A parts", right?
> 

Yes, and/or no. "Ours"' is still whatever you want it to be. Perhaps we 
should add some new strategies, like "favour-current" and "favour-new".

> 
>>  With this commit M, you are
>>telling the outside world that it is OK if they start from a
>>commit on the now-recovered side branch.
> 
> 
> This is mystical to me.  How is the "A" (ie, side branch)
> now in a "recovered" state?
> 

Because the commits pullers already have are now inside the respository 
history, as seen by average pullers (again). The merge between "master" 
(or some such) and "new-devel" (or some such) happen to coincide, which 
means they share a mutual merge-base, which means they're both part of 
the same chain of developemnt. If you intend to disimiss most of the 
changes between (fork-point) and (point-of-new-weird-rebase) this might 
not be the best solution, but...


Sorry, but to me this is friaday night and currently I can't logically 
differ between a bluewhale and a kangaroo [*1]

/exon

[1]
Sadly, this has been empirically proven. [*2]


[2]
At some other time. I'm no *that* drunk right now.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
