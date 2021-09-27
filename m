Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFCDC43217
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3560F39
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhI0Alg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhI0Alf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9EC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g16so47201149wrb.3
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsVkSpisGsJGbZcWnRvIa0T5Bdm9HBonuCilEnXqQkY=;
        b=QlCsby7HZzNvMJyJwo9L/30y47UDVf94nWQPYnbbRLR43AgyZGPTMVygXshfkBou1v
         2lY90cnN+68DC0ILhYF12DkiQeJZ5I1+KC7MWwzSfIpb41yGC3Ga6kkCZOUbNw80303k
         wFHnzeOoq6CKWqFzLXKVu9QlLjCx+O4s9oscpxC1JxcRc8QgN/DXdR6TCfJrptO+soFE
         TZBG6JGjkyw/6Lc+pqCvftIf3UdsWo0xU3AdJOqd1er/eod/Lzz2bHRNQrYhPJhbXNWF
         ypXlgObuygpsAxUH7ZqYGjDJpy/wIgik8mYhkrlRVwxS03ctKU1j/9QkOP2TrtexVb+a
         fs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsVkSpisGsJGbZcWnRvIa0T5Bdm9HBonuCilEnXqQkY=;
        b=mO4AOp18IRuhQSj3TiDqmnfHew/8A0UZU1mfejLlHAj1RprZAMjaHNBg02kT3oXE+4
         z3ae1uiwcxR3ZVnclwOqiyJk/yTBL+8L6x6BK0xDtTVWb0GhjNkPpA5s4P0ir6xSw8UI
         XlkEo2Gw6maCxMHUC/tqP/d5zzbQbh6wWlUu6KKl6VUFFQvsXdzjPEUd2d1wR5zrmZx5
         AnUscHd4cgPhcJOjMyY3wz0IbMTLxEDTCtism00J8RMj3o4+zIxUcirkOFdx6gZt8sWg
         m121rloa6+g2LiGHoA1SGb1e1P5nlwUxHCcjE3Vn0MFR/w9aXi61f0P7cyOxIGJUDU1Y
         W4Ag==
X-Gm-Message-State: AOAM531IJEghDhaDuz5GPzuvYu5zRGUsvULrZO/n7DZ726Nkb+7btLWL
        mCbe29Z5FE+Gbi2WUOLwllD2/TxhtUHtCA==
X-Google-Smtp-Source: ABdhPJypFW+mWIyGp9csy5Q8GRrDaXqpqx5kEAxyoU9v+ERJo62L0HwiiputIXIiEZYoKql/Rr3TvA==
X-Received: by 2002:a05:600c:3543:: with SMTP id i3mr13110559wmq.64.1632703196273;
        Sun, 26 Sep 2021 17:39:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
Date:   Mon, 27 Sep 2021 02:39:49 +0200
Message-Id: <patch-2.5-d612e7df7a5-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In C it isn't required to specify that all members of a struct are
zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
accomplish that.

Let's also change change code that provided N zero'd fields to just
provide one, and change e.g. "{ NULL }" to "{ 0 }" for
consistency. I.e. even if the first member is a pointer let's use "0"
instead of "NULL". The point of using "0" consistently is to pick one,
and to not have the reader wonder why we're not using the same pattern
everywhere.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c                      | 16 ++++++++--------
 checkout.c                                       |  2 +-
 .../gnome-keyring/git-credential-gnome-keyring.c |  2 +-
 .../libsecret/git-credential-libsecret.c         |  2 +-
 diff.c                                           |  4 ++--
 entry.h                                          |  2 +-
 lockfile.h                                       |  2 +-
 object-store.h                                   |  2 +-
 object.h                                         |  2 +-
 oid-array.h                                      |  2 +-
 path.h                                           |  5 +----
 ref-filter.c                                     |  2 +-
 remote.c                                         |  2 +-
 revision.c                                       |  2 +-
 14 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5336daf186d..deca75c83ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -307,7 +307,7 @@ struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
 };
