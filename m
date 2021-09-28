Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D1AC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7161139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhI1NQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbhI1NQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F64C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w29so57864287wra.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqSstnTP+KtUctKZ7pL2cKWlUwUbOzaNkbDJ6RsPu2k=;
        b=kjtSzBoXLDRnL7D+YJKntP1SPvH6QzfgicNUia7jVLlbOO9eMi/KSipVpQILB1UlEB
         ZapsO2dg0b5B15c1s/S1PiaIg8kHrB7l23vfM7GnR00a/hrxeEzOBrZrnMWz480Uu0pR
         9c1CisaKTFCx53JTblCENPQ/WYN9Ct9Qey914TMo2/ATmBqfNQHgWRsEv52CcoPhp1u3
         xwt1e3+e+q2nFTPvZCSvHUi4QvlQ763/tt7x/X8oXsCoxqXVTFfjUNK2okwoaI7Lb4vR
         wkQTUrj+fgSNTdKpCWjwGV6dEQ25OWXwLQkZ2bHJtuK8Xzjjh4MSDPd177WaKWMqvjzd
         rPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqSstnTP+KtUctKZ7pL2cKWlUwUbOzaNkbDJ6RsPu2k=;
        b=QXjtfMN05N6vR+5IWL515DQK2/Y+Hbp3znGtIlnh5OtbSxNwKQKMbO5/tt2VKsp8wy
         D/w650zJu+IUzOqweUn3BKYLGZyr899jUXuYRISvnIj5NUJanHGmZWHQOLBZX8QJmrFF
         5oMcSwfvCMULd5pA0XGeI/Q/6h5mfk3+YNAIkLVFMRcrFdCO1jcmRNTJ40vy5oq8qC08
         iN99ygvt8fUb1EhtdSK9A2pbnbDth8slup3DcVHWydBs91kCXFaU3SDfPmBKmS1Ay1VI
         zy8DJb7TeReSOxN0ZzPhDp9mh/uFZRmQ5j3TQy/PBOriQ9xEA28WhhUkEMVLN57cx/0Z
         qjIw==
X-Gm-Message-State: AOAM532I1+/8WHK5vGpIH5fqfgIfoZoNWc5p5cfHls2ZxuAPCXenr+PC
        l8TU7MaEri3fYTU18kI42ADJ5+C7303xsQ==
X-Google-Smtp-Source: ABdhPJwPjkQfe7g6WQ4Eq92K9xtYTaUqIrDtOQL+3XDlgxQvXxVxyzGGdTf/2zOCygrWZrzXar5DmA==
X-Received: by 2002:adf:f387:: with SMTP id m7mr6219793wro.53.1632834878828;
        Tue, 28 Sep 2021 06:14:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] parse-options.[ch]: consistently use "enum parse_opt_result"
Date:   Tue, 28 Sep 2021 15:14:24 +0200
Message-Id: <patch-03.10-fbcbaa47329-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c    |  3 +++
 builtin/shortlog.c |  3 +++
 parse-options.c    | 15 ++++++++-------
 parse-options.h    | 15 ++++++++-------
 4 files changed, 22 insertions(+), 14 deletions(-)

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
index 9dce8b7f8a8..799cd884f2b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -703,9 +703,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
 
-int parse_options_step(struct parse_opt_ctx_t *ctx,
-		       const struct option *options,
-		       const char * const usagestr[])
+enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
+					 const struct option *options,
+					 const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
 
@@ -839,10 +839,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
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
2.33.0.1340.ge9f77250f2b

