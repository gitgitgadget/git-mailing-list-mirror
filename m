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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B59C433E3
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7E6196F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC1NQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhC1NQC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48538C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z2so10162876wrl.5
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xrh5ruUrkDtP6aD+i+ttBnrPDGjDhup2yK+mV9ahqzw=;
        b=FTbU92yrjUWv/I4peM23Y3GG4NqDkTfjnmO/zPpn4tLHC4RLLkG7VY3DTn3uof5u8P
         Q8Cht4eMXtz1fjRDAPmoKwWuxihC4W34zHqJxZ0kbvP/XYb3K2GX82BolZJSQOeQgPWP
         ZI8kRefsthSE12NHG1gvtfdDPC7/c4mIoxAV119sV2Y1/zodyRJigptsoK0aD9Yazu58
         iiqqlpnPQ3f5QUrnQLqIjkUzugtOlg8gvQzy8hB3Ys5ECm4Pvl8VT18ntTSxpF8KuBXu
         GStffCm/hXnttc+lXXS0Y6YLh0YNkmC79tNZXDEi/ltr0lYQTKLvFkIytaY3x63DVTFN
         OqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xrh5ruUrkDtP6aD+i+ttBnrPDGjDhup2yK+mV9ahqzw=;
        b=SL/WIXJQ+pdoLEn6TlOCalA1xxxVIcje2bynUI6IHZDS8hqI5g/VFUIsnJaXe7g8A/
         T2ABRwFr3om/wfCMLf7z4JthgBsFBH6O4trEt78cKW6iwMzeeiKiDYU5n5p6cthPVS93
         dB1rzGZSJ5gND2EWd2bSy6YiM7DxOqdA2gnT1aTGAf2DQlFSViHhXYvdUaPzOmsh3bK6
         isbIrmyxvSDNKvAaOxmItneBAnkVTAcKGrCcH7M5iqTfYC2ZFFnhJ5JdUT/Yro3K1+2g
         thNjNzE2oLT4cBbhnJclxEuiigZ1O7EfZlAAfqKsP/+u+OAEb6uwqg1VEn9JDjAQ1BWN
         QAbw==
X-Gm-Message-State: AOAM533N7bZYkOlDDS05Nwx2WWqOz9CmykzZekfl4Mkn1pH4zH8R7wrj
        5jmN7An84UiNSAMJWSq0ZxG6hlX2N5zbdg==
X-Google-Smtp-Source: ABdhPJwK0YInbwcjMnOtEMUhTb9G256fAN2N3h7XWsirpVUy8FYarC4LUzBKRKwIAJu44py9R3GhSQ==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr24050959wrs.400.1616937360766;
        Sun, 28 Mar 2021 06:16:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/19] fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
Date:   Sun, 28 Mar 2021 15:15:40 +0200
Message-Id: <patch-08.20-8ea468bf4d8-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index ed5f2af6b5c..17940a4e24a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -84,7 +84,7 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o,
 			   const struct object_id *oid,
 			   enum object_type object_type,
-			   int msg_type, const char *message)
+			   enum fsck_msg_type msg_type, const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f6e1178df90..8338b832b63 100644
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
index 23c4b8763fa..052a510ad7f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -17,7 +17,8 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
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
index 8614ee2c2a0..c5a81e4ff05 100644
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
@@ -275,7 +273,8 @@ static int report(struct fsck_options *options,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(msg_id, options), result;
+	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
+	int result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -1247,7 +1246,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type,
-			int msg_type, const char *message)
+			enum fsck_msg_type msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
diff --git a/fsck.h b/fsck.h
index 30a3acabc50..baf37620760 100644
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
2.31.1.445.g087790d4945

