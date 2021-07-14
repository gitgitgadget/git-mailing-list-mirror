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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B0C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFDE6128C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhGNASo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbhGNASn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:18:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC8AC0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l7so890459wrv.7
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSzJiaRys8MEwLx29CBT9JFknXxR9FkUdPnPxaAzaWA=;
        b=HeB9yulpSN1vl4LQV1URNDTYl/FX3dCq0FdOW8Awlq8GHP3nhNXeHY6hMku6DlJtCN
         KKMFT9DwGLjrrcwP/Gzk3Mu3nmis7IRwobR++clWWMc9GdV6AAjLxV05yYB2mj9d5ILh
         9n5TY3fDwo1Sc6pDZgItpB+Y0yDfhXy+Vw/XqcLkpWssR68g+z6SGLgsPJy4HRl5DUP7
         38rLZkeLVdi9RHtrdeCZKSi7Z/KlKW5RprVIweONsYWGB7+bzlBfCtbG9Ki8coS0TwUA
         nhNUWBrHtZ8LikOVfkaqBDRf+7t8KRytW2WCzVXu9E/JbEW96JPphCAPP/9FltAbmH/l
         SGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSzJiaRys8MEwLx29CBT9JFknXxR9FkUdPnPxaAzaWA=;
        b=HX72XFtfzAaKhgjyR3GJuRXRex7Rg80VucHkzM/Reeuwu20XzdJoUy7675nCvTeu7O
         YQyCYwShgjsUuRYrwlug8V/hMKqLS+UenU5XU/EVmaJIgeUgSY969LTOmXhrD41qE/1F
         Qt0sw9XIxhxjdPhe43kgnvjGq9Jp9GuNKsscWxg9TSgK1BhRl+94Hfmzy9SOB2zsT72A
         QiXnCzgio5rBTG/01ysDcejhEQ+GtbYf1YidenfwoU2zHoeJpF06cv+kmlvGezxTeIlN
         cSniNV3B1n0FZhd/74vw+DUd5L2HVl+feenObJEBMAM+3XJ4VkNMEqknSLDGz46M9CB0
         4E2w==
X-Gm-Message-State: AOAM533CbAYJ3D8WZQwok0L4J87CsWEuyIYXexBJJqhjsQhhpCOww5hu
        zKis10VUz+VcyJmd0/a+o/ht0Tb/GkTBNKd+
X-Google-Smtp-Source: ABdhPJy6IYU+WAnCGy628HZR5T/jFnKmTHdW3wyovpOTYjnegSsjPynZNun1YkaBqwQsr0nJ6RAN4w==
X-Received: by 2002:adf:e582:: with SMTP id l2mr9074144wrm.101.1626221749687;
        Tue, 13 Jul 2021 17:15:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm2876518wmc.7.2021.07.13.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:15:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] *.c static functions: add missing __attribute__((format))
Date:   Wed, 14 Jul 2021 02:15:42 +0200
Message-Id: <patch-3.5-e2e039f481-20210714T001433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing __attribute__((format)) function attributes to various
"static" functions that take printf arguments.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c                                                 | 1 +
 builtin/am.c                                                | 1 +
 builtin/bisect--helper.c                                    | 2 ++
 commit-graph.c                                              | 1 +
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 1 +
 contrib/credential/wincred/git-credential-wincred.c         | 1 +
 gettext.c                                                   | 1 +
 imap-send.c                                                 | 3 +++
 mailmap.c                                                   | 1 +
 merge-ort.c                                                 | 1 +
 merge-recursive.c                                           | 1 +
 midx.c                                                      | 1 +
 ref-filter.c                                                | 1 +
 sequencer.c                                                 | 2 ++
 server-info.c                                               | 1 +
 worktree.c                                                  | 1 +
 16 files changed, 20 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index 2fad92ca37..8c41cdfe39 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -280,6 +280,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	clear_add_i_state(&s->s);
 }
 
