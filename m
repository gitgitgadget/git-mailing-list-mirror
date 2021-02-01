Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E6C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 03:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E6F64E25
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 03:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBAD4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhBAD4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 22:56:34 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99AC061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 19:55:54 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h16so10252655qth.11
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 19:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l5uOnEnZWQ2yOodCTyh1VknUnMLzzWTi3IC9ZanSwl8=;
        b=AV/tFx9jwNTXJoE0OJBeg+OEtGmHiNPTWFDNP7o8ocVjyuQbmyUkZu0GwaZI1o8lwZ
         Cx3saIf0+vA8eWogSBq0dLbb/3gThQN5Eg2zcTAgCv1LWQaASBMb8Pu60P9O0wAGR0hE
         qYesqMpeOflgFdWhwvPeCBDFRrAPgAgsIyWVw5j3NpXQcveA7AcKPHbR/Z4pLEjyBZWL
         BD5VFIRfdnQmRM6JjE9SXpfE1iXGDA0E3y99fe7plbuAkcNWtPwp2CvGWg1epv0N1eM6
         cjHZhp9Q1ADo7XEMWnUfKmMMW3N1q+4+lVZ2GNIABaRLT2YKC21IqWLtCi5WRhWs9Duo
         qf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l5uOnEnZWQ2yOodCTyh1VknUnMLzzWTi3IC9ZanSwl8=;
        b=VATo4u9yAtnWvin+I8CxhizINeFJWcgHuaX/ZVGeSmhN86qKGinpcD47xexmgqa/Uw
         HsaE1YV5xJReY8EsTbxneodG/P3ZeeDPPyVYGFsSvDHPFL8Nyp54QMViq61moZ02Sj4p
         OUkE76XLdv702n2wCnc/NIj3oASTby6XfWv8J7OMEatygE8GjlXbndwe2suW2gOi/dQz
         PQ+d9IHrzkdc1hxMrZwpylAIe0LoaLtKS/n2+yGp/ePRC+85ltwGiCOproZeaOiDljHH
         Zt+8LKtQj9xS63gQCOjimQP3xKKObMlXrTBQ5LaI46KJ5fQCkQ8kcRi2TtN2jDhAi3lc
         i4fA==
X-Gm-Message-State: AOAM532Jwy3dp/uJ4ldTZkzU9Kv8ki22ZfOxyet9gfgYZfMHPWmahRC8
        UMmwgRTgwAsU+MS6tTM7PCs=
X-Google-Smtp-Source: ABdhPJwIq8QY+W1ERUHE9/EHi0JOyQsSb5t1ZGEXI4dCwOMBBotVdDNipLn1zY28Txp5/XFFF362tg==
X-Received: by 2002:ac8:5707:: with SMTP id 7mr13781299qtw.365.1612151753343;
        Sun, 31 Jan 2021 19:55:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id 186sm13209145qkh.30.2021.01.31.19.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 19:55:52 -0800 (PST)
Message-ID: <5d1e909e-b2e2-afda-d8ee-a3c32d25b01d@gmail.com>
Date:   Sun, 31 Jan 2021 22:55:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/3] commit-reach: use one walk in remove_redundant()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
 <3fe74e339fc5b7083398f2df51baae5a4a008060.1611851095.git.gitgitgadget@gmail.com>
 <xmqqtur0vl7i.fsf@gitster.c.googlers.com>
 <e5863616-ff74-88f2-3d6a-c8dbe03477fe@gmail.com>
 <xmqqft2gonuh.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqft2gonuh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/2021 3:25 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> So, the inner loop makes sure we won't revisit STALE parent, but
>>> keep digging parents we haven't seen, and stop when the generation
>>> is old enough.  What happens when there is no generation number
>>> computed yet, I wonder...  We'll keep getting infinity and dig all
>>> the way down to root?
>>
>> If we are on commits that have no generation number yet, then we
>> will walk until reaching commits in the commit-graph file that have
>> a computed generation (or in the heuristic case, when we have reached
>> all but one of the commits).
>>
>> In the case of the commit-graph, all commits will have generation
>> number "infinity". In such a case, perhaps the old algorithm _is_
>> the best we can do, at least for now.
> 
> Hmph, I am afraid that such is life X-<.
> 
>> One way to ensure we do not regress from the current behavior
>> would be to condition the new algorithm with
>>
>> 	if (generation_numbers_enabled(the_repository))
>> 		new_algorithm();
>> 	else
>> 		old_algorithm();
>>
>> much like in repo_is_descendant_of().
>>
>> Is that a good plan?
> 
> It would certainly avoid one particular form of regression, so it is
> better than nothing.
> 
> But at the same time, we'd probably want to encourage people to
> enable and maintain generation numbers for the majority of commits
> in their repository, but unless you "gc" twice a day or something,
> you'd inevitably have a mixture, say, all commits that are more than
> two weeks old are covered by commit-graph, but more recent ones are
> not yet enumerated, and you have to traverse at runtime.
> 
> And the performance characteristics we would care the most in the
> longer term is to make sure that we perform well in such a mixed
> environment for the parts of the history that are not old enough.

You're right, that in the mixed case of "all of these input commits
have infinite generation number" is the worst possible case for
this algorithm. However, if even a single commit has a finite
generation number, then this new algorithm should out-perform the
one using paint_down_to_common() in all cases.

I tested the painful case of

	git merge-base --independent 2ecedd756908 d2360a398f0b

in the Linux kernel repository with different commit-graph files.
I found that the new algorithm performed worse than the old
algorithm until there were fewer than 2,500 commits reachable
from these two but not in the commit-graph file. That's probably
too small of a gap to expect of a typical user.

I will modify my check

	if (generation_numbers_enabled(r)) {
		int i;

		/*
		 * If we have a single commit with finite generation
		 * number, then the _with_gen algorithm is preferred.
		 */
		for (i = 0; i < cnt; i++) {
			if (commit_graph_generation(array[i]) < GENERATION_NUMBER_INFINITY)
				return remove_redundant_with_gen(r, array, cnt);
		}
	}

	return remove_redundant_no_gen(r, array, cnt);

> Many things can be sped up by precomputing and storing the result in
> the commit-graph file and that is not all that interesting or
> surprising part of the story, I would think.  Rather, we want to
> ensure that we do not perform on the youngest part of the history
> any worse---that way, people will have strong incentive to enable
> commit-graph, as things will work superbly for older parts of the
> history, while not doing any worse than the original system for the
> newest parts of the history.

I'm definitely biased to a case where there is an up-to-date
commit-graph file, since I care most about server-side performance
or users with background maintenance enabled (and computing the
commit-graph frequently). You are right to call out that that is
not always the case.
 
> There was a side thread where somebody wished if they can remove
> support for all the codepaths that do not use commit-graph, but
> would this be an example of how such a wish is impractical, I have
> to wonder?

Some cases might allow de-duplication, such as
sort_in_topological_order(), that would have roughly the same
performance, give or take some overhead. It takes time to check
and see if that is the case, however.

Thanks,
-Stolee
