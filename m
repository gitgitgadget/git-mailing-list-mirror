From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFD] remembering hand resolve...
Date: Wed, 25 Jan 2006 14:45:49 +0100
Message-ID: <43D7810D.9010508@op5.se>
References: <7v4q3ssbr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 14:46:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1ky9-0008UA-Kr
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 14:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWAYNpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWAYNpv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 08:45:51 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55213 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751130AbWAYNpu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 08:45:50 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4D8C06BD01; Wed, 25 Jan 2006 14:45:49 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q3ssbr6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15132>

Junio C Hamano wrote:
> As people on the list may know, I keep many mini topic-branches
> and keep combining them on top of then-current master to publish
> "pu".  This involves resolving merge conflicts by hand, when the
> areas topic-branches touch overlap.
> 
> The thing is, I find myself resolving the same conflicts over
> and over.  This is because the master branch tends to advance
> faster than topic branches that touch an overlapping area.


How can that be possible? If the area of code in master is modified 
beyond simple merging from the topic-branches, the resulting diff (which 
has to be against master's HEAD) should apply cleanly so long as there 
aren't *new* changes to master, in which case the pu commit needs 
adaptation again, so it wouldn't really be the same conflict (or even 
necessarily a similar one), would it?


> If I linearize topic-branches that conflict with each other in
> some way, say base topic B on top of topic A, I would not have
> problem merging them into "pu" as long as I do not change my
> mind later and try to merge only topic B without topic A.  But
> that defeats the whole point of having independent topic
> branches.
> 

Wouldn't cherry-pick be useful here? If it isn't, I fail to understand 
how a merge can solve it for you. Admittedly, I know little of the inner 
workings of git.

> 
> A trivial solution would be to save the diff between conflicted
> automerge result before hand resolving, and the result of my
> hand resolve, and apply with "patch" when I see a conflicted
> automerge the next time.  I've tried this by hand and it worked
> quite well tonight, but I felt it was somewhat kludgy.  We
> should be able to do better than that, with some tool support.
> 

> Another obvious way is to avoid rebuilding "pu"; instead I could
> pull "master" into "pu" every time I have added something new to
> "master".  That would work most of the time, until I decide to
> change the order the topic branches are merged into "pu" (or
> drop one of them).
> 

Couldn't you do something like this:

for t in $topic_branches; do
	checkout $t
	git rebase master
done
git checkout master
git branch -D pu
git checkout -b pu
git pull . $topic_branches

That's what I thought you were doing right now, but I can't imagine that 
flow leading to the same conflicts over and over, so I must be mistaken 
somehow.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
