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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC15C43332
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7665029
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCFLFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCFLFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E4C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j2so5220960wrx.9
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2NnHot1kq8rulN1A2zV4gom9+OLEHu8U8IrSMxJR5w=;
        b=sLRv6Xklr7BQ51oW1brKlJaG6h+Q4JZk9JrIDAxY0HMWANHb/CEDZmEW17tZBnCC0E
         GOdBnTo3RFhjMpN+4sto7NdgWw4RdWx18yl75Ud9wehJWDTaZqE7qoWrTHAty+64NMrI
         hu4aRCBopirUIBhXtQeLJjYzmyko8lT+0cRVmWQHGPvrcgLRNnvGX49xQyohpLXMyXdj
         U1CpGv04MlR/qqL66cvIkS4lMXfJva5av6ROJURENk0tVOGIdBCg+RXwOriT4AqUUmyZ
         SeHJKhOzKIkzUVZCshYR+vk63DrEJpOQXQHLGcpWKB1RqLUnxN7c8jYBGLHCzY8eEKU4
         SStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2NnHot1kq8rulN1A2zV4gom9+OLEHu8U8IrSMxJR5w=;
        b=kp0vDwe1kLTDIvLZ59RSd+qjSriVCcwvVD2dTcULrIXa4KYYHzUTXtQm2w/YZv9mGX
         ULC+5aVkVjOwPd32uL45j0NpAfR2VD6k+0EF0Zi8aAr0wHaKBhwMB9RxfOCEYiouu+ec
         HqGvjcDfzZ1Dbdl7fhYdOKJ2XovAJnVXxuShcwz/za+gq5d2hDVhWp3tb3CQvvz9+eHA
         qCj9tSBJeAQO6D4vEZ2+o7XUUMpNv9u8a7qqaKTMgAvlFplwmzZBKkqu0zH4HDs1HZJq
         W+q5fPtTHCkf4qVISD131Tzj3cGnWluaFYbSMLpxSr2Ipd42IDkvi1r8iqxvYOxzjhD/
         Qk7A==
X-Gm-Message-State: AOAM530QZoOR+5ExmOH7NTyO0nTmmbS2Df2Y6q9XOly8CAfkJQSB21pZ
        yn+WmEzZzJq0/3n5l7J6qjHruNliU0W/HA==
X-Google-Smtp-Source: ABdhPJyApIHJFoZoH80Ny3UUuvCivl+QkVErGomUBMJUvDGIWSiG7M5boEyvg3kooDh2F0pdoR93HQ==
X-Received: by 2002:adf:f587:: with SMTP id f7mr13799002wro.147.1615028699179;
        Sat, 06 Mar 2021 03:04:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/22] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Sat,  6 Mar 2021 12:04:26 +0100
Message-Id: <20210306110439.27694-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the remaining variables of type fsck_msg_id from "id" to
"msg_id". This change is relatively small, and is worth the churn for
a later change where we have different id's in the "report" function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index b977493f57a..6b72ddaa51d 100644
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
2.31.0.rc0.126.g04f22c5b82

