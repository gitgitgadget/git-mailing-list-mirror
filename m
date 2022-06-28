Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE97C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbiF1KQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiF1KQK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3082FE5E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k22so16951037wrd.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K65BDFFNJVsPm/Cu+2dXmkFv+s+va/umGR8fB6aSyG4=;
        b=pfQHY4SwcoqtiZ0tHoQzPx9aIBG7EFuq/hZ3nQEUJYk2gS2MbSm2zT4yfMgvMAS3fl
         NfXLorsPdYcXi1yJ5/j6xcqjyS3zIu4rEczJ0ozGlfuywbpw+zO4aWTiX5yjr8wY6New
         N9pZxGKSbY3rZYWBIIGHkYn2oTpJ6wCpe/T3b6yN1ToSlYZ+fn+Y5iVFGxm1uYbjJv6p
         OUFvt9meyvOn2AQjQuEjxz5iKuR2rn7ri1dLsx5OTO4WThFmrO8mQZQ8Yqv0no9pAOKz
         jfcDiUUjMXH9WOaWDb1Axz8hnh7uhFMsOp4LRaJKI5NdX81IbsPt3g/UAvBmBRgxE42c
         poIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K65BDFFNJVsPm/Cu+2dXmkFv+s+va/umGR8fB6aSyG4=;
        b=dXgDVIewZLiJCL3f//AiryfwTPOgqwttwK0zzNaRdv1GlW5OZFgJM8+5FRbSmi2B+/
         c5KIk68xzWjDTBB8zyzZ71UORSKtLjKbDv+5rtCq8CsgQ8SVtZaLJrf5pBk8SCP42YcT
         ffFfVUBEDKdB6QbYthonpke0CjhrAuGkWqQjzkutkqLOG0/aPrDXnNGvilAx9ozX7Rr3
         dIfB1bYoCoPuWqiMbSy1XYFg3TjUO/qnJJ2nG9cUAKMK6+PapQZzpI28zNJFOc5bxQnw
         jVmKn2wtKrZyeARZ0SYOR+cBn9ID2D2QA7IcxviDVIA7xrOD30Liqcb0vii04eZvIoLq
         Eu3A==
X-Gm-Message-State: AJIora8FWMSEmbtcJvMjNC85zDtpLcf1Ti3jJNbco6VlnzEAqac4Ay/X
        8oyZBs4jGueVOIj6yvcVqNtKY8DugjtLwg==
X-Google-Smtp-Source: AGRyM1uZFARljIs5zeFjwrBVktD/+jBhyRpTCa2XiIBE0mprQ56Gh62VufPJoRHBU2kmj+JANWpnFA==
X-Received: by 2002:adf:e182:0:b0:21b:92c8:b045 with SMTP id az2-20020adfe182000000b0021b92c8b045mr16761000wrb.219.1656411367884;
        Tue, 28 Jun 2022 03:16:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] gitweb/Makefile: add a $(GITWEB_ALL) variable
Date:   Tue, 28 Jun 2022 12:15:56 +0200
Message-Id: <patch-v3-2.8-5c9895949aa-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the targets that the "all" target depends on with a new
$(GITWEB_ALL) variable. This will help to reduce churn in subsequent
commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index abb5c9f9ab6..733b60f925e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -54,6 +54,11 @@ ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
 endif
 
+# What targets we'll add to 'all' for "make gitweb"
+GITWEB_ALL =
+GITWEB_ALL += gitweb.cgi
+GITWEB_ALL += static/gitweb.js
+
 ### Build rules
 
 SHELL_PATH ?= $(SHELL)
@@ -92,7 +97,7 @@ ifndef V
 endif
 endif
 
-all:: gitweb.cgi static/gitweb.js
+all:: $(GITWEB_ALL)
 
 GITWEB_PROGRAMS = gitweb.cgi
 
-- 
2.37.0.880.gf07d56b18ba

