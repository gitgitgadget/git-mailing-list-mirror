Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540DDC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbiCBOOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 09:14:09 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193D8A303
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 06:13:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q4so1290797qki.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hgNAxN0gDeu2FhgjufL3lOskgg8uc/ph46FZLmA+vfo=;
        b=CnPlbzXNSdaylBYeqApLJaPvdtnh7vDmb4SdhkpGOoLmIu/dXwDS0W5dcNsqd3skzv
         kocXs1S0viBuDNSDcQDnYq75fYbyYsafZ5wsjUYZdNXgXpqiC0rTvWaczT0hFRNM+37Z
         DamSxuewMTqurylxSiGVss7KIVX8hEgOqWhesxCP/WpOXuG/7h0n5QVkhVTnI8gqjtwP
         B0DsSoEJCd14Mrb2xQlklM1m1IXdhc8RTjoatlXfgWW898rqtE6qtly1I+9DNBm2jQYK
         v6EnSCMtZ0o4RI1N6fr1VttAfq0HuMU2QXoKaV1xYDS99+5FeuXqamYf3fmpS6w3qlw8
         Nr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hgNAxN0gDeu2FhgjufL3lOskgg8uc/ph46FZLmA+vfo=;
        b=wZA4byVuH1QdTczchZFwJK275EE0B0SvsVLctqp6qUlW/tRSsJae/McS/SCEzv2bX5
         FuG6cpHUEVSLcg8z2UB/DSzbYAwuxdv9IhuUKvsEfqbCzgNJBTzVsr59ha/pLoZFLTYc
         FyU0qucHKjpJv3p0V5HZUO1Yp75D3oIsopSDCA9BRVngrVLgPHpIwd1/cjrVPKLioV7v
         2AbrXZrwp7kFDQTdbvtaBH/O3IvLPGAVVTPlIJ2QxH+91P+CTCWAXkLKXahvSiP7pXKH
         Z2mgmfK7dzEWP0bbSQt5s0Ne/WAbvAMTIXU8wcL8z7+PcRM8fwOIgWNv/DPrujVpgJjD
         S/JQ==
X-Gm-Message-State: AOAM532C2jM75WSrAGeRh1QIRGM08jv/8WFwYo4dS7TfM6SjHwrMyY8W
        8tebNHj1kySdFEaSeBuQBLzZ
X-Google-Smtp-Source: ABdhPJxQTSAX01+SZtglbOCjtKbuyPZHrZLgIqXkTmVdxiopc3lU4bCNMTdylnmaLTvXqPtcYx+gQw==
X-Received: by 2002:a37:9b4e:0:b0:604:4a59:faad with SMTP id d75-20020a379b4e000000b006044a59faadmr16138057qke.155.1646230405805;
        Wed, 02 Mar 2022 06:13:25 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a181600b002dd4f62308dsm11169696qtc.57.2022.03.02.06.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 06:13:25 -0800 (PST)
Message-ID: <f21f854d-3fe6-a0f9-1a7f-4396457e70fd@github.com>
Date:   Wed, 2 Mar 2022 09:13:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/5] commit-graph: fix ordering bug in generation
 numbers
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
 <562341b76b30ff3cdc01cea4cda550a7b8165bdd.1646164112.git.gitgitgadget@gmail.com>
 <xmqqmti9ph26.fsf@gitster.g> <xmqqbkyppg9r.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkyppg9r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 3:30 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> Create a new t5328-commit-graph-64-bit-time.sh test script to handle
>>> special cases of testing 64-bit timestampes. This helps demonstrate this
>>> bug in more cases. It still won't hit all potential cases until the next
>>> change, which reenables reading generation numbers. Use the skip_all
>>> trick from 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
>>> single-test file, 2022-02-04) to make the output clean when run on a
>>> 32-bit system.
>>>
>>> Hepled-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>
>> I can typofix this one locally if needed.
> 
> What I meant was s/timestampes/timestamps/ and s/Hepled/Helped/.

Thank you!
-Stolee
