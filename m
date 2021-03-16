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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51EBC4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1B365108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhCPQSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbhCPQSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55364C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v11so7745415wro.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuDmrbI3YRgPU8vjBPfu3IOOLOX8Z3LwlKyicz3ofus=;
        b=fEyloe8ZuwwV6msRxtqBfb+Fb73doZcxmEbCIP5HJsaEm+NfG6gmn8OxpILuVDaWv+
         JOmSrmWt/p6juowz1B5T23bvhaCJmwGhBq1pG8yC7s8ajpKcf14uaSeCCf+c1/ueHybh
         LAm05f7knA7+38L0lWZ8v3EKoWU4AbvptkQRK1ni01b7Oxs7M9Q7RN9ILaOejIwYpksZ
         a+2M7uemvL81XhEQeGWO1Ue0u/PpCJFs4kaqwIKHbhyWQoTNHYH82JPwoNmLf0E8XkDg
         0h3Y5vDH/W1YAyqsKfAsWyogPlEUBfE+C4lijclsCrE2aewPwKq8zTwZhuGdeib7pq0G
         n/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuDmrbI3YRgPU8vjBPfu3IOOLOX8Z3LwlKyicz3ofus=;
        b=dgrrbJz56ZIhNAdv/n4Mc19OK7ntWa9Qspob/IG+1SFEXFkfebkrRIBUUyhStd2Pvk
         DQ5LuGyh+PUPwQ71QPFInTMugZHHnNR9NQ6fye8ZMacjl/JqSdrZYb7seDIHJSEWn2Pm
         D/afZHnCnbwRIj5Oa/AcaUxv7Npl8qXQ4+DUEgvTWvye43SZ4oiFX+voXaTFCH/+M3U8
         sVMfKUNvKUwOj+u8+hYU93LjGiy9EycBolZa8SI8CGrfhE68RHBzXc54ZI7JSxbJhMCG
         2po6EMQiji+ngA0HzFPiuGfgDuXSxD8EfxNQVDl7e/hC6d7mOZMcBg532k0e4XHthfjp
         OLDA==
X-Gm-Message-State: AOAM532DGqL9ZtrNB+Vf61gtmpkRYV97LNdfQEI+1QmhqBFOnDDK1XSI
        lWnYc3/OY9hn4nonERTEcmIRtMNyLIgD3A==
X-Google-Smtp-Source: ABdhPJyk7HsSNfMkpvctY2rBK7PofDBK3k5tLKc5IjecwfmTIv8+3cyBN8nfNBhjC+R7d23GFOzRnA==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr5668703wre.386.1615911482752;
        Tue, 16 Mar 2021 09:18:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/22] fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Date:   Tue, 16 Mar 2021 17:17:27 +0100
Message-Id: <20210316161738.30254-12-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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

The reason these were defined in two different places is because we
use FSCK_{IGNORE,INFO,FATAL} only in fsck.c, but FSCK_{ERROR,WARN} are
used by external callbacks.

Untangling that would take some more work, since we expose the new
"enum fsck_msg_type" to both. Similar to "enum object_type" it's not
worth structuring the API in such a way that only those who need
FSCK_{ERROR,WARN} pass around a different type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c       |  2 +-
 builtin/index-pack.c |  3 ++-
 builtin/mktag.c      |  3 ++-
 fsck.c               | 21 ++++++++++-----------
 fsck.h               | 16 ++++++++++------
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 68f0329e69..d6d745dc70 100644
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
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 69f24fe9f7..56b8efaa89 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1716,7 +1716,8 @@ static void show_pack_info(int stat_only)
 static int print_dangling_gitmodules(struct fsck_options *o,
 				     const struct object_id *oid,
 				     enum object_type object_type,
-				     int msg_type, const char *message)
+				     enum fsck_msg_type msg_type,
+				     const char *message)
 {
 	/*
 	 * NEEDSWORK: Plumb the MSG_ID (from fsck.c) here and use it
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 41a399a69e..1834394a9b 100644
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
index 0988ab6579..fb7d071bbf 100644
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
@@ -164,13 +161,13 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 		list_config_item(list, prefix, msg_id_info[i].camelcased);
 }
 
-static int fsck_msg_type(enum fsck_msg_id msg_id,
+static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
 	if (!options->msg_type) {
-		int msg_type = msg_id_info[msg_id].msg_type;
+		enum fsck_msg_type msg_type = msg_id_info[msg_id].msg_type;
 
 		if (options->strict && msg_type == FSCK_WARN)
 			msg_type = FSCK_ERROR;
@@ -180,7 +177,7 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return options->msg_type[msg_id];
 }
 
-static int parse_msg_type(const char *str)
+static enum fsck_msg_type parse_msg_type(const char *str)
 {
 	if (!strcmp(str, "error"))
 		return FSCK_ERROR;
@@ -203,7 +200,8 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
-	int msg_id = parse_msg_id(msg_id_str), msg_type;
+	int msg_id = parse_msg_id(msg_id_str);
+	enum fsck_msg_type msg_type;
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
@@ -214,7 +212,7 @@ void fsck_set_msg_type(struct fsck_options *options,
 
 	if (!options->msg_type) {
 		int i;
-		int *severity;
+		enum fsck_msg_type *severity;
 		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
 			severity[i] = fsck_msg_type(i, options);
@@ -294,7 +292,8 @@ static int report(struct fsck_options *options,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(msg_id, options), result;
+	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
+	int result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -1265,7 +1264,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type,
-			int msg_type, const char *message)
+			enum fsck_msg_type msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
diff --git a/fsck.h b/fsck.h
index f67edd8f1f..2ecc15eee7 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,9 +3,13 @@
 
 #include "oidset.h"
 
-#define FSCK_ERROR 1
-#define FSCK_WARN 2
-#define FSCK_IGNORE 3
+enum fsck_msg_type {
+	FSCK_INFO  = -2,
+	FSCK_FATAL = -1,
+	FSCK_ERROR = 1,
+	FSCK_WARN,
+	FSCK_IGNORE
+};
 
 struct fsck_options;
 struct object;
@@ -29,17 +33,17 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
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
2.31.0.260.g719c683c1d

