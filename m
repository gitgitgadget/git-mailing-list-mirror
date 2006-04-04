From: Andreas Ericsson <ae@op5.se>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 12:44:52 +0200
Message-ID: <44324E24.3090007@op5.se>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se> <7v1wwd8y9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 12:45:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQj28-0005gG-2w
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 12:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWDDKoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 06:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWDDKoy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 06:44:54 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:33225 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751849AbWDDKoy
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 06:44:54 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F3D816BCBC; Tue,  4 Apr 2006 12:44:52 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wwd8y9j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18384>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Sam Vilain wrote:
>>
>>>Junio C Hamano wrote:
>>>
>>>>[ made change on a test branch that bundles topic branches
>>>>  -- now want to commit back to the component topic branch ]
>>>>Would patch commutation calculus help with his problem?
>>>>
>>>
>>>I'd provisionally say "yes, that's the fit". It's just like having
>>>multiple topic branches all checked out at once, with commits going to
>>>the appropriate branch as necessary.
>>
>>Wouldn't "git commit -M -b topic", for committing to a different
>>branch than what is checked out (-b) and also to the checked out
>>branch (-M) have the same beneficial effects, but without the
>>complexity of hydras and patch dependency theory? It would only remove
>>the cherry-pick stage though, but perhaps it's good enough. Although
>>when I think about it, -b
>><branch> for committing to another branch and -B <branch> for doing
>>the above probably makes more sense.
> 
> 
> It feels to me that the above set of flags encourage a workflow
> that:
> 
>  (1) modify the source and run tests in "test" branch;
>  (2) have tool automatically adjust the change to match the other
>      branch (i.e. the topic to be checked in) automatically;
>  (3) make a commit, without a chance to do the final sanity
>      check in the context of the branch being committed.
> 

I don't fully understand 3 here. The workflow makes it easier to test 
how different topics work together, and make fixes to those that don't 
play well with others. Granted, it's not possible to test each topic by 
itself without checking it out, making the changes and re-compiling and 
so on, but since commits are so easy to undo I think it'd be nice to 
have the changes tracked. Another good thing is that fixes that apply on 
top of the "work-together" fixes, but that only make the topic branch 
build/work properly are completely rebase'able, and should result in a 
fast-forward merge since they share the same commit.


> An individual topic branch itself might not be even testable
> standalone, but at least I'd prefer to have a chance to double
> check if the "patch commuting" (or "cherry-pick stage") did a
> sensible thing [*1*].
> 

Understandable, and this workflow would still be available, but see below.


> As I said on the list in the past, I am from a school that
> believes in not committing anything that has not been
> tested/reviewed as a whole, especially when it comes to
> individual developers, so I am not sure it is a good idea
> in general to make it easy to do so to begin with.
> 

In short, you're from the school of centralized repositories. I used to 
be very careful about committing things too, but since I switched to git 
I happily commit smaller and more often, and regularly toss up a 
throw-away branch to make small commits that may or may not work and 
later apply the (tested) combined diff as a single commit or series of 
commits at points where I've tested one feature/fix to actually work as 
intended. This is nifty because people that help with testing can pull 
from my throw-away branch and get to work without me having to send them 
a tar-tree and a patch.

I believe in not *pushing* anything that hasn't been thoroughly tested, 
but the ability to track and commit possibly broken changes without it 
affecting the project as a whole is what makes git so great for me. In 
the CVS days distributed testing was a nuissance. With git it's smooth 
sailing.

> 
>>Those flags don't exist currently btw, in case someone's reading this
>>on the archives.
> 
> 
> I take it that you are volunteering to come up with an initial
> round of implementation of these flags?
> 

Unless someone can convince me I'm on the wrong track before I get off 
work, yes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
