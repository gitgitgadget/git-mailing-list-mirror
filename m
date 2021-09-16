Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59629C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D16D613A2
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbhIPLhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhIPLhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 07:37:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C0C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso4527655pjb.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRHzS52wMxKd+i7kAUfNbrK2l104bUAfvk9tDhm7Dpk=;
        b=iKKJARt31yt5zlmkvEBGtF+9cxkppgh+jRJM0plk6o7UR32Tgn0gsXAsYDSjo2poYf
         whFTmD/MuqMhn8RwQLGzEd2nzi/tHfAdx1cTiLkJc2AcRFvKOseviihV1cMayoH1ysrF
         +tWwC0DMBHC/krSmzML4/YiE2B6wJT5/dtsBUSziS58NdNVDgeHAoY0y/GySmCvJt068
         WMENS7n9fsjSEF7Sf5rZoyRnB52b8YLyK9OEeh51e1E7fcuz5FTfInoBjZexoImQuG8J
         4ew+Uqs82QYN6j4iMMKrwyLgdOU/PvcvNFfNbQVMup7RjT0Qy587NCXGgAryRbKBYLtl
         VFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRHzS52wMxKd+i7kAUfNbrK2l104bUAfvk9tDhm7Dpk=;
        b=bB5VmX8As79KhDFRl6N/c+cmY1ba7rjkfBT/BLNdh2l+YUia5uOMXLZ3STE9amuxWY
         DqlxRLYSVtAJRPvjSypt1OccWtiljUiR94w5CsID0PmufoDaVr5EVMVoOd7bJeMOv6+O
         ayZi0Si/xyZm6O2W1aQqOFcg/0IDAIaG8bm96cqhhjdDOQc9l5Zp07cT9yNdEo1h//uW
         aWTfc+YNkFiyFes/964IufGsjSJjl0XLz6T8sAYDl8GyX2GiRwUPwgNBmynmw7fDvM4R
         qAK3u12e3ZXcVZbuzk+HpnyZcfpADsm+69ctLtPZMTYoa7J604IDUtQJYAr1dk+npd8M
         7Z+w==
X-Gm-Message-State: AOAM5326zpTx0Fq+zV4/XKXRg5fZkaesEohm6QHCi62uTex8FYdW5ImK
        DRX+J+toLxpBfBk+AE4kCBACgc5JKrdmDg==
X-Google-Smtp-Source: ABdhPJwKnZ+D7XIwBwM3JYHRZM1U/XeVBqSMx3SUnd0NPml7uf6f1E+DSlHe+k1OFwkiyn+yGuYzPw==
X-Received: by 2002:a17:90a:16:: with SMTP id 22mr14544347pja.25.1631792175570;
        Thu, 16 Sep 2021 04:36:15 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id d5sm2501188pjs.53.2021.09.16.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:36:15 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] git-request-pull i18n
Date:   Thu, 16 Sep 2021 18:35:15 +0700
Message-Id: <20210916113516.76445-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internationalize git-request-pull.

The use case is when sending pull request message to developer mailing
lists that accepts contributions in non-English languages (for example
"foo-dev-it" for Foo developer list in Italian).

The first patch is small preparation to make translatable strings can be
marked as such, while the second patch is actual marking.

Bagas Sanjaya (2):
  request-pull: simplify "remote or HEAD" variable in warning messages
  request-pull: mark translatable strings

 git-request-pull.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
-- 
2.25.1

