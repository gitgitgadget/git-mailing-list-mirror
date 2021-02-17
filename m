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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF31C433E9
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76BA64E4A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhBQTp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82778C06178B
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so24395121ejb.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f5XYzKRXKPmEq1KVmrHHlwG9tFIaE53l7vKmvKSa/k=;
        b=Gn9AUdnKpA+zNDbd9FD3J9zCxHaewdjazWS1E4scimA+Re9bvGA1EibRlymchKx5cU
         Qe4HR0R64WfJfL6d+ywBKqdj7+Lc3c66fDF48UsdcBnfn/lcMHFHn9MLyJbY2It6KGmC
         p6x/je8oHHdwj/UJrXVQLYyqUwP9akq6Gr44/QK2vPikWsx4B2Z9wfimap2plTPpeA5V
         RSz5eCrqUjz+mdVR09P0zb46sn6ie+ZOOBXixcRKD9Ix86op5L97vagoiNChbfrZ7qib
         WPoo8piwbI18jdq9MgefP1e1u6KrDipk16atISiqW40U+Jq/yS+7R4q5Ssc6UcXeRm8G
         krmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f5XYzKRXKPmEq1KVmrHHlwG9tFIaE53l7vKmvKSa/k=;
        b=NZ0Du/t5FIRPMfkNW04lcprvD75Yu/Z6XJj8sFi6EZpz7dLKzb7XG/dAYjMOKM5xcQ
         DdTrFRXPDDmH9JyK1DwnhLsOXLJCGDnwUt3LxLpeCGZ0wZtVXeyJt9rk+2inZRtKVI6U
         NERNCy1eD0xMrIQT89thP5SBYn+OusQ+2GBDN6PlEA53/EK+44hLqw8a0cweJ3/piYkq
         zGvac/8LtaDvDQWR2DW2K5bfG/XIjPlVd2I1AFDrkALwPXJt4rQYCzwoqSVbYPqCSSRc
         E3SeXltnNU8QO8b1/PIq2kIo3ZwO4nWKXW4KRuPiZHvvxG/9OWJWMekSyhUGmSR6nwbG
         NN+A==
X-Gm-Message-State: AOAM530DNE8dEar+eyfzFBeas1sRonfMCWcma9F/KQ2sXd3OraiOIRmL
        t+sTrs4fvHrPw3tDu6++3pYUbf+w4YDn9Q==
X-Google-Smtp-Source: ABdhPJwkh4Ane5vOgpq2l8IJ68yReqfQ7bXVd746fDTbTyggEamcmgHFlBYbdgDYoorcfysJpJwImg==
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr482534ejb.441.1613590987901;
        Wed, 17 Feb 2021 11:43:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/14] fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Date:   Wed, 17 Feb 2021 20:42:38 +0100
Message-Id: <20210217194246.25342-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} defines into a new
fsck_msg_type enum.

These defines were originally introduced in:

 - ba002f3b28a (builtin-fsck: move common object checking code to
   fsck.c, 2008-02-25)
 - f50c4407305 (fsck: disallow demoting grave fsck errors to warnings,
   2015-06-22)
 - efaba7cc77f (fsck: optionally ignore specific fsck issues
   completely, 2015-06-22)
 - f27d05b1704 (fsck: allow upgrading fsck warnings to errors,
   2015-06-22)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c  |  2 +-
 builtin/mktag.c |  3 ++-
 fsck.c          | 21 ++++++++++-----------
 fsck.h          | 17 ++++++++++-------
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 68f0329e69e..d6d745dc702 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,7 +89,7 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o,
 			   const struct object_id *oid,
 			   enum object_type object_type,
-			   int msg_type, const char *message)
+			   enum fsck_msg_type msg_type, const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 41a399a69e4..1834394a9b6 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -22,7 +22,8 @@ static int mktag_config(const char *var, const char *value, void *cb)
 static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
-				 int msg_type, const char *message)
+				 enum fsck_msg_type msg_type,
+				 const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
diff --git a/fsck.c b/fsck.c
index dbb6f7c4ee2..00e0fef21ca 100644
--- a/fsck.c
+++ b/fsck.c
@@ -22,9 +22,6 @@
 static struct oidset gitmodules_found = OIDSET_INIT;
 static struct oidset gitmodules_done = OIDSET_INIT;
 
-#define FSCK_FATAL -1
-#define FSCK_INFO -2
-
 #define FOREACH_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
@@ -97,7 +94,7 @@ static struct {
 	const char *id_string;
 	const char *downcased;
 	const char *camelcased;
-	int msg_type;
+	enum fsck_msg_type msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
 	{ NULL, NULL, NULL, -1 }
@@ -164,10 +161,10 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 		list_config_item(list, prefix, msg_id_info[i].camelcased);
 }
 
-static int fsck_msg_type(enum fsck_msg_id msg_id,
+static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int msg_type;
+	enum fsck_msg_type msg_type;
 
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
@@ -182,7 +179,7 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
-static int parse_msg_type(const char *str)
+static enum fsck_msg_type parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
 		return FSCK_ERROR;
@@ -205,7 +202,8 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
-	int msg_id = parse_msg_id(msg_id_str), msg_type;
+	int msg_id = parse_msg_id(msg_id_str);
+	enum fsck_msg_type msg_type;
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
@@ -216,7 +214,7 @@ void fsck_set_msg_type(struct fsck_options *options,
 
 	if (!options->msg_type) {
 		int i;
-		int *tmp;
+		enum fsck_msg_type *tmp;
 		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
 			tmp[i] = fsck_msg_type(i, options);
@@ -296,7 +294,8 @@ static int report(struct fsck_options *options,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(msg_id, options), result;
+	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
+	int result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -1262,7 +1261,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type,
-			int msg_type, const char *message)
+			enum fsck_msg_type msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
diff --git a/fsck.h b/fsck.h
index 0c75789d219..c77e8ddf10b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,10 +3,13 @@
 
 #include "oidset.h"
 
-#define FSCK_ERROR 1
-#define FSCK_WARN 2
-#define FSCK_IGNORE 3
-
+enum fsck_msg_type {
+	FSCK_INFO = -2,
+	FSCK_FATAL = -1,
+	FSCK_ERROR = 1,
+	FSCK_WARN,
+	FSCK_IGNORE
+};
 struct fsck_options;
 struct object;
 
@@ -29,17 +32,17 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
-			  int msg_type, const char *message);
+			  enum fsck_msg_type msg_type, const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
-			int msg_type, const char *message);
+			enum fsck_msg_type msg_type, const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
-	int *msg_type;
+	enum fsck_msg_type *msg_type;
 	struct oidset skiplist;
 	kh_oid_map_t *object_names;
 };
-- 
2.30.0.284.gd98b1dd5eaa7

