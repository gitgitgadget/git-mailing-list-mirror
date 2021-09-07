Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF6C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBEC60F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbhIGLAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C4C06129E
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1472525wmb.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKA2gN+AKTbQHqM2l0D4ZakKrU9BY5OaxyIn9EApBzo=;
        b=Jodm8SGbRYS7lecVlhlCRKcXeoWLvoJF7MEJQf4inlUcAZ9igX3EnHj8VHP5EKPsOu
         Sm2R8DZtNgx7/VR9hDMk0LCAzG5/lQPHQr05VSxTgQomVWWNMfacRqWbTLXQeyLMKUBu
         ZDAPiwBEd8QqAnW2/QWp9sMz/RQZo78swfNOwGYbXXRDXy5ceOkdeQTfk4xm0OSDaD3l
         hYfCBJs3G+fyPvGKyIWwLWYh2+CsNM4FxNFR/PKZz7jnofPqqatmCf+DHScoAVtT2i1S
         mUPsbcfXlRrYhqPJB1XSrBM3N3Crl/8U0QYCOcvxnKNlZCPeKqMFclMYKXCufhrH60Jk
         Zrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKA2gN+AKTbQHqM2l0D4ZakKrU9BY5OaxyIn9EApBzo=;
        b=CBquZfQBo+PePk3fxoyHIH2YAEnAfHg/KluBzPAPBqDPDL2XvgLNTx0CywfXopxJ1v
         K/2tdVVRlCtBZOuWiJrAbSi5xNqemaOU2O1zYSPxjFSNRVsoFTPCMTS2r6M9e5eM+JzQ
         cqnSKfDWuy4Cr6/40qTdlYwJ3JPlswuXG8OlHIfa9fFY3WZ95eFA8c4s+8V+/zorL9C5
         iml8yYTTmzAhgRTdm6HJr1App6X2tVCn5Qc4d/he9U28LhMJ90O0VQSoIpTy6hti71ZR
         khNFvSHoCu6T5EUOZnp8gc4yFwQakPFdf7CDZQLnG+CWnCAHyVSkUA5PpfBFY57mcgWA
         3Ltg==
X-Gm-Message-State: AOAM530kxK21loi/xZCCs/6PWdPiAs1X1XDtBj9psaTC6nbutBqQha5w
        4OYEpolrhjndEOu1DhDfuNlb1ogJbkIZLA==
X-Google-Smtp-Source: ABdhPJyGrHxJLavo5y7RE2Vg2B9CICewL6vubMqs9fb9R8c6CgCd7iMcUseHgRxdmt/IXszWy+VeUA==
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr3312881wme.67.1631012316382;
        Tue, 07 Sep 2021 03:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 13/22] object-file.c: split up ternary in parse_loose_header()
Date:   Tue,  7 Sep 2021 12:58:08 +0200
Message-Id: <patch-v6-13.22-90489d9e6ec-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor formatting change serves to make a subsequent patch easier
to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 2dd4cdd1ae0..7c6a865a6c0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1404,7 +1404,10 @@ int parse_loose_header(const char *hdr,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	if (*hdr)
+		return -1;
+
+	return type;
 }
 
 static int loose_object_info(struct repository *r,
-- 
2.33.0.815.g21c7aaf6073

