From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Wed, 26 Jan 2011 15:22:27 +0800
Message-ID: <4D3FCBB3.2090508@intel.com>
References: <4D3CDDF9.6080405@intel.com>	<AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>	<4D3D54D3.7040801@intel.com> <AANLkTin1rS-ZBDx4j-UNFH4z9tnTiv5LBodLO-G2U2UF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 08:22:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhziK-0008Gk-9D
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 08:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab1AZHWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 02:22:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:30714 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab1AZHWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 02:22:31 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 25 Jan 2011 23:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,379,1291622400"; 
   d="scan'208";a="700754810"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.254.208.80]) ([10.254.208.80])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2011 23:22:28 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTin1rS-ZBDx4j-UNFH4z9tnTiv5LBodLO-G2U2UF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165505>

On 2011/1/25 17:20, Christian Couder wrote:
> On Mon, Jan 24, 2011 at 11:30 AM, Shuang He<shuang.he@intel.com>  wrote:
>> On 2011/1/24 17:53, Christian Couder wrote:
>>> Hi,
>>>
>>> On Mon, Jan 24, 2011 at 3:03 AM, Shuang He<shuang.he@intel.com>    wrote:
>>>> Hi
>>>>      The default git-bisect algorithm will jump around the commit tree,
>>>> on the purpose of taking least steps to find the first culprit commit.
>>>> We may find it sometime would locate a old culprit commit that we're not
>>>> concerned about anymore.
>>> Yes, it can be a problem.
>> I'm honored to be given so much comment :)
>> Thank you
> I am honored by your interest in git bisect and the fact that you
> provided a patch :-)
> Thanks!

I'm glad to see that git community is so hot.

>
>>> If the quality of these branches is too bad, I think they should not
>>> have been merged in the first place.
>>> If they are not merged (and not marked as good), then git bisect will
>>> not look at them, since it will look only at commits that are
>>> ancestors of the bad commit it is given.
>>>
>>> Or if one is merged but it causes too many problems, then perhaps a
>>> replacement commit could be used to unmerge the branch.
>>>
>>> Another possibility is to have in a file a list of commits that are
>>> the last commits on these branches before the merge commits, and do a:
>>>
>>> git bisect good $(cat good_commits_file.txt)
>>>
>>> at the beginning of each bisection.
>>>
>>> So I think the long term solution in this case is not what your are
>>> suggesting.
>> Yeah, I agree that the issue I addressed above will not be a problem if all
>> those branches are maintained very well.
>> Actually we've implemented a automated bisect system for Intel Linux
>> Graphics Driver Project, and so we'd like the system
>> helps us to locate issue in an more automatic way when branches are not
>> maintained as good as expected.
> I think there is always a price to pay when you bisect if the branches
> are not well maintained.
> Maybe your algorithm could help in some cases, but my opinion is that
> there will probably still be many problems and a human will often have
> to take a look.
>

Yes, I agree. What we trying to do is just make the machine to do more 
help for human.

>>>>          2. Some of those branches may not synchronized with main
>>>> branch in time.  Say feature1 is broken when feature2 branch is created,
>>>> and
>>>> feature1 is fixed just a moment later after feature2 branch is created,
>>>> and when feature2's development is done, and developer want to merge
>>>> feature2 branch back to master branch, feature2 will be firstly
>>>> synchronized to master branch tip, then merge into master.  For the same
>>>> reason addressed in issue 1, this will also lead git-bisect into wrong
>>>> direction.
>>> I am not sure what you mean by " feature2 will be firstly synchronized
>>> to master branch tip", and I think this should mean a rebase that
>>> would fix the bug if feature1 has already been merged into the master
>>> branch.
>>>
>>> But anyway in this case, I think that git bisect will find that the
>>> first bad commit is the last commit in the branch, just before it was
>>> merged. And by looking at the branch graph it should be quite easy to
>>> understand what happened.
> Now I think I was wrong here, as git bisect will probably find that
> the first commit in the branch (not the last one) is the first bad
> commit.
>
> [...]
>
>>> - the name "bisectbadbranchfirst" seems wrong to me, because git
>>> branches are just some special tags; "firstparentsonly" would be a
>>> better name,
>> It's recursively applying bad branch first algorithm, not just constantly
>> stick to first parent.
>> Given this condition:
>>     A ->  B ->  C ->  D ->  E ->  F ->  G ->  H   (master)
>>          \ a  ->  b ->  c ->  d ->  e /  (feature 1)
>>               \ x ->  y ->  z/      (feature 2)
>> start with H as bad commit, and A as good commit, if y is the target bad
>> commit. bad-branch-first algorithm will do it like this:
>>     1. In first round stick to master branch, so it will locate G as first
>> bad commit
>>     2. In second round stick to feature1 branch, then it will locate d as
>> first bad commit
>>     3. In third round stick to feature2 branch, then it will finally locate y
>> as first bad commit
>> So you could see, it's always sticking to branch where current bad commit
>> sit
> I see. It is interesting, but why not develop a "firstparentsonly"
> algorithm first?
>
> As Avery explains in his email, it is already interesting to have a
> "firstparentsonly" algorithm because some people are only interested
> to know from which branch the bug comes from.
> When they know that, they can just contact the relevant people and be
> done with it.
>
> And when we have a "firstparentsonly" algorithm, then your algorithm
> could be just a script that repeatedly uses git bisect with the
> "firstparentsonly" algorithm. And this script might be integrated in
> the "contrib" directory if it not considered important to be
> integrated as an algorithm into git bisect.

Sorry to reply so late, since I was on a long journey home for Chinese 
New Year vacation ;)
I agree that's also an good option.
Is it acceptable to add option to git-bisect stuff, so user could choose 
which algorithm to use at every step at will.
And we have tested previous attached patch with t6002-rev-list-bisect.sh 
and t6030-bisect-porcelain.sh, and we get:
     with bad-branch-first disabled (which is the default setting):
         t6002-rev-list-bisect.sh: # passed all 45 test(s)
         t6030-bisect-porcelain.sh: # passed all 40 test(s)
     and with bad-branch-first enabled:
         t6002-rev-list-bisect.sh: # passed all 45 test(s)
         t6030-bisect-porcelain.sh: # failed 5 among 40 test(s), and I 
have spent some time digging into those failures ,and it seems they're 
all false negative since they're using hard-coded bisect path to 
validate specific case

Thanks
     --Shuang
> Thanks,
> Christian.