+__attribute__((format (printf, 2, 3)))
 static void err(struct add_p_state *s, const char *fmt, ...)
 {
 	va_list args;
diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..0c2ad96b70 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -210,6 +210,7 @@ static void write_state_bool(const struct am_state *state,
  * If state->quiet is false, calls fprintf(fp, fmt, ...), and appends a newline
  * at the end.
  */
+__attribute__((format (printf, 3, 4)))
 static void say(const struct am_state *state, FILE *fp, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9d9540a0ab..f184eaeac6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -117,6 +117,7 @@ static int write_in_file(const char *path, const char *mode, const char *format,
 	return fclose(fp);
 }
 
+__attribute__((format (printf, 2, 3)))
 static int write_to_file(const char *path, const char *format, ...)
 {
 	int res;
@@ -129,6 +130,7 @@ static int write_to_file(const char *path, const char *format, ...)
 	return res;
 }
 
+__attribute__((format (printf, 2, 3)))
 static int append_to_file(const char *path, const char *format, ...)
 {
 	int res;
diff --git a/commit-graph.c b/commit-graph.c
index 2bcb4e0f89..9179a3a647 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2408,6 +2408,7 @@ int write_commit_graph(struct object_directory *odb,
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
 
+__attribute__((format (printf, 1, 2)))
 static void graph_report(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bcd3f575a3..0b44a9b7cc 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -10,6 +10,7 @@ static char *username;
 static char *password;
 static UInt16 port;
 
+__attribute__((format (printf, 1, 2)))
 static void die(const char *err, ...)
 {
 	char msg[4096];
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 5bdad41de1..5091048f9c 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -11,6 +11,7 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+__attribute__((format (printf, 1, 2)))
 static void die(const char *err, ...)
 {
 	char msg[4096];
diff --git a/gettext.c b/gettext.c
index af2413b47e..bb5ba1fe7c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -66,6 +66,7 @@ const char *get_preferred_languages(void)
 }
 
 #ifndef NO_GETTEXT
+__attribute__((format (printf, 1, 2)))
 static int test_vsnprintf(const char *fmt, ...)
 {
 	char buf[26];
diff --git a/imap-send.c b/imap-send.c
index bb085d66d1..ce5a0461a4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -451,6 +451,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 	/* not reached */
 }
 
+__attribute__((format (printf, 1, 2)))
 static void imap_info(const char *msg, ...)
 {
 	va_list va;
@@ -463,6 +464,7 @@ static void imap_info(const char *msg, ...)
 	}
 }
 
+__attribute__((format (printf, 1, 2)))
 static void imap_warn(const char *msg, ...)
 {
 	va_list va;
@@ -504,6 +506,7 @@ static char *next_arg(char **s)
 	return ret;
 }
 
+__attribute__((format (printf, 3, 4)))
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
 	int ret;
diff --git a/mailmap.c b/mailmap.c
index d1f7c0d272..462b395634 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -8,6 +8,7 @@
 #define debug_mm(...) fprintf(stderr, __VA_ARGS__)
 #define debug_str(X) ((X) ? (X) : "(none)")
 #else
+__attribute__((format (printf, 1, 2)))
 static inline void debug_mm(const char *format, ...) {}
 static inline const char *debug_str(const char *s) { return s; }
 #endif
diff --git a/merge-ort.c b/merge-ort.c
index b954f7184a..955d1d0502 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -529,6 +529,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
 }
 
+__attribute__((format (printf, 2, 3)))
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
diff --git a/merge-recursive.c b/merge-recursive.c
index 4327e0cfa3..5d54990af9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -167,6 +167,7 @@ static void flush_output(struct merge_options *opt)
 	}
 }
 
+__attribute__((format (printf, 2, 3)))
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
diff --git a/midx.c b/midx.c
index 21d6a05e88..0956849e2a 100644
--- a/midx.c
+++ b/midx.c
@@ -1162,6 +1162,7 @@ void clear_midx_file(struct repository *r)
 
 static int verify_midx_error;
 
+__attribute__((format (printf, 1, 2)))
 static void midx_report(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4..f45d3a1b26 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -213,6 +213,7 @@ static int used_atom_cnt, need_tagged, need_symref;
  * Expand string, append it to strbuf *sb, then return error code ret.
  * Allow to save few lines of code.
  */
+__attribute__((format (printf, 3, 4)))
 static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/sequencer.c b/sequencer.c
index c316d8374a..7f07cd00f3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3521,6 +3521,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	return status;
 }
 
+__attribute__((format (printf, 2, 3)))
 static int safe_append(const char *filename, const char *fmt, ...)
 {
 	va_list ap;
@@ -3598,6 +3599,7 @@ static int do_label(struct repository *r, const char *name, int len)
 	return ret;
 }
 
+__attribute__((format (printf, 3, 4)))
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
diff --git a/server-info.c b/server-info.c
index de0aa4498c..7701d7c20a 100644
--- a/server-info.c
+++ b/server-info.c
@@ -27,6 +27,7 @@ static int uic_is_stale(const struct update_info_ctx *uic)
 	return uic->old_fp == NULL;
 }
 
+__attribute__((format (printf, 2, 3)))
 static int uic_printf(struct update_info_ctx *uic, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/worktree.c b/worktree.c
index 237517baee..092a4f92ad 100644
--- a/worktree.c
+++ b/worktree.c
@@ -265,6 +265,7 @@ const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
 }
 
 /* convenient wrapper to deal with NULL strbuf */
+__attribute__((format (printf, 2, 3)))
 static void strbuf_addf_gently(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list params;
-- 
2.32.0-dev

