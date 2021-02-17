Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769FBC433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4955D64E4D
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhBQTop (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhBQToj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1519C06178A
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:08 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id g5so20850047ejt.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/p3IrFKRA6rCPnmEqk44ZSVJLst7ZDX8PsMJJO4GDM=;
        b=uri5JquPJ7nA6liQ0Ixv+pAPEZyDbe0rBHMKIzDZNUedbzClgfxkkUsv/bHaEqBrZS
         SiDrkssRPjkwg5M1xkmJ3HEi6zLsNi+E+V0tyL7pFkUMX73+1OL8YKjjzl1VsId62mwa
         9wItUp5bO0Wj9nWQNhEPlWdebG5sLatRMCWMGZ3AvmWpf44wdIm8HS5MXsaxE2+eNZnC
         PM/vHjFada6U8XaBrf+Zw+Pi2BV4j/Hz4seZHlZIvWUKCJjHjtkhnnL2G0tUuyTGC+a6
         w3/hKZBSrj9e2Lxj1nXtvCBAA1CBjuYCNZFdTH7K5KfQcX51MV7IUWlCjQqok9rJPYMg
         I9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/p3IrFKRA6rCPnmEqk44ZSVJLst7ZDX8PsMJJO4GDM=;
        b=iLwvKdLQRiyndP6aoMI5Xy7fEDyqt6ut3vvu/ccuUlWdr/oIRAddh/cSbt+NxiNk2l
         q0GAj6+ej7JG450goSHx3ULLwyRKjA2buAdN1xo4A6oMm4qVcYq9twNjU2duUFhGfEH9
         jcAC+/ZvEsjE48rdcAaGT1wSerZVQv4DioIY6qg8or+aitd7jbThFGilioXoP3XfSKo2
         KMac640L5ofZMo8i0xTbbpIlq9CilGK+NFGCFtI0bIxDGSGahs+ADfBZcXm7MLyGVurG
         8xqAnti5dhPm65OdxGAadNjDZcplnNPa11fL0hGda06f8tqomFdIreN1AVL2sFzkMgO7
         tHSw==
X-Gm-Message-State: AOAM533Yaqfza1cCVkDHHjJVk2cEOEs5WZfVB5yBCXiIgwce7D5p1n5h
        vOBWKzZFdAe2g36K0LdT41j5euVW20LxJA==
X-Google-Smtp-Source: ABdhPJw+TRtgX7KseEdd2pq/AC6MqW8x9dXW/1L1WO4F3WVHX/sRpGjfTemS+bKyO69M1UfqWrb6uA==
X-Received: by 2002:a17:907:d25:: with SMTP id gn37mr505894ejc.303.1613590987174;
        Wed, 17 Feb 2021 11:43:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/14] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Wed, 17 Feb 2021 20:42:37 +0100
Message-Id: <20210217194246.25342-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
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

