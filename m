Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C3BC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CB164F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232863AbhBCDaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhBCD3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705BC061797
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b3so4444224wrj.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xIet10MhWiHzzWeiSUKVPoxFWBjUs8GWyU+LV8FRZc=;
        b=n4aO4MJcPn4PtboznmKBSonWKWa/QYkGX9uLx0p3kYXcsTlEKdhyZX3H13vgkSuzLa
         o2O8/UsT5MwO7nzVqR6d0hgE1UAHm2+i0Obmlu22DvBRK45VEotGruYFYM7vuXHhRPhJ
         2hUngWy8Q4oRfYJld4meBh26ieE01CMDNDjhllmrqlng2/W1cfGz4ULyY3Pll8AWxBR/
         Oz5bP1iSp6LPP7q2/k/3KzBrCbH2J0EIWS7k6Q0+Ny5XP/8cwb1qb/fNN0gPKhi0JT/W
         nqPtW2TZKJji8NxiC1yUmTJNs3+bpBrb39PxTuzA9F4VmQfzSZT+LFRLjRL0Z9VBVYqi
         i00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xIet10MhWiHzzWeiSUKVPoxFWBjUs8GWyU+LV8FRZc=;
        b=LENjp40l24AZPOqtfwllegt46o7shCTtX828aJJsCblAiE4QvJD7BTqdu+is9qkBbP
         9TjM0RpwkEf2VZh1sk3npHhYKiKi/HAvCKnFZ2qGsi7JWISjkQ7rDCjFFqNQnAZzXLCe
         d46YbjgSNlu/0YKk7vLayosxUGcsEP3nBGjMvBzIQsy7SSFnsi8ckPi5JBHlivtVnLQI
         aVu5b/4+5nYDnCHAB6UqqNJA4pdNhGuoJwG1wJ50WXD7y8gj78lXgr2OD0VbakaQN1U7
         ++6TkDcuTycd85AHXvwTvwnvZzQs2h6LsI7bVGX+KH8vLjIAF2ESpi+3xPX4b0WG3n/w
         aKoA==
X-Gm-Message-State: AOAM530BeS40NhvUBkBo4Nt67w8Ru4T8B/X1JfkxwrW5MY4qh8yRvbOY
        rjelk2QqzqkjIOVtFAHVHfAmZlkb0kJi7w==
X-Google-Smtp-Source: ABdhPJxM5gtRWlQgpomkZErD4ByzZNABCtYG4DDjXs1ed2fyow6RUp4iBw3FNGuYJ0DLs49jzKDakw==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr1011218wru.175.1612322907004;
        Tue, 02 Feb 2021 19:28:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/25] grep/pcre2: move back to thread-only PCREv2 structures
Date:   Wed,  3 Feb 2021 04:27:56 +0100
Message-Id: <20210203032811.14979-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the setup of the "pcre2_general_context" to happen per-thread
in compile_pcre2_pattern() instead of in grep_init(), as happens with
all the rest of the pcre2_* members of the grep_pat structure.

As noted in the preceding commit the approach 513f2b0bbd4 (grep: make
PCRE2 aware of custom allocator, 2019-10-16) took to allocate the
pcre2_general_context seems to have been initially based on a
misunderstanding of how PCREv2 memory allocation works.

This approach of creating a global context is just added complexity
for almost zero gain. On my system it's 24 bytes saved per-thread, for
context PCREv2 will then go on to some kilobytes for its own
thread-local state.

As noted in 6d423dd542f (grep: don't redundantly compile throwaway
patterns under threading, 2017-05-25) the grep code is intentionally
not trying to micro-optimize allocations by e.g. sharing some PCREv2
structures globally, while making others thread-local.

So let's remove this special case and make all of them thread-local
for simplicity again.

See also the discussion in 94da9193a6 (grep: add support for PCRE v2,
2017-06-01) about thread safety, and Johannes's comments[1] to the
effect that we should be doing what this patch is doing.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.1908052120302.46@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c |  1 -
 grep.c         | 41 +++++++++++++++--------------------------
 grep.h         |  3 ++-
 3 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 55d06c9513..c69fe99340 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1175,6 +1175,5 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
