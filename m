Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DAC2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25C6610A1
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhFSRdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhFSRdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 13:33:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A2EC061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 10:31:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x196so14718896oif.10
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uYkdHupm8lrwVh5u0S3FjHgMjvGGg8lSWzQx752jX4M=;
        b=bN6fm6C3exxd+SRxwW3pkTwwvcJ8XbwIlI6B/w8tZ9ivgFli9qKNxMeNoenO8mFoU8
         31j0aVkitNRr3IyGTtHG27YfuBP7pKaUm6tIyxiFvaVbTGrE9xEt8cQaUOEqwa8TMnpa
         OvOkY1FHwtDTdlZ1C24Y/RODMq6/nZTsXaiQ0wpn4SS6kMnTJBq9aEzJyBtx9Az/6K4M
         xGRxwB05fCQhps7TPsUL3RJhyImdCdakiOjBdhNfbv7eucO977TPyGnVxuyP1dvu3oZG
         vF5OQVmZK10/5cIwMSEN2qlQY3VIZK4EN3pjhZ27h83mTJiTy70Vk+65cCmBvpu/qphz
         s9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uYkdHupm8lrwVh5u0S3FjHgMjvGGg8lSWzQx752jX4M=;
        b=haHUMcKlooo3aUm89GsNEjTqndSv7ET8GeVkKz7l7Fk934xRgw0yIquPJreTaVcz0T
         KNpLPEUtfN7fGaL5DaOZQ6IDYSoIGplJQArzEYDAB0e3DEuXnMPHqTtkeWuohiOtJHU/
         cPFJDAJ2uhfonLM79xjOJgCuV/agUi8QM+7a2JlY04bS6cRtq2Uatbb6xSjoPFGMNQ3f
         JX2/uIvZMPx/x2uwJYBuaojito9/8ceHW1CwaAeZo8CKqwDo/XNHnknhP2tsYKWFgapl
         NLkATsm7tCkHm0GAMm6EicD0BtGwrbNAzrZw2XB3y+RD5lC8stfJM6LdF4fVFgnOoXCU
         E1mw==
X-Gm-Message-State: AOAM5313T11MTkamTFytTZZMVIjBW63YYehHX6A5A0skTqrvoTzyxauQ
        OmOfxpIpKJ/93eBe/U/hRNk=
X-Google-Smtp-Source: ABdhPJxKleNTeL3tOBVryxRTxb9SLTyM2i9tNOYpB4Cbgm6M6q19eyeOoaqxqy3jP8R+7/p59lay2g==
X-Received: by 2002:aca:aad4:: with SMTP id t203mr11547521oie.149.1624123866739;
        Sat, 19 Jun 2021 10:31:06 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o20sm2693100otl.2.2021.06.19.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 10:31:06 -0700 (PDT)
Date:   Sat, 19 Jun 2021 12:31:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     Barret Rhoden <brho@google.com>
Message-ID: <60ce29d9144e9_cc2b1208f8@natae.notmuch>
In-Reply-To: <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
References: <20210618221104.42260-1-rybak.a.v@gmail.com>
 <8921ac50-e628-9a60-2a8d-1b8cc2a5a056@gmail.com>
Subject: Re: [PATCH] blame: fix typo in documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> That above is not typo fixing; that is correcting configuration variable 
> name.
> 
> PS: I have to download mbox of this thread and reply from it because I 
> didn't receive the thread on my Thunderbird, regardless of CCing Git ML.

This is something I've noticed; I can always see mails on the archive,
however, I don't receive them on my inbox until much later.

-- 
Felipe Contreras
