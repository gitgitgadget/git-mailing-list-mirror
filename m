Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E27C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FA8613D2
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 10:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEKby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEKby (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 06:31:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3404AC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 03:29:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n12so9816756pgs.13
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uFpj+FrucdibQHUAilIZFPieuBijY43vl7+igfPuFGk=;
        b=sgLJuqEuGJD2RtHEiNcXl5zPShasLd87SVf29+4saPQbCk3GJzi0ACdgySiPEqGYm5
         k1HLLmAp4GueoSZoLwfuocEe8aXf1GWA6xuj4/V+01o/ADec4ubwqiz+JG2jwXNE40hv
         FNQVAcLIid2gCjEVgQCZ2eyYWTzPVZNXICDCzgp6AasQmxbbMhdrbhHrukHgKIQCh45R
         uWsa/5WdOxC8mkjfhwDyY6SkjW9Fx0PKXtJXypQy5MoF9wm2BTB7kjDyBR3D4h82kmwy
         84Nuw8EBAfe+XE0D7RQo2FqmA/JTaH0Fx1qoUmZn9SeB4rqCEtpAYCqFtFd2vM33HQXY
         Vo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFpj+FrucdibQHUAilIZFPieuBijY43vl7+igfPuFGk=;
        b=lJHxyuezU1BSDR0xNU7k3bXbZzbkslhfXRbYMbRF7EBUwW8K+FPzrah93PE1Jx7Fbd
         kAvG4Dbt/czMAPScdC51zi+mxP8UpaKL09ZMDbnK9d1JsSWgFrVfV2Vtw/s3TSupNw3D
         9dVSTED3GPQwYULfdXryXcgR2clo3N3jB5hqVG4VB8RNMvtd7EDmWUA5zJJAy8lg5Bv9
         8jctLjBWZNjBIMUvgKAF6mSbHeg20KNJ5nzv5K41V8NaycxOualBGh4K2CLBRdx2hEBA
         hKvfzctHiQKh1xSRkGkM63IIdyKMqPqqxSHbG/Wp8vMQumN5SXjotrhyS3sIA6VjofHd
         iooQ==
X-Gm-Message-State: AOAM531g3lm8t3QsnxHtJr+Ow5LaOq/EHeZMrUe97he2LuNMNVIQ//Jk
        dDeDjBLMsIBeryowHhZViJs=
X-Google-Smtp-Source: ABdhPJyO4jgehiWF29/v6L5Hqee2T62yHm9IVUzqKWD0Adt6n9NoYgFvTUNrBtoqnbBlVnjYvpfD3w==
X-Received: by 2002:a63:524c:: with SMTP id s12mr7659165pgl.453.1622888990665;
        Sat, 05 Jun 2021 03:29:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id h76sm4305282pfe.161.2021.06.05.03.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 03:29:50 -0700 (PDT)
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and
 %(raw:filters)
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b699c1b7-5f4c-b52e-1d81-a569c4dc45bd@gmail.com>
Date:   Sat, 5 Jun 2021 17:29:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 05/06/21 16.13, ZheNing Hu via GitGitGadget wrote:
> In order to let git cat-file --batch reuse ref-filter logic, This patch,
> %(rest), %(raw:textconv), %(raw:filters) atoms and --rest=<rest> option are
> added to ref-filter.
> 

Better say "Add ... atoms and --rest=<rest> option to ref-filter, in 
order to let git cat-file reuse ref-filter logic."

>   * %(rest) int the format will be replaced by the <rest> in --rest=<rest>.
>   * the <rest> in --rest=<rest> can also be used as the <path> for
>     %(raw:textconv) and %(raw:filters).

s/int/in/

Did you mean that %(rest) atom can also be used as <path> for the latter?

-- 
An old man doll... just what I always wanted! - Clara
