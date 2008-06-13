From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 10:11:13 +0200
Message-ID: <48522BA1.9010702@op5.se>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K74ON-0004av-F8
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbYFMILW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 04:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYFMILU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:11:20 -0400
Received: from mail.op5.se ([193.201.96.20]:53108 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752911AbYFMILR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 04:11:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 923F724B0004;
	Fri, 13 Jun 2008 10:07:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.766
X-Spam-Level: 
X-Spam-Status: No, score=-3.766 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.633, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JG-cQf+lZMfK; Fri, 13 Jun 2008 10:07:51 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 25DD81B80085;
	Fri, 13 Jun 2008 10:07:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080613074257.GA513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84847>

Jeff King wrote:
> On Fri, Jun 13, 2008 at 09:16:42AM +0200, Andreas Ericsson wrote:
> 
>> To me, long-living stashes are useful because I can all of a sudden be
>> pulled away from something I'm working on and set to work on something
>> entirely different for up to 6 months (so far we haven't had a single
>> emergency project run longer than that). It doesn't happen a lot, but
>> it *does* happen.
> 
> So of course my first question is "then why didn't you use a branch?" :)
> 

Because stashes are convenient, never get propagated anywhere by accident,
are easy to apply, means you won't have the hassle of creating "topic-bugs"
and later merge it into "topic" when you find something you need to fix
before you merge "topic" into "master". There are lots of good reasons.

> 
>> I think these are the options we're faced with:
>> 1. Never expire stashes (don't shoot the user)
>> 2. Don't treat stashes specially (shoot the user)
>> 3. Don't purge stashes when auto-gc-ing (let the users shoot themselves)
>> 4. Make the behaviour configurable (let the users shoot themselves)
>> 5. Double the expiration time on stashes and warn for them when they should
>>   normally have expired (during gc, that is) (shoot the user, but warn first).
> 
> I am tempted by #3, which again matches my workflow. But again, it seems
> like an accident waiting to happen for unsuspecting users.
> 
> So I think either #1 or #4 is reasonable. #4 probably isn't worth the
> effort. If the stash reflog gets too cluttered, one can always expire or
> clean it manually.
> 

Right. If #1 gets dropped, I'll most likely hack up #4 though. I'd hate
for one part of git to be able to silently drop work when every other
aspect of it makes damn sure that never, ever happens.

I can imagine lots of people complaining if the merge logic suddenly
starts clobbering dirty work-tree files with an mtime 90 days in the past,
even though the user hasn't explicitly asked git to take care of those at
all.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
