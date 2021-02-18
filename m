Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794F0C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2821D64E0F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBRM1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958FC061793
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u14so2455351wri.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/p3IrFKRA6rCPnmEqk44ZSVJLst7ZDX8PsMJJO4GDM=;
        b=ke6aa0lHKn9wEQGcndl30dRGR3GB0gATGnAr64CGt9avT2EuErnGxAUPZpuJZ92gel
         BI9UrEFXLQCdACJ8zX4eLCQtvEVp2pZb+356LSFQ2NXkO5a4IYa3vppSwG5snshQnN9C
         ZMWOfg4ELle8yfUgr/pnO5K8mhBo9m9jZw4e4Zmr3Whfif9goaiYZt/xcqowHQBthz4U
         LAGluCyOtgk5rgsYKyawQWfk7Jm+ZRhs+HuBmfsrXaOQTR3DOV61OcJ60YUSkdc8hwUC
         TkIQQgmXxe5y97UELXBmX/SSSXzmZ7pPieWIpQupKKsk4maq0j12uaf9rOgw2tPIYjDI
         2BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/p3IrFKRA6rCPnmEqk44ZSVJLst7ZDX8PsMJJO4GDM=;
        b=S3YwAnG467XjA14lnxkGtarMeCnnWzQfs98niYvEPG9/9R+Kz27I3Q2XzqHhajYiFy
         TZAuikMRmuPaQo2XVkKr+nmUXrPwOMsO0hMLslF/gdoZBWaXviNDqQz02O5e6pvN4OhM
         R5AM8VjM5LiyMdQf9fBGzI5aiWDg1w6e/JoTcn3VauTIJ2jVibyEOzJGw5IbZFsz6QaI
         lmZNspXTl3CEt3Dw1GBy4x0xKpUxxnS5qkuxpKJ6JcbX6qcXpSPVdsaY2kM58U8LDieb
         KyxkqSSSG9Lntr7VuttAXbPKH5RdFJ+SPvA8W+atJSBqIl2o4jylezwyTGszkQt2s4Jm
         9nuw==
X-Gm-Message-State: AOAM533g6KUyxnMhuWiA7dxK4huxlFV4Qx7LeUQqKMZP20o3xiKXZJih
        uAd3Mab3MGR5SpeNKutGExxATGxY/2qz/w==
X-Google-Smtp-Source: ABdhPJyYdsOj6ug5QvG4zwn8misjn1ddxQgn8ESW8m25PgKSUqJvwqlmP37PHU1A969lB0BBbMNoAQ==
X-Received: by 2002:adf:f750:: with SMTP id z16mr1380092wrp.108.1613645927082;
        Thu, 18 Feb 2021 02:58:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Thu, 18 Feb 2021 11:58:35 +0100
Message-Id: <20210218105840.11989-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the remaining variables of type fsck_msg_id from "id" to
"msg_id". This change is relatively small, and is worth the churn for
a later change where we have different id's in the "report" function.
---
 fsck.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 1070071ffec..dbb6f7c4ee2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,19 +264,19 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id msg_id)
 {
-	const char *msg_id = msg_id_info[id].id_string;
+	const char *msg_id_str = msg_id_info[msg_id].id_string;
 	for (;;) {
-		char c = *(msg_id)++;
+		char c = *(msg_id_str)++;
 
 		if (!c)
 			break;
 		if (c != '_')
 			strbuf_addch(sb, tolower(c));
 		else {
-			assert(*msg_id);
-			strbuf_addch(sb, *(msg_id)++);
+			assert(*msg_id_str);
+			strbuf_addch(sb, *(msg_id_str)++);
 		}
 	}
 
@@ -292,11 +292,11 @@ static int object_on_skiplist(struct fsck_options *opts,
 __attribute__((format (printf, 5, 6)))
 static int report(struct fsck_options *options,
 		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id id, const char *fmt, ...)
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(id, options), result;
+	int msg_type = fsck_msg_type(msg_id, options), result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -309,7 +309,7 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, id);
+	append_msg_id(&sb, msg_id);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.30.0.284.gd98b1dd5eaa7

