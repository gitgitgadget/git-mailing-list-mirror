Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1559C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D68461369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFPEEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhFPEEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:04:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19779C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:02:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l184so866072pgd.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WBczbCSPab8bWZT6QbJQ49L2eRphP4pgqcXz8DKiDs=;
        b=iVxkHhm9+El37yRDsWyVU1jDpwUX11T/xZ6ZCtqaGJ1JzcUgMkXTnPIqdUcuM94rKZ
         MfPpPGOoTIvtOqZgtBwn964LCxTKm2Kq3LLaME5aUT7A9jE2upmc/VWgKoOhRpt4yLx2
         3WARK97QJQNnzbXduv1sFHs3ufuA+zJIggDOAVUmzVEhK1ukbAf0NDJnsnGloTcDDZ2s
         U4II2NXShF9LQ+1w7qWmn6HaxhCxeuhC1F7gnx0sIGSTirkDJFtGiBApFqgfjyHPh1V6
         7zHjb6jX7wf2iHzDoy361vJN3TrydlTv/aAl0paGeFqRbHTjMpCQEcHejZSbSGqj1i8d
         OlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WBczbCSPab8bWZT6QbJQ49L2eRphP4pgqcXz8DKiDs=;
        b=G3iAOm76jUgr7ksx1K51bzZ6ZNQtECooDUGfBNkSfwwdC7zEdY7BD7m8X9khruqCHC
         w3pd8H3Q+EajKfxphSABJSPbaAHoDscijUC1CoekxOs0cPPFptLxcVcloJtjQzOH2/Bb
         9cGoJG6Q4oyb8fudA1pqnhelo10RVoR1yj0LB+2Kc4VeFD0z5FJmVsWM0TNFH+0g2RhO
         OtpR8E5yKx+2OFPA4eUUnEc5ng3rqyPCwZka6LPl6ACdqbGIhF3s1QJNo1qFL9x48+ND
         9D2bfM+IkiN4FA5ztEvP3twYzHuxIo7ozG4p0TXx1kADsO+RAOVM6L1A7TY7HW8/YWbd
         1h4A==
X-Gm-Message-State: AOAM532liyVQXCFuABf5QPZmQZd/ZfQsdNiDH68RiT4zQ/Iz/XwXUjAr
        1PdxmPOzgReuLOO18Enovs4=
X-Google-Smtp-Source: ABdhPJxnWXdoqW2/KnGS2/BxGpo5rDMGYGhVKBGOeTxxDT6vYUpFtNvz5POUeO0IpwM8+5XxHAT95A==
X-Received: by 2002:a63:d218:: with SMTP id a24mr2930106pgg.345.1623816143615;
        Tue, 15 Jun 2021 21:02:23 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id t19sm3782185pjq.44.2021.06.15.21.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 21:02:23 -0700 (PDT)
Subject: Re: [PATCH 2/6] gitcvs-migration doc: replace "alice" and "bob" with
 "you" and "www-data"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <patch-2.6-39e8654507c-20210615T161330Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c67312d5-cc71-7337-6c14-56ecfbba7737@gmail.com>
Date:   Wed, 16 Jun 2021 11:02:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-2.6-39e8654507c-20210615T161330Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/21 23.17, Ævar Arnfjörð Bjarmason wrote:
>   ------------------------------------------------
> -$ mkdir /pub/my-repo.git
> -$ cd /pub/my-repo.git
> +$ mkdir /var/www-data/deployment.git
> +$ cd /var/www-data/deployment.git
>   $ git --bare init --shared
> -$ git --bare fetch /home/alice/myproject master:master
> +$ git --bare fetch /home/you/project master:master
>   ------------------------------------------------
>   

Normally you need to mkdir there as root.

-- 
An old man doll... just what I always wanted! - Clara
