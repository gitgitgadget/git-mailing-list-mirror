Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E611C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CB1600CD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbhI1NQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbhI1NQS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E6C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so14575435wrv.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TbVUPd8V76NN87Pt7XBq451ixBgEJFvkD0QzmoIPuY=;
        b=i+X06OR5HxxeqJ2RwJfov6NTlEC8GBvswV2KCNABA+ET8AMt4xMLravy2Zjieaox0b
         ZWRfLNCrB1jNg7uh1aagTDfSJgT5smEFPm6lsdrzUca1Mc4b2XS6ebbdH4FtoTc4/7VD
         amdi+BfCQg5sNmRPyA1+/o4kP2cr4oqrZUFuY0kw7cVOc0/zM5li0Q4vs1J+OvBJhrCH
         6YD7fMPhacD2RPBwfDQeOHO5P+pU7u3RBSIf9NPupThkd1LuskEl3aun7a69Gfh/wTFo
         qrpuqlqo0TKFalgIln/YvsaXDIuULL1RGT40oRd9M6RJRXwhuYxbscz/u9yf3o6CzHYL
         G//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TbVUPd8V76NN87Pt7XBq451ixBgEJFvkD0QzmoIPuY=;
        b=WjbMs4jaV/NAuYAHqNV8IFV7k4jVSpNkJ16zv9LehNq8AnxC1JU2WogcY/QO9BGA4u
         ljPbXfhpbavRxCbH8lRQftIKiwHs6IauJHPt/AOCf5nOf4v6v8zuYmZ8lVs2Z6TN1V0N
         j1eLyjR+AI68N/XUjyUSgRoxW4l19954tDxJpQo+es7unW/McIgmiyettERJejqu0lrx
         kGvDelmS1AhIvTiqXWcFYW//TGc2eZGWqz5deGaHuIcr9Ui0+IYRfpkJ8S1Q+garnOvo
         oGg8jo8aLe+dq41N5KagaHn2bHawahKiiHz9plRSyI3Zx4GKdufVmnlHTdsJ6oMUf2+/
         rxEw==
X-Gm-Message-State: AOAM531ROSAVJ7p7MUa6uRdLPheNX+QUxjRSD8RxS41kWOK38hnaZKnx
        dsDupRSCtnOe4cUyMO5rBPU3TxSLAuwODQ==
X-Google-Smtp-Source: ABdhPJwYc0paMY7flo10c/VqHjefpqbrRwvX6/hENRyYba0H5nz/XU2i1AIOS0p47DMSFOAbo7yI/A==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr6561414wri.140.1632834877468;
        Tue, 28 Sep 2021 06:14:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] parse-options.[ch]: consistently use "enum parse_opt_flags"
Date:   Tue, 28 Sep 2021 15:14:23 +0200
Message-Id: <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "enum parse_opt_flags" instead of an "int flags" as arguments
to the various functions in parse-options.c. This will help to catch
cases where we're not handling cases in switch statements, and
generally make it obvious which "flags" we're referring to in this
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 13 ++++++++-----
 parse-options.h |  6 ++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 55c5821b08d..9dce8b7f8a8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -481,7 +481,8 @@ static void parse_options_check(const struct option *opts)
 
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 				  int argc, const char **argv, const char *prefix,
-				  const struct option *options, int flags)
+				  const struct option *options,
+				  enum parse_opt_flags flags)
 {
 	ctx->argc = argc;
 	ctx->argv = argv;
@@ -506,7 +507,8 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
-			 const struct option *options, int flags)
+			 const struct option *options,
+			 enum parse_opt_flags flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
 	parse_options_start_1(ctx, argc, argv, prefix, options, flags);
@@ -838,8 +840,9 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 }
 
 int parse_options(int argc, const char **argv, const char *prefix,
-		  const struct option *options, const char * const usagestr[],
-		  int flags)
+		  const struct option *options,
+		  const char * const usagestr[],
+		  enum parse_opt_flags flags)
 {
 	struct parse_opt_ctx_t ctx;
 	struct option *real_options;
@@ -861,7 +864,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
-	default: /* PARSE_OPT_UNKNOWN */
+	case PARSE_OPT_UNKNOWN:
 		if (ctx.argv[0][1] == '-') {
 			error(_("unknown option `%s'"), ctx.argv[0] + 2);
 		} else if (isascii(*ctx.opt)) {
diff --git a/parse-options.h b/parse-options.h
index 3a3176ae65c..fb5aafd4f7b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -213,7 +213,8 @@ struct option {
  */
 int parse_options(int argc, const char **argv, const char *prefix,
 		  const struct option *options,
-		  const char * const usagestr[], int flags);
+		  const char * const usagestr[],
+		  enum parse_opt_flags flags);
 
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
@@ -270,7 +271,8 @@ struct parse_opt_ctx_t {
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
-			 const struct option *options, int flags);
+			 const struct option *options,
+			 enum parse_opt_flags flags);
 
 int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
-- 
2.33.0.1340.ge9f77250f2b

