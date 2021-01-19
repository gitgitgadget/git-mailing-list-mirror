Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12BC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5ED230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbhASHqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:46:46 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:46746 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbhASHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:08 -0500
Received: from [10.42.0.115] (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10J7hw46011490
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 19 Jan 2021 02:43:59 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10J7hw46011490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611042240; bh=R+nMSApAcDZ+R2w3icpKF//d2XOsLRW3iE3peoLLNLU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HW18pggm2Hll36HyHFXNPpFIwhwZP2V+M2AuZeUYOP2lG9X3nMwGvFbfrlOFgGfyX
         qTKJwJyMh+5MkUvaugjG3KpJ38oYnHCEzl/JOill7sotuFONnljCmnLSG87S6V42Hc
         OBujmvn82FWweei+hWEHkkpvWsvzPKPQ2pZqdto/ievRnaECFj/OM88UsgQ8edTE3y
         vFVf4BlYIeTEgjiARccDhLptrFKEQVUDmxGrIOfs297pz8DoSyEhErF/wLJqqp7SGd
         rZlgGRz/opdIbXzUDqFrqlNrcxqjEyXTRb9z/x72n0mQWwTUC4Ph9PLpYetUTTvN4T
         KqgDvIfwn8c7Q==
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
 <20210117110337.429994-2-kmarek@pdinc.us>
 <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
 <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
 <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
 <xmqqr1mij88k.fsf@gitster.c.googlers.com>
From:   Kyle Marek <kmarek@pdinc.us>
Message-ID: <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
Date:   Tue, 19 Jan 2021 02:43:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1mij88k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/21 3:33 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> [Footnote]
>>
>> *1* Stepping back a bit, I think concentrating too much on "is it
>>      root?" is a wrong way to think about the problem.  Suppose you
>>      have two histories, e.g. (time flows from left to right; A and X
>>      are roots)
> A shorter and more concrete example.  Start from an empty repository:
>
> 	$ git init
> 	$ git commit --allow-empty -m Aroot
> 	$ git checkout --orphan side
> 	$ git commit --allow-empty -m Xroot
> 	$ git log --all --graph --oneline
>          * a1f7cb2 (HEAD -> side) Xroot
>          * b6fb655 (master) Aroot
>
> These depict two root commits, Aroot and Xroot, and no other
> commits.  We do want to show that these two commits do not have
> parent-child relationship at all, and your (and a few proposals made
> by other in the past) solution was to show them both with "#".
>
> Continuing in the same repository:
>
> 	$ git checkout --orphan another
> 	$ git commit --allow-empty -m Oroot
> 	$ git commit --allow-empty -m A
> 	$ git log --graph --oneline ^another^ another side
>          * eddf116 (HEAD -> another) A
>          * a1f7cb2 (side) Xroot
>
> These depict two commits, A and Xroot, and no other commits.  We
> also want to show that these two commits do not have parent-child
> relationship at all, but if we paint Xroot with "#", it still makes
> it appear that A is a child of Xroot.
>
>>      And the right way to look at it is "does A have any parent in
>>      the part of the history being shown?", not "does A have any
>>      parent?"  Then 'A' will get exactly the same treatment in the
>>      two examples, and the visual problem that makes A appear as if
>>      it has parent-child relationship with unrelated commit X goes
>>      away.
> So the condition we saw in your patches, !commit->parents, which
> attempted to see if it was root, needs to be replaced with a helper
> function that checks if there is any parent that is shown in the
> output.  Perhaps
>
> 	int no_interesting_parents(struct commit *commit)
> 	{
> 		struct commit_list *parents = commit->parents;
>
> 		while (parents) {
> 			if (!(parents->object.flags & UNINTERESTING))
> 				return 0;
> 			parents = parents->next;
> 		}
> 		return 1;
> 	}
>
> or something like that should serve as a replacement, i.e.
>
> 	return !commit->parents ? "#" : "*";
>
> would become
>
> 	return no_interesting_parents(commit) ? "#" : "*";
>
> Hmm?

Okay, I see what you mean. Fixing --graph to avoid implying ancestry 
sounds like a better approach to me.

That being said, I spoke to Jason recently, and he expressed interest in 
optionally marking root commits so they are easy to search for in a 
graph with something like /# in `less`. I see value in this, too.

So would you be open to my modifying of the patch in question (patch 1+2 
squashed, I guess) to instead use "--mark-roots=<mark>" to optionally 
mark root commits with a string <mark>, and pursue fixing the --graph 
rendering issue in another series?

If so, what would you like to see out of the --left-right issue? Maybe 
"--mark-left-root=<mark>" and "--mark-right-root=<mark>", so multi-byte 
strings may be used? Can there be more than one root on either side? (so 
the option would use a plural "roots" instead of "root"?)

-- 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Kyle Marek                        PD Inc. http://www.pdinc.us -
- Jr. Developer                     10 West 24th Street #100    -
- +1 (443) 269-1555 x361            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

