From: Kevin Ballard <kevin@sb.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 18:32:14 -0700
Message-ID: <3B2566EF-807E-46E6-8447-D13A5904F00C@sb.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807291235350.6791@localhost.localdomain> <alpine.LFD.1.10
 .0807290838360.3334@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807300223010.6791@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 03:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO0uC-0005iQ-UX
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 03:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbYG3ByJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 21:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYG3ByI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 21:54:08 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:43730 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbYG3ByH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 21:54:07 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jul 2008 21:54:07 EDT
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id 36C641250181;
	Tue, 29 Jul 2008 18:32:15 -0700 (PDT)
Received: from [10.100.18.156] (unknown [10.100.18.156])
	by mail.rapleaf.com (Postfix) with ESMTP id 0688E12500B6;
	Tue, 29 Jul 2008 18:32:15 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0807300223010.6791@localhost.localdomain>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90726>

On Jul 29, 2008, at 6:14 PM, Roman Zippel wrote:

>> So here's my challenge again, which you seem to have TOTALLY MISSED.
>>
>> Make this be fast:
>>
>> 	time sh -c "git log <filename> | head"
>>
>> nothing else matters. If you can make that one be fast, I'm happy.
>
> I already explained it, but you simply dismissed it. It's possible,  
> but it
> requires a bit of cached information (e.g. as part of the pack file,  
> which
> is needed for decent performance anyway).

As an outside observer, this argument is basically akin to "it's easy  
to fly, you just need some faerie dust". Basically, you're dismissing  
the entire complexity of the problem by saying "oh, that's easy, just  
use some cached data" without any proof that this would work, or any  
sample code, or really any evidence at all. Given that the path  
simplification can be arbitrarily complex (I can pass any set of paths  
I want), I don't believe that you can just use "a bit of cached  
information" for this. If you did rely on cached information, said  
information would probably be orders of magnitude larger than the  
object graph itself (for repos with lots of files).

>> In fact, you can see what I'm talking about by trying --topo-order  
>> in the
>> above timing test.
>
> Please give me full example.
> gitk --topo-order kernel/printk.c shows no difference (e.g. it doesn't
> show 02630a12c7f72fa294981c8d86e38038781c25b7), several experiments  
> with
> git-rev-list show no improvement either.

He's not saying it changes what commits are shown, he's saying it has  
a performance impact - topo order has to post-process the graph. For a  
quick demonstration, run `time sh -c 'git log | head'` vs `time sh -c  
'git log --topo-order | head'`.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
