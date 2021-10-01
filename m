Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB46C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A4361A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhJAObK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354514AbhJAObI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11828C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d6so15743559wrc.11
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnMQ/PeBa9XgyAi15/bLt1q2MQoOQih3HUOYN+cx550=;
        b=dyHJAbn3Zc/pciVICZjgaGMe/kh5Eq21iHk213uE/R7QKmEEhosxedD6jEir08L7RV
         A36Jj3HKZfIWkCX3uQr8hz2yQ+Yjieq/7HFGtW4ZEWzmmGFhQMYaXorqhbw/iYebulM2
         dekMZiw9vN15s1qJyq6tN0VKX4xbRwft61bg/LtfpzgsQwiYirRz/rgBaZDOoW65IzK3
         HUhh2qg2N6JZ2ikK/D7lQ4zpy0FAAaFmxkrsMA8hjOMz5Z4TCB+LmiHTgLN2ZrADyZo1
         yM/CZgP+90oSzdZP3MC8EFUCQDYN7mUWQg6Acy/hxY4EfH8iTSplIn7oHMP59vNCbTXI
         Vm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnMQ/PeBa9XgyAi15/bLt1q2MQoOQih3HUOYN+cx550=;
        b=S8S9G6hoH7gzSB4O89uCcLacwf0MaSzXTET9kIllU8doAiljsoYxbLArTzVjnmThj+
         33f73lXGQknAHbMThfBaTZntNwDwrLJiJnhxFzSOA3ic1WNrEeSoK8Wm76CIxMX/2ncW
         av8MhYX8fl+Zet6jqQxlEqjueTxDtMnfVbYbA4IPwH4GNlUt+qD47vhF19xyknUOA/DO
         S1GSjSLj4shQMcsrqBn1wrbybiMGGLohe5w2j1HAKJP4+d5r2gnb7auiVZ7JNX6mkNuf
         YSbk9myA1e1ftP/yemsbXTdVy7LhJTCqjL8A/2U4TVt5xS2F37F99O90/Oc0MjuLGLDR
         FOQw==
X-Gm-Message-State: AOAM533PvzJJ38xmDXo7K0z0cSO9JasM+2Lt8ooHJ1WmN/YkGqUAPh+2
        BNfJiL/eT88nNfGvFgA2GpBLysD/fvG9ZQ==
X-Google-Smtp-Source: ABdhPJyg92/ICiy89d/kBI5wmuJ34paA7tJa9px27zeKQK/RgbyPVCUbTit+lKf5dRh01xW3PEPQWQ==
X-Received: by 2002:adf:f610:: with SMTP id t16mr13217309wrp.309.1633098562363;
        Fri, 01 Oct 2021 07:29:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] parse-options.[ch]: consistently use "enum parse_opt_flags"
Date:   Fri,  1 Oct 2021 16:29:08 +0200
Message-Id: <patch-v2-02.11-99f5251c557-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the "enum parse_opt_flags" instead of an "int flags" as arguments
to the various functions in parse-options.c.

In C enums aren't first-class types, and the "enum
parse_opt_option_flag" uses a enum-as-bitfield pattern. So unlike
exhaustively enumerated "case" arms we're not going to get validation
that we used the "right" enum labels.

I.e. this won't catch the sort of bug that was fixed with
"PARSE_OPT_SHELL_EVAL" in the preceding commit.

But there's still a benefit to doing this when it comes to the wider C
ecosystem. E.g. the GNU debugger (gdb) will helpfully detect and print
out meaningful enum labels in this case. Here's the output before and
after when breaking in "parse_options()" after invoking "git stash
show":

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
 parse-options.h |  6 ++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

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
2.33.0.1374.gc8f4fa74caf

