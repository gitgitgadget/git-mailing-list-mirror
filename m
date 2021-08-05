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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A0C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B87D610FC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbhHEXD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbhHEXDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:03:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B35C061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:03:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o13so8019431qkk.9
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQ3PAW5NnDEOQDcTpseBrYoHNfaMEmvwPol5LZZS/ms=;
        b=TpAI0Bwu0GxwMoTjiTurboeRY8jTsA2lihPfNPU2oC4az0ZAC7trKlj0073i7kAJQ8
         09wmZaGt11/ELAsHhuOgE8Fz4knUOlnDl6OR0TE6sOTPh8RrmficW3Tx8nVI/CFH5jwf
         LRTy+mWvgUUDxYP6Fiu8Jd2fqYcy3tKkhfpzYp6YKIMm1VwgmWls2DiYJ2udd4zvnSvh
         FrahUdFNULFGnlM9X2dfDaNlOHlXFLWsiuqLswLXgmct++LavyVAIrFBEBQoOc/Q88rN
         FEO14ndDI3U5fcmAAVvjWECx7AHSqDF/rPcJzJL/GEszeHij+ExZYk57LaLrpiIIYSsm
         yhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQ3PAW5NnDEOQDcTpseBrYoHNfaMEmvwPol5LZZS/ms=;
        b=Dh6jQPXuMoQBJlMWKXG7GmETEhXQRObFwfGZObl0BD3PGFyWUErdb1nQokfucbTgI8
         3IfxvDKoPxfSf4ttN8Nj0qa5Fth9EF5HD/ZPc0F8+HA6Kj8GS/7Gkuf3Wt9h/vMWUa8L
         kJ0ZoY4xcuf2OtXfaqGE3L2k0ezBdb3oaKHpVqIVCnil8J94/SBIgN3eAO3/eVcN+pK0
         aPYOFQ14YtznzFh3C85Q6HaQ+7dM7pbdZOdiY/+5D1Zcj2fB22GxJZuItDpD+DLaTDC8
         Hqc3wKa9vqCWn4P+nc2fjdBFB/xxdTLjXPilxdv/PVysNF0AYIt5AsxnePPpiYEBF+OA
         LsBQ==
X-Gm-Message-State: AOAM531EFiEDQud3MSHNg8TwqJM719yy4A9pLzFrb8XD6H6RJQsfyTze
        EXlYLsJNu5/U7JS6FumSd+jYGQVufH8=
X-Google-Smtp-Source: ABdhPJxpyQnawAZ+sjaxtdXPqhMKBZCd5LsUGu/2QIFOcclvN78KremXSKsEwWhhTKH8PLgw3BeWbg==
X-Received: by 2002:a05:620a:1311:: with SMTP id o17mr7600720qkj.157.1628204615925;
        Thu, 05 Aug 2021 16:03:35 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o63sm3796818qkf.4.2021.08.05.16.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:03:35 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] advice: add `advice_set` to update advice settings at runtime
Date:   Thu,  5 Aug 2021 19:03:20 -0400
Message-Id: <20210805230321.532218-4-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805230321.532218-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210805230321.532218-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two uses of global `advice_` variables that write to them.
Replace these uses with a new API that writes to the internal table so
that the global variables may be removed completely.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c          | 5 +++++
 advice.h          | 5 +++++
 builtin/add.c     | 2 +-
 builtin/replace.c | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 0cf3cda26a..ee4edc5e28 100644
--- a/advice.c
+++ b/advice.c
@@ -189,6 +189,11 @@ int advice_enabled(enum advice_type type)
 	}
 }
 
+void advice_set(enum advice_type type, int value)
+{
+	advice_setting[type].enabled = value;
+}
+
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
 {
 	va_list params;
diff --git a/advice.h b/advice.h
index 95489ab4c6..101c4054b7 100644
--- a/advice.h
+++ b/advice.h
@@ -89,6 +89,11 @@ void advise(const char *advice, ...);
  */
 int advice_enabled(enum advice_type type);
 
+/**
+ * Enable or disable advice of a certain kind.
+ */
+void advice_set(enum advice_type type, int value);
+
 /**
  * Checks the visibility of the advice before printing.
  */
diff --git a/builtin/add.c b/builtin/add.c
index a903306300..3d1fd64294 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -433,7 +433,7 @@ static void check_embedded_repo(const char *path)
 	if (advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
 		advise(embedded_advice, name.buf, name.buf);
 		/* there may be multiple entries; advise only once */
-		advice_add_embedded_repo = 0;
+		advice_set(ADVICE_ADD_EMBEDDED_REPO, 0);
 	}
 
 	strbuf_release(&name);
diff --git a/builtin/replace.c b/builtin/replace.c
index cd48765911..1340878021 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -507,7 +507,7 @@ static int convert_graft_file(int force)
 	if (!fp)
 		return -1;
 
-	advice_graft_file_deprecated = 0;
+	advice_set(ADVICE_GRAFT_FILE_DEPRECATED, 0);
 	while (strbuf_getline(&buf, fp) != EOF) {
 		if (*buf.buf == '#')
 			continue;
-- 
2.31.1

