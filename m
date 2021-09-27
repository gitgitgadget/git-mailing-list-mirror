Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DE260F39
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhI0Alj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhI0Alg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B74C061604
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d6so47022394wrc.11
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16EkB3zXStBIgCD0v0NeBB6tvf+cLXRPVsFcir5oR1U=;
        b=V328+JWOez1wjOCp6q5EME2trpEINhC7Z08Lkv1U+9k5PzgQ2ckLrc8DA2XMxYgKY4
         6WjJfl8qLzvi+ihoj7qiVuGrIWoHj3mac6yaDFciYn42pkYWTLL5ewlcveC7i3K//tBT
         vlTw/liQKyIY4QM+leSuzQghiPuUnPtsu3QYRMlskGWHmb7EyCOiVyK4wWhDZXb5lcJs
         jjrfiLIWCjVRltcKDDMnQJNwrQ8ZwLq/gJ4/jYwkKR9wS7hh8Hm5I1NONqpZinNQQTGb
         3qCM0lm1Rc26G72jVPm0XI0w3UcyGF0+yEvVLIINQ5/pVaS5GEJhRYE2spcpf9MKOCQ+
         tJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16EkB3zXStBIgCD0v0NeBB6tvf+cLXRPVsFcir5oR1U=;
        b=mH2ju68B+UTmzhFpPuA9Tk4wai7bILFY6skrk1Hxw2UHuVyxPFDQmFoyQSmtSxHidt
         wxW6TL39dvgLasYb57g+q/QJ9si0mupWCd/ZK9KiXKP/lQzgKC1Z04vDJo1XfOepJaOF
         vli6TjVc2HKIfYZLgiOPcXrDzg9FooLMXpB8Q/bAXc8kG/bASkkjXyifIlXjuhKQqswf
         gcaw4lg/G/yl8HZ91Zsw+mYU3kngi7t46PzQlEpX5VUeeCwZTgfSmW1mVRcz3e1FuiJk
         T21uTkw5h5WYO2iApWTy7/epZKlxcWJccCsBTCIiU0OyJzgU+ovWdhrrZagSTPsML1Oq
         iNog==
X-Gm-Message-State: AOAM5307nIx0cFL69p5L26LIClVDatbuO6JhB49F6CvJIFRIrqvOsPqd
        yiIpw7zuHKxm251GZmBuzJDGKE4Xqk4G5Q==
X-Google-Smtp-Source: ABdhPJw5ZZupzDMKkTK4yijCWp67isQpF728SfMiyugXeXUSUa3o+lQeNvTFHb3mpow6xU1BZV+9OA==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr9501856wrj.221.1632703197837;
        Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] *.h: move some *_INIT to designated initializers
Date:   Mon, 27 Sep 2021 02:39:51 +0200
Message-Id: <patch-4.5-1f364565111-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
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
 sequencer.h                 | 4 +++-
 shallow.h                   | 4 +++-
 strvec.h                    | 4 +++-
 submodule.c                 | 8 +++++---
 submodule.h                 | 4 +++-
 t/helper/test-run-command.c | 6 ++++--
 transport.h                 | 4 +++-
 10 files changed, 36 insertions(+), 15 deletions(-)

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
index f6295f3b048..794237515b9 100644
--- a/cache.h
+++ b/cache.h
@@ -1668,7 +1668,9 @@ struct cache_def {
 	int track_flags;
 	int prefix_len_stat_func;
 };
-#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
+#define CACHE_DEF_INIT { \
+	.path = STRBUF_INIT, \
+}
 static inline void cache_def_clear(struct cache_def *cache)
 {
 	strbuf_release(&cache->path);
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
index 6b3cbd67589..9f55c8766ba 100644
--- a/strvec.h
+++ b/strvec.h
@@ -33,7 +33,9 @@ struct strvec {
 	size_t alloc;
 };
 
-#define STRVEC_INIT { empty_strvec, 0, 0 }
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
index 4578e501b86..6bd2c99fd99 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,7 +37,9 @@ struct submodule_update_strategy {
 	enum submodule_update_type type;
 	const char *command;
 };
-#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
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
2.33.0.1294.g2bdf2798764

