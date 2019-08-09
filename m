Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F39B1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404791AbfHIDCW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:02:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43015 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfHIDCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:02:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so37363913pld.10
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lz7TAmnW4tk5QEZqhP5bqZumTK32LogdZLc0g0fjFo0=;
        b=NNN41WrEOuV+1eUa28yYY3UBve2utHMf2xkx3U4JTBV+R/NNnezcijPDpR4iCaiWW7
         u08Tvd9gFBziKP/KB/xjP0I1hGdm8I9gXdmte6uRB9IfNya2jZEjr2/IwClQjwyaahSL
         Ky6LRmMiPyaSSHqFD8e3GCk6KPwtifbcQ+z7HwIO6Ng7V9gKSJQ717Ztd9VtnttcTzYa
         Fq7B/A50nnUpWcVqMQ5Fe87rgbEV5AaiqTe7oU8eTitDUVzo0cZ5x1s26yjHfZU5BBuS
         uoez0XkUiHPrbk0++vvbk5R+hiSKkmvtdgj/afZVaW5zfKMwHaXViagMgcP00FofhhcC
         bjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lz7TAmnW4tk5QEZqhP5bqZumTK32LogdZLc0g0fjFo0=;
        b=BkP83GuoSct11CE27Lc3qXoD0eiYutjczBakaxYHhUE9SJzze8jzCw+DqVYu1yC0go
         0SIsWCWuSmsGZ0eEkL2PVmAP++SC4ovwXLslV9wwWZiIIHOdKfELCviGBhFivoFLOzy5
         vGbgVRoEDCB0I6RVIyd9BEZI7V4oYJpo8c3kqxRi8Ia04xr7abSufbSQ/kfAHJgsE29/
         wO9v4SFFGg7NTsmyngB7w3L1GdkGZZfK9U+XPgTClO17gtdMllBcbK4eS6EYvlIcu14f
         9LAIxiB7WT/yauLqDBwB9NK4EZdXL8WkMDj3LuBr6i5B9tU0EIWFrBkTpwLSGUHf7kvh
         jM8Q==
X-Gm-Message-State: APjAAAXlKIOnhjvSy5NfcxrZqcUNmc2vNd0/IZcBAaBzQlMYvoxHYUIh
        IuHFaio9yi1v684rEzhn1P85vr+Qs2E=
X-Google-Smtp-Source: APXvYqx5TAsAN1UMcdjnl4xr/tXIaXGYfFRsTR8A5q/9GA/O1ct4VojdAgD6/c6MOSYs4ZbYwhPgUg==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr17037944plp.245.1565319740184;
        Thu, 08 Aug 2019 20:02:20 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id h1sm124965938pfo.152.2019.08.08.20.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 20:02:19 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
Date:   Thu,  8 Aug 2019 20:02:09 -0700
Message-Id: <20190809030210.18353-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190809030210.18353-1-carenas@gmail.com>
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
a way to override the system allocator, and so it is incompatible with
USE_NED_ALLOCATOR.  The problem was made visible when an attempt to
avoid a leak in a data structure that is created by the library was
passed to NED's free for disposal triggering a segfault in Windows.

PCRE2 requires the use of a general context to override the allocator
and therefore, there is a lot more code needed than in PCRE1, including
a couple of wrapper functions.

Extend the grep API with a "destructor" that could be called to cleanup
any objects that were created and used globally.

Update builtin/grep to use that new API, but any other future
users should make sure to have matching grep_init/grep_destroy calls
if they are using the pattern matching functionality (currently only
relevant when using both NED and PCRE2)

Move the logic to decide if a general context will be needed to an
earlier phase so it will only be done once per pattern (instead of
at least once per worker thread) avoiding then the need for locking.

This change does the minimum change required to hopefully solve the
crash, with the rest of the users of it added later.

Helped-by: René Scharfe <l.s.r@web.de>
Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/grep.c |  1 +
 grep.c         | 56 +++++++++++++++++++++++++++++++++++++++++++++++++-
 grep.h         |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..e49c20df60 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1145,5 +1145,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	grep_destroy();
 	return !hit;
 }
diff --git a/grep.c b/grep.c
index 0154998695..8e0b838db0 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,44 @@ static int grep_source_is_binary(struct grep_source *gs,
 
 static struct grep_opt grep_defaults;
 
+#ifdef USE_LIBPCRE2
+static pcre2_general_context *pcre2_global_context;
+
+#ifdef USE_NED_ALLOCATOR
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+{
+	return xmalloc(size); /* will use nedalloc underneath */
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+	return free(pointer);
+}
+
+/*
+ * BUG: this is technically not needed if we will do UTF matching
+ *      but UTF locale detection is currently broken
+ * TODO: has_non_ascii() doesn't support NUL in pattern
+ */
+void setup_pcre2_as_needed(struct grep_opt *opt, const char *pat)
+{
+	if (!pcre2_global_context && opt->ignore_case &&
+		has_non_ascii(pat))
+		pcre2_global_context = pcre2_general_context_create(
+					pcre2_malloc, pcre2_free, NULL);
+}
+
+static void cleanup_pcre2_as_needed(void)
+{
+	pcre2_general_context_free(pcre2_global_context);
+}
+
+#else
+#define setup_pcre2_as_needed(opt, pat)
+#define cleanup_pcre2_as_needed()
+#endif
+#endif
+
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -153,6 +191,7 @@ int grep_config(const char *var, const char *value, void *cb)
  *
  * If using PCRE make sure that the library is configured
  * to use the right allocator (ex: NED)
+ * if any object is created it should be cleaned up in grep_destroy()
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
@@ -188,6 +227,11 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 		color_set(opt->colors[i], def->colors[i]);
 }
 
+void grep_destroy(void)
+{
+	cleanup_pcre2_as_needed();
+}
+
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	/*
@@ -326,6 +370,7 @@ void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
 		     const char *origin, int no, enum grep_pat_token t)
 {
 	struct grep_pat *p = create_grep_pat(pat, patlen, origin, no, t, 0);
+	setup_pcre2_as_needed(opt, pat);
 	do_append_grep_pat(&opt->pattern_tail, p);
 }
 
@@ -507,9 +552,18 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	p->pcre2_compile_context = NULL;
 
+	/*
+	 * pcre2_global_context is initialized in append_grep_pat()
+	 * with logic from setup_pcre2_as_needed() that mimics what
+	 * is used here and with the BUG() to protect from mismatches
+	 */
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+#ifdef USE_NED_ALLOCATOR
+			if (!pcre2_global_context)
+				BUG("pcre2_global_context uninitialized");
+#endif
+			character_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 		}
diff --git a/grep.h b/grep.h
index 1875880f37..526c2db9ef 100644
--- a/grep.h
+++ b/grep.h
@@ -189,6 +189,7 @@ struct grep_opt {
 void init_grep_defaults(struct repository *);
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_destroy(void);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
-- 
2.23.0.rc1