-	grep_destroy();
 	return !hit;
 }
diff --git a/grep.c b/grep.c
index 0116ff5f09..2599f329cd 100644
--- a/grep.c
+++ b/grep.c
@@ -41,7 +41,6 @@ static struct grep_opt grep_defaults = {
 };
 
 #ifdef USE_LIBPCRE2
-static pcre2_general_context *pcre2_global_context;
 #define GREP_PCRE2_DEBUG_MALLOC 0
 
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
@@ -163,20 +162,9 @@ int grep_config(const char *var, const char *value, void *cb)
  * Initialize one instance of grep_opt and copy the
  * default values from the template we read the configuration
  * information in an earlier call to git_config(grep_config).
- *
- * If using PCRE, make sure that the library is configured
- * to use the same allocator as Git (e.g. nedmalloc on Windows).
- *
- * Any allocated memory needs to be released in grep_destroy().
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
-#if defined(USE_LIBPCRE2)
-	if (!pcre2_global_context)
-		pcre2_global_context = pcre2_general_context_create(
-					pcre2_malloc, pcre2_free, NULL);
-#endif
-
 	*opt = grep_defaults;
 
 	opt->repo = repo;
@@ -186,13 +174,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	opt->header_tail = &opt->header_list;
 }
 
-void grep_destroy(void)
-{
-#ifdef USE_LIBPCRE2
-	pcre2_general_context_free(pcre2_global_context);
-#endif
-}
-
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	/*
@@ -384,13 +365,20 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	/* pcre2_global_context is initialized in grep_init */
+	/*
+	 * Call pcre2_general_context_create() before calling any
+	 * other pcre2_*(). It sets up our malloc()/free() functions
+	 * with which everything else is allocated.
+	 */
+	p->pcre2_general_context = pcre2_general_context_create(
+		pcre2_malloc, pcre2_free, NULL);
+	if (!p->pcre2_general_context)
+		die("Couldn't allocate PCRE2 general context");
+
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
-			if (!pcre2_global_context)
-				BUG("pcre2_global_context uninitialized");
-			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
-			p->pcre2_compile_context = pcre2_compile_context_create(pcre2_global_context);
+			p->pcre2_tables = pcre2_maketables(p->pcre2_general_context);
+			p->pcre2_compile_context = pcre2_compile_context_create(p->pcre2_general_context);
 			pcre2_set_character_tables(p->pcre2_compile_context,
 							p->pcre2_tables);
 		}
@@ -411,7 +399,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 					 p->pcre2_compile_context);
 
 	if (p->pcre2_pattern) {
-		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, pcre2_global_context);
+		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, p->pcre2_general_context);
 		if (!p->pcre2_match_data)
 			die("Couldn't allocate PCRE2 match data");
 	} else {
@@ -491,10 +479,11 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_code_free(p->pcre2_pattern);
 	pcre2_match_data_free(p->pcre2_match_data);
 #ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
-	pcre2_maketables_free(pcre2_global_context, p->pcre2_tables);
+	pcre2_maketables_free(p->pcre2_general_context, p->pcre2_tables);
 #else
 	free((void *)p->pcre2_tables);
 #endif
+	pcre2_general_context_free(p->pcre2_general_context);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 64666e9204..72f82b1e30 100644
--- a/grep.h
+++ b/grep.h
@@ -14,6 +14,7 @@
 typedef int pcre2_code;
 typedef int pcre2_match_data;
 typedef int pcre2_compile_context;
+typedef int pcre2_general_context;
 #endif
 #ifndef PCRE2_MATCH_INVALID_UTF
 /* PCRE2_MATCH_* dummy also with !USE_LIBPCRE2, for test-pcre2-config.c */
@@ -75,6 +76,7 @@ struct grep_pat {
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
 	pcre2_compile_context *pcre2_compile_context;
+	pcre2_general_context *pcre2_general_context;
 	const uint8_t *pcre2_tables;
 	uint32_t pcre2_jit_on;
 	unsigned fixed:1;
@@ -167,7 +169,6 @@ struct grep_opt {
 
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
-void grep_destroy(void);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
-- 
2.30.0.284.gd98b1dd5eaa7

