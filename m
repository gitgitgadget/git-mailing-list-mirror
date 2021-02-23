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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8DAC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8622664E32
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhBWLma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBWLm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:42:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BACC06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n8so22202657wrm.10
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKImk1JWlEwJpCvx3ykCPQtKZ1Db9a5dapA1xyYlS+I=;
        b=QR31C1hVua6dXP1yCRK5ugWYKty5nYnj4uC8giGTeisOCIzR/3IZ6IqdI82M043/PX
         HHDX+aGLM/UZ8cgcQbse+hoPtA5dMhZJ21eqM8Blzsc3EZb4xhTpqqEWooqFNd9ZYj9s
         DnrrqlHcffSTldKRBklhKS3qkf17+Q4gUDXRaYuEKccC6z/KYySNiCI20ozm8y3GemEj
         zwfEHGVq3f8F9ioRFQYezOQcAHmay/s7iRfBSy8pHtL7IVn0UPv/pLCMlUnJDVqzP1Ux
         QjQk2RIz5/h5qcovy+5tyRrdSGU5L3QZgx0IazfPyTJeyM2mMwWXKNUhxdoycPEdpl0B
         6K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKImk1JWlEwJpCvx3ykCPQtKZ1Db9a5dapA1xyYlS+I=;
        b=Z/eynGV2Ij8ZipvT9G8aRe6duVqa3ciVw2NoJjvfwuCa7/HhYHjH0ZQ2jFkFFcUizi
         vGe7FWWMWDZmIfREiQIETtAxBq/1oFZR6i2/aX0qSDOK5Ko6izf16NUxwCWudB0ZqZTi
         Dc9H2GcIseH8V1Xox3smlhPB7fb1+L0o+fMxiaDQVEErTkKqM9iRUnjfsPWLDYXh0pcr
         9xNPdwmupAriGss2YY5KCWl5DZ/eyMhv3E1XPt53mDohkPu5yPI+kQEcR6VSK8z2bV83
         AdBMSFsH8iVD+dSvGgTrxa8rfaat4SnuEb3+A9gEZ6DghjeBKNqfP32ne0yJhmV0CWbg
         rXBg==
X-Gm-Message-State: AOAM5312/KAO2fw7GN7mOGUyFRZWxsRd58UYkHMFmsnga57q8jAm/GN1
        muDW/3KcKTr1MvimOJ3wU/zavI8Do0/64w==
X-Google-Smtp-Source: ABdhPJz6Xzb4p5bzbACNr2yHzAH4nO7DcDOmApW2ieATd2PAj4Hz5QboZ9aaY3EcdSFgW7P0eHiKUQ==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr13044776wrq.312.1614080505281;
        Tue, 23 Feb 2021 03:41:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] Makefile: guard against TEST_OBJS in the environment
Date:   Tue, 23 Feb 2021 12:41:27 +0100
Message-Id: <20210223114132.24345-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add TEST_OBJS to the list of other *_OBJS variables we reset. We had
already established this pattern when TEST_OBJS was introduced in
daa99a91729 (Makefile: make sure test helpers are rebuilt when headers
change, 2010-01-26), but it wasn't added to the list in that commit
along with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 5a239cac20e..c3872f783f1 100644
--- a/Makefile
+++ b/Makefile
@@ -584,6 +584,7 @@ SCRIPT_PYTHON =
 SCRIPT_SH =
 SCRIPT_LIB =
 TEST_BUILTINS_OBJS =
+TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
-- 
2.30.0.284.gd98b1dd5eaa7

