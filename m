Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99EC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237F16115B
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhITPqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhITPqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:46:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E6C061760
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:45:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n71so3444549iod.0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yl7aeND154r3DVTtmImpn+oLmft0cNJJ+fa8gs+5ReU=;
        b=iLG/AuuXE8wk3Bc/U05IhVqu79DVgmHqnVoiG1EFDlTOjj8IRTiL4jKn8FEfZuKDFJ
         ugl7017u2sxUZ0sD+ABH1i9cuLgPY1FQXJSTqTmXctNeC2i3lDRUfuOhCnzXe0rGAGhA
         Mmr37KFqDH5RzxpZYxuWFuswWZPi2R7vrkovaaWHxfvombGSx1yEqXnyOA+KNwP8nbTD
         1DviqMEKmvd15r39C5jPsYqLbDBLBpqaKz7JJl8UaY5qrhRmIXR9krTW97fHoUX0bWP6
         DTiN5CeyPWSulBKptCzhvfmSVZ7lLYQN2/sPAzSHhcomCN4Jpz5qk09BuQw3vL+7tLh8
         lPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yl7aeND154r3DVTtmImpn+oLmft0cNJJ+fa8gs+5ReU=;
        b=aILYA0jHIzvrE+VFDIqtrDNBodapatEugYIYfl1K86syhR9zgmCy5F4JwQ5NM9PPiI
         Mci2YnMH1i5WGIfEfT9XuWt5+4v4NklpSv2AW3GEu15FyYfxb1bvZiqcL8jHsjFSR4D7
         7/68tx4vwLo1M8j3ypmAJZP2O8DEbtICeaadP7DUo6GwNEATTQ6rLjwNlmUeEqAoHbFA
         XjJ5vC785Yf+/kM0O2FECYVOTgV50jpMx6xMC+jRuZMuAvI+R/r0nXd3/YzxIkOqK5Tz
         ocQ4wku4qkcngeyAMOURNDY/GzUWws5M6vlbS06OmSju+efdagXF5WL8N4vxePFBWBt6
         rOyQ==
X-Gm-Message-State: AOAM530lmJs6xngJNPM5f+KioBzvb2+31xNv2vkrYOx5ebaj+5jYJlM+
        F5HO0RldfCoXUjjmysPwhyY=
X-Google-Smtp-Source: ABdhPJzjYCbnZUBCqR/rwZ+czFr6QDtf6BYJZNup1a/Q2yYIt0r1ew6cGShtYeZkB1P69POfmlZctA==
X-Received: by 2002:a5e:8d10:: with SMTP id m16mr4241021ioj.215.1632152706924;
        Mon, 20 Sep 2021 08:45:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id u12sm9992693ill.33.2021.09.20.08.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 08:45:06 -0700 (PDT)
Subject: Re: [PATCH v2 08/14] add: implement the --sparse option
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <944ae2cffa8ff175cd1cee0b3a25060ec5599973.1631453010.git.gitgitgadget@gmail.com>
 <CABPp-BFvCpfq66oJoxgABJy3LP=VNDwtd3YkTwV-nEQjXm2_Bg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3c4332f0-5c88-033f-b294-4fe50d010b1c@gmail.com>
Date:   Mon, 20 Sep 2021 11:45:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFvCpfq66oJoxgABJy3LP=VNDwtd3YkTwV-nEQjXm2_Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2021 12:59 PM, Elijah Newren wrote:
> On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
...
>> +--sparse::
>> +       Allow updating index entries outside of the sparse-checkout cone.
>> +       Normally, `git add` refuses to update index entries whose paths do
>> +       not fit within the sparse-checkout cone, since those files might
>> +       be removed from the working tree without warning. See
>> +       linkgit:git-sparse-checkout[1] for more.
> 
> for more ...?  details?  I find the last sentence incomplete.

I'll add "details"

> Following that track for a moment and thinking out loud, I wonder if
> we want more details somewhere in the sparse-checkout docs about this
> issue and if so, if we should point to that specific part of that
> page.  The 'reapply' section of the sparse-checkout page kind of
> touches on the topic of the worktree not exactly matching sparsity
> patterns (due to other commands), but focuses on unsparsifying files
> due to conflicts and kind of ignores the re-sparsification that
> happens in other commands after the working copy matches the index.
> (Such a documentation improvement could come after your series, as I
> said, I'm just thinking out loud.)

This is a good idea to include in a new "Troubleshooting" section.

>> -# NEEDSWORK: This test is documenting current behavior, but that
>> -# behavior can be confusing to users so there is desire to change it.
>> -# Right now, users might be using this flow to work through conflicts,
>> -# so any solution should present advice to users who try this sequence
>> -# of commands to follow whatever new method we create.
>> -test_expect_failure 'merge with conflict outside cone' '
>> +test_expect_success 'merge with conflict outside cone' '
> 
> Based on the comments on the next hunk, I also wonder if this hunk
> doesn't belong in the previous commit...

You are absolutely right, I squashed the wrong commits. Thanks.

-Stolee
