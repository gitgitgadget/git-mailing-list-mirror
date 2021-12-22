Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 17:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhLVR2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLVR2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 12:28:21 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27886C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 09:28:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i8-20020a639d08000000b00340a257c531so1755901pgd.16
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 09:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ftdnrF+exOXO0gOMeOHFCj3cptqhWbyBn2NpSYG4ziU=;
        b=D3kdIjU37LSL0PCNJ3UfjDrPby+c2eoB8Isq+apyWgnOwslC3tyWgs6krVhyTkEcfC
         arvh3p8GRmFMnZ7yvcVmAew88JhCGMr6gwTCkFvrLpgMWWs/6hnmCcIY30gLWHxs5hg5
         L2VKer8GOhWoBM9++erObzmN4hNxT4OL5feZDv9+xuCLsm8i6az1Dgs0tYpCPr9pkHiq
         knSHzh9mTV0+xmtJn3xDAmEJy0bVdJGIml3m8+UCkPNcDR95+UfJ62ArguLBcSeG+PE5
         r8sZ7OEi/rq+LOs0277awK0SQ2j2U+faZTe2sqkvExEAZcLcj6KobLU5ncoLPggYkVjF
         n4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ftdnrF+exOXO0gOMeOHFCj3cptqhWbyBn2NpSYG4ziU=;
        b=fs1GdEXGYrxvbwXr7p4kqscAD3PHzl1ZGJ2t1wN2L7lFCXX3w4h9GhtLMf3eRbYW5a
         zWTU07ceNMqY6aXh25/poQL/nkhh4ISdssMeNEjYg/Fz90/i4Y1P9P95/WMAEdWmiJYg
         7OKThY45XhLBuS8Wr19z5hEhfJR5ziohLckruM527xqeGGrQlMUo57Bjr0DaaIaCcGIH
         TdSFooLOpmgOLBtDQMtU38nEwr1fWL3A140Bg/N2+4/QWUW3jvpSVh1ycBLkFGWGDvSI
         tbUiLJcbmWR8jXT7VxJGdmAjacW8JNpjIpptZsKbTs4XWmGWlW1rPRv606PocQ87AJ+h
         sDdw==
X-Gm-Message-State: AOAM532DK8KaTBtTMGZUrdHeDFxr1brAm6FtK0HbaETdF6QFCgbdMCkM
        5B8BgZAA/26SLTOqhfL7bKi1OkxkezvGNQ==
X-Google-Smtp-Source: ABdhPJwuCCU19REBJizoQQw7iqceUJIazqLuYMeM91b2bTm0mNNdtyAXK/UnfAx73Kggwd/ZpKpwa8MKPUI2Ag==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b51:: with SMTP id
 mi17mr2494420pjb.48.1640194099649; Wed, 22 Dec 2021 09:28:19 -0800 (PST)
Date:   Wed, 22 Dec 2021 09:28:17 -0800
In-Reply-To: <xmqqa6gtkumz.fsf@gitster.g>
Message-Id: <kl6l8rwczgzy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com> <20211222001134.28933-1-chooglen@google.com>
 <20211222001134.28933-3-chooglen@google.com> <xmqqa6gtkumz.fsf@gitster.g>
Subject: Re: [PATCH v3 2/3] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> @@ -2113,6 +2122,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  		result = fetch_multiple(&list, max_children);
>>  	}
>>  
>> +	/*
>> +	 * Skip irrelevant tasks because we know objects were not
>> +	 * fetched.
>> +	 *
>> +	 * NEEDSWORK: as a future optimization, we can return early
>> +	 * whenever objects were not fetched e.g. if we already have all
>> +	 * of them.
>> +	 */
>> +	if (negotiate_only)
>> +		goto cleanup;
>
> Sorry if I did not mention this in the review of the earlier round,
> but I think the location this patch places the jump is wrong,
> especially with the NEEDSWORK comment.
>
> When we are not under negotiate_only, if our earlier call to
> transport_fetch_refs() learns to tell us that that we did not add
> any new objects, we would be able to jump to the clean-up label,
> making the above code to:
>
> 	if (negotiate_only || !num_fetched_objects)
> 		goto cleanup;

Thanks for the clarification. Yes, we agree that the location of the
jump in this patch should be the same as the location of the jump after
the future optimization.

> But such a future enhancement is made harder by having this jump
> here---the optimization the NEEDSWORK comment alludes to has no
> reason to be incompatible with "--recurse-submodules".
>
> If the above block is placed _after_ the "if the main fetch was
> successful, and we are not told not to recurse into submodules, then
> do this" block we see below, then
>
>  (1) this patch still achieves its goal, as we have manually
>      and unconditionally turned recursion off;
>
>  (2) such a future enhancement will not be forbidden from working
>      with recurse-submodules feature.
>

I would have come to same conclusion if I agreed that we should recurse
into submodules even if no objects are fetched. When I first wrote this
patch, I was convinced that "no new objects" implies "no need to update
submodules" (see my response at [1]), but I'm not sure any more and I'd
like to check my understanding.

The way "fetch --recurse-submodules" works is that the changed
submodules are calcuated from the newly updated tips fetched from the
remote. If no objects were fetched, we already have all of the
superproject commits.

In ~99% of the time, no objects were fetched because the remote doesn't
have any info we do not know about - there are no new commits and no
refs were updated. In this scenario, 'git fetch' can avoid recursing
into submodules because there's no need to. But if we choose to recurse,
the worst thing that happens is that we do some file I/O and realize
that there are no changed submodules - essentially a no-op given that
fetch is slow.

(This is where my understanding of objects vs refs needs to be checked)
In the other ~1%, we might already have all commits, but a remote ref
might still have moved, albeit to a known commit. In this case, the
submodule would need to be updated because it might have changed.

If my understanding is correct, then my patch produces the wrong
behavior in that ~1%. But even if my understanding is wrong, and we
don't need to worry about that edge case, I see that there's unnecessary
risk in trying to be too be clever in my reasoning and skipping what is
essentially a no-op.

Is my understanding accurate? At any rate, I'm somewhat convinced to
move the jump to just after the "if main fetch was successful, and we
are not told not to recurse into submodules" block, i.e. before the "if
we should write the commit graph" block.

[1] https://lore.kernel.org/git/kl6ltuf3ysnw.fsf@chooglen-macbookpro.roam.corp.google.com

>>  	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>>  		struct strvec options = STRVEC_INIT;
>>  		int max_children = max_jobs;
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 8212ca56dc..732031085e 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -229,6 +229,18 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>>  	test_i18ngrep "push negotiation failed" err
>>  '
>>  
>> +test_expect_success 'push with negotiation does not attempt to fetch submodules' '
>> +	mk_empty submodule_upstream &&
>> +	test_commit -C submodule_upstream submodule_commit &&
>> +	git submodule add ./submodule_upstream submodule &&
>> +	mk_empty testrepo &&
>> +	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
>> +	test_commit -C testrepo unrelated_commit &&
>> +	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
>> +	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
>> +	! grep "Fetching submodule" err
>> +'
>> +
>>  test_expect_success 'push without wildcard' '
>>  	mk_empty testrepo &&
