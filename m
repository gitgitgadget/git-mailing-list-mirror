From: =?UTF-8?B?UMSTdGVyaXMgS8S8YXZpxYbFoQ==?= <klavins@netspace.net.au>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 23:40:44 +0100
Message-ID: <j0a9te$vcv$1@dough.gmane.org>
References: <20110721125544.26006.qmail@science.horizon.com> <1311263869.9745.72.camel@drew-northup.unet.maine.edu> <4E2852A1.30800@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 00:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qk1vc-0001US-CE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 00:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab1GUWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 18:41:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:57116 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab1GUWlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 18:41:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qk1vO-0001Mu-8e
	for git@vger.kernel.org; Fri, 22 Jul 2011 00:40:58 +0200
Received: from 188.141.121.82 ([188.141.121.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 00:40:58 +0200
Received: from klavins by 188.141.121.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 00:40:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.141.121.82
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E2852A1.30800@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177628>

On 21/07/2011 5:24 PM, Phil Hord wrote:
> Maybe the confusion comes from the different storage mechanisms being
> discussed. If the generation numbers are in a local cache and used by a
> single client, the determinism of the specific numbers doesn't much
> matter. If they are part of the commit, it still doesn't need to be
> completely deterministic. However, interoperability requires standards,
> and standards favor determinism, so dogmatic determinism may triumph in
> that case.
>
> 1. gen(06) might make sense if you mean to implement --date-order using
> gen-numbers, for example. But I don't think it's practical in any case.
>
> 2. gen(06)+1 might make sense if you mean to require that gen-numbers
> are unique per repo. But this is both unsupportable and unnecessary, so
> it's a non-starter.
>
> 3. gen(B)+1 is what you'd get from the the algorithm I saw proposed.
>
> All three of these are provably correct by my definition of "correct":
> "for each A in ancestors_of(B), gen(A) < gen(B)".
>
> However, [1] and [2] have some extra features of dubious value. Simpler
> is better for interoperability, so I like [3] for this purpose.
>
> Even [3] has an extra feature I think is unnecessary: determinism. If
> that "requirement" is dropped, I think all three of these algorithms are
> (functionally) roughly equivalent.
>
>> I don't think everybody MEANT to be saying such
>> different things--that's just how they appeared on this end.
>>
>> Now, did you mean something different by "commit number?"
>
> I remain unconvinced that there is value in gen-number distribution, so
> to my mind, the specific algorithm and whether or not it is
> deterministic are unimportant.
>

The beauty of Git is that no two copies of a Git repository as a whole 
are the same:  some people make shallow copies;  others prune away all 
branches except for the one they are interested in;  yet others graft 
together multiple original repositories.  The upshot is that two copies 
of the same repository may end up having different commits as their root 
commits, and so the generation numbers computed for their repositories 
would be different.  Indeed, the shallow repository copy could later be 
filled out with additional underlying commits, and so on.

Given this context, I can't see the value in fixing generation numbers 
within commits.  In my mind generation numbers are extremely useful 
transient helper objects in every Git repository but they have no 
meaning outside that repository, sort of like GIT_WORK_TREE.

Peter
