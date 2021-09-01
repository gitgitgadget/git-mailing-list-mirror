Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792DC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF1560F6C
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbhIALc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhIALc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:32:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6454C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:31:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v123so1768457pfb.11
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7kwPD5cEDxQz54KsyhEtkmgd34tpaP76LYZlbtw7s5w=;
        b=iI25EXDlpGrIxPxXdEwgIW/z1OlBmXr0fG1JjE4ZijKtaKfuygEXI6c3rWh9XGOKeZ
         11qcKSdXHG/cUqZneF/D/B8llr2T5Lah0m96LfXG+odkCTzo9MFEFBMBUAJZe8+ysBjd
         tpG714h3C9QeveBESwdFesOtxfrhkiaen8YW5m8LN841czoGlcDY96eqxWqNASDIpX9G
         Jz60P50GaFydKEnv5SPaz7NF80ZaZL07DmJ0pS1pwOgB0AEq0DETdFM/GsGIcYU1WXCK
         377HDI7V+FQ5h2NpV2t4Xeg7thiMG0NYmMOo9Ko1Lm9FCXTLiU3ryOU2HsAsM/sc1pJ7
         pFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kwPD5cEDxQz54KsyhEtkmgd34tpaP76LYZlbtw7s5w=;
        b=C3ncwTGld+iMFkrKUTQVXbLTGZPIm7opOVOshXld4Tka4eg1QYIQ8oGR046Gg6jNFN
         geRLeI2/tvg7AXuKoXJ146s44eZjX+VRRdGAJCSpZzmSPEiSRAfUq8IqeWhDFJ/C9CUa
         S6Djm+OGZRJE3UbJn2x23OO+a/YHFaFGn25LgnjZomdI5W2yrRwEdpg82qSQrtXBEjDA
         wNX/6rAc+8pTlbhCq6b5lR8hxB4w1y+SJ1jPr0/SuS1enSOWreDMYBWmDkwnN7hZRzHZ
         0j85yNW+A8TjeqJxTLK8un6q17dqxDIAR82lAhbn5VhhUSofF4s1RDfQXkJNPNxZggzg
         +LBg==
X-Gm-Message-State: AOAM533ydjzQEH70/p1n61ep3vJ5tizJU2cp+Zsk8zJcyGgGeY/LzZpg
        /x6C9O0LFnt7L980UIBkpiDDybttP9SFAA==
X-Google-Smtp-Source: ABdhPJwhJL+RREwU4nBAiDAHL3xIjrOiifQYOn/AxL8LR4p2rgelDWv+4qs6hBai2B5jHyLKpqSmpg==
X-Received: by 2002:a62:1b56:0:b0:405:9140:5e37 with SMTP id b83-20020a621b56000000b0040591405e37mr7482385pfb.57.1630495889977;
        Wed, 01 Sep 2021 04:31:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-20.three.co.id. [180.214.233.20])
        by smtp.gmail.com with ESMTPSA id d8sm5572712pjr.17.2021.09.01.04.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 04:31:29 -0700 (PDT)
Subject: Re: [PATCH RESEND v2] make: add install-stripped target
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        felipe.contreras@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210831013235.388682-1-bagasdotme@gmail.com>
 <xmqq8s0hwnkm.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <96e4b388-d924-e5a9-b23f-07cc0007c328@gmail.com>
Date:   Wed, 1 Sep 2021 18:31:26 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s0hwnkm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09/21 00.06, Junio C Hamano wrote:
> Given that, I am not sure if we really want "install-stripped"
> target.  Adding INSTALL_OPTS make variable that defaults to an empty
> string is a good idea, but we probably can and should stop there.
> 
> Then users can do any of the following:
> 
> 	$ make INSTALL_OPTS=-s install
> 
> 	$ STRIPBIN=my-strip make INSTALL_OPTS=-s install
> 
> depending on their system, which sounds sufficient, and is a vast
> improvement over the current
> 
> 	$ make ; make strip ; make install
> 
> I would think.

If we make $(INSTALL_OPTS) applies to both compiled executables and 
scripts, we have problem that $(INSTALL) -s only works for the former.

-- 
An old man doll... just what I always wanted! - Clara
