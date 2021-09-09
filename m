Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E73EC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81CE610C8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhIIHsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhIIHsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 03:48:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310EDC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 00:47:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s25so1457517edw.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WzUXCJ461fEgv2IU2akAhRsZUA2+ShijVB7IyRuusX8=;
        b=c82hwuiFw6dT9QELDkozbpLo5sx10cR9tNvZE366ioBpjzjk4Y3IPKoVp4wE5kFuvq
         LaDME3IKH+1TDAUsAOVLs2U/q5rNb2XH8EkVs+yOGsLUA7A/H5g6VhNbHqhGULEOLuTF
         jc7MBaA2bOxGZSXCAFguZZsv7u51wXNNXIFyNmuTdx88O/YksjWY3G2ieZaG+Pe6jhet
         SdG/QpUL1Q6V4AXACMfbdbC+xRINAAASdT8i7xL5PW2A8YXNRA7ZXlgITEBGeLAISqy6
         nrcmG8rCilCTn8qDEU+LC9yN2VVkcl6YVlbANY6jXuzyZc0eId1LZFLfwCyBpVXIxF8N
         lpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WzUXCJ461fEgv2IU2akAhRsZUA2+ShijVB7IyRuusX8=;
        b=6S2Etl68ffEOzuFnoPl7OG/MzZgWmhiL3zGM4G4OvZH6OED/KKtNia1v8Giq+PeLbK
         GFjMSRHPNFcdZ61FfkIMkxnkvprTgM5GGNdQ5BtxF/isEHmGWuBiL0vcreSY3hrcpoUu
         Vc6yeiA4cHE0RCnS77fVu4+nSIpHBVA8NPkZjqWcVcVpW2qvQpg9w8+WXGmODyyXfL73
         ruc3oalT+WvyetF4ru32o0858wbHOS9LkgRyF0IvBBN6BCy0OIm0B9wEHHB964bwur93
         C6DJHNWgHLu9bHotDICtGIegEKLPwwI6OzYDUToMQE2G33HrDZcRDfDP6VLnzz7+yUpV
         FxwQ==
X-Gm-Message-State: AOAM530WcjGevj+S9d0tE5NbLvfSLknhtTv2spo17LHSirZSIt7doE/t
        xXSuv6PQx6BgFyEy6OaD8To=
X-Google-Smtp-Source: ABdhPJza17kKUcvwsRaWCO6QABenA2szUF9ZSWuVMgZ7A9AU4sxdZIagtK0WWvZWM5lXa/9UzkeksA==
X-Received: by 2002:a05:6402:2048:: with SMTP id bc8mr1831601edb.114.1631173660738;
        Thu, 09 Sep 2021 00:47:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm582986edf.85.2021.09.09.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:47:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/9] pack-write.c: rename `.idx` files after `*.rev`
Date:   Thu, 09 Sep 2021 09:46:57 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
Message-ID: <87h7eufaw5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> [...]
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

git commit --amend --signed-off-by-harder ? :)

I.e. the duplicate header entry can go, maybe something Junio will fix
up while queuing...
