Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1705C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7BA604DC
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhI0M4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhI0M40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD4C061740
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so51893911wri.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c94+0QJ5wT63NSxhm+3QhTaaCaVxFAKMiFZioHyUY4M=;
        b=i1Tq8uXbKecUgdZKCxypyvLJlS3HOOrAotYDjWRJTOQVXRwTp0JTErWagj6wPmOb7o
         G2yxPCcquKLX+h7q0OXC/3VAaHyzrQnBUUuxYaj3gLm2UmAgXv8sIBI96mlbuZKdvki2
         1ChU51034OC3+Kpv4b9FUqgOGL8yx23xFht0N4Nc6GxGWfP+OAbdlpfX2twjZh20OUQs
         gd2Zdmq4RwAjIqgJmSHHCgObPQ5IBBI4zaKj5MNVjjgGWafZkwbQcJar3tAgIAAFssAk
         jDegDYoPUmI4ub1x3OAMgcVlzbfF4BHAybncn1yXH5YmRSfylBM5uCsRWy61qKkQQvpq
         a/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c94+0QJ5wT63NSxhm+3QhTaaCaVxFAKMiFZioHyUY4M=;
        b=tsD4E6qDaJwoChiTnqhYhusOtxhRn041cFKmOVcGhxidkGPXeD6HVunFoMrcPEyMiC
         XMxbSj+HIFK569YS0rrAWyHWO0gqqY9DWYzqZIn5Vf/hy3eeHtYoTo5c3uN8nTOH2Fl+
         satvZCOoQurr6F9aU7WgveObnu6F77SaA1dWneFRtKGE6ef4HbVT6b9sh8kUgoCpvPRW
         Amdpwmp59T202Tr9t5NUP9vuMuP01e9jxHUugvVNf7Zzbm/FTJIUNbnDQNwrMoKuqpar
         SViSeHmCdRUtudZ5A0eEug5tpjf3dzOD3Alxw7DQJIregm7q7IlhsKOgtP0ffVlmy2+Z
         VQAQ==
X-Gm-Message-State: AOAM530aEUmKMzurfYdClIbNVbvdv/JmG2rMfIJtTGeTDpxfStwMgNyJ
        gh4ZWomKG7MJZYGeibn5QyTqSFSEg14UbQ==
X-Google-Smtp-Source: ABdhPJwM/jgtMpi5Dpt2sYHRRiuPjtiBeunMgZJ+ybWElW00v159RFoaBQyWOhVNNojrMIV1UsS/oA==
X-Received: by 2002:a5d:5231:: with SMTP id i17mr4935488wra.392.1632747287009;
        Mon, 27 Sep 2021 05:54:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w14sm16460434wro.8.2021.09.27.05.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] *.h: move some *_INIT to designated initializers
Date:   Mon, 27 Sep 2021 14:54:27 +0200
Message-Id: <patch-v2-4.5-dd4ec1a0219-20210927T124407Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move various *_INIT macros to use designated initializers. This helps
readability. I've only picked those leftover macros that were not
touched by another in-flight series of mine which changed others, but
also how initialization was done.

In the case of SUBMODULE_ALTERNATE_SETUP_INIT I've left an explicit
initialization of "error_mode", even though
SUBMODULE_ALTERNATE_ERROR_IGNORE itself is defined as "0". Let's not
peek under the hood and assume that enum fields we know the value of
will stay at "0".

The change to "TESTSUITE_INIT" in "t/helper/test-run-command.c" was
part of an earlier on-list version[1] of c90be786da9 (test-tool
run-command: fix flip-flop init pattern, 2021-09-11).

1. https://lore.kernel.org/git/patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c           | 8 ++++++--
 builtin/submodule--helper.c | 5 +++--
 cache.h                     | 4 +++-
 entry.h                     | 2 +-
 list.h                      | 5 ++++-
 sequencer.h                 | 4 +++-
 shallow.h                   | 4 +++-
 strvec.h                    | 4 +++-
 submodule.c                 | 8 +++++---
 submodule.h                 | 4 +++-
 t/helper/test-run-command.c | 6 ++++--
 trace.h                     | 2 +-
 transport.h                 | 4 +++-
 13 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 36ebdbdf7e2..6498ae196f1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -102,8 +102,12 @@ struct prefix_item_list {
 	int *selected; /* for multi-selections */
 	size_t min_length, max_length;
 };
-#define PREFIX_ITEM_LIST_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_NODUP, NULL, 1, 4 }
+#define PREFIX_ITEM_LIST_INIT { \
+	.items = STRING_LIST_INIT_DUP, \
+	.sorted = STRING_LIST_INIT_NODUP, \
+	.min_length = 1, \
+	.max_length = 4, \
+}
 
 static void prefix_item_list_clear(struct prefix_item_list *list)
 {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index deca75c83ee..57f09925157 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1647,8 +1647,9 @@ struct submodule_alternate_setup {
 	} error_mode;
 	struct string_list *reference;
 };
