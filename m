From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Wed, 02 May 2012 09:44:52 -0400
Message-ID: <1335966292.14207.40.camel@gandalf.stny.rr.com>
References: <20120502004439.965120020@goodmis.org>
	 <CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
	 <7v62cf6y3d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-i1GOf1ESdzsghpoZJQGN"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed May 02 15:45:12 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SPZri-0001y3-PU
	for glk-linux-kernel-3@plane.gmane.org; Wed, 02 May 2012 15:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab2EBNo7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 May 2012 09:44:59 -0400
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:25449 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab2EBNoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 May 2012 09:44:55 -0400
X-Authority-Analysis: v=2.0 cv=fvFelSEf c=1 sm=0 a=ZycB6UtQUfgMyuk2+PxD7w==:17 a=XQbtiDEiEegA:10 a=9QRZpqc-8XMA:10 a=5SG0PmZfjMsA:10 a=Z4Rwk6OoAAAA:8 a=pe7uiH_1oFhS6a0rf0IA:9 a=qc93Q-uhG_Dmufa0CxcA:7 a=PUjeQqilurYA:10 a=jbrJJM5MRmoA:10 a=IvSWoApnl5rvpy7U1OMA:9 a=ZycB6UtQUfgMyuk2+PxD7w==:117
X-Cloudmark-Score: 0
X-Originating-IP: 74.67.80.29
Received: from [74.67.80.29] ([74.67.80.29:37284] helo=[192.168.23.10])
	by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 0C/AE-23230-45A31AF4; Wed, 02 May 2012 13:44:53 +0000
In-Reply-To: <7v62cf6y3d.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196815>


--=-i1GOf1ESdzsghpoZJQGN
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-01 at 20:49 -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 

> When a normal developer wants to _reset to_ a particular tagged release,
> in order to _start_ new work, she wouldn't be doing even the above "git
> pull linus v3.4-rc5".  That will contaminate the result with whatever
> random stuff she happened to have on the current branch.  A more natural
> sequence would be "git fetch --tags linus" followed by either
> 
>         git checkout v3.4-rc5 ;# to detach

The problem is, I like to know what has been pulled into mainline. I
have patches in quilt (for ktest only, not for my other work) and will
start adding them on a "clean" release. By doing a git pull (or fetch
and merge), I like to see the fast forward to know if everything that's
in my current branch has been pulled. If it hasn't, then something may
have been missed.

> 
> or
> 
>         git checkout -b mywork v3.4-rc5 ;# to start

But then I would end up with several branches that would require
deleting. One way I could see myself in handling this case would be to
delete the current branch and start again (thinking that everything was
already pulled). But by doing that, if something wasn't pulled in, then
I would have lost those changes without ever knowing.

> 
> So the case to "reset to" is not very interesting.
> 
> But when a normal developer wants to _sync to_ a particular tagged
> release, in order to _continue_ working on her topic, she would need to
> have a merge (unless she does not have _anything_ herself), and at that
> point, merging v3.4-rc5 vs v3.4-rc5^0 would not make that much of a
> difference.  If she absolutely detests the "mergetag" header, she could do
> a "git fetch --tags linus" followed by
> 
> 	git merge v3.4-rc5^0
> 
> which admittedly is two more letters than she used to type.

This would fit into my workflow. Thus I could use this.

> 
> If you mean by "Ideas" for additional features, obviously the last step
> could be enhanced to use a more intuitive command line that requires the
> user to type even more, i.e.
> 
> 	git merge --ff v3.4-rc5
> 
> Once that is done, "git pull --ff linus v3.4-rc5" would fall out as a
> logical consequence.
> 
> But obviously these two would need new code ;-)

The -ff would make sense as it seems to be the logical thing a user
would want. If they specify the fast-forward flag, then the user would
expect the merge to be a fast forward if possible.

BTW, is there a git compare type option. That is, I like to compare two
separate branches with the result that one currently gets with git when
a branch is following another branch. When you check out that branch, it
gives you an update on how those two branches are related (is one a fast
forward of the other, are they off by different commits?). It would be
nice if git could do this with any two branches. I wrote a script to do
this for me (attached) but it would be nice if git had it natively.

$ git-branch-status v3.0.4 v3.0.5              
Branch v3.0.4 can be fast forward to v3.0.5 in 240 commits

$ git-branch-status v3.0.4 v3.1  
Branch v3.0.4 and v3.1
differ by 257 and 9380 commit(s) respectively


-- Steve

--=-i1GOf1ESdzsghpoZJQGN
Content-Type: application/x-shellscript; name="git-branch-status"
Content-Disposition: attachment; filename="git-branch-status"
Content-Transfer-Encoding: 7bit

#!/bin/bash

if [ $# -lt 1 ]; then
	echo "usage: git-branch-stat [branch1] branch2"
	exit
fi

if [ $# -lt 2 ]; then
	b1="HEAD"
	b2=$1
else
	b1=$1
	b2=$2
fi


c1=`git rev-list $b1..$b2 | wc -l`
if [ $? -gt 0 ]; then
	echo error in git
	exit
fi

c2=`git rev-list $b2..$b1 | wc -l`
if [ $? -gt 0 ]; then
	echo error in git
	exit
fi

if [ $c1 -eq 0 -a $c2 -eq 0 ]; then
	echo "Branch $b1 and $b2 are equal"
	exit
fi

if [ $c1 -eq 0 ]; then
	echo "Branch $b2 can be fast forward to $b1 in $c2 commits"
	exit
fi

if [ $c2 -eq 0 ]; then
	echo "Branch $b1 can be fast forward to $b2 in $c1 commits"
	exit
fi

echo "Branch $b1 and $b2"
echo "differ by $c2 and $c1 commit(s) respectively"

--=-i1GOf1ESdzsghpoZJQGN--
