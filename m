Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4EAC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC18C613CD
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhELXWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349214AbhELWas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF63C061355
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id f184so3417365oig.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHMEP9kDb3ZmLN9AvcA+uxl5MPYwU7VXbQkvAkXisHc=;
        b=J6Op2i5/RFTCdfevdvQp9sn0hPFTg+nbyUrfpvu14dgfahOVUIwEXOSgRgIlbyeqVa
         ZIMmC/BUmb7nAH7DLqr+/k02Sn/LlzgNd/+g+eoVboKl2d9nDBeFHiE4Dhks5Hh5tNJk
         lndGO4AimN8pAUSFRRAZTglyh9MLK0ogxBNYh3fFmLKAt2ndA10AGp3k1X9oim92wcfg
         UVJN0qRXThaaWH0OeeSZCzVlKDACGMmZxn7zPLChF5is4MSXLLDwO2d+O9PaF3x/v1Ak
         EyQ0bNZeIOfP20xeSrgWgeA1pWDqZeJUMpZ00S9GUqzbFv3fL885U1l4p7OMa7jgmIWF
         OWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHMEP9kDb3ZmLN9AvcA+uxl5MPYwU7VXbQkvAkXisHc=;
        b=ZScbhb34S7rX4QhgFXjhEqxeP/cyjrTg3H5KVkltsa6Idi3FSFI6LFmaPalqoEvnQw
         HAyUCUEFZPNquHW1xN9mFoPtK3t20tIfLQOY8/pYNy7aExc/9GkVGReKmrYs5aOMrK0p
         yYKV0Cq586Oc6chqjl9YCyqEUXWC5mv/fR1wSh5ScoWXGIw0SW6QmfxAnbgubN7BFDlb
         MlpRvV9Hb8BqZYch+jpGvIq7x+ejZaBEqcwteMBqkUidow7xn3F+ntj8L1Xs2OSiCgAF
         JLpgCeSEUoOwI1k8RVZVUG2nUfdEsjNT+/eQtmnFGADYvCBm2v4nd1zy6uYXzAHNEfFu
         2LUw==
X-Gm-Message-State: AOAM533F9a14W2FDMSVtos3M2LE8SGEekFL1LD6pYCNWb9XVrdkEJpVL
        AxdbZ/BkfsMEBrjI8iyR30efTvGQeX5j/Q==
X-Google-Smtp-Source: ABdhPJyjcYNwX6QfqqbqWBLiofqW9Koe3f8SU4/nuqJHJGnef2cLp99K0LcHkh3FkQaLJeEg1biRSw==
X-Received: by 2002:aca:dc07:: with SMTP id t7mr595794oig.164.1620858505047;
        Wed, 12 May 2021 15:28:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id o6sm285603ote.14.2021.05.12.15.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/8] doc: disable asciidoc-helper for asciidoctor
Date:   Wed, 12 May 2021 17:27:58 -0500
Message-Id: <20210512222803.508446-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

asciidoctor handles interruptions correctly, no need for the helper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c2a3df24a..956cfabadd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -194,6 +194,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_BASE = $(ASCIIDOC_COMMON)
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
-- 
2.31.1

