Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FBDC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A565105
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhCIWpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIWp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:45:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3FC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:45:29 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id j22so8655696otp.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tITEdxEzPy0HSlLYzE/qK4k5eUJR5Q/0w+PquSnhrXE=;
        b=aBZUNT8taHYZpmyox0/PC9/8nHPezGZBGMocMt5VSs1F9uBHMBhPrtD2T5jiwhWEcf
         TWcFnzB6LcgOPxybzrkPXvJuciHfItvF1jczBNv3xsM0XCIND6XjVr7hCBw/gSHJyfoE
         GrENvSVxeu0kEoLewxFIHiYdMu+W9XZABouNp3fWBdjxm0LnM7BtF1BmEtrQPvBraltY
         OCetbj4R1O+oWj+NhAyY71/egIn4jlW+Xo3dQx6HoW9voEtnr80kbNEza/NzudI+0gg1
         FG6MYy3LGHKdpaPTZBefCQz4TLviQQ6QKpW+AofSdc3VeHY3gNgdzVos9cleO+6MX7yI
         WaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tITEdxEzPy0HSlLYzE/qK4k5eUJR5Q/0w+PquSnhrXE=;
        b=a8LCxI3wSw+TUhELnIb5NVnCLe3ej8kUdkydsq0LFLBh9j/o8bT1TB1Y893AfEhGg/
         mqBxsXn+XfNdKtq2PcQIVPhSEUAxRayruuoEm/XLDbHLlESi2hgauVbJurRZeoJ2Cei4
         Ew+8U6r/zF79JRb9AmrOYPUxq7VXplxCSHNOX/yGZML+mfMKo2wmuzBVCAbVPLKsf2Gw
         ovtL6erKVGgsmuLqUkDqX970GAgqdO3V1KvKGbA9qJDqxzyZPdgcHobXJEmWSEutKeOu
         MxBbKh679dbchaa/UhEPPWjBjSd+AqzqC4Z9jlyVe+dvPoErlFy9TFltl6vOcUl6rXg4
         pNwA==
X-Gm-Message-State: AOAM5303nusza8lbewCOteWPYyDX2lHpnF+PleRL5ypIdJzjl11UcH1O
        3doxEqfYVQwJtE6s9VB0HWM=
X-Google-Smtp-Source: ABdhPJwk7o0Duo+I1Cnq3WQVb3oy96uEDzNLuo3ezb+4vlt03KDpBU+vzwxRgBfptv5xRYjX+VbSUA==
X-Received: by 2002:a9d:4587:: with SMTP id x7mr327202ote.274.1615329928646;
        Tue, 09 Mar 2021 14:45:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id a6sm3502053otq.79.2021.03.09.14.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:45:28 -0800 (PST)
Subject: Re: [PATCH v2 1/8] diffcore-rename: enable filtering possible rename
 sources
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
 <dab8e3c6aee5a852ad46c569c0be729d64310ad9.1615248599.git.gitgitgadget@gmail.com>
 <c646e320-566b-3b53-63d8-a97c6d17c5bd@gmail.com>
 <CABPp-BFnkHMd_1roiXL1njJXCP+T-Qm0H2eCTOQiM2qUM7gDBA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1898cd73-7ade-45fc-af41-e55cf38d1ab4@gmail.com>
Date:   Tue, 9 Mar 2021 17:45:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFnkHMd_1roiXL1njJXCP+T-Qm0H2eCTOQiM2qUM7gDBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 5:40 PM, Elijah Newren wrote:
> On Tue, Mar 9, 2021 at 2:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:
>>> @@ -1167,9 +1178,10 @@ void diffcore_rename_extended(struct diff_options *options,
>>>               /*
>>>                * Cull sources, again:
>>>                *   - remove ones involved in renames (found via basenames)
>>> +              *   - remove ones not found in relevant_sources
>>>                */
>>>               trace2_region_enter("diff", "cull basename", options->repo);
>>> -             remove_unneeded_paths_from_src(want_copies);
>>> +             remove_unneeded_paths_from_src(want_copies, relevant_sources);
>>>               trace2_region_leave("diff", "cull basename", options->repo);
>>
>> This seems backwards from your cover letter. You are using the exact renames
>> _and_ basename matches to remove the unneeded paths. Why are we not stripping
>> out the relevant_sources in the call further up, before we call
>> find_basename_matches()?
> 
> Yeah, good flag.  I should add a comment to the commit message about
> how these are still needed in initialize_dir_rename_info() for
> basename-guided directory rename detection...and will also play a role
> in some of the special cases where renames are needed for more than
> three-way content merges.  And add a comment about how by the end of
> the series, relevant_sources will be passed to find_basename_matches()
> so that it can skip over those paths.
 
Ah, so by the end, find_basename_matches() will be coupled to the
relevant_sources set directory instead of relying on the culling
happening earlier? Interesting. It seems to me like it would be
better to have them be less coupled by relying on the culling
before calling find_basename_matches(), but I'll keep reading to
see your good reason for not doing that.

Thanks,
-Stolee
