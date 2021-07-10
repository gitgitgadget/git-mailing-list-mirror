Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9AC07E9C
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFA4613DA
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhGJIuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhGJIuY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAB3C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d12so15040898wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3AabF10bNli6HBcqQWQaLk4Fr8Kz6AcyFpqC/44+hY=;
        b=kFO+e9nYHrwGFN5hIJKLrrF4LgNyTOXkJ/K2GRiys/Ab+wPMDdwIgLwBc43DHULQ5r
         8I0acGLs3GeRYgtiFfIvVvEEU94zjpyeswIj1ZWwIzpORdAmK69JkRclK4J29lyCVnze
         No6syX/Fzt9ZzuTQtS3eqbwgrACtn72xkap9YpKugPVJ1lbnmUxW6Yqtq8bm6W4lVxf0
         ewHzSKrRrDoGunBU06OXR1yKLmDTa2/DIxRj6GikQIw5XOO0jWqHxLqEZfPrNh5t/QSs
         PPkFs3oObt5D6tgwgW2vJIZWynRNjWshSZbaz1+ai+vHuwcXkxjWeo/WDtN3j7ze1RmQ
         ZFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3AabF10bNli6HBcqQWQaLk4Fr8Kz6AcyFpqC/44+hY=;
        b=eYzOUUs5Uw/3oYja7hAE9FFvmeF2/747EF3V3ZqQz0TsFymGsed/3HezY5wLEFSyQx
         7c13+17t3AS659l/xGKbAqAodt/oY9IqceUt8UdfVkCLRoPwfquL71gLGI4sPRRdy/A6
         sVJ9VyXAgSMYBHD8MGs2gEjQ5X64ZWRJGy4Qa16oPezhr3vlx34gSI7DtjUny0KUXEHw
         DKoXw6q2L/cIqUAJh2lCS08GzLa5COHNGPsCFfaqG5Cf5qCbi4yF2K5j4eev+IqztZBa
         4Th6q9Hq745nSM7w4KZMzUi213mDeAO0v88KwEBL87jyPOrtgm7xVxFxAFOH5B1sQwtG
         4Cww==
X-Gm-Message-State: AOAM530OkoPU3KuXhnT9/ldxklZV7aTRg5LPbhZHR7EDrIKR/a+XkfKO
        10anbP2ZKf+q1gf10pb+FqonlkofeVUX7Q==
X-Google-Smtp-Source: ABdhPJy2/y0aGOe1syy9gjDpPUyWwsuiY6bilJDCzUtPGegAkupFloZxwtyKqpP+TchdzEtUtkgaxg==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr40656645wry.221.1625906857289;
        Sat, 10 Jul 2021 01:47:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] *.c static functions: add missing __attribute__((format))
Date:   Sat, 10 Jul 2021 10:47:29 +0200
Message-Id: <patch-3.6-bc3fee3b7a1-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
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
 compat/mingw.c                                              | 1 +
 compat/winansi.c                                            | 1 +
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
 18 files changed, 22 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index 2fad92ca373..8c41cdfe39b 100644
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
index 0b2d886c81b..0c2ad96b70e 100644
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
index 9d9540a0abf..f184eaeac6d 100644
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
index 2bcb4e0f89e..9179a3a6476 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2408,6 +2408,7 @@ int write_commit_graph(struct object_directory *odb,
 #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 static int verify_commit_graph_error;
 
+__attribute__((format (printf, 1, 2)))
 static void graph_report(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/compat/mingw.c b/compat/mingw.c
index aa647b367b0..e6afb4ad9e8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -189,6 +189,7 @@ static int read_yes_no_answer(void)
 	return -1;
 }
 
+__attribute__((format (printf, 1, 2)))
 static int ask_yes_no_if_possible(const char *format, ...)
 {
 	char question[4096];
diff --git a/compat/winansi.c b/compat/winansi.c
index c27b20a79d9..9cf95747d41 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -461,6 +461,7 @@ static void winansi_exit(void)
 	CloseHandle(hthread);
 }
 
+__attribute__((format (printf, 1, 2)))
 static void die_lasterr(const char *fmt, ...)
 {
 	va_list params;
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bcd3f575a3e..0b44a9b7cc6 100644
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
index 5bdad41de1f..5091048f9c6 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -11,6 +11,7 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+__attribute__((format (printf, 1, 2)))
 static void die(const char *err, ...)
 {
 	char msg[4096];
diff --git a/gettext.c b/gettext.c
index af2413b47e8..bb5ba1fe7cc 100644
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
index bb085d66d10..ce5a0461a43 100644
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
index d1f7c0d272d..462b3956340 100644
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
index b954f7184a5..955d1d05027 100644
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
index 4327e0cfa33..5d54990af9a 100644
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
index 21d6a05e887..0956849e2a1 100644
--- a/midx.c
+++ b/midx.c
@@ -1162,6 +1162,7 @@ void clear_midx_file(struct repository *r)
 
 static int verify_midx_error;
 
+__attribute__((format (printf, 1, 2)))
 static void midx_report(const char *fmt, ...)
 {
 	va_list ap;
diff --git a/ref-filter.c b/ref-filter.c
index 4db0e40ff4c..f45d3a1b26d 100644
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
index c316d8374a7..7f07cd00f3f 100644
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
index de0aa4498c6..7701d7c20a1 100644
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
index 237517baee6..092a4f92ad2 100644
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
2.32.0.636.g43e71d69cff

