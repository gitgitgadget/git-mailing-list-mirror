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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A4C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944F564EAE
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhBRM2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07BC0617A9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so2456248wrx.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0d1ZxTeFD9C5da4FH4CjB+U6np2r6VvDvX58IOSB6Y=;
        b=Nu94B6ZTDMned/ktk4/FqQneoZgU4HuV3uague63lAUJ+d6yG5NAAAcbltVHOFrWXw
         VVwBlAPBNt1N5gP/zpb5D4o7ZvHoXSTB0MpJB1rvTeil0V1F/ajAMK/Q83N9f4hbIbsX
         aComt8oFY1vHoEs9QjKvbp8szprAMeOxxl5UEiTY+O/QBkA+n45VWBwY9YrLYyWidezU
         GtJRejsiYftBcqe5B9XELWvGyf1bi4UP7JZQcbfHISTt9gSFLS0xsCt0vDBHNtz4bp1h
         nmDS2pwXOCVwSkrmJ9NU+P9L0STTil1pqe0ywhuiJPgze+Bf2LM9zaQnv7jNcobIgbFN
         FzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0d1ZxTeFD9C5da4FH4CjB+U6np2r6VvDvX58IOSB6Y=;
        b=sBV9xhOnuV4M4g7BXGBlWhkYmFENqI+/i/5/Z/JbXttnjk77LrFcCLhSMUUi/67Sf4
         jArOP8Oky2D76PACg4xstjhJKUZcfXPZ8z9oBAXwRAbNBpp2Xi7FlzN9GmAlL61/YRFf
         sOHQtbALtlALKIk8mTCmM2zBlDwSoiQxlYXN0Ls88jdHVibMLJGhGULnmDpyuG2vY/gp
         ziPEYjlPTrd/9MNCj7TfU9gRSfPKDsxwGoXN5NPmpIS+rnFsnsSEky3ouSHBTh1y0iHK
         8ceKKpivnBdmTYQmWBgNkPBTBaN7JfnofWkqmiE9PhShLCchSgJSHleGts1IhvWiX8uI
         3kTQ==
X-Gm-Message-State: AOAM531HESCNLO2tvAFkVEsH+WSZVUHQUG9L7D7EYDHl44m5+E6B2EbV
        HV9fNXX/6Bfn30WsJPrkdRX7x9OxHFHhtQ==
X-Google-Smtp-Source: ABdhPJzXf622wzdLR0HHYENNRd7+kMg6efNJQLwpO6yjnHQdFzs9xYLyry6Risva3lWE6249FEKRYg==
X-Received: by 2002:adf:ebc9:: with SMTP id v9mr3790982wrn.387.1613645930328;
        Thu, 18 Feb 2021 02:58:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Thu, 18 Feb 2021 11:58:39 +0100
Message-Id: <20210218105840.11989-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the FOREACH_MSG_ID macro to FOREACH_FSCK_MSG_ID in preparation
for moving it over to fsck.h. It's good convention to name macros
in *.h files in such a way as to clearly not clash with any other
names in other files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index 88884e91c89..1730acd698d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -22,7 +22,7 @@
 static struct oidset gitmodules_found = OIDSET_INIT;
 static struct oidset gitmodules_done = OIDSET_INIT;
 
-#define FOREACH_MSG_ID(FUNC) \
+#define FOREACH_FSCK_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
 	FUNC(UNTERMINATED_HEADER, FATAL) \
@@ -83,7 +83,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
 };
 #undef MSG_ID
@@ -96,7 +96,7 @@ static struct {
 	const char *camelcased;
 	enum fsck_msg_type msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
-- 
2.30.0.284.gd98b1dd5eaa7

