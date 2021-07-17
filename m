Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCCC12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FD561003
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhGQCRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhGQCRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:17:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E02C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 19:14:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y17so11743538pgf.12
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=chP3ydeNUf655pFsgHrvrq9nrEgaoLIOl4VDGXTvGZQ=;
        b=Fc44G5GnSDxyEWvekj08q4X0RHzmpU4xCiGTS363QwsUIQRQDCbSAXB846cFkysD1s
         IRyWAEiPCdTa/40m6kDGA/ARoAN9ND5P+9r7+8mgZnuA8/8j9vYEBJrhIuqh7w7W2oQO
         rFOiFUmpkxhBRv8Kww1ZnA+5TqFYGauM2k2bCzdGiLGnUIyKk3DDtif4katWcdIY6vQ6
         XJwpCkceu8G30gmwaArSlFaffx1x9OGc7FebCg+0RBk6SoP/8o10xRjqUi7d5/ytqsqw
         RFesw5XeeUkhCEtqgeePMeg5p+HUiDklFhEYTqeExBnZtUUGPZn+3e5s8YlRKYxCzedC
         Y5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=chP3ydeNUf655pFsgHrvrq9nrEgaoLIOl4VDGXTvGZQ=;
        b=siXITbkdVAheejUwNOf5QqcKGjv+B9uHSEg88wP8fJZFuQ0STH3dGHr2n/C5k/jcnm
         fd/HMvVTVtZZXhpi5bjdUV2OlTyH1CvvFgMTTDHc96yBGCL8HuYY8Jq4Q7xrsA7QFUad
         feVDccxnGe3dh3MCNL0rUVjWXYQZSMVRwnW0d3U55V9b1ra+3iKmll0gyOPckgztfRId
         n+ksx8D5Tdp/Wb2cmH/ThrkN9BWQnbiew7ufgXyDm2CpWljXDMJdckg/mVVFKuDnS9Vy
         ENB7Hl0iHDTQoiPJlHBqTNE4kCY4fR/pk7eFzJCRGBx6osP9qIcE6W0+MnVt9z2Tl2gn
         KDFQ==
X-Gm-Message-State: AOAM532fXgdTMAityIc6af/TRQZVrLSUmw4sqhtlMHGI+f20UwzfsDn5
        uQhdM86Uf1w2ennaoRaBzFJxTE5PJb4=
X-Google-Smtp-Source: ABdhPJzAJfsypx3bqE1i/dItKy2/vKm+RYw2nRetmVF6wdT9n5Mj8Gz3O+XSJDBU+LKfsvmxKnu3MQ==
X-Received: by 2002:aa7:81cd:0:b029:329:fcb0:1b44 with SMTP id c13-20020aa781cd0000b0290329fcb01b44mr13264178pfn.5.1626488061908;
        Fri, 16 Jul 2021 19:14:21 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id k20sm13201252pji.3.2021.07.16.19.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 19:14:21 -0700 (PDT)
Subject: Re: When are you going to stop ignoring pull.mode?
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
References: <60f1daa896f69_330208b1@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c015e599-0178-cc3d-11be-175dc917f2b9@gmail.com>
Date:   Sat, 17 Jul 2021 09:14:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60f1daa896f69_330208b1@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/07/21 02.14, Felipe Contreras wrote:
> The solution is simple and self-documenting:
> 
>    pull.mode={fast-forward,merge,rebase}
> 

But how about config transition from pull.{ff,rebase} to pull.mode?

-- 
An old man doll... just what I always wanted! - Clara
