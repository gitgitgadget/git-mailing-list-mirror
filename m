Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615AAC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461BD61208
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFGQNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGQNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:13:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D940C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:11:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so12835029oth.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjws9kEEE8GHlU9H61KPh6i87M3FxshGPCpAId2hMRE=;
        b=pH6d1q8cV7Bgj93VGtQBzx0NEzzS70ug62Yk20NzJq69AxGW9plmv0LF3OzEiFunq+
         9dCqN9NWCgOH++NvJaYQdtBeT8CkHWK4poplxCEV4zCpGNMAtBgFVAsAfA3AoF/i0RVG
         eSQuiFwUWfusGQUheGa/r5Zq8kEd82ak7ca0fRJdhkdigy5Z0d8FVuacXeW5/j4YmSfn
         6m0CpSjbtcjze4KJDbiKC65XRvupqImgBxaeca0p7/mT4srHBRpFLSOaTkrftljIlEN2
         rOScKTDRt0uDcs00QFYMugAwsn3hCXJZARQzOqzkECvFbTN70To/Q4h2tSSVmVUeghmM
         2n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjws9kEEE8GHlU9H61KPh6i87M3FxshGPCpAId2hMRE=;
        b=UFpNVN6r8w/aizizn0tcn+9gnrdfWjZVsfOvPGNZdkn/dVH29IejpCQkcOaiN/vqsQ
         1RbMplNOoUWgF9ThM3RCx+ONqadApGF9o+pTYWAR2jNnuQeZhUGBEbiivoibrsItgAHb
         CopQOTp9mnE79vS/qzLCDDdU9DV0/UfO1pTfAmgHtEdjad76SFPxjbG5BK8bnoXneOuE
         YF3Uw7HA1E/qJZHVMC5GFGYxK6vwxCCB/DA+6DN/AEUevj/LsA1mvEW5ONLJ/UUU4GId
         MzeYu60gXiRsj6ce/WS87c6wmyG4X6R1kVtd2WwA2IH/upIeLI/RBQqVnr1IUuVsMd1L
         yrTw==
X-Gm-Message-State: AOAM530w2prmhRGuhQr4zhr/Yz4JtYeTO/24d8OWdNE1jrIugt3rPP/t
        C6Pj/GPdCjfVUK79yJkJ51Q=
X-Google-Smtp-Source: ABdhPJwapo4vehXdZI1cyhQhM4jrgtgenqMnLt7Ia1MknA6zse5uP6h70rp35oXUdYqqjFEZoNJSfA==
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr11147091otq.321.1623082275383;
        Mon, 07 Jun 2021 09:11:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id t63sm2009093oih.31.2021.06.07.09.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:11:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] read-cache.c: don't guard calls to progress.c API
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-1.2-1680109655-20210607T144206Z-avarab@gmail.com>
 <51e00403-dcab-c57f-b77a-de01a61a60eb@gmail.com>
 <87mts14qgz.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6cb306a5-4c01-5241-4430-0de21a7953f9@gmail.com>
Date:   Mon, 7 Jun 2021 12:11:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87mts14qgz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 11:52 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 07 2021, Derrick Stolee wrote:
> 
>> On 6/7/2021 10:43 AM, Ævar Arnfjörð Bjarmason wrote:
>>> Don't guard the calls to the progress.c API with "if (progress)". The
>>> API itself will check this. This doesn't change any behavior, but
>>> makes this code consistent with the rest of the codebase.
>>
>> Since stop_progress() closes a trace2 region, this actually
>> does make a change in behavior, I think. In a good way.
> 
> I don't see the behavior change.
> 
> Yes start_delayed_progress() will call start_progress_delay() which
> mallocs and enters the trace2 region, and then if you don't call
> stop_progress() at all you won't leave it.
> 
> But in read-cache.c both before & after my change we only malloc & only
> enter the region if we're actually displaying the progress, there's an
> isatty() guard on it.

That's right. I misremembered where this trace2 stuff was.

The idea we didn't pursue was to create the progress struct
unconditionally, and just leave it as "quiet" based on an
input parameter. That would keep the trace2 regions consistent.

But I'm wrong and there is no behavior change here.

Thanks,
-Stolee
