Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE88C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 21:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D5C60232
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 21:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhBAVLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 16:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhBAVLX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 16:11:23 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B9C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 13:10:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id h192so20432674oib.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jOOncHoObOPHNOP8nF++92WzzSS+3++KUJ54SBGAEII=;
        b=litcUZSX+C3LD0Qfte6i9wqBKMclP0bWMoiBYahnSS6Ws5Jc9x5opABE007XC/RwqX
         b6JBC83IoRtRASNBAi1QyygkSWkNNF3CIxqXeN+djLIpFEl3Gx3ode7x3IkCgQXiU5et
         cL6PvyRDcsdMgUacqK8/3oSvyozYW0O+W+DsKH/76Ls9QLmEqOgCheTfrojxP7D9D2Aj
         zw/jtqZIrUuF3LAaMFgLvnYdWgWv9r8wTVgJWAFxujNIVB5mZc/poIpu3XBqtYuQmaBw
         aoOfgPzPwkdQzLbIsaGXHBTtOTe9b74I8wVdy2YySKDAw15Q9nbXTxSl7gd3V4jF3rs4
         QHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jOOncHoObOPHNOP8nF++92WzzSS+3++KUJ54SBGAEII=;
        b=lmi6gqgAAcSkF8p6Widqf1kzUVp2ZR1MBhEhi8KnfuMqhkBt+//2+pfCAv0vqgyWF1
         vlzpJyrzj1Yg7DDke2ranK+9Ra1ZBgiqGKims2Qa20iIRjINOcgKJeCY91NVIIf6eQFX
         spcAMOp5+AfF+Ix0PCv1xzdnkgvEvkjyrXJFKevEXBtpV/vfKeyqdAvNsP5lvSQRdhn9
         amHzhwPtKNYVSBs3oWvGJYDgD67GM/IA78rvrVKKBMmdQqdyd35cBkbtsd32T9jU4wnV
         29Zjg1PsbuhUTUoIlcmdiLMgogPnEXAkYxY0aZZ/0+Gyln0MW68Iu+9fEndj4uXcd2AL
         xJpA==
X-Gm-Message-State: AOAM533cF8t+8i/Me2t9nwB9AAMUHhuIO5jWUJgSSEurkzEdURUSNJxf
        jcSMoCCyffXeq+PkQ57aWHw=
X-Google-Smtp-Source: ABdhPJwnEUm58RmixhDOOWUeFI0wx+Kr6K65pdskg50Oxax8vvHd+G/nPxZEp3/fxKntVy+cZSOdNw==
X-Received: by 2002:aca:dc56:: with SMTP id t83mr543466oig.75.1612213842076;
        Mon, 01 Feb 2021 13:10:42 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8497:2090:4038:7fd1? ([2600:1700:e72:80a0:8497:2090:4038:7fd1])
        by smtp.gmail.com with UTF8SMTPSA id d17sm4186389otk.3.2021.02.01.13.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 13:10:41 -0800 (PST)
Message-ID: <52beefd1-9974-0673-2dd7-3e43b0efbef7@gmail.com>
Date:   Mon, 1 Feb 2021 16:10:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 15/27] [RFC-VERSION] *: ensure full index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <71b33bb2498d53e5818f3a597240b530976152fb.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BHSnqPZckgk4oPQonA8YCBQ8jMpH+QzcnpEALr7yc9+rg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHSnqPZckgk4oPQonA8YCBQ8jMpH+QzcnpEALr7yc9+rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 3:22 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> This giant patch is not intended for actual review. I have a branch that
>> has these changes split out in a sane way with some commentary in each
>> file that is modified.
>>
>> The idea here is to guard certain portions of the codebase that do not
>> know how to handle sparse indexes by ensuring that the index is expanded
>> to a full index before proceeding with the logic.
>>
>> This also provides a good mechanism for testing which code needs
>> updating to enable the sparse index in a Git builtin. The builtin can
>> set the_repository->settings.command_requires_full_index to zero and
>> then we can debug the command with a breakpoint on ensure_full_index().
>> That identifies the portion of code that needs adjusting before enabling
>> sparse indexes for that command.
>>
>> Some index operations must be changed to operate on a non-const pointer,
>> since ensuring a full index will modify the index itself.
>>
>> There are likely some gaps to these protections, which is why it will be
>> important to carefully test each scenario as we relax the requirements.
>> I expect that to be a long effort.
> 
> I think the idea makes sense; it provides a way for us to
> incrementally build support for this new feature.
> 
> I skimmed over the code and noticed various interesting places that
> had the ensure_full_index() call (e.g.
> read_skip_worktree_file_from_index() -- whose existence comes from
> sparsity; what irony...).  Better breakouts would be great, so I'll
> defer commenting much until then.  But, just to verify I'm
> understanding: the primary defence is the command_requires_full_index
> setting, and you have added several ensure_full_index() calls
> throughout the code in places you believe would need to be fixed up in
> case someone switches the command_requires_full_index setting.  Is
> that correct?  And your comment on the gaps is just that there may be
> other places that are missing the secondary protection (as opposed to
> my first reading of that paragraph as suggesting we aren't sure if we
> have enough protections yet and need to add more before this moves out
> of RFC); is that right?

Yes, the idea is that we can incrementally enable
command_requires_full_index for some builtins and be confident that
corner cases will be protected by ensure_full_index(). Further, we
can test whether ensure_full_index() was called using test_region
in test scripts to demonstrate that a command is truly "sparse aware"
or if it is converting to full and back to sparse.

There is also the case that when we write the index into a sparse
format, the in-memory structure is modified. If the index is re-used
afterwards, then we must expand to full again for these code paths.

unpack_trees() already has one of these calls because it was necessary
for the sparse-index write to work.

The ensure_full_index() pattern also works when updating a builtin to
work with the sparse-index because of the breakpoint trick.

When I submit this as a full series, this patch will be one full
patch series submission with careful comments about why each of these
is added on a file-by-file basis.

Thanks,
-Stolee
