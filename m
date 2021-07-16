Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E0DC636C8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B5B6115B
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhGPBbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGPBa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 21:30:57 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6EC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:28:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c68so2460301qkf.9
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cmmqa1fYojEf0eBtYNzqSp2V62rkD3Nbxar3QSGloJc=;
        b=OwxRh1DWZ7CjkhlMM25VYk9rcey3Djf7gy1SPNNYDA83t4XkzWQ+fsAFHbeI58Qri8
         mfdpKI+Ma34RdNyhMcu9Kf59rCtzoi8naBn7YTg9DqdbRX9s0ms/8rPMcDL7Ep9cJ/8u
         4tVCNlhXLYKeZPwxSh/NRDKr/sKnJ7NmRmydSNAq9OuSNBoIIBFXGzmA4kLr7bu7ERP3
         QWT656IUm0JM87JBZXENlm/lm8CgP+Erd38dvpCyUPNO9GhXGZZGxx2r3/o/ERJo6bx6
         QcA47QG/VGWIB6+nIZVlT5BLAKPazaYlBqjAdop8wuyfmtSKQU1vvv/MSb1EJuzdlIyF
         I/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cmmqa1fYojEf0eBtYNzqSp2V62rkD3Nbxar3QSGloJc=;
        b=iXuSojYgqqVbB6aJNGf7KHoi43VRlF9WNPnHE7tOVkP2nGfyQT1zbU/6fxhUugJVtM
         43SQZaxnrVsfNt5juzEjg1vN1m5rXfTno/5cOn3/C5Nm0ZmSOlFWP5/ZlszjRkFEZFFo
         KbEFZFSbAV83fbBWAQHbvGagLyLCMuWDV+gOmbYH9ufpmvOhBNlrAMQ0lfXoPgC4gnpf
         TQYNHSxY10OW4BEZVKQgXgwbBXa+/dgDd1hWUFwOVXbSskpRGxxTU8ifO5InmJcc+QSF
         Oe4mODtQqLJrT+JTBHIYq3jf5pguxP+PES/LXiKOGDFNp+16b3rW0xzZT2xXjc7G+4hQ
         t1rA==
X-Gm-Message-State: AOAM5330ZKFHDR/miMVJ2x0mZT/qvwl6dzY5FR9tLH2ZtsMirCW7XpSs
        DwKHc7RDB8lwS+MGIxIZQeU=
X-Google-Smtp-Source: ABdhPJy7e89NCh0wlNPURw7eEB6Jg0LO/tQs9rb0Wu2RNyIobswjC5i8eFef6YS2/EuNaWoOLzWjjA==
X-Received: by 2002:a37:4585:: with SMTP id s127mr7029383qka.195.1626398882160;
        Thu, 15 Jul 2021 18:28:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d200sm3275527qke.95.2021.07.15.18.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 18:28:01 -0700 (PDT)
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
 <60f06a8a8e611_4b68208a9@natae.notmuch>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c8322c37-38da-bde7-9361-adb68834b7d1@gmail.com>
Date:   Thu, 15 Jul 2021 21:28:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60f06a8a8e611_4b68208a9@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

Le 2021-07-15 à 13:04, Felipe Contreras a écrit :
> Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>>
>> Helpfully, since 64cc539fd2 (parse-options: don't leak alias help
>> messages, 2021-03-21) these copies have the PARSE_OPT_FROM_ALIAS flag
>> set, so check that flag early in 'show_gitcomp' and do not print them,
> 
> Makes sense but I don't think what the patch is doing should be buried
> here. I think a separate paragraph explaining what you are trying to do
> will be better.

Indeed. Will clarify.


> 
> I agree this is better, and the patch itself looks obviously correct.
> 
> Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
> 

Thanks!

Philippe.
