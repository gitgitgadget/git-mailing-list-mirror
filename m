Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041BF1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbfHFQhD (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:37:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47096 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387810AbfHFQhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:37:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so18658389pfa.13
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLQSfcY2hO8y3jJA5LQ+OeNzX9pjT4cZLrGyf4LmA38=;
        b=ZdVJXIleqGY/ZyX3IU6ZVH2Xa+Opfm92wgQcRQHVloseFoamNLVpl2/yS85H13dqWE
         8QU1wEvQXk7ZvTZ23yZ28mK6y4RbeKbmlkG/aiD3BgDNW86SdenAkxpqXPfG54lzS1Yd
         /Sbj6BqjMhwFxLmaG8UsbreThXtdnPGBkKb4kFoKzt7lEiUbhsBdwo6h7qhGhVO1tnPU
         QL/L7qykOhBdngtgcdaGAIQidBAO8NPPrVSzEUOYHqxobsIhLekxPK1QJzhkJu59iJbm
         EAvEPuD6vqxcLXwZF0mvVPUkBvZc583PdQMcEU2dTP0EE4NAsrB9pst7v6W7J97Nl39X
         RCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLQSfcY2hO8y3jJA5LQ+OeNzX9pjT4cZLrGyf4LmA38=;
        b=E07UOFdt17HYpdq8JKlauJ7C0Zm+HK7Frp6xakGbRMcUmGHLB8ea2zRd8slVkFGh5P
         V5DMM4r1cJN6KhPZXjyCgxvv/A17pWwSr5Rqb1TpWUpP2GTeg8Nzdbi9qgz1K3Z0ibMp
         oPt9OJkYq99hBC2cgF9gmb+pnY64uFzlscS1uMVKDbhHAZ6jfznwFv1i6KwpZKRMiRkv
         rceRbYANXm/I8ZFs7n9HSh0Xs0j3aWNep82MqonKJSZZ8cWIqTf49enRMoQw08j2MIL+
         xi7MNZpf4V9Jv/GzOIeEW7KtORJO7TKonAClBqazY3DkRiEOT/pDz7aV27GbZuuV/UMU
         VWQQ==
X-Gm-Message-State: APjAAAUnQxyKluJe1+GGhlM1oXPLEZGIK3pZy+4DBRCKaOqcV0VsE44M
        mEkBzpL+DMt/efpJJ29fJVO/xnVPJCs=
X-Google-Smtp-Source: APXvYqzdRhl5DSw/MzlNflp3YgDIl1TmZSytscIQ3Oxr9K1lBa3b7JVECGDV/ueB0CaE/9OEnrUMYg==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr3983993pji.126.1565109421819;
        Tue, 06 Aug 2019 09:37:01 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k36sm89364611pgl.42.2019.08.06.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 09:37:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
Date:   Tue,  6 Aug 2019 09:36:57 -0700
Message-Id: <20190806163658.66932-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com>
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
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

Move some of the logic that was before done per thread (in the workers)
into an earlier phase to avoid degrading performance, but as the use
of PCRE2 with NED is better understood it is expected more of its
functions will be instructed to use the custom allocator as well as
was done in the original code[1] this work was based on.

[1] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/grep.c |  1 +
 grep.c         | 36 +++++++++++++++++++++++++++++++++++-
 grep.h         |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

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
index 0154998695..3e5bdf94a6 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,22 @@ static int grep_source_is_binary(struct grep_source *gs,
 
 static struct grep_opt grep_defaults;
 
+#ifdef USE_LIBPCRE2
+static pcre2_general_context *pcre2_global_context;
+
+#ifdef USE_NED_ALLOCATOR
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+{
+	return malloc(size);
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+	return free(pointer);
+}
+#endif
+#endif
+
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -153,6 +169,7 @@ int grep_config(const char *var, const char *value, void *cb)
  *
  * If using PCRE make sure that the library is configured
  * to use the right allocator (ex: NED)
+ * if any object is created it should be cleaned up in grep_destroy()
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
@@ -188,6 +205,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 		color_set(opt->colors[i], def->colors[i]);
 }
 
+void grep_destroy(void)
+{
+#ifdef USE_LIBPCRE2
+	pcre2_general_context_free(pcre2_global_context);
+#endif
+}
+
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	/*
@@ -319,6 +343,11 @@ void append_header_grep_pattern(struct grep_opt *opt,
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
 			 const char *origin, int no, enum grep_pat_token t)
 {
+#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
+	if (!pcre2_global_context && opt->ignore_case && has_non_ascii(pat))
+		pcre2_global_context = pcre2_general_context_create(
+					pcre2_malloc, pcre2_free, NULL);
+#endif
 	append_grep_pat(opt, pat, strlen(pat), origin, no, t);
 }
 
@@ -507,9 +536,14 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	p->pcre2_compile_context = NULL;
 
+	/* pcre2_global_context is initialized in append_grep_pattern */
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

