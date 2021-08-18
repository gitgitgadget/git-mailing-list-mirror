Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D7C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C8F610FD
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhHRSms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHRSmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:42:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65229C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:42:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w6so4676411oiv.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yFIW5pAxERiVbRut27SstwnkJJ+GpiDPShQjVOvtezE=;
        b=K59XSBg6Rqd5KOtOTf9ohgwL0fX+9hAppON1MzxvpGKVWD+EjZ7b9gxsLq6dr1P2H0
         xr3FA9WX+bm1m0Wv+rB/Yc9gUDoANnEjC+hlyBxEIpSxTAVcbXVyHKHVLIoLmfpp00A+
         ovPGYrG0hMUPOsnd5yas75ayu0ZRuD5M2U7fpELB4unwqrKGistKmGI19KcluAM89Ktn
         Ioa474dIaPw5J2FcWgSoMwqkY3stG1LwzY34OEuYMqjUhJS2GDX4XkAuUp/sqX/tJCkb
         tfM55pVHCHhX249Iuc39n+5C0/oMLhqYFSKEInldzBOMzlmpRhEcC61uoISZXcBf7Dai
         3Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFIW5pAxERiVbRut27SstwnkJJ+GpiDPShQjVOvtezE=;
        b=cE1kfrgi0/+4HQaXx+pyRBrjHKoQac2ZM5WvjXCnWS/AmfmoZrhCQaMsRRyIK/Z2Ha
         MNUgtSkrH8lFqim/nGcOGVotxq/7VNC6XRqUPUrXixvBQ2jPGU0FOVlxCOiqxeiVN0q4
         9Fm30d1Ju22UXt4+u4HAyQc30j/AoW77AbJmnUj0GJ8nfiCqEEijWPZe6YGcCiN3htb6
         Gzph5+ZeJyX96U9DrCvMdAmvci/g5Hw++T4XpNmBjgzl7/9INmdxXr7pPGReGy7z5U/y
         +Pcg/oSc8W7QuG0Vkr2RAanLba/rY2wqE4H1mtcKmFc1ABIUHVbrpPAFP4lyYGtmg45C
         Pq/A==
X-Gm-Message-State: AOAM532Gs/d2tt2n56dT8s/t0+dQC7QCHnI2I5kFECHkpU5vwaVSlS9z
        HmtMumPSCOUzMNFJ5IptubI=
X-Google-Smtp-Source: ABdhPJwZNgNYLHt1Ulm/IdURuNrGp3cuxDQkxqbJjzxTOi6cy6Do45mc8ox/nabwjvWPZjRXBkGdMw==
X-Received: by 2002:a05:6808:6:: with SMTP id u6mr8480711oic.150.1629312131758;
        Wed, 18 Aug 2021 11:42:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:581d:96e0:cdbb:9c3d? ([2600:1700:e72:80a0:581d:96e0:cdbb:9c3d])
        by smtp.gmail.com with ESMTPSA id c7sm163161otl.30.2021.08.18.11.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 11:42:11 -0700 (PDT)
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
 <xmqqzgte62ud.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
Date:   Wed, 18 Aug 2021 14:42:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgte62ud.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2021 2:10 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The sparse index will be compatible with the ORT merge strategy, so
>> let's use it explicitly in our tests.
> 
> Unless you mean that the sparse index will only be compatible with
> ort, but will never be with recursive, I do not quite see why this
> is taking us into a good direction.  Is this because we want to gain
> test coverage for ort early, before we flip the default to ort [*1*]?

The sparse index will _work_ with the recursive merge strategy, it will
just continue to be slow, and likely slower than if we had a full index.
This is because the recursive merge algorithm will expand a sparse index
into a full one before doing any of its logic (hence my confidence that
it will work).

The main point why ORT is the focus is that the ORT strategy is required
so the sparse index can get the intended performance gains (i.e. it does
not expand in most cases). The ORT algorithm can resolve conflicts
outside the sparse-checkout cone without needing the index as a data
structure and instead the resulting tree is recorded in the correct
sparse directory entry.

> [Footnote]
> 
> *1* If the answer is "no, it is because sparse index will not work
>     with recursive", the please disregard the rest, but just in
>     case it is not...
> 
>     It seems to me that it would let us live in the future in a more
>     comprehensive way if we tweaked merge_recursive() and/or
>     merge_recursive_generic() so that all internal callers, not just
>     builtin/merge.c, would redirect to the ort machinery when say
>     GIT_TEST_REPLACE_RECURSIVE_WITH_ORT environment exists, and
>     doing it that way we do not need to sprinkle "-srecursive" and
>     "-sort" everywhere in our tests at randomly chosen places to
>     give test coverage to both strategies.

I could also change this patch to stop using ORT _all the time_ and
instead let the GIT_TEST_MERGE_ALGORITHM decide which is tested.

That is, except for the final tests that check that the index is not
expanded. Those tests must specify the ORT strategy explicitly.

I think I started playing with the GIT_TEST_MERGE_ALGORITHM because
it appears to override the command-line option, but I will need to
double-check that.

Thanks,
-Stolee
