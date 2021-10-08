Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49FFC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9508360F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbhJHTKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbhJHTJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C533C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so32670013wra.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHSTimRQK1P9+oMaU37/Qr3VBwTzs5I9LVjztFZr0yU=;
        b=kRAe754J+lsg6zOsABCJCyjKqrWbuSN4ghNVL/O6rm68+Y0DdblS1oH/ySaHUb8wYK
         bCr1ZrBjE3Gb3gdMy3Ls/Vc1TP3talabjEEUcZkIbzmpDL8rsrQs1mbMLWi7ZHuBJ8Jw
         IWq1Re2UHEKuCeQ8KW9GBcqwzNFdsQ4aRSQZUHjpZ/zwOT32F+AKULLCEnLRejQlpgR+
         o5R4q5HC5Z4gYYoQl/OjfhoyN5arB0qvFrMSHHfg0WlapDkB6WbPjfQHtKYup6nmoS6x
         grasGlnG74NUK4fxPB+yFSGuBkkry611LcgocV8tRWjnWIJNWA0oH4u6wDMa6ljiLOWp
         pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHSTimRQK1P9+oMaU37/Qr3VBwTzs5I9LVjztFZr0yU=;
        b=OMsFWaxHLEJPmoNrSrzD1+hC5iXcjrSOZdqt5V/zvmEYWU07FAH6Buu5HWAtZMtRN7
         Q/MU2MIEvNARz7vZxW0EpSvzYue4bUivBZ7HXHgVtyJXQGEBGHJN3ziXF+zpwf0ysNms
         YRtDlLLzlPgWE/68DZwIrPXEZBsUC3i6zbqOtJ/YoSEpiY/gSk8Pigz9A7gnppPlK6X5
         fZwXzkLud/RjG9KT+rQhswSXzqo4ZFcbWDJn9x4Rc6qRLVjVmkXWmb5vZ7INVCaj7pKA
         1gO7/XWvCKjeYYMpMqOxXnB0r1r9VxBniFZQGWadic8jN4kV/xe2srhtHgj1opF6dnMh
         L5UQ==
X-Gm-Message-State: AOAM531oDphFPC+PJfH3TE085b3lvAzqhPJb0pnnLsbzWXXXylx7pZ6p
        gZTvoVa4tRrhvnUflD3bGd2+eU9qeEFhtQ==
X-Google-Smtp-Source: ABdhPJzlb3q3nVDXhcd5wSJ4/J93U+C5Of5453Ndk/VilyGFCF37Q3YavzXLunawylHuuGBYflcOvA==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr5267851wme.41.1633720070066;
        Fri, 08 Oct 2021 12:07:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] parse-options.[ch]: consistently use "enum parse_opt_flags"
Date:   Fri,  8 Oct 2021 21:07:38 +0200
Message-Id: <patch-v3-02.10-d4aaaa645de-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "enum parse_opt_flags" instead of an "int flags" as arguments
to the various functions in parse-options.c.

Even though this is an enum bitfield there's there's a benefit to
doing this when it comes to the wider C ecosystem. E.g. the GNU
debugger (gdb) will helpfully detect and print out meaningful enum
labels in this case. Here's the output before and after when breaking
in "parse_options()" after invoking "git stash show":

Before:

    (gdb) p flags
    $1 = 9

After:

    (gdb) p flags
    $1 = (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN)

Of course as noted in[1] there's a limit to this smartness,
i.e. manually setting it with unrelated enum labels won't be
caught. There are some third-party extensions to do more exhaustive
checking[2], perhaps we'll be able to make use of them sooner than
later.

We've also got prior art using this pattern in the codebase. See
e.g. "enum bloom_filter_computed" added in 312cff52074 (bloom: split
'get_bloom_filter()' in two, 2020-09-16) and the "permitted" enum
added in ce910287e72 (add -p: fix checking of user input, 2020-08-17).

1. https://lore.kernel.org/git/87mtnvvj3c.fsf@evledraar.gmail.com/
2. https://github.com/sinelaw/elfs-clang-plugins/blob/master/enums_conversion/README.md

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 11 +++++++----
 parse-options.h |  8 +++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 55c5821b08d..9c8ba963400 100644
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
diff --git a/parse-options.h b/parse-options.h
index 3a3176ae65c..2e8798d8744 100644
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
@@ -262,7 +263,7 @@ struct parse_opt_ctx_t {
 	const char **out;
 	int argc, cpidx, total;
 	const char *opt;
-	int flags;
+	enum parse_opt_flags flags;
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
 	struct option *updated_options;
@@ -270,7 +271,8 @@ struct parse_opt_ctx_t {
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
-			 const struct option *options, int flags);
+			 const struct option *options,
+			 enum parse_opt_flags flags);
 
 int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
-- 
2.33.0.1446.g6af949f83bd

