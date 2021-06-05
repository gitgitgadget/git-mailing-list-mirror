Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48ABC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 05:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C060461404
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 05:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFEFre (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 01:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFEFrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 01:47:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACCCC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 22:45:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y7so6661388wrh.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5D7r8R2ueCdwOKxPrMNImnmmcLnSjDudmuw62D2hbdo=;
        b=O3JxV8tyWXQydYMtlx0Ffz7yrrFZ1VuBhloe6VkpSlpTZSdmoXL0+N8MTg2G7W+xGV
         20cl3pIQ7hm43vrxxOKBASo/wwAhWAwoudeLbOxTnjmL558nalVYkU+GQ4pbNUOyryO7
         3GIISKAXJ23/+9BWb4fXqCdb9aXJeXrSoJHWJ9LpYnz7QkciyF6RHI+j1cHD01WuFohb
         W2H1UvrmhaZ5C2tlOOC42TteWcjnKAmNsPF7yoJjkXW6NbUO4NTaSlu7Acm46+4xjlWi
         unTkiqc73xN7nhqztgYWxLA5LeZo2Emus3F13C1FqtEL1iwXCyVpTVMDZbTOC0OY4a0c
         nItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5D7r8R2ueCdwOKxPrMNImnmmcLnSjDudmuw62D2hbdo=;
        b=tDdfv0Z5c4+3upFN/5DhQ7DsuBTx9mzPCUNvhtNJ9pUvslxVfGyaVQ7dMhY/Lc+gRE
         dzh5WLSUF2qiV/qPSVdiRNMHm4ijAZK5HRFhTrznzA907BEgn0rS7/rhU6w5l/VcbihY
         Rjufls8I3/8ayeka5W3QPwEipPws9p1mo5fzQ3Ca1Ayb+evQLr7tTTruKlXftBck/PJV
         ypn0d6KHr7E/6cSkBSfoCFG5Zxr3rA7GiYrysYSNaONVDdWwEs34l+UFhjjRl+R0JQXt
         f3N37qYHt2wH2TSt/pVy9S2ADpCqzxvrDRBLmJnrqmhY2Q9na94tIf6DdQ6x/wJWL/tl
         J2cg==
X-Gm-Message-State: AOAM532rlqCjgbfi++Qr+nFE3M1VCJiSWJhTrhwwBj1ZQcMFVLm40EPo
        R9JZt4s4EmTYkPb0OqIKabjzuM/WKDTEXTVS
X-Google-Smtp-Source: ABdhPJymzWRqlb7AiSVq4Sm8azrzrcxH4EQM3E6B66/UEfa9NQzWtMVx0tyZSoKZ/PipJjsdREb44Q==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr893574wrc.38.1622871924130;
        Fri, 04 Jun 2021 22:45:24 -0700 (PDT)
Received: from ?IPv6:2a02:587:4411:d162:d4f6:a55c:626a:a7c? ([2a02:587:4411:d162:d4f6:a55c:626a:a7c])
        by smtp.gmail.com with ESMTPSA id 89sm9133938wrq.14.2021.06.04.22.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 22:45:23 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_Request_feature=3a_=e2=80=93no-submodule?=
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
 <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
 <YLg/dLqYFEqHZJUn@nand.local> <xmqq7dja6e46.fsf@gitster.g>
 <YLkr+kLdjmHyPjgl@coredump.intra.peff.net> <xmqqo8cm4nst.fsf@gitster.g>
 <YLmmIXy/SITKh/Yw@coredump.intra.peff.net> <xmqqbl8m2p71.fsf@gitster.g>
From:   Ilias Apostolou <ilias.apostolou.zero@gmail.com>
Message-ID: <d75f856e-f219-3d15-e94b-837fb2355df9@gmail.com>
Date:   Sat, 5 Jun 2021 08:45:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqbl8m2p71.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I understand correctly, we should learn to use git ls-files special 
parameters like 'attr' and 'exclude'. I'm impressed by the fact that 
these are not wide-spread known. We should learn to use these advanced 
features instead of extra piping. Your emails are precious to my team 
and will help us advance.

Please consider this request closed.
Ilias

