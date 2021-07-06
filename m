Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13530C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E153261CAE
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGFVVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhGFVVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:21:22 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B9C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 14:18:42 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so910283oiv.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SHOanKi3lho3z/dLdixdMuw6jiOS3dFn2jlMx3rhsA8=;
        b=F7DPMqrQx0wW2MGcKDhIeLsD4Lb1h8O0Ea3pi4LRAfkfKJia5MzJ9c4C7/bOSe2mQl
         nTUoUpUD0LaauLCh1JlajWv5V2Hbq/imIidnGOrJC4lTx/AJfSOnzlmGUdQU5StSJxz1
         iiShgDDQ3sL9KsocTWUdQh5P7E+ZO+jiSGowjXzNRrPm2V8PZTF9cCeE0GzqeupxxRpS
         40TNm43m/ag5vIoE+uXRxk6aCLX+vqDuefVi6XyztAMFwpH/w+B0OMqpvNAKqUQycIkO
         Cldv2mF0bhyiTuZXU3K6rp3idYW80ISRDOXjwXmFshiH8vTq1zdm1rTk7cEnnvHpfCwS
         Au0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SHOanKi3lho3z/dLdixdMuw6jiOS3dFn2jlMx3rhsA8=;
        b=D2RPyOsLLJGapppZ86EsN338Y6pBHMnYdrpMOt/WYzO9rjbMmaqKH0UohnhRZA4iYB
         CUVhXE4yzpKHlTffyEoNqRk8scIG2bTlMiEIYRU1FxVMD1hs4b/Vx78BZtENcroWICXg
         hbSllJQYLWN9ES6OvYVxHmH9ChG86V9nTkFibu+FYVA1nsLA9XiNIOy8Ioqd8VVzJjz5
         7AYxxiWEmx0T8aLISIVgFU8CZXNHseJWUUuNXcMZwi0mIb9e9nLSfFQ/etTHlsdWUtdn
         BxHmDBjW3wq/+ZY8NLGsGQiW4btyo4U5ub6YesTqU7WM4jsgRyQLOT42f/HiPmE9ecaA
         itkA==
X-Gm-Message-State: AOAM532G9a0Jf6k2FGFV7JoaboAKCVzEkscyNohA4hlrkMzJUZeP4rTp
        OJsDz/5jCdkFqksbMVmuGR4=
X-Google-Smtp-Source: ABdhPJxiGTz9dG/zbySGxBogsp5j2CnpxOYwu8+lOF6Yo8NbdToBGi5Z/WoYoeC3QHWKiNJdC+XiTQ==
X-Received: by 2002:aca:4256:: with SMTP id p83mr1997755oia.70.1625606322301;
        Tue, 06 Jul 2021 14:18:42 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id r1sm2457576ooi.21.2021.07.06.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:18:41 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:18:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Message-ID: <60e4c8b0c734b_1c428120895@natae.notmuch>
In-Reply-To: <87h7h75hzz.fsf@evledraar.gmail.com>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr>
 <87h7h75hzz.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gd3JvdGU6Cj4gCj4gT24gRnJp
LCBKdWwgMDIgMjAyMSwgTMOpbmHDr2MgSHVhcmQgd3JvdGU6Cj4gCj4gPiAr
ICogICAgIOKUj+KUgeKUgeKUgeKUgeKUgeKUgeKUgeKUs+KUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKUgeKU
geKUkwo+ID4gKyAqICAgICDilIMgSW5wdXQg4pSDICAgICAgICAgICAgICAg
ICAgICAgT3V0cHV0ICAgICAgICAgICAgICAgICAgICAgIOKUgwo+ID4gKyAq
ICAgICDilIMgKmNtZCAg4pSDIHJldHVybiBjb2RlIOKUgiAgICAgICAqY21k
ICAgICAgICDilIIgKmlzX2F2YWlsYWJsZSDilIMKPiA+ICsgKiAgICAg4pSj
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pWL4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pS/4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pS/4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSrCj4gPiAr
ICogICAgIOKUgyAiZm9vIiDilIMgICAgZmFsc2UgICAg4pSCICJmb28iICh1
bmNoYW5nZWQpIOKUgiAgKHVuY2hhbmdlZCkgIOKUgwo+ID4gKyAqICAgICDi
lJfilIHilIHilIHilIHilIHilIHilIHilLvilIHilIHilIHilIHilIHilIHi
lIHilIHilIHilIHilIHilIHilIHilLfilIHilIHilIHilIHilIHilIHilIHi
lIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilLfilIHilIHi
lIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilJsKPiAK
PiBJIHdvbmRlciBpZiB3ZSBoYXZlIGRldmVsb3BlcnMgZm9yIHdob20gdGhl
IG5vbi1BU0NJSSBoZXJlIGlzIGFuIGlzc3VlLgoKSXQncyBub3QgYW4gaXNz
dWUgcGVyIHNlIGZvciBtZSwgaXQganVzdCBsb29rcyB3ZWlyZCB0byBteSBl
eWVzLCBsaWtlCnNlZWluZyBhbiBlbW9qaSBpbiB0aGUgbWlkZGxlIG9mIGEg
dGV4dCBmaWxlLgoKSXQncyBub3Qgd3JvbmcsIEknbSBqdXN0IG5vdCB1c2Vk
IHRvIGl0LiBSZWFsbHkgbm90IHVzZWQgdG8gaXQuCgotLSAKRmVsaXBlIENv
bnRyZXJhcw==
