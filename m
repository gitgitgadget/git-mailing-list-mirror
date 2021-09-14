Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB50C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D360E05
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhINKdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhINKdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:33:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0FC061766
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:31:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so19355445wrc.7
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGPxaWLddDB1B+9MtX+BtCUHITwZCauA1k4RS88/Oqc=;
        b=L5JnqLNhX6UBtyaYi9Dm/sNJ6tUPlkbwHL7/OFMcPgF0kAy1lJMyD06LyzxHo2uGS3
         cIhrWPehTKDeMN0Eje95abiewBlqN69NMYK7KDiRSyUnbn3StEF8rG/fLDAEHJyypwB1
         V41OuStB8bnLftiLfv7JX+PdxXhmEnSe/6+f+snrLtr1r7lzazaz6I7LRFcRedp2v9PO
         eHUK8b0PqgVlEVr3YJ64tyvnCldP5I8bKxvUJ/H5xY5EvleDVHkQ0ll7/hSJYNpS5mKn
         YzpJhfZWra0Dc/M9XJ4IZyokuSPX0/HrJXJnbzAuiIA/ED8ToZPNwGg/opNJJRS1k9rf
         sZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PGPxaWLddDB1B+9MtX+BtCUHITwZCauA1k4RS88/Oqc=;
        b=uhcbNUYCsZIIAKga+MzBdAGB1EsDOuLsm+sChgdGHmLO8qT7KMOSf62LS8PaRYo9O2
         127ZQyGxp9Zz2ILn2o+21fBxrlRNB3TpT+yhU/5/S2MbVDJ7MWBfldSR3KOQUF4Z7qjo
         NEqcmjFy0KsmOkb4yPsbUWwX+UN+4fDArGNGMoFDR9FpRHS8AUVaZzyynVTYX89aOlBB
         YDXfWlKY7WWo/FhmwOqsNKTY7BRD8EcqIPVMI0O9DveVNf53bC/gj0jVkw2mVKKTy4oA
         SzFXTeF9CQqvkQKmhp+y420hu2lUCTueMmQtmJdA6wntBV01Rkj54yeuQZ7z3mwii40Q
         qJdA==
X-Gm-Message-State: AOAM530nzdTJxpwics+5a9PzzUxP7M8yltFA68iC8S6bttIvtX5z7pNs
        9vsvltKE+PcOqyXfh+8LVL0=
X-Google-Smtp-Source: ABdhPJwmWmrkLNx47BAHeK4KmquoXVPqq6olW+XGvb/PSBHvZaSaOIEXRtCocaDMU8sgmGkNWksWcA==
X-Received: by 2002:adf:f890:: with SMTP id u16mr11352287wrp.388.1631615502756;
        Tue, 14 Sep 2021 03:31:42 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id y18sm10065792wrq.6.2021.09.14.03.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 03:31:42 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 08/11] rebase: remove redundant strbuf
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
 <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de> <xmqqczpccd57.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0c067b02-44e4-f719-42d9-7ceac5804e4a@gmail.com>
Date:   Tue, 14 Sep 2021 11:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqczpccd57.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/09/2021 23:40, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 13.09.21 um 17:19 schrieb Phillip Wood via GitGitGadget:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> There is already an strbuf that can be reused for creating messages.
>>
>> Reminds me of a terrible joke from elementary school: In Peter's class
>> everybody is called Klaus, except Franz -- his name is Michael.
>>
>> Why would we want to use the same variable for multiple purposes?  This
>> makes the code harder to read.  And the allocation overhead for these
>> few cases should be negligible.

For better or worse reusing the same strbuf is a common pattern and when 
I saw the code switch to using a different variable I wondered if it was 
because the value of buf was being used later. It is also confusing to 
free msg in a different place to all the other variables. rebase_cmd() 
being so long does not help (msg is defined 763 lines before its first 
use) as it makes it harder to see what is going on.

>> The most important question: Is this patch really needed to support
>> tags (the purpose of this series)?
>>
>>> msg is not freed if there is an error and there is a logic error where
>>> we call strbuf_release(&msg) followed by strbuf_reset(&msg) and
>>> strbuf_addf(&msg).
>>
>> strbuf_reset() after strbuf_release() is redundant but legal.

It is confusing to the reader though, I spent time checking why the 
strbuf_release() call was there before concluding it was a mistake.

> All good points.
> 
> I do not care too deeply either way, in the sense that it probably
> is better for this function to have two variables (with at least one
> of them having a meaningful name "msg" that tells readers what it is
> about), if the original submission to rewrite "rebase" in C used a
> single strbuf for both of these and given it a name (like "tmp")
> that makes it clear that the buffer is merely a temporary area
> without any longer term significance, I probably wouldn't have told
> the submitter to rewrite it to use separate strbuf variables.
> 
> But if existing code already uses two variables, with at least one
> of them having a meaningful name that tells what it is used for, I
> see no reason why we want to rewrite it to use a single one.

In a short function where it is easy to see what happens between the 
variable declaration and its use I'd agree but here everything is so 
spread out I actually found the switch to a second variable confusing.

Best Wishes

Phillip

> Thanks.
> 
