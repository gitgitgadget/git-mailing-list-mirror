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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B205C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6497A60EE9
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhHHRmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHRmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 13:42:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CC7C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 10:41:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mt6so24328104pjb.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X58SlSRFyzWSbWjYY1At0xmd5yh5NPewxthgTyb8UKc=;
        b=GIiQomsm4I7YUphwZDDRHq8aiY0RrB35Dj6xQDtC8upic35eMmiuzkCri4wlt/Vvaa
         C1nZZ859Y5MAMK4F0ruKDjQ1z1rXdY64FbAw4Z/7b6eY1DGg4nY5rqxMOjNBwJJb/F+M
         V5rM8uhGosvc/UjY/X7ycZLunHdIWn9Jn75RCzssoI1kyrZeMoHCdB2JkQ/vVpBvoQq2
         493pK7i0n2g0Dn1B74eBosjwEQH0KmPu3Lzt7K29v+qya4DUGS7KBv7NNrrlIFUyitFF
         ptdS7/B5QSvOJGd80rQRR3C45fol8p4VdyrZuS9ogjMj58YkoOjysXJZJ1epVDVHGlZ5
         AdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X58SlSRFyzWSbWjYY1At0xmd5yh5NPewxthgTyb8UKc=;
        b=lklq7MqyyxBPgAs5hN3lHieK/x/FLbNqAZEibb3K7/9QUzRQfDwQ7PyGbehSnStJev
         E5FRE25zn+3Bc5FsYebBd3hX/E4EcDrO55zvi+zNFqzPmoFd/ePa3gISjpsWSQQFsUw8
         gKBk4mAFWydWW7EXP2nG9OKPRfb4T2xfPPkvgbeLVZ5SOPPnHhhldVzmcPSKAj89UMLA
         8bRmQc7Tleg39CCh03m2a3LRn1f0NSNOGKCHr/K2q9A0R7jD715Fv2uxjzMuPj57SFgX
         YQV0VLwuPcgS+q79DQtGDV9WBHXJFEZhyOlesTfD0wqg/FzRP8tyHsLCdoKo5uilnelg
         gMLw==
X-Gm-Message-State: AOAM5323MGIzRkXJLmCRQeZFqR6XmsfseFqNTkVXFnZT2bqePqbGPpPJ
        GGSdn8t22+GStQutqpdfwGw=
X-Google-Smtp-Source: ABdhPJzVNMFtu3eJZ7rEWuts02jW1OXKLmROUZKGhSm+o4GpHoO+5RypRxCBfr6sBlIAeRCIuXRwKQ==
X-Received: by 2002:a63:5119:: with SMTP id f25mr243444pgb.271.1628444505546;
        Sun, 08 Aug 2021 10:41:45 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.169])
        by smtp.gmail.com with ESMTPSA id z5sm17937735pff.97.2021.08.08.10.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 10:41:45 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 1/8] submodule--helper: add options for
 compute_submodule_clone_url()
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-2-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <0752736f-11d5-103b-653f-a4bbe6436304@gmail.com>
Date:   Sun, 8 Aug 2021 23:11:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807071613.99610-2-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/21 12:46 pm, Atharva Raykar wrote:
> Let's modify the interface to `compute_submodule_clone_url()` function
> by adding two more arguments, so that we can reuse this in various parts
> of `submodule--helper.c` that follow a common pattern, which is--read
> the remote url configuration of the superproject and then call
> `relative_url()`.
> 
> This function is nearly identical to `resolve_relative_url()`, the only
> difference being the extra warning message. We can add a quiet flag to
> it, ...

It took me a while to figure what "it" meant in the above sentence. Does it
refer to `compute_submodule_clone_url` or `resolve_relative_url`. After one
sees the patch and takes a look at `resolve_relative_url`, it's clear the "it"
indeed does refer to `resolve_relative_url`. But it might worth clarifying this
in the commit message itself.

Certainly not worth a re-roll on its own. May be Junio could amend this while queing ?


> ...  to suppress that warning when not needed, and then refactor
> `resolve_relative_url()` by using this function, something we will do in
> the next patch.
> 
> Having this functionality factored out will be useful for converting the
> rest of `submodule add` in subsequent patches.
> 
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>

Otherwise, this looks good.

-- 
Sivaraam
