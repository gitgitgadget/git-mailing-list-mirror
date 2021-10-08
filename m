Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67527C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D07C60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhJHTJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbhJHTJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AAC061764
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so32512965wrd.13
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CH9uNT1ovcPcUx1HrgpRJHKZZ5gYHCr8ACF4ZtsTsA0=;
        b=Q9/p004gvEiNiQbj7vwsHDJG/vw89rGzIxt8It6aavpaRwlN2tr1MrZTkTi+fLAdIG
         8E4tSYv79LCYplypPtvivE/AyifAj8c1PrsXWPBM2yKEjd6IxANl/dhe2H/fHamn0+K+
         wfk6DZWU/UiAxOAUs8BueoBBIX7GqPzuru+nPlUsQ2n/o6ey88AL6TR9gu1aGfn1eFdP
         2KZNhqrlNxFKaH/TEGaGjmPL5H0EtRGicArZzlt1oH4wDSE7tbGxzcHuKaFhAvbNGmY6
         SCWJbE7tMceewfAzisg1x/Jiv629pTQJMC0AhGaKA7u4QtzgO2R2GGE1ZpkWBTSKH/tC
         FrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CH9uNT1ovcPcUx1HrgpRJHKZZ5gYHCr8ACF4ZtsTsA0=;
        b=JYdvbvs1RrvtjQWRhxYW2wMa66yLl8j5lGsEf4Yfni9J5Te31qplNgRhC5KT2GbZAq
         I5ji9MtArymprn3wSpZL7BDMPG98IKdrmgbYqvbJI9/M60cCVebXEXjRfQOwyZY3vEV9
         GhslbNNdD0aoLVV186lI/eGCT/8aBiBTJFK9fpvLkWPSdPezGH3XI6sgzX8qH9zOF942
         U45wDaYFX29eJ5vg39k+0iVMZJkrFrqyUTWe/olW2HkAAgkxFZU2bJ/BKgyKYBOqCTWE
         VO6V9J2Qnr7BRrTuJMZP71qPUZCi7N8ZzAYExn2+NaiSJ3X90+ugKtVC6KNdBqb8R9b6
         VfSw==
X-Gm-Message-State: AOAM5324VCJUdsOhOepY6duN5riWLAfI56iWLvc+h5P64H0xNUQ331kt
        Bxp4MdusTYNmjcs0g4bUvbZz8k8ekdN+Ow==
X-Google-Smtp-Source: ABdhPJxwCp0Ql7J+z+SXuNnqW9ICNV2dDFI3LoLThwMtTWa3vobPlS+ulukmvVKq674ERkwRjaRNjg==
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr6403221wrb.237.1633720070683;
        Fri, 08 Oct 2021 12:07:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] parse-options.[ch]: consistently use "enum parse_opt_result"
Date:   Fri,  8 Oct 2021 21:07:39 +0200
Message-Id: <patch-v3-03.10-828e8b96574-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "enum parse_opt_result" instead of an "int flags" as the
return value of the applicable functions in parse-options.c.

This will help catch future bugs, such as the missing "case" arms in
the two existing users of the API in "blame.c" and "shortlog.c". A
third caller in 309be813c9b (update-index: migrate to parse-options
API, 2010-12-01) was already checking for these.

As can be seen when trying to sort through the deluge of warnings
produced when compiling this with CC=g++ (mostly unrelated to this
change) we're not consistently using "enum parse_opt_result" even now,
i.e. we'll return error() and "return 0;". See f41179f16ba
(parse-options: avoid magic return codes, 2019-01-27) for a commit
which started changing some of that.

I'm not doing any more of that exhaustive migration here, and it's
probably not worthwhile past the point of being able to check "enum
parse_opt_result" in switch().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c    |  3 +++
 builtin/shortlog.c |  3 +++
 parse-options.c    | 31 +++++++++++++++++--------------
 parse-options.h    | 15 ++++++++-------
 4 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 641523ff9af..9273fb222d5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -917,6 +917,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
+		case PARSE_OPT_NON_OPTION:
+		case PARSE_OPT_UNKNOWN:
+			break;
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
 			exit(129);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3e7ab1ca821..e7f7af5de3f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -374,6 +374,9 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	for (;;) {
 		switch (parse_options_step(&ctx, options, shortlog_usage)) {
+		case PARSE_OPT_NON_OPTION:
+		case PARSE_OPT_UNKNOWN:
+			break;
 		case PARSE_OPT_HELP:
 		case PARSE_OPT_ERROR:
 			exit(129);
diff --git a/parse-options.c b/parse-options.c
index 9c8ba963400..f718242096c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -699,13 +699,14 @@ static void free_preprocessed_options(struct option *options)
 	free(options);
 }
 
-static int usage_with_options_internal(struct parse_opt_ctx_t *,
-				       const char * const *,
-				       const struct option *, int, int);
-
-int parse_options_step(struct parse_opt_ctx_t *ctx,
-		       const struct option *options,
-		       const char * const usagestr[])
+static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
+							 const char * const *,
+							 const struct option *,
+							 int, int);
+
+enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
+					 const struct option *options,
+					 const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
 
@@ -839,10 +840,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 	return ctx->cpidx + ctx->argc;
 }
 
-int parse_options(int argc, const char **argv, const char *prefix,
-		  const struct option *options,
-		  const char * const usagestr[],
-		  enum parse_opt_flags flags)
+enum parse_opt_result parse_options(int argc, const char **argv,
+				    const char *prefix,
+				    const struct option *options,
+				    const char * const usagestr[],
+				    enum parse_opt_flags flags)
 {
 	struct parse_opt_ctx_t ctx;
 	struct option *real_options;
@@ -900,9 +902,10 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
-				       const char * const *usagestr,
-				       const struct option *opts, int full, int err)
+static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
+							 const char * const *usagestr,
+							 const struct option *opts,
+							 int full, int err)
 {
 	FILE *outfile = err ? stderr : stdout;
 	int need_newline;
diff --git a/parse-options.h b/parse-options.h
index 2e8798d8744..a1c7c86ad30 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -211,10 +211,11 @@ struct option {
  * untouched and parse_options() returns the number of options
  * processed.
  */
-int parse_options(int argc, const char **argv, const char *prefix,
-		  const struct option *options,
-		  const char * const usagestr[],
-		  enum parse_opt_flags flags);
+enum parse_opt_result parse_options(int argc, const char **argv,
+				    const char *prefix,
+				    const struct option *options,
+				    const char * const usagestr[],
+				    enum parse_opt_flags flags);
 
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
@@ -274,9 +275,9 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 const struct option *options,
 			 enum parse_opt_flags flags);
 
-int parse_options_step(struct parse_opt_ctx_t *ctx,
-		       const struct option *options,
-		       const char * const usagestr[]);
+enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
+					 const struct option *options,
+					 const char * const usagestr[]);
 
 int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-- 
2.33.0.1446.g6af949f83bd

