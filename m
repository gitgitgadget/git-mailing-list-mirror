From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to revert one of multiple merges
Date: Mon, 19 Oct 2009 21:36:38 +0200
Message-ID: <4ADCBFC6.5010807@drmicha.warpmail.net>
References: <19162.32265.738503.382638@lisa.zopyra.com>	<4ADC8387.9010808@drmicha.warpmail.net> <19164.44099.875117.96168@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzy2Q-0002L3-P6
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 21:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbZJSTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 15:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757254AbZJSTgm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 15:36:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44630 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757323AbZJSTgl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 15:36:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EFA84B4C15;
	Mon, 19 Oct 2009 15:36:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 19 Oct 2009 15:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NK7RB91hCHTgXm8iJh1ocKs1IKo=; b=GHN1IKiAEtqM3nzo/Q+4m+ewlJ/mngd34iHYahY8htelUvIelIdD5Kg3g369Xwy+1FZ27Y8yPewWMHymwrtJumXjffmYrwHz3/fNON1jiCWWpFTj1W5UzwqolRdKmyitl5oxaZ6VIOzJG3RyQylLmQZZWdk0AjZY+BgGhTfXDP0=
X-Sasl-enc: RUSk8Pgvmh3aU0t83ht1yP4QTVX1ZlvcfGUdEuRkWshM 1255981005
Received: from localhost.localdomain (p5DCC180B.dip0.t-ipconnect.de [93.204.24.11])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F2BF629B72;
	Mon, 19 Oct 2009 15:36:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091019 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <19164.44099.875117.96168@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130731>

Bill Lear venit, vidit, dixit 19.10.2009 20:13:
> On Monday, October 19, 2009 at 17:19:35 (+0200) Michael J Gruber writes:
>> Bill Lear venit, vidit, dixit 18.10.2009 04:31:
>>> Branch A, B, C each have 20 commits, 0-19.
>>>
>>> Branch v1.0.0 created, then merge of A, B, C performed.
>>>
>>> After testing, we realize that the branch B is not ready for
>>> production release and we'd like to remove it from branch
>>> v1.0.0.
>>>
>>> If I do
>>>
>>> % git merge A B C
>>>
>>> I get a single commit:
>>>
>>> % git log -p
>>>
>>> commit 1644a0b98c01869aa83e59aa41374c22098c47b6
>>> [...]
>>> Date:   Fri Oct 16 09:52:32 2009 -0500
>>>
>>>     Merge branches 'A', 'B' and 'C' into v1.0.0
>>>
>>> [20 x 3 commits]
>>>
>>> If I do
>>>
>>> % git merge A
>>> % git merge B
>>> % git merge C
>>>
>>> Then:
>>>
>>> % git log -p
>>>
>>> commit 8946edd381384d0882221c87b5b3b7bf47127d70
>>> [...]
>>> Date:   Sat Oct 17 21:28:36 2009 -0500
>>>
>>>     Merge branch 'B' into v1.0.0
>>>
>>> commit 076ed422443e3684e564f7cae2b92e4538088ae6
>>> [...]
>>> Date:   Sat Oct 17 21:28:35 2009 -0500
>>>
>>>     Merge branch 'A' into v1.0.0
>>>
>>> but no "Merge branch 'C' into v1.0.0".
>>
>> Do you get any commits after the merge of B? If yes, then v1.0.0 got
>> fast-forwarded (you can avoid that using --no-ff). If no, C was
>> contained in v1.0.0 already.
> 
> BTW this is all with git 1.6.5.
> 
> My test script that set all of this up makes no commit to any branch
> after the merge of any branch is done.  C was not in v1.0.0 already.
> Here is the script I used to set this up:
> 
> % cat scripto
> rm -rf branch_test
> mkdir branch_test
> cd branch_test
> git init
> 
> echo foo > foo
> git add foo
> git commit -a -m "foo"
> 
> git checkout -b A
> for ((i=0; i < 20; ++i)); do
>     echo "bar $i" > bar
>     git add bar
>     git commit -a -m "bar $i"
> done
> 
> git checkout master
> git checkout -b B
> for ((i=0; i < 20; ++i)); do
>     echo "baz $i" > baz
>     git add baz
>     git commit -a -m "baz $i"
> done
> 
> git checkout master
> git checkout -b C
> for ((i=0; i < 20; ++i)); do
>     echo "buz $i" > buz
>     git add buz
>     git commit -a -m "buz $i"
> done
> 
> git checkout master
> git checkout -b v1.0.0
> 
> After that, I did the merges this way:
> 
> % git merge A
> % git merge B
> % git merge C
> 
> and then the git log shows no merge of C, as above.  Hmm, actually, when I
> just ran this, I get no output showing branch A was merged.  I just
> did this again and here is the merge output:
> 
> % git branch -a
>   A
>   B
>   C
>   master
> * v1.0.0
> % git merge A
> Updating af6c884..c7e5f2c
> Fast forward

A was based off master, and v1.0.0 equals that base commit, so it's a f-f.

>  bar |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 bar
> % git merge B
> Merge made by recursive.
>  baz |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 baz
> % git merge C
> Merge made by recursive.
>  buz |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 buz
> 
> Then, git log -p shows no branch A merge:
> 
> % git log -p | grep -i merge
> Merge: f462b95 2c2b064
>     Merge branch 'C' into v1.0.0
> Merge: c7e5f2c adde6ff
>     Merge branch 'B' into v1.0.0
> 
>> In both cases, it's not clear how C could have been "ready" when B was not.
> 
> A, B, and C, are entirely independent of one another.  I'm trying to
> replicate an instance in which a feature is developed and submitted for
> inclusion in a release, accepted for inclusion, but then later found
> to be defective.
> 
>>> And so, I'm faced with git rebase -i posing some unanswerable questions
>>> to our release manager.  She cannot easily remove B from the merge after
>>> doint either merge A B C, or merge A, merge B, merge C.
>>
>> The way you described the situation there are no commits after the
>> merges. So, why not reset to before the merge and do a "git merge A C"?
> 
> Presumably, I would need to tag the v1.0.0 branch after creating it,
> which I was hoping not to have to do.  I wanted the equivalent of
> "git unmerge B" after doing three separate merges as above, or an octopus
> merge.  I'm just trying to make life simpler for our release manager,
> who is not equipped with git fu.

I think the octopus case is difficult. So let's treat the other one ;)

If you have separate merges you can revert them separately. You don't
need to tag them, you only need to be able to find the merge commit, say
using

git log --grep='Merge branch'

Then you can revert that merge using

git revert -m 1 sha1ofthatmerge

Now comes the difficult part: If, later on, you want to merge B *and
include also the parts of B from before that previous merge* you need to
revert that revert, then merge. If, on the other hand, you only want to
merge the "new parts" of B then simply merge B.

The reason is that reverting a merge undoes its changes, but still
leaves the merge in the DAG, so that the commits of the merged branch
are still considered part of the history, and as such won't be merged in
again.

howto/revert-a-faulty-merge.txt explains this, but the above is a short
summary.

Cheers,
Michael
