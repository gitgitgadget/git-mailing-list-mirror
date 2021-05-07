Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F09C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23C0613D8
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhEGGHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 02:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 02:07:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60940C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 23:06:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h127so6859890pfe.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4GmLUuy/KOlcUFUzHfGoXLiEerqU992Qxpp7EP9/gwc=;
        b=bC+MWhWHjh6WQlCqy7CIKaBUSM7aONxxVIVMduyOoB/a67v3gs1cEsW7QKVNwWPZhg
         cX2ABdc8Su7yJsYTLxdCvXfkKXDPzfdc1+KN5eNuiDpIw/XXqYK2DeCKWI7U/TCsT9ei
         mI8FUElLA4IymvTUpJQI1TbiwXSi8uI2LEaYq+wGcq3Gf4DT227QbEzq/fDtLlTE4vRo
         7AF401c+ppfnuTDcT5XddRLOdWauLTvKnziGEKGZ5Dytuoj4uTrwbLjrclmZM3xTFUt+
         ovDIzgtloNSwuAPYNjqSIlt6QEiEHYpBWKaftQpnlEOjoSg9zB1rxHYzT3Hljz6TxG2A
         7VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4GmLUuy/KOlcUFUzHfGoXLiEerqU992Qxpp7EP9/gwc=;
        b=ToxEiQyOyhxAhyrr9S4uIjRLeRE/J39PGzj1IX1iPTFXwiH6PMnEGWf2zZGeVZWAAz
         ZPD7Q7qY/BqLqG9T1pPreEvM0SlWJNgAPSTXwGaAtFs4Kc+igwcC7d42zlSzBXxuxRBO
         CArS4QX+atFXwyDiSDSVu9MqWoSu8mZtr/sqDrlovbTjovDTERYk+LarFjREajQXKEaU
         dig4JEWSvDz6/ghJ7mNotXjt7GV35v3I5NfSyBe1wDJYoIilLHOBYYbGT8OpVKxMegBP
         M83SmjfNbj8xxvqg2Db5lXi8LMVAd65xUQjdbA3PQr8jggtuwG4tBbwH4D3mN5UUfeYF
         QPaA==
X-Gm-Message-State: AOAM530is5jL0P61O0Xht+vF+F9AtR8sNburd3yXSJ8nOdaQD4B4JGEc
        4+cgiY3Cyg3jjWU8TIyHzwfvVMfBMhKiOw==
X-Google-Smtp-Source: ABdhPJzi9XNIzI3bBIjP8UPXRo4hRePe5ZjWrk6QLyWTESVUKjmFJ99RgfRlTIFWrHHYrrl8uxtEew==
X-Received: by 2002:a63:c142:: with SMTP id p2mr8248934pgi.14.1620367594611;
        Thu, 06 May 2021 23:06:34 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-8.three.co.id. [116.206.28.8])
        by smtp.gmail.com with ESMTPSA id e23sm3742450pfd.104.2021.05.06.23.06.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 23:06:34 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
Date:   Fri, 7 May 2021 13:06:31 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Asciidoctor has support for directly generating manpage, see [1].

We support using Asciidoctor as drop-in replacement for original
Asciidoc, but currently we need to use xmlto together with Asciidoc(tor)
to produce manpages. However, most users don't inclined to install
xmlto toolchain, partly because they had to download more than 300 MB
of data just to install xmlto and its dependencies (including dblatex
and texlive).

So completely migrating to Asciidoctor can eliminate xmlto requirement
for generating manpage.

What do you think about above?

[1]: https://docs.asciidoctor.org/asciidoctor/latest/manpage-backend/
-- 
An old man doll... just what I always wanted! - Clara
