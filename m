Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10165C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 10:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03F361360
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 10:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbhGOKqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhGOKqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 06:46:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E4C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 03:43:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cu14so3620043pjb.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GVYj5DHOqqNAm+ZVP/Y7rKY51fbNPDNQhzW1qwHVQNE=;
        b=u6E8e0Bl6BJAR4dhvbVglPKRguQTpBo6fIKmUuSI6Di8VtVa55C2luyO+CI9Oqzbd4
         thopNwb42YisHPqGmfRx2v5HuH2/EzaXLHy7/hsL5oeeyPYe7ftXaGj1jKKGrfjUnPmZ
         wHWt/la/jHswAlOYLro5ditcAypRW/b8u09PSjTWjx9glueGODVXsNlnoYUKBQWY4l08
         1H5X94sWliSP9An1rpLi11aB4+PfSKyPnihjsrP9VdJlXSCNx1rV+o5/ZFy0C1gb8+Xe
         pQivTBvIHN1B3nk3G8cgACNIleePN0eL1q15pwt5jbxi067fwkdUdiX592DCXW7Yt677
         BaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GVYj5DHOqqNAm+ZVP/Y7rKY51fbNPDNQhzW1qwHVQNE=;
        b=rcH/C2/Fpu9a/bN33tfxK9aVuwps3E2fxRpkfhhG8qklq/uzy02QM9HwGeylDeyyzK
         /L549awX9uoOb4m+CH99Z4+FTc9sl7TIphfyVFayRJX8LB7mh6+gNb/vEmhCTYJfefCE
         hyWuT3lDEzxB6ieWZb/DuvemSzYMGuWsC1mGzh6iR4g/1V19GEFPdkDSlWnEBkD7Ge9f
         fwFVZgUsQavpP/8c08bectsNTMLELFM+jMZGcZ/AEBrBEmee88JWSh4QbgbqiZdRml4a
         9KEwRjqpo+pO7YqKpKXgxIww1CFKQzD3XRdSmQze52+PkT79PaE1ZHZEgfU5gFXEtHmi
         cxvw==
X-Gm-Message-State: AOAM531n49svdET5fV976Yg8g/65QCM3Y+OwXyW6Q0EuieuYzLVw777o
        G1+Y0sPNkpl144dWq2CNspQ=
X-Google-Smtp-Source: ABdhPJyAuV8vnsnPNnM3p31e1VF5WpuuPZndJJAcikzqMmHcGIobLyt5bFZA0+Lf5zw6xyFV5uR5XA==
X-Received: by 2002:a17:90a:3d0d:: with SMTP id h13mr3848502pjc.20.1626345821417;
        Thu, 15 Jul 2021 03:43:41 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id js5sm4834457pjb.40.2021.07.15.03.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:43:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] ssh signing: add documentation
To:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
 <xmqq35sgwtga.fsf@gitster.g>
 <cf9aaa48-ea49-e3c2-9909-486d9a3f7aac@gigacodes.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3fb410ef-a4f7-4f54-27e3-9d468cfeb1bc@gmail.com>
Date:   Thu, 15 Jul 2021 17:43:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cf9aaa48-ea49-e3c2-9909-486d9a3f7aac@gigacodes.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/07/21 15.48, Fabian Stelzer wrote:
> I meant that the format is really similar but i see the problem. I 
> wanted to explain the format (which pretty much is just one ssh pubkey 
> per line with a name prefixed to identify the key with) so that users 
> don't have to look into the ssh manpage for a basic example. Maybe just 
> provide a short example of the file contents?

You can write full format description in git-allowedsigners(5) manpage, 
along with examples of course.

-- 
An old man doll... just what I always wanted! - Clara
