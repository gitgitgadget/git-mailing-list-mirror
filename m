From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Wed, 26 Jan 2011 18:40:16 +0800
Message-ID: <4D3FFA10.4010807@intel.com>
References: <4D3CDDF9.6080405@intel.com>	<AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com>	<4D3D54D3.7040801@intel.com>	<AANLkTin1rS-ZBDx4j-UNFH4z9tnTiv5LBodLO-G2U2UF@mail.gmail.com>	<4D3FCBB3.2090508@intel.com> <AANLkTi=T+oapfn1CTu_smU1P+JEraihE4BUKJcB=uBHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 11:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi2nd-000498-N5
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 11:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab1AZKkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 05:40:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:36869 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab1AZKkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 05:40:19 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2011 02:40:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,379,1291622400"; 
   d="scan'208";a="881112635"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.254.208.80]) ([10.254.208.80])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2011 02:40:17 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=T+oapfn1CTu_smU1P+JEraihE4BUKJcB=uBHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165515>

On 2011/1/26 17:44, Christian Couder wrote:
> On Wed, Jan 26, 2011 at 8:22 AM, Shuang He<shuang.he@intel.com>  wrote:
>> On 2011/1/25 17:20, Christian Couder wrote:
>>>> Yeah, I agree that the issue I addressed above will not be a problem if
>>>> all
>>>> those branches are maintained very well.
>>>> Actually we've implemented a automated bisect system for Intel Linux
>>>> Graphics Driver Project, and so we'd like the system
>>>> helps us to locate issue in an more automatic way when branches are not
>>>> maintained as good as expected.
>>> I think there is always a price to pay when you bisect if the branches
>>> are not well maintained.
>>> Maybe your algorithm could help in some cases, but my opinion is that
>>> there will probably still be many problems and a human will often have
>>> to take a look.
>>>
>> Yes, I agree. What we trying to do is just make the machine to do more help
>> for human.
> Yeah, this is the way to go. And by the way I am happy to know that
> you have implemented an automated bisect system. That's great and I
> hope it already helps.
>
>>>>> - the name "bisectbadbranchfirst" seems wrong to me, because git
>>>>> branches are just some special tags; "firstparentsonly" would be a
>>>>> better name,
>>>> It's recursively applying bad branch first algorithm, not just constantly
>>>> stick to first parent.
>>>> Given this condition:
>>>>     A ->    B ->    C ->    D ->    E ->    F ->    G ->    H   (master)
>>>>          \ a  ->    b ->    c ->    d ->    e /  (feature 1)
>>>>               \ x ->    y ->    z/      (feature 2)
>>>> start with H as bad commit, and A as good commit, if y is the target bad
>>>> commit. bad-branch-first algorithm will do it like this:
>>>>     1. In first round stick to master branch, so it will locate G as first
>>>> bad commit
>>>>     2. In second round stick to feature1 branch, then it will locate d as
>>>> first bad commit
>>>>     3. In third round stick to feature2 branch, then it will finally
>>>> locate y
>>>> as first bad commit
>>>> So you could see, it's always sticking to branch where current bad commit
>>>> sit
>>> I see. It is interesting, but why not develop a "firstparentsonly"
>>> algorithm first?
>>>
>>> As Avery explains in his email, it is already interesting to have a
>>> "firstparentsonly" algorithm because some people are only interested
>>> to know from which branch the bug comes from.
>>> When they know that, they can just contact the relevant people and be
>>> done with it.
>>>
>>> And when we have a "firstparentsonly" algorithm, then your algorithm
>>> could be just a script that repeatedly uses git bisect with the
>>> "firstparentsonly" algorithm. And this script might be integrated in
>>> the "contrib" directory if it not considered important to be
>>> integrated as an algorithm into git bisect.
>> Sorry to reply so late, since I was on a long journey home for Chinese New
>> Year vacation ;)
> No problem. I am not in a hurry at all. In fact I don't have much time
> these days so I reply very late too.
>
>> I agree that's also an good option.
>> Is it acceptable to add option to git-bisect stuff, so user could choose
>> which algorithm to use at every step at will.
> Are you sure it is needed to be able to change the algorithm at every step?

I don't think it's needed, it would just give user more control over the 
algorithm.

> This means that you would like a new "git bisect strategy<strategy>"
> subcommand ?
>
> First I thought that we could just add a "--strategy<strategy>"
> option to "git bisect start".
> But anyway, I think it should be easy to add afterward, and it can be
> done in a separated patch that can be discussed on its own.

Yeah, agree. We could discuss this later

>> And we have tested previous attached patch with t6002-rev-list-bisect.sh and
>> t6030-bisect-porcelain.sh, and we get:
>>     with bad-branch-first disabled (which is the default setting):
>>         t6002-rev-list-bisect.sh: # passed all 45 test(s)
>>         t6030-bisect-porcelain.sh: # passed all 40 test(s)
>>     and with bad-branch-first enabled:
>>         t6002-rev-list-bisect.sh: # passed all 45 test(s)
>>         t6030-bisect-porcelain.sh: # failed 5 among 40 test(s), and I have
>> spent some time digging into those failures ,and it seems they're all false
>> negative since they're using hard-coded bisect path to validate specific
>> case
> Yes, there are some hard coded commits that depend on the algorithm.
> Anyway I did not look in depth at your patch yet, and as I said it
> would be better if you could split it into a patch series where a
> "firstparentsonly" algorithm is implemented first.
> This way it will be easier to review, and we can start to integrate
> some non controversial features, and then discuss the other ones on
> their own merit.
>
> Thanks in advance,
> Christian.

Thanks for the good suggestion, I'll start the work soon.

Thanks
     --Shuang