-#define MODULE_LIST_INIT { NULL, 0, 0 }
+#define MODULE_LIST_INIT { 0 }
 
 static int module_list_compute(int argc, const char **argv,
 			       const char *prefix,
@@ -588,7 +588,7 @@ struct init_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-#define INIT_CB_INIT { NULL, 0 }
+#define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
 			   unsigned int flags)
@@ -717,7 +717,7 @@ struct status_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-#define STATUS_CB_INIT { NULL, 0 }
+#define STATUS_CB_INIT { 0 }
 
 static void print_status(unsigned int flags, char state, const char *path,
 			 const struct object_id *oid, const char *displaypath)
@@ -911,13 +911,13 @@ struct module_cb {
 	char status;
 	const char *sm_path;
 };
-#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
+#define MODULE_CB_INIT { 0 }
 
 struct module_cb_list {
 	struct module_cb **entries;
 	int alloc, nr;
 };
-#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
+#define MODULE_CB_LIST_INIT { 0 }
 
 struct summary_cb {
 	int argc;
@@ -928,7 +928,7 @@ struct summary_cb {
 	unsigned int files: 1;
 	int summary_limit;
 };
-#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0 }
+#define SUMMARY_CB_INIT { 0 }
 
 enum diff_cmd {
 	DIFF_INDEX,
@@ -1334,7 +1334,7 @@ struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-#define SYNC_CB_INIT { NULL, 0 }
+#define SYNC_CB_INIT { 0 }
 
 static void sync_submodule(const char *path, const char *prefix,
 			   unsigned int flags)
@@ -1480,7 +1480,7 @@ struct deinit_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-#define DEINIT_CB_INIT { NULL, 0 }
+#define DEINIT_CB_INIT { 0 }
 
 static void deinit_submodule(const char *path, const char *prefix,
 			     unsigned int flags)
diff --git a/checkout.c b/checkout.c
index 6586e30ca5a..2e39dae684f 100644
--- a/checkout.c
+++ b/checkout.c
@@ -14,7 +14,7 @@ struct tracking_name_data {
 	struct object_id *default_dst_oid;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0, NULL, NULL, NULL }
+#define TRACKING_NAME_DATA_INIT { 0 }
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index d389bfadcee..5927e27ae6e 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -138,7 +138,7 @@ struct credential {
 	char *password;
 };
 
-#define CREDENTIAL_INIT { NULL, NULL, 0, NULL, NULL, NULL }
+#define CREDENTIAL_INIT { 0 }
 
 typedef int (*credential_op_cb)(struct credential *);
 
diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index e6598b63833..2c5d76d789f 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -41,7 +41,7 @@ struct credential {
 	char *password;
 };
 
-#define CREDENTIAL_INIT { NULL, NULL, 0, NULL, NULL, NULL }
+#define CREDENTIAL_INIT { 0 }
 
 typedef int (*credential_op_cb)(struct credential *);
 
diff --git a/diff.c b/diff.c
index c8f530ffdbe..861282db1c3 100644
--- a/diff.c
+++ b/diff.c
@@ -775,13 +775,13 @@ struct emitted_diff_symbol {
 	int indent_width; /* The visual width of the indentation */
 	enum diff_symbol s;
 };
-#define EMITTED_DIFF_SYMBOL_INIT {NULL}
+#define EMITTED_DIFF_SYMBOL_INIT { 0 }
 
 struct emitted_diff_symbols {
 	struct emitted_diff_symbol *buf;
 	int nr, alloc;
 };
-#define EMITTED_DIFF_SYMBOLS_INIT {NULL, 0, 0}
+#define EMITTED_DIFF_SYMBOLS_INIT { 0 }
 
 static void append_emitted_diff_symbol(struct diff_options *o,
 				       struct emitted_diff_symbol *e)
diff --git a/entry.h b/entry.h
index 7c889e58fd7..04bc8bb59f0 100644
--- a/entry.h
+++ b/entry.h
@@ -16,7 +16,7 @@ struct checkout {
 		 clone:1,
 		 refresh_cache:1;
 };
-#define CHECKOUT_INIT { NULL, "" }
+#define CHECKOUT_INIT { 0 }
 
 #define TEMPORARY_FILENAME_LENGTH 25
 /*
diff --git a/lockfile.h b/lockfile.h
index db93e6ba73e..90af4e66b28 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -121,7 +121,7 @@ struct lock_file {
 	struct tempfile *tempfile;
 };
 
-#define LOCK_INIT { NULL }
+#define LOCK_INIT { 0 }
 
 /* String appended to a filename to derive the lockfile name: */
 #define LOCK_SUFFIX ".lock"
diff --git a/object-store.h b/object-store.h
index c5130d8baea..1e647a5be30 100644
--- a/object-store.h
+++ b/object-store.h
@@ -371,7 +371,7 @@ struct object_info {
  * Initializer for a "struct object_info" that wants no items. You may
  * also memset() the memory to all-zeroes.
  */
-#define OBJECT_INFO_INIT {NULL}
+#define OBJECT_INFO_INIT { 0 }
 
 /* Invoke lookup_replace_object() on the given hash */
 #define OBJECT_INFO_LOOKUP_REPLACE 1
diff --git a/object.h b/object.h
index 549f2d256bc..cb556ab7753 100644
--- a/object.h
+++ b/object.h
@@ -55,7 +55,7 @@ struct object_array {
 	} *objects;
 };
 
-#define OBJECT_ARRAY_INIT { 0, 0, NULL }
+#define OBJECT_ARRAY_INIT { 0 }
 
 /*
  * object flag allocation:
diff --git a/oid-array.h b/oid-array.h
index 72bca78b7dc..f60f9af6741 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -56,7 +56,7 @@ struct oid_array {
 	int sorted;
 };
 
-#define OID_ARRAY_INIT { NULL, 0, 0, 0 }
+#define OID_ARRAY_INIT { 0 }
 
 /**
  * Add an item to the set. The object ID will be placed at the end of the array
diff --git a/path.h b/path.h
index 251c78d9800..b68691a86b8 100644
--- a/path.h
+++ b/path.h
@@ -181,10 +181,7 @@ struct path_cache {
 	const char *shallow;
 };
 
-#define PATH_CACHE_INIT                                        \
-	{                                                      \
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL \
-	}
+#define PATH_CACHE_INIT { 0 }
 
 const char *git_path_squash_msg(struct repository *r);
 const char *git_path_merge_msg(struct repository *r);
diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..eee4f9b17c5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -633,7 +633,7 @@ static struct {
 	 */
 };
 
-#define REF_FORMATTING_STATE_INIT  { 0, NULL }
+#define REF_FORMATTING_STATE_INIT  { 0 }
 
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
diff --git a/remote.c b/remote.c
index 31e141b01fa..f958543d707 100644
--- a/remote.c
+++ b/remote.c
@@ -2403,7 +2403,7 @@ struct reflog_commit_array {
 	size_t nr, alloc;
 };
 
-#define REFLOG_COMMIT_ARRAY_INIT { NULL, 0, 0 }
+#define REFLOG_COMMIT_ARRAY_INIT { 0 }
 
 /* Append a commit to the array. */
 static void append_commit(struct reflog_commit_array *arr,
diff --git a/revision.c b/revision.c
index 0dabb5a0bcf..73e5004d60b 100644
--- a/revision.c
+++ b/revision.c
@@ -249,7 +249,7 @@ struct commit_stack {
 	struct commit **items;
 	size_t nr, alloc;
 };
-#define COMMIT_STACK_INIT { NULL, 0, 0 }
+#define COMMIT_STACK_INIT { 0 }
 
 static void commit_stack_push(struct commit_stack *stack, struct commit *commit)
 {
-- 
2.33.0.1294.g2bdf2798764

