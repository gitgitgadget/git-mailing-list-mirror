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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D490BC43333
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFB46502A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCFLFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCFLFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C34C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so826645wmj.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igMIhotyuOhoBckK/dC8eb8bGgNq7kg03ExyxSBA5o0=;
        b=D2HGE/fI3GgrBtmCqgzvafNy7mpFlAMWlhy7NcbgXu82WdfXmS0nqLXKJtQPM8/QRl
         i4Bq+rbozZOJKwsgciEECLnpmWVGHyNjetrsOOv/IKnO8SQ5LW5lvbqWe1ZmDT7LuzL/
         rxCCz/qDkFlTHIYYJ78KJwvCTzWiK/oLp2CtKDlK3UUDd5hw/CfgjHdWKwUrI96nPd4O
         J+Ht/BikK3CppaQE1UTM+pROe3b5r8qFlN9iKmO0MdtaDjMvGSC12b/YNn2dK71x0a/U
         4ldHlcamAdP4CM4fx6+cgyX8y1CcIu8L38c9vrethto16d4dOVt0l7wduwS/1AIhtzXi
         fa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igMIhotyuOhoBckK/dC8eb8bGgNq7kg03ExyxSBA5o0=;
        b=KalMGcslzdu0uOL+7MtS+bhwYNY7xObdPVy8BspXC6G1co6ljGG0l/Tv0D3GoPWSsL
         a+APOVg+eJFXjxzodT5jVeagj7+eWo+PSp81ZbsNArLwvYKGuJtLlsyVXzmnq7OUdysj
         MRS4AGjYXwPo2kx+ix4len9btL39YyLXWaMBVtdGH9LwwBSvJUYo4fTxLx8z3tQl8+p/
         /blj9PKN9OlFmT26zTr4QfxoVi7q8SFESAnJts/AV4SI4a6UYYLhv6VxZ68Flx/0pxY9
         n933eSF99E2036DCXDyyUvm7KWg+5+dPjs4ftYUVz6SSFeZR3QZh1mHwsyMfPJZ9EMW+
         KyZQ==
X-Gm-Message-State: AOAM5310jvyaDRMnf+nb9KcUi1nJF+kHcUw9uVV7GVV1AP1DynLBXddh
        +uC6ow/Wy3rgSIopOQDiH031i84chIQj/Q==
X-Google-Smtp-Source: ABdhPJz3SKZmixWYwsszxmi5QjwV1skmJy5j0PxkEGmfMiRbRoVX/JU5pyGboh0g3XnscKvW3Io42Q==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr12871995wmi.127.1615028700779;
        Sat, 06 Mar 2021 03:05:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/22] fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Date:   Sat,  6 Mar 2021 12:04:28 +0100
Message-Id: <20210306110439.27694-12-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 69f24fe9f76..56b8efaa89b 100644
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
index 0988ab65792..fb7d071bbf9 100644
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
index f67edd8f1f9..2ecc15eee77 100644
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
2.31.0.rc0.126.g04f22c5b82