-#define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
-	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
+#define SUBMODULE_ALTERNATE_SETUP_INIT { \
+	.error_mode = SUBMODULE_ALTERNATE_ERROR_IGNORE, \
+}
 
 static const char alternate_error_advice[] = N_(
 "An alternate computed from a superproject's alternate is invalid.\n"
diff --git a/cache.h b/cache.h
index 25c6b0b1200..794237515b9 100644
--- a/cache.h
+++ b/cache.h
@@ -1668,7 +1668,9 @@ struct cache_def {
 	int track_flags;
 	int prefix_len_stat_func;
 };
-#define CACHE_DEF_INIT { STRBUF_INIT }
+#define CACHE_DEF_INIT { \
+	.path = STRBUF_INIT, \
+}
 static inline void cache_def_clear(struct cache_def *cache)
 {
 	strbuf_release(&cache->path);
diff --git a/entry.h b/entry.h
index 7c889e58fd7..2254c62727f 100644
--- a/entry.h
+++ b/entry.h
@@ -16,7 +16,7 @@ struct checkout {
 		 clone:1,
 		 refresh_cache:1;
 };
-#define CHECKOUT_INIT { NULL, "" }
+#define CHECKOUT_INIT { .base_dir = "" }
 
 #define TEMPORARY_FILENAME_LENGTH 25
 /*
diff --git a/list.h b/list.h
index eb601192f4c..362a4cd7f5f 100644
--- a/list.h
+++ b/list.h
@@ -46,7 +46,10 @@ struct list_head {
 #define INIT_LIST_HEAD(ptr) \
 	(ptr)->next = (ptr)->prev = (ptr)
 
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
+#define LIST_HEAD_INIT(name) { \
+	.next = &(name), \
+	.prev = &(name), \
+}
 
 /* Add new element at the head of the list. */
 static inline void list_add(struct list_head *newp, struct list_head *head)
diff --git a/sequencer.h b/sequencer.h
index 2088344cb37..259d4eb4a8a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,7 +119,9 @@ struct todo_list {
 	struct stat_data stat;
 };
 
-#define TODO_LIST_INIT { STRBUF_INIT }
+#define TODO_LIST_INIT { \
+	.buf = STRBUF_INIT, \
+}
 
 int todo_list_parse_insn_buffer(struct repository *r, char *buf,
 				struct todo_list *todo_list);
diff --git a/shallow.h b/shallow.h
index 5b4a96dcd69..aba6ff58294 100644
--- a/shallow.h
+++ b/shallow.h
@@ -23,7 +23,9 @@ int is_repository_shallow(struct repository *r);
 struct shallow_lock {
 	struct lock_file lock;
 };
-#define SHALLOW_LOCK_INIT { LOCK_INIT }
+#define SHALLOW_LOCK_INIT { \
+	.lock = LOCK_INIT, \
+}
 
 /* commit $GIT_DIR/shallow and reset stat-validity checks */
 int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
diff --git a/strvec.h b/strvec.h
index a10aad5f645..9f55c8766ba 100644
--- a/strvec.h
+++ b/strvec.h
@@ -33,7 +33,9 @@ struct strvec {
 	size_t alloc;
 };
 
-#define STRVEC_INIT { empty_strvec }
+#define STRVEC_INIT { \
+	.v = empty_strvec, \
+}
 
 /**
  * Initialize an array. This is no different than assigning from
diff --git a/submodule.c b/submodule.c
index 78aed03d928..03cf36707ae 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1321,9 +1321,11 @@ struct submodule_parallel_fetch {
 
 	struct strbuf submodules_with_errors;
 };
-#define SPF_INIT {0, STRVEC_INIT, NULL, NULL, 0, 0, 0, 0, \
-		  STRING_LIST_INIT_DUP, \
-		  NULL, 0, 0, STRBUF_INIT}
+#define SPF_INIT { \
+	.args = STRVEC_INIT, \
+	.changed_submodule_names = STRING_LIST_INIT_DUP, \
+	.submodules_with_errors = STRBUF_INIT, \
+}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
diff --git a/submodule.h b/submodule.h
index 35d18c7868a..6bd2c99fd99 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,7 +37,9 @@ struct submodule_update_strategy {
 	enum submodule_update_type type;
 	const char *command;
 };
-#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED}
+#define SUBMODULE_UPDATE_STRATEGY_INIT { \
+	.type = SM_UPDATE_UNSPECIFIED, \
+}
 
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 50bb98b7e04..3c4fb862234 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -60,8 +60,10 @@ struct testsuite {
 	int next;
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
 };
-#define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP }
+#define TESTSUITE_INIT { \
+	.tests = STRING_LIST_INIT_DUP, \
+	.failed = STRING_LIST_INIT_DUP, \
+}
 
 static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		     void **task_cb)
diff --git a/trace.h b/trace.h
index 74f62919c57..e25984051aa 100644
--- a/trace.h
+++ b/trace.h
@@ -89,7 +89,7 @@ struct trace_key {
 
 extern struct trace_key trace_default_key;
 
-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
+#define TRACE_KEY_INIT(name) { .key = "GIT_TRACE_" #name }
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
diff --git a/transport.h b/transport.h
index 1cbab113730..8bb4c8bbc8c 100644
--- a/transport.h
+++ b/transport.h
@@ -262,7 +262,9 @@ struct transport_ls_refs_options {
 	 */
 	char *unborn_head_target;
 };
-#define TRANSPORT_LS_REFS_OPTIONS_INIT { STRVEC_INIT }
+#define TRANSPORT_LS_REFS_OPTIONS_INIT { \
+	.ref_prefixes = STRVEC_INIT, \
+}
 
 /*
  * Retrieve refs from a remote.
-- 
2.33.0.1316.gb2e9b3ba3ae

