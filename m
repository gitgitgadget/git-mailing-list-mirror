Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90F161A3A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354524AbhJAObM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbhJAObJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C4C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v25so5188085wra.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+J4vYeG8G+YnXjiE8eWeDR32ZXMGjjPfpcrpKwVc5w=;
        b=iHMNOzCcZnmhvDcyqJdeqnEcaO0vNXxdSeDH62QJZZCsF6a0/kX3SC85nVbLxW8AwY
         F1mzkt8IFAzOFacCihxiZx2FNBIByurUmsClDHbOv2tHOTW54+Dw69wz0nCLa7VnFkPQ
         59rJQqp058nAoCwBptjcqNTYALqtUdi1LHMwr+IuPecJIJS19aFm6gi3gHjr6TKkLzq+
         jpOMm8kzVUEsAw5cTNv+++uN/IVDeiLNvH/s7oR9VdZ3jKe4/hWG/TE2639kQ9Wnt1Jh
         bWv/IbE2b2/oeX2KRiQt2oxMHXNzdlqnwCpKW/m/2u4iIIILWvCP74sT8KS/JWKmeWKz
         fYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+J4vYeG8G+YnXjiE8eWeDR32ZXMGjjPfpcrpKwVc5w=;
        b=zYHx5xMmGN+fjQ7EKzztPOLoP7lZeVeyjj/7Skcgg82zh4L7MJCx/9e+snH8IMP2Ei
         FL6SW3jaNRgD0eZ+6VRH/d6sIW4hLl/C6N9Na6d5ksVdOfh1KmNklkt+fp4jrz3RR1ZQ
         1o2ZKTzqwPTKU2vO1CQPBQVCbhQ0CkkG1LrQA+NjZGPIT/AV673XJAOgcal+HnpjB0EC
         IRFhRHTWmQ2yk/HdketD5li4Bv9hKdCx4nqH0sUaaZKJlw8d5xT4AFz7IT+mEfs8AQCF
         fajL1W39Uzy6R6svfMKXG29EPm5xRcE39iZn7G3/nqcTCQ0/4G9g8WgbeDg7Gkidj3KQ
         GUOg==
X-Gm-Message-State: AOAM530jaBXWdztFjzxcKZSVprB1V0P0uCfeUrY+jqR80VMMf0De2uDx
        Q9jYS23Y5Uget47fWzujc2jgdGsUnxQ0IQ==
X-Google-Smtp-Source: ABdhPJweohQ3uKh7mVQeilKVh36FiZ8MNOruoe66ZcvI+cl39EAY2boq8GBSLyOR0vfXVXtgnmZljg==
X-Received: by 2002:adf:b35c:: with SMTP id k28mr12661255wrd.209.1633098563190;
        Fri, 01 Oct 2021 07:29:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] parse-options.[ch]: consistently use "enum parse_opt_result"
Date:   Fri,  1 Oct 2021 16:29:09 +0200
Message-Id: <patch-v2-03.11-be198e42df9-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
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
index fb5aafd4f7b..d931300f4d6 100644
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
2.33.0.1374.gc8f4fa74caf

