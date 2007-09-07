From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 11:41:53 +0200
Message-ID: <46E11CE1.4030209@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <fbr2iv$ugg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITaLi-0005Q0-8u
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbXIGJl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 05:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbXIGJl5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:41:57 -0400
Received: from mail.op5.se ([193.201.96.20]:39728 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965025AbXIGJl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 05:41:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D791F1943FC;
	Fri,  7 Sep 2007 11:41:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayT6qXfVFny9; Fri,  7 Sep 2007 11:41:54 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 413931943C5;
	Fri,  7 Sep 2007 11:41:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <fbr2iv$ugg$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58012>

Walter Bright wrote:
> Wincent Colaiuta wrote:
>> Git is all about speed, and C is the best choice for speed, especially 
>> in context of Git's workload.
> 
> I can appreciate that. I originally got into writing compilers because 
> my game (Empire) ran too slowly and I thought the existing compilers 
> could be dramatically improved.
> 
> And technically, yes, you can write code in C that is >= the speed of 
> any other language (other than asm). But practically, this isn't 
> necessarily so, for the following reasons:
> 
> 1) You wind up having to implement the complex, dirty details of things 
> yourself. The consequences of this are:
> 
>    a) you pick a simpler algorithm (which is likely less efficient - I 
> run across bubble sorts all the time in code)
> 
>    b) once you implement, tune, and squeeze all the bugs out of those 
> complex, dirty details, you're reluctant to change it. You're reluctant 
> to try a different algorithm to see if it's faster. I've seen this 
> effect a lot in my own code. (I translated a large body of my own C++ 
> code that I'd spent months tuning to D, and quickly managed to get 
> significantly more speed out of it, because it was much simpler to try 
> out different algorithms/data structures.)
> 

I haven't seen this in the development of git, although to be fair, you
didn't mention the number of developers that were simultaneously working
on your project. If it was you alone, I can imagine you were reluctant to
change it just to see if something is faster.

Opensource projects with many contributors (git, linux) work differently,
since one or a few among the plethora of authors will almost always be
a true expert at the problem being solved.

The current pack-format and how it's read is one such example. It was
done once, by the combined efforts of Linus and Junio (this is all off
the top of my head and I cba to go looking up the details, so bear with
me if there are errors). Linus and Junio are both very good C-programmers,
but the handling of packfiles was not what you'd call their specialty.
Along came Nicolas Pitre, another excellent C programmer, who probably
has done some similar work before. He constructed a better algorithm,
eventually resulting in the ultimate performance win with a net gain
in both time and size (gj, Nicolas).

The point is that, given enough developers, *someone* is bound to
find an algorithm that works so well that it's no longer worth
investing time to even discuss if anything else would work better,
either because it moves the performance bottleneck to somewhere else
(where further speedups would no longer produce humanly measurable
improvements), or because the action seems instantanous to the user
(further improvements simply aren't worth it, because no valuable
resource will be saved from it).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
