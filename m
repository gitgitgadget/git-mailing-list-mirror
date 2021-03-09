Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472EDC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB4864FC0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhCIVfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhCIVff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:35:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C344C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:35:35 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x78so16652616oix.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ys8HVAJvAR/sfzUamhU65w/1NjebasJSzfYZQGdgkw=;
        b=dW/E5U47uwNtgICsGb/SLc30SdBw4Pzi5PEbmnWov+Sl04lidB0knXBSbdFdRcuHkr
         Fq5bgWD9f5xE4+FNTGZb4ph4DvPhZ8LP/nOAopJU9g/aogu1VE1vr0bmC0kev+e9JlA+
         JpkeVQ0M0G2scw2kc8JSTNBd0FlPF45KDA0yxDgbX0cHNNPf8547RK+4dcsUtKXCCs7j
         P+Q1QE2wyxTmUkwgYYvBpALO5J3sHo1O1OtHMaLFmK+XYL7qbpO3VK+lG4+cCEvY96xQ
         eHf81KfmfolATDMtKcHCllDN3Tmc7mBRtuNynIHgLV+dIBcGalTslUrx0/AunTyNvsQ+
         +DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ys8HVAJvAR/sfzUamhU65w/1NjebasJSzfYZQGdgkw=;
        b=El0/lLjFwCRGHf5cePO97dF9fM15bs8qW0UfSjmAub27SBpPNiQZQ+FTJD6UftbG0I
         YCd1luIzRnrae76nX6RusWL+H/wQ1nLccn76GvrRhXZRm1U9UEp75wbMKtRfPKO9DxK4
         gUwTB1vr6Ox7GHNZ0NoyraUIRUdcyBpDK2uxOjIrcuP5p8jOsDZvxLw/+QAcyV0fUM/9
         mxR5s8amODGoQVcp4v6sNiRuOjGzkXDmUYP2PTeLgK5VuusAotHMpoaM75rwmYYxgHK5
         HhTMdPhJAH5YFi5wsTZtiQcx+Fc5vFtOLl12UBd+sg6wJlhj+tvN7IcKP8NQ+wi4LxT1
         aJ5Q==
X-Gm-Message-State: AOAM530R4gX6/qRV/in2Am2C3p+otQv+1sqB5Ui2gxnIh+UJakrJ0RDI
        xpYkMuOGfsSu7PcaCoVIHZA=
X-Google-Smtp-Source: ABdhPJz+nROSqTxHXFXeTmgJl2R1W/LRyIZH+/XpGSy8YnoMng4phTOq4s31J7f6SB+TDYOsK3NvHw==
X-Received: by 2002:a54:450c:: with SMTP id l12mr112732oil.133.1615325734281;
        Tue, 09 Mar 2021 13:35:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id q22sm426151otl.56.2021.03.09.13.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:35:33 -0800 (PST)
Subject: Re: [PATCH 13/20] unpack-trees: allow sparse directories
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <fda23f07e6a20408b0a10c8944d54e7c65a1d629.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BEMNavqAEG54VYkZvSiJ4=X3vZUXsubCmFfk3yxUWOjXQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d5d12e9-cd14-c195-b267-0e130109f1e0@gmail.com>
Date:   Tue, 9 Mar 2021 16:35:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEMNavqAEG54VYkZvSiJ4=X3vZUXsubCmFfk3yxUWOjXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 2:40 AM, Elijah Newren wrote:
> On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The index_pos_by_traverse_info() currently throws a BUG() when a
>> directory entry exists exactly in the index. We need to consider that it
>> is possible to have a directory in a sparse index as long as that entry
>> is itself marked with the skip-worktree bit.
>>
>> The negation of the 'pos' variable must be conditioned to only when it
>> starts as negative. This is identical behavior as before when the index
>> is full.
> 
> Same comment on the second paragraph as I made in the RFC series --
> https://lore.kernel.org/git/CABPp-BGPJgA4guWHVm3AVS=hM0fTixUpRvJe5i9NnHT-3QJMfw@mail.gmail.com/.
> I apologize if I'm repeating stuff you chose to not change, but I
> didn't see a response and given the three typos left in previous
> patches, I'm unsure whether it was unaddressed on purpose or on
> accident.

Yes, I dropped this one. How about this?

    The 'pos' variable is assigned a negative value if an exact match is not
    found. Since a directory name can be an exact match, it is no longer an
    error to have a nonnegative 'pos' value.

Thanks,
-Stolee
