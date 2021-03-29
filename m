Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832AC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638E761959
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 14:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2OcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhC2OcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 10:32:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B9C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:32:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w70so13317002oie.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L03XxrHZfXfzq5Z99rJmdrApX6mF+n48rIkPB9pr/kg=;
        b=e/wMUkqkTC2xS9TZ+lNPuPldI/c4RBbNs+O13UQk/bF/VHblZ2SJhBYl4yz4V1NO6n
         6EYp9A/FZD5amPTsLu7Qsq5z+4UClqNDEsNvYamqaC+TzMEaK1oiWhqc3bW42TfbZNRg
         mQiLr/FX7EJfgn4Rb57dtR7UXa9AxiTDbrY8ahCyTLTvg6HrSr3ZsfnY2ai27KEssGHi
         vQGjoX5cl7YYMjJGRHUB4cafhmzVaq7AE31gW1RRS0UGk0MHBNZBEajLJ62Ir2VhAGKi
         fvETUHakDgxHlmSjADLasjzlXTfwUawYFuHmz7fhphmNQunECiR0bCr2Q39nwlGf7mZV
         tETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L03XxrHZfXfzq5Z99rJmdrApX6mF+n48rIkPB9pr/kg=;
        b=tOb+euT2WsoaOPQ06uPlCyeDSHPF0WXcKOshmaN4zyENL3q+vE5HK7f9T5fdJdWpBN
         wsUXRcF3WN9DyFTRLiXXEdd6uZ2Ffaqdz0iu9EQdnTuaZHFr9y50ALDJ02lNxwjm5hRs
         j/4s8Va9MMyF1HlkBJZXXJlAI/cqON46XeLfU/wnRFuwqJlz5Y1J4vSIf3VZjhwZeYkX
         fJjJoouzg+Xk1iwEjXPoefR3fuWp148V1cgKANggRg93No+MUAAzOEwcL9Rzz/iLQJ6V
         aqQCE1EX4rI8XjZRpVEkGdtslyxB+QROCEnfTY70wl2i7y+090qEH+aNxz0M2PLj2IDL
         r34Q==
X-Gm-Message-State: AOAM533ZJZXok6XMXsn8rymdG7nPpAKhcxj5Keq33WOsB8sDpzTQ8gI4
        ZRjm5bPalAzqd5WT2p8Wyo8=
X-Google-Smtp-Source: ABdhPJyg4E4iROgWwrbwC3Q2olc8pKxsp6AcoBFCMdTIPjKFU0U8+zyx4z2L0Ni+Hjpiu+dhWe/muw==
X-Received: by 2002:aca:d5d1:: with SMTP id m200mr18439200oig.102.1617028327490;
        Mon, 29 Mar 2021 07:32:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:18fb:da6e:ec24:b27d? ([2600:1700:e72:80a0:18fb:da6e:ec24:b27d])
        by smtp.gmail.com with ESMTPSA id x25sm4331415oto.72.2021.03.29.07.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:32:06 -0700 (PDT)
Subject: Re: [PATCH v4 01/20] sparse-index: design doc and format update
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <6426a5c60e53e30091360c00c61c9123803fe9c1.1616507069.git.gitgitgadget@gmail.com>
 <20210326202940.GC2271@szeder.dev> <xmqq8s68oxr4.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7a0550b-90e8-fa37-c456-7c70c089dbec@gmail.com>
Date:   Mon, 29 Mar 2021 10:32:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s68oxr4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/27/2021 9:47 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>>> +To start, we use a new repository extension, `extensions.sparseIndex`, to
>>> +allow inserting sparse-directory entries into indexes with file format
>>> +versions 2, 3, and 4. This prevents Git versions that do not understand
>>> +the sparse-index from operating on one, but it also prevents other
>>> +operations that do not use the index at all.
>>
>> Why is this not a non-optional index extension?  ...
>> This really should be a non-optional index extension.
> 
> Yeah, the index extension mechanism was designed with optional and
> required kinds because we wanted to support exactly a use case like
> this one.
> 
> Thanks for pointing it out.

Ok, so let me be sure I understand the request, as I believe it is
a very good one:

Using a REQUIRED index extension that says "this index has
sparse-directory entries" will allow tools that don't touch
the index to be compatible with repos using the sparse-index,
while also avoiding a new index version.

I'll work on this right away. Thanks!
-Stolee
