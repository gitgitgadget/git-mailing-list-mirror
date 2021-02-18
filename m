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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D8FC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A6964E2F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhBRM2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A738C061794
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o82so2502419wme.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f5XYzKRXKPmEq1KVmrHHlwG9tFIaE53l7vKmvKSa/k=;
        b=Ddqy2CkZPxWdorG0b+x84Vubqsoj0KkNZ5eb+P/5BqQnrSXQbG3t1hd4Z+SJi38kHJ
         7P93g1ywPqA1QUXFfQaAhz1TKusoJRac4X2JERPFy3DLs1Dd59WFl605gvokbSW8it7U
         GqLcXyV5+QACAGenyGfCkW1ucPoTryM5p67VYZVy7MPChNbmzrv8LeSMb6dSJsxUP7hZ
         f6GeoWibEloEtxt6RxWZxiFNt+geDisxv8gU8DG/hND3y592QTSYIQA6sdwwCiDDFbfB
         sl361/s3yKTVf2zHLSet6q8sZRVtD3XrPqI0Du8BdT/L7mPhUxQMMbQdRyoag36l+sn8
         EEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f5XYzKRXKPmEq1KVmrHHlwG9tFIaE53l7vKmvKSa/k=;
        b=U3bwpH0Cz1HjZIyWTdwxuM5VNA4ZG7OJcWxkXsyy5QLUi6Zkhkck8aXDCXpuJ30NEa
         j4wDjTDSVIU56Dz9a5E2mZg9lCsWaQoQIOBZXWXjy+o/zdzVWO/3uvpcaXEde7p56pUT
         6Pm4RRJM0RWv+kioB0pUtg8A1LhHo+r0pDta5TU3CwtFsK1QTbIcYGQHvf44xbYF/O9n
         rTanOtFFbRNiZec+8Ob6m8oK6Rqxw6Ead0SUBmoO+kDF47OkPSOpeXIpUdAjxFcRPY1q
         sVHQutawD0m9V46lGjIOdhFeQUvtSJkl+CMyRTlneEO167YxchwgJN/hm+NEf7F29/0K
         K7/Q==
X-Gm-Message-State: AOAM533DUVvj6vHB4EjkOl3EblCtTy7iAqkQ99lJwHaCNH18KgJJ4JVC
        AUGV3oxACqs4AkyQNUvCq3Nj8XmKMsyoJw==
X-Google-Smtp-Source: ABdhPJwZuuBCwD/3H5KNzF0yEXItzwvxs40yBCAfhUQyEGjWeMC/qQIRg209E/wF+MYyx5qElmDAZQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr3141943wmc.60.1613645927876;
        Thu, 18 Feb 2021 02:58:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Date:   Thu, 18 Feb 2021 11:58:36 +0100
Message-Id: <20210218105840.11989-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
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

