Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E61AC55178
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 19:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC4C20885
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 19:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku5geJer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418531AbgJYTYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418527AbgJYTYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 15:24:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA42C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 12:24:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q5so10503089wmq.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=xu8cbT7zKtME/VH31y179BDbpiXJ6MGK3badQNRoh8g=;
        b=ku5geJerfT190gRUU+IQX1XbD726fWXsB+SzjXAJyz4ilgFqCfe1vC3fZdyJuatCg1
         60L796MlU0Dly63G72QCpdkMlSCgdpmLPSr93LI2M91w87d9uoFrglD/R7wlQ/JzLM1b
         dtVZ2TP8BiwGoTswc8zxlJVHqCaj4lk7IkABh2xsPNuDD+bCmZ6Dv/4Kx4EoLK7e/ePK
         /USzrmgRMhzI8PKRGOfkSbvk7PvK7iXSfKtcg+85rSuVVqZxW4ROSf37GjykmJro95/h
         GGzyfHEXisRING+yfaFHzzhrnGaIDfm7F2ao3kOagDDhjevwkAmWYuIkA75YKNXrY4tb
         ZJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=xu8cbT7zKtME/VH31y179BDbpiXJ6MGK3badQNRoh8g=;
        b=nXmBqmJD1+MugH5h+zcRASH1HClD6RQO+FoL+HoNdymxapCr1bUL9YX4b6sYBjroRQ
         /RHZpkIK4+RbNP0vpN8Kn8gBTQJD7T1XlwJytD2E+2/V0atz9Nn36QMmhfUIPZC+kDEI
         8ZFb7XwSx2m7psJZGqRQYPaL2RwHLKVQuWlfobFYD6FmRf7AA/VJZCh10cpxyeexX6gq
         ab5Jqu5EFfjDw+4Y7fVQm/XA0KvIFX3GfC2dy32NiMy+U/hAmKx2NRzLIhoqhQ3lvUWE
         KYu0kCDa3ZHibcnKWUVZPozsNVXVgGPjE7YHnSUy8eOE53P8zfjOQWMxdSk1zMHevqZu
         jFFw==
X-Gm-Message-State: AOAM533DY/UVcPU58YlWn+2L0GTbmZplBF/97k5Lb110AcKcWAxOO4zf
        Z/y1xzwDOnFms0bDS1FD1vcQr3pLTO1ZFA==
X-Google-Smtp-Source: ABdhPJwbeby+e1pv0Z16t2HJi8sjFShbghMGpJj4yr4WQQRGAZgSp0Z+mronN8z94dMw0bUER+FLbA==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr6312012wmj.78.1603653854633;
        Sun, 25 Oct 2020 12:24:14 -0700 (PDT)
Received: from [10.27.0.166] ([91.207.57.182])
        by smtp.gmail.com with ESMTPSA id e7sm18143316wrm.6.2020.10.25.12.24.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2020 12:24:14 -0700 (PDT)
From:   Dan Mutigli <dmutigli@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: changing root name
Message-Id: <3DCC404F-D903-41B6-89C2-D1F0C1CA2EBC@gmail.com>
Date:   Sun, 25 Oct 2020 15:24:11 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you change the name of root to ROTOROOTER, will that screw up your =
application installs in zsh?

Just curious.=
