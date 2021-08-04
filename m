Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9738C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9060EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhHDO0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhHDO0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:26:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385AFC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:26:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z24so1478219qtn.8
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UNayRj1mILJXA7D0TrZprvvAi3Vi1C5TQC7ss/5e9FU=;
        b=o1AetnICXwj68ffy9GWK9BJBPvrB7fGNgxRXIVf9ZpRkxHsUeLx1Na0i/z6tu12oad
         TNAefYvCRS8FWzIBIvlNDEO54mm2d0R3XhAbSieXEs+daMe09on0ScAol5+uue7QSwh4
         62IQGbFAnljgRRomHtDrTqn9NorHlt4C/R3+g6dZHskRWlvpK+MnCIri5NYFBPFaJ0Nn
         qfIjZ+azg/4MpThudcuR2w7+Ro/p5vw9vdHEOtKurCZqjP5Y+l8hEZXmnyM4C0meabqr
         mZPuR9bBeVH7AphpWo71IIpnHg8REb53wgSvI+zPVjbnUMGbxbTCjo/KN2ZNh0Kx+QJN
         UhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UNayRj1mILJXA7D0TrZprvvAi3Vi1C5TQC7ss/5e9FU=;
        b=kU+TtSJh7q1Wf90Gd+dd1Ly7j/5XSylHMN0OttV6SfsJWfxwsu7DwEI42SlsK+S4Hd
         9M0HAegK44pajmoIGyo1P31xwcOG7TD4qSzClLvtKQv1hzKu1C0QjwoaMIuoY/XivE1b
         ed9t2Eemg/BaaLZz17WcKdNCNhE8OcRpa+jhAiR5KnGmfNvcalIfA/mmeeLVIANFkbBM
         cmFsApDkYdoz7LM5hGMt9rOzpWFKgzParaZAW5qU1Xh28XR+/qT3wFXqTLNMlFWBILOT
         WsWwkLjiXXD0GNMQMU8mS+i1uULh+vrIPg0L/uy7T8bwk/z0JOUUIKrzzmJj+8xjA9l+
         Ax/A==
X-Gm-Message-State: AOAM531v1S1SW0XhWAEhbsaXsylcge3bpSXg617Nt3aGcIZREheoy1E9
        EHOCOqJDAPV+t78/L5YcxQE=
X-Google-Smtp-Source: ABdhPJyuHO1JEMaRQLd394Ign3n4Ge4aEBDsKmnOO4pJW+iSp8990eCXMiBsjiDv/Iew8z3nyQSglQ==
X-Received: by 2002:ac8:5987:: with SMTP id e7mr6983555qte.272.1628087163246;
        Wed, 04 Aug 2021 07:26:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3da5:bc29:43f3:f85c? ([2600:1700:e72:80a0:3da5:bc29:43f3:f85c])
        by smtp.gmail.com with ESMTPSA id 2sm1357515qka.68.2021.08.04.07.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:26:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] Update docs for change of default merge backend
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
 <845d5bf510c5dea2bf6d96d6bc21f356d00fc562.1628055482.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcaa2322-6ef4-9db0-4c0f-3050d37bb875@gmail.com>
Date:   Wed, 4 Aug 2021 10:26:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <845d5bf510c5dea2bf6d96d6bc21f356d00fc562.1628055482.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 1:38 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

These updates look good to me. Mostly whole paragraphs moving and some
word replacements.

>  subtree::
> -	This is a modified recursive strategy. When merging trees A and
> +	This is a modified ort strategy. When merging trees A and

Here is one more case where the old docs could have used quotes around
"recursive" and the new ones could use quotes around "ort". Not worth
a re-roll on its own.

Thanks,
-Stolee
