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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA1C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F8164DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBRAJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBRAI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51188C061794
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n6so653296wrv.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jENNyEUWjkgAd1Ra96MgpADIZR7bNslJ14yjFDQfyRw=;
        b=iWulLpQX0rUxRJYG56DWYs9ozNxCB8FyWNHPx4qwyD9yIHRnvqrHLm51Npuq/yPvQA
         imdTJiOfQFFO0sizAiIeyrte3STVUz2hI+bQAshvnG8F/H259oxIle1pMOfkiip9YeUC
         kCGc0MgS/W1jDQV0yvE0OWjClGpm4p3Cyrh3+Vg6lMQgn7cOb/PcVDly78Nqs93ouYKE
         ev2152zB/uM8Wy+s4KyKSB2CIZfH8kaO9KMgtrwZpsbJkLfJQdgngBwxErnQRoPOWktC
         mW9MNbVRefiZQGGzpoWIK7QTcYq9O6wn4VMc+PSDK1H+iv+780CIjJkVllLOxpZaBJMr
         lUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jENNyEUWjkgAd1Ra96MgpADIZR7bNslJ14yjFDQfyRw=;
        b=Skbw7dESHrg5LphHX2iNmD3ECG+AZbjZ8ABBQ8S4hT4ItMtE7mDU+GxUXSC7qpCLZZ
         dpotlFuw5P4RJoEuRap+oE+JRCajHgavRMj1McGHD44pXQU+Xp4udZPC36+8rSVHi9mK
         kpd5P2rptwD060yVGDSlUawBEh1VMdc8+6YJc42IlqgwW+u8259UGxUSp1VjGbA5jhBN
         I5T3rAZhXI+XRLsgrPve1mYRTc5ywULAPg/Sb1F0+xMEjjz5fhoYfTxmpszaSgcFUliQ
         cNG2GV1ZUHIM+Of2YzagL3uusZzhgsqo0JAAaZCs0eDjHd4LuyvIUJFgb78IYARApFp4
         Zf3Q==
X-Gm-Message-State: AOAM530mBnmubAAR5f3KtfUkmo7oM3qZ35wgbsiczSFAgbgZnI29J4Az
        7DmB2dTnZiq/k9N8CK9WImpaeu8NXgsaFg==
X-Google-Smtp-Source: ABdhPJyLrGblCzjqsfFtywEDtfl3L1LRyZWh1eSxSbWe89gcEOHhK6yDvOYDQlc4DKSiQJYtykC0/w==
X-Received: by 2002:adf:df01:: with SMTP id y1mr1608225wrl.380.1613606858718;
        Wed, 17 Feb 2021 16:07:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] grep/pcre2: move back to thread-only PCREv2 structures
Date:   Thu, 18 Feb 2021 01:07:27 +0100
Message-Id: <20210218000728.13995-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the setup of the "pcre2_general_context" to happen per-thread
in compile_pcre2_pattern() instead of in grep_init().

This change brings it in line with how the rest of the pcre2_* members
in the grep_pat structure are set up.

As noted in the preceding commit the approach 513f2b0bbd4 (grep: make
PCRE2 aware of custom allocator, 2019-10-16) took to allocate the
pcre2_general_context seems to have been initially based on a
misunderstanding of how PCREv2 memory allocation works.

The approach of creating a global context in grep_init() is just added
complexity for almost zero gain. On my system it's 24 bytes saved
per-thread. For comparison PCREv2 will then go on to allocate at least
a kilobyte for its own thread-local state.

As noted in 6d423dd542f (grep: don't redundantly compile throwaway
patterns under threading, 2017-05-25) the grep code is intentionally
not trying to micro-optimize allocations by e.g. sharing some PCREv2
structures globally, while making others thread-local.

So let's remove this special case and make all of them thread-local
again for simplicity. With this change we could move the
pcre2_{malloc,free} functions around to live closer to their current
use. I'm not doing that here to keep this change small, that cleanup
will be done in a follow-up commit.

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
index 55d06c95130..c69fe993406 100644
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
index 0116ff5f09f..2599f329cd6 100644
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
index 64666e92049..72f82b1e302 100644
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

