Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8869FC4332D
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9D96501A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCFLFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCFLE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B2C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so5214285wrx.8
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKKgtxzQL1iB11MvkcQMQs+/cTEMZjhHR7GCbHtNkoE=;
        b=CjhhP6SVeHZapY+IEqYYIbtqcVnIxhwbws//L/G+lkSrijxCLUGUm6UaMHHexOmrN8
         cxuZVbRrGo8Xzx/Mh7OuIUPEum99DjtxtB4DohbnZE7suso2VLFTlTb5axFMbCeXmVHp
         845gbj3/RAU/SAi6jk9zzHLEi+zi303qGR333GwQ4GpQV1Bl9qnfx6+aJWrvcN3iMEyQ
         oB9fkBGPtVylq7fMA2O1IsmD2oSdxHyTDhVhncj1X+x99iWpcrXZ4Z7XWQAB26eDjfUU
         8pAt0B3GQ0O7qQeKq4O1wwNG0ps8+/TdGEkT8c9hQOU0PxtmzJmTjuXpM0ZGQtEkThrM
         Wwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKKgtxzQL1iB11MvkcQMQs+/cTEMZjhHR7GCbHtNkoE=;
        b=U9XkjC5XmorHvvY7W2YvjLdkAkN1ntSXqxjGzhyqzRqO/+TQ7ci58lqtjP24uB+p9Y
         jUsxeBxBlcw6sUEvg4xvyGPa5hbHUyRZBgdY0AnbUt2plrzGMXRvkbxjozdZ6x14irwL
         yYi26S2zOCWjbxp2v/9As92nGVC76I8G3btsDeifiMcQoTnjy3isXIgbRtWUNSTPCSxU
         So8z6EbyPdQtMf5p7yFgMr1v72YgejHpqAHuM3c121rhmtATQg8anv1LNmSHdnYH5v5F
         jhK2x5qsyIHqjRp3wqszLUYrn6mg+rAxCKMSZ5nRTuQbYYQ9K76yRVsmnd+NlEFFub2X
         TxlQ==
X-Gm-Message-State: AOAM530+fQIVIN8j1APPEd0ECJTVcZOAP3Fm2p5B5sf/gtTnLYew6BZi
        n0CPWt/O94yZWI/t3Ne+oJtojoGWtlDnVw==
X-Google-Smtp-Source: ABdhPJxtf8rFK0enK4fUvR7NidF6+y1kEXrG9zU2/wb+PZC6SGxoDo1m3Th83D1xeVxajqoIUFVleQ==
X-Received: by 2002:adf:8104:: with SMTP id 4mr13719143wrm.265.1615028697480;
        Sat, 06 Mar 2021 03:04:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/22] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Sat,  6 Mar 2021 12:04:24 +0100
Message-Id: <20210306110439.27694-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variables in a function added in 0282f4dced0 (fsck: offer a
function to demote fsck errors to warnings, 2015-06-22).

It was needlessly confusing that it took a "msg_type" argument, but
then later declared another "msg_type" of a different type.

Let's rename that to "severity", and rename "id" to "msg_id" and
"msg_id" to "msg_id_str" etc. This will make a follow-up change
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..0a9ac9ca070 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,27 +203,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type)
+		const char *msg_id_str, const char *msg_type_str)
 {
-	int id = parse_msg_id(msg_id), type;
+	int msg_id = parse_msg_id(msg_id_str), msg_type;
 
-	if (id < 0)
-		die("Unhandled message id: %s", msg_id);
-	type = parse_msg_type(msg_type);
+	if (msg_id < 0)
+		die("Unhandled message id: %s", msg_id_str);
+	msg_type = parse_msg_type(msg_type_str);
 
-	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %s to %s", msg_id, msg_type);
+	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type;
-		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
+		int *severity;
+		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_type[i] = fsck_msg_type(i, options);
-		options->msg_type = msg_type;
+			severity[i] = fsck_msg_type(i, options);
+		options->msg_type = severity;
 	}
 
-	options->msg_type[id] = type;
+	options->msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
-- 
2.31.0.rc0.126.g04f22c5b82

