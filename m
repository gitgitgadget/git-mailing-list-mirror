Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A521ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiHaTT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiHaTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:19:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68944101A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:19:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so15386688pfb.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=ImsujrSfq7IlG3oN4EtdxoBq6GDDw6r7112TpJZdXLU=;
        b=PV0AN+k1qXxR/iWt1e2aI4M7iDHkqBxfXkMAF7IJVxAGt4Xim5dr/gihlwvjfC5VGo
         xb51g+2Ejni+tQ1IIKX+pLnze1tMdFk/8e1Pqw+S3DTwardJvUnbC9EwkVyvYo6wR/11
         Adklo6PuGVtSsmSBAfy40MA1Los56sqodPIyDT+5UP8YzotBWkHU7DroRC5h04gwhJmW
         RNx2DGCx0BJzMi+eihDIQh1N/YPzZ7IlrzuOea+SckX0Ilh7cc8uqrPQud40Kk75xZkL
         115Bbzw842XFFvErjFTtI6Fwtpzaucm85wd6JY8iqdLUmJEAGdOC9gWVNaTXphXi8K5N
         BWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ImsujrSfq7IlG3oN4EtdxoBq6GDDw6r7112TpJZdXLU=;
        b=CIlT9DKy7BVZsw0beQy0UrGmnQzUt4IEdiqY68RV3Jc2q4UeNZPV5YjsQAH7W1RPAp
         VMxDkITZZ/CEDeuAM8BTVBba+yjKONsLzZ9tLy20uC2mQ4D3OJIBU4CQx+k2nMlKka+b
         9htIQ70cTHnVInoIIlwhMlOfjz/EYoeQYUHNtc5MTNl8vNZA/BlfCYUfbturIOBCSWVw
         CnzU20yHf5GWjhNFAGapxVpjGD20oZZjP+vyDKLrYAR3TozT2wGESfqkZeSiSFcn01RW
         pWkR5Fb7i9JNo5vKtFnNR5s+4g7UpJ/izIbjW5s73aR5yfvGMiCBT1NKK6G6gdXD/IXi
         GPIQ==
X-Gm-Message-State: ACgBeo2/CBKgKfld579l1PYmbuzKXp28KBlA6dnsAcO03TLmiXQ6/Pcg
        B4w1tkxp5RCKbyUU8sML8dtlfP4YuQE=
X-Google-Smtp-Source: AA6agR4hM8nf7cH90azPMlz+MwyJZGMrE8rA1rNFD2CJIfVQeh9850T+CCDzrZ16M1XQupRWBwTAYw==
X-Received: by 2002:aa7:8149:0:b0:536:84bf:69a0 with SMTP id d9-20020aa78149000000b0053684bf69a0mr27968837pfn.85.1661973587748;
        Wed, 31 Aug 2022 12:19:47 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y27-20020aa7943b000000b00537f30237e9sm9270309pfo.157.2022.08.31.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:19:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <xmqqwnax438x.fsf@gitster.g>
        <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
        <xmqqfshl3pbp.fsf@gitster.g>
        <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
        <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
        <xmqqczcnymtd.fsf@gitster.g> <20220831084403.GA13663@szeder.dev>
        <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
        <Yw99GwZ/MVaK9D0b@coredump.intra.peff.net>
Date:   Wed, 31 Aug 2022 12:19:46 -0700
In-Reply-To: <Yw99GwZ/MVaK9D0b@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 31 Aug 2022 11:24:11 -0400")
Message-ID: <xmqqczcggqzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 31, 2022 at 02:13:51PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Removing coccinelle rules because we're seeing slowness somewhere seems
>> particularly short-sighted to me.
>> 
>> Maybe we do run into intractable problems somewhere with it being slow,
>> and we'd also like to cater to more "interactive" use.
>
> Agreed. I'm not wild about how long it takes to run either, but if it's
> producing useful results, it seems worth it to pay the CPU (and I think
> unused.cocci did find some useful results already). There's a point at
> which the CPU use becomes intractable, but I don't think we're there
> yet.

I am not, either, as it does not look like it is producing all that
useful results these days, but of course, we are looking at the end
result of previous clean-up triggered by these existing rules, and
therefore be biased---we only see cost of running the rules these
days without seeing anything new getting caught.
