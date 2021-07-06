Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95140C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8135161A0F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhGFPUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhGFPUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583F9C0613DD
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 06:52:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a8so14488667wrp.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VNG3nQMGHBoFFAuFHvv0EF4Bx6pQZqSAt7JIKfsllik=;
        b=YT+U5K2B1VJD8uwqoePX2GoZAx87CqlbM/lij/DLUxjARPl+Do4Mrf+0Qortz+wGpf
         Gs9tU6kIThgRu2hL9UYfTNhS/FMmveI3o9ASAHRIrmwbemWkHI1IAKO/zIZ21ljP/koz
         Z4SkQmZI5FjX2PnPvq1TYcxEfmqUiDThtE7UPJIFjBzeq3JC0GO1M9d1+phef3l7+6e7
         4bSwdyuppF9LGttqqMRt5B5lbfo7kUMWduz4wFreBcvSihVSinb4qWHZ9VDj8YDjjH1E
         zN/fWC2gnuUCyazsV3CSQzxKGCvABmf2nfU4E6JKHacGYN5GmB2kwiQ7Ub6HKIWdB/rs
         Aevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VNG3nQMGHBoFFAuFHvv0EF4Bx6pQZqSAt7JIKfsllik=;
        b=rGS/09xLCILf63df8cG/6Powd8BXkl/sLPoWZLSD7jMUwq3U0G7OtRcJWHF8ACP6qM
         LwZwfcoo091uGacZzPqJhqPzlyalWUUD9TkJog/ldYJxgsX7GEO8u3LQb+IliQV8fqef
         daCFCvXTbqyjVhPkX4xWN6zLDGGaNT1lPdOn6nFJYj5pnKMLOCq3ENLSI4x4q4TXxPsa
         mGIR1jLbvFj84UjuvudrybCbmpQwl7EqyF+KsFNAvz2HVyHMsy3htNsjU50vjnRYAbtX
         2M/xXvu0ijEWZjYEBXqtu1NzrnwjL2kExzzUtSbs1Mb9iXWDbgfYPehpqAu7LVoNjshQ
         m9Bg==
X-Gm-Message-State: AOAM53068J8W5tYfAFswL1rZdFV0XCxwLLw4zzlcWlbeo8XUlygBUB3f
        bLdZeL9wj4jjxCRydxUNe70=
X-Google-Smtp-Source: ABdhPJzKpsFtlZefH4YIah2f7B3L5fwQfM/QKiuYsupasj7dT5w3D3DeNbZhW9H/3b4NtGH5nAnAbA==
X-Received: by 2002:adf:e906:: with SMTP id f6mr22418214wrm.30.1625579567036;
        Tue, 06 Jul 2021 06:52:47 -0700 (PDT)
Received: from [192.168.1.240] (118.22.198.146.dyn.plus.net. [146.198.22.118])
        by smtp.gmail.com with ESMTPSA id z4sm15578629wmf.9.2021.07.06.06.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:52:46 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
 <7ee36923-0806-4316-729c-8418df5b6555@gmail.com> <xmqqpmvwn1qp.fsf@gitster.g>
 <xmqqlf6kmup4.fsf@gitster.g>
 <CAMMLpeQG-eYgWTXyG0YzgN3U8QDASAtNFpxyXDFFPSVNzfw18g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <103eaf23-e55a-4583-bf02-0cebb78f00ae@gmail.com>
Date:   Tue, 6 Jul 2021 14:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMMLpeQG-eYgWTXyG0YzgN3U8QDASAtNFpxyXDFFPSVNzfw18g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 05/07/2021 20:48, Alex Henrie wrote:
> On Mon, Jul 5, 2021 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Looking at origin/seen:builtin/pull.c we already check if we can
>>> fast-forward and unconditionally merge in that case irrespective of
>>> any '--rebase' option or pull.rebase config. It should be simple for
>>> pull to error out if '--ff-only' is given and we cannot fast-forward.
>>
>> Excellent.
>>
>> Even though teaching even more special case on the "git pull" side
>> makes me feel somewhat dirty, but I think it would be a small price
>> to pay, and the end result would save an useless fork whose sole
>> purpose is to make the integration step after fetch fail when "pull"
>> can easily tell, as you said, that it ought to fail, so overall it
>> would probably be a net win.
> 
> Okay, so it sounds like I should just scrap this patch and try again,
> after "pull: cleanup autostash check" is in master, with a patch that
> only modifies `git pull` and not `git rebase`. (Unless someone more
> experienced wants to take over, which would be fine by me.)

I don't think you need to wait, if necessary you could base your patches 
on top of that branch. Junio's latest what's cooking email said he was 
going to merge that branch into next so it is unlikely to change. In any 
case looking at the 'git diff origin/master origin/seen builtin/pull.c' 
I suspect the changes required won't conflict with that branch.

> Thanks anyway to Phillip and Ævar: Your feedback will help me write
> better patches in the future.

You're welcome, I look forward to reading your future patches

Best wishes

Phillip
> -Alex
> 
