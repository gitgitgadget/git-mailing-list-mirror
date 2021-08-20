Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF1C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F1161214
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhHTPbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHTPbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:31:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75476C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:30:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so6041408otg.11
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nByDzUliSnVZuWAqOrjnhI6KnedkqnEPmcY2L/mu5w=;
        b=jkwTuYlSEWikPBUwrDcw5xbKKWzDkB/cMDDXTt0SxnrTpg567tu3++eBvilIKjAeDr
         RS3Ah520kZ3gAFvOXq1QW9eAkYWhFBYrKg8nCO3vzp1XlcRnYuEzAvLlM3/vQLTN4XCh
         QRx7SbE4xmQ+o4zeCfxgy1/pEi7urw47VRkERB2EVYSW9MlkDC5NeHuWUuVaXIVk4ke+
         SnX29Wy8Mn0BZHNhsZLpeM0YRK2McNVM635ZK4B8m0m2Cne+3ix3t5X30f5wEX4iqjRa
         0ohhRYqZF8BDEtTBsyCo7g1K8SMNNh6GGfJ+t6Q/hMOI1pLwEiDrLsbO/4W8ZaniIpZV
         iivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nByDzUliSnVZuWAqOrjnhI6KnedkqnEPmcY2L/mu5w=;
        b=VyzNvH1fTU0bvDvxOxSuKnm+ywvRG7USLpZJcjwbDlclr1TVHdzaSoSbPd0pEKGA4G
         mHeLYiS5YPD1VvWnUjcGwFBA/hkl/SIl79rnjXUstzgLLHyO6l/hZQ9FYKG+g74Le31T
         GPm2VeD9l/eNJy4yBStysD8+tzCtYtDxqc6t6v+4MbgHVeCcXH1GuQEjKFebM/85MBv6
         Iyv1p0ui+ospPXb/Xg1B2uEXw5ODqH+5YlyBSHB+Twu5Qatc5wDEvvtwGZ6cwMJivZ/W
         ezg8h3vfkspfMesQRjuFkhkg44W9+bHTLhuW+eMiRygj+MTenXw298S83rFfJ4dBTgPA
         +dOA==
X-Gm-Message-State: AOAM531W+CNZ1R145qUDFupmdDsi4R+rSFNLvlF5xPxBFJAmWVmBX6fA
        qK8mQDo2JXB/kpYjRLQW+WA=
X-Google-Smtp-Source: ABdhPJzl/c4BrmIVgYNnw8qicb1oJrIUZPR/kH/CDES75y06m6DRaZ4HaNH+7S66Prh7T1RIAYr5Bw==
X-Received: by 2002:a9d:798f:: with SMTP id h15mr17360955otm.227.1629473442572;
        Fri, 20 Aug 2021 08:30:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id s35sm1486275otv.44.2021.08.20.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:30:42 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] sparse-checkout: create helper methods
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <5d28570c82af19b4bda4253e72ace3760dfe2606.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108191005560.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9c451e4-c1b2-1680-944a-e3355248cc44@gmail.com>
Date:   Fri, 20 Aug 2021 11:30:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108191005560.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:07 AM, Johannes Schindelin wrote:
...
>>  			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
>> -			    (sparse_checkout_enabled &&
>> -			     !path_matches_pattern_list(path, strlen(path), NULL,
>> -							&dtype, &pl, &the_index))) {
>> +			    (core_apply_sparse_checkout &&
> 
> Do we need to test for `core_apply_sparse_checkout` here? Or does the `if
> (!istate->sparse_checkout_patterns) return MATCHED;` early return in
> `path_in_sparse_checkout()` suffice to catch this?
> 
> The remainder of the patch looks good to me.
> 
> Thank you,
> Dscho
> 
>> +			     path_in_sparse_checkout(path, &the_index) == NOT_MATCHED)) {

Thank you for pointing out this. This is actually a stale change from an earlier
version where path_in_sparse_checkout returned an 'enum pattern_match_result'
but now casts down to an 'int', meaning '0' is not in the sparse-checkout and '1'
is that it _is_ in the sparse-checkout.

>> +int path_in_sparse_checkout(const char *path,
>> +			    struct index_state *istate)
>> +{
>> +	const char *base;
>> +	int dtype = DT_REG;
>> +	init_sparse_checkout_patterns(istate);
>> +
>> +	if (!istate->sparse_checkout_patterns)
>> +		return MATCHED;

So here, if we do not have sparse-checkout patterns (for example, if
core_apply_sparse_checkout is false), then this returns MATCHED (== 1).

To be extra clear, this should just be 'return 1;'.

>> +	base = strrchr(path, '/');
>> +	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
>> +					 &dtype,
>> +					 istate->sparse_checkout_patterns,
>> +					 istate) > 0;

Here, we are selecting the portion of 'enum pattern_match_result' that
we care about (MATCHED and MATCHED_RECURSIVE). The UNMATCHED (0) and
UNDECIDED (-1) are the other possibilities, but file paths will not
return UNDECIDED, that is instead for directories in non-cone mode
patterns.

Thanks,
-Stolee
