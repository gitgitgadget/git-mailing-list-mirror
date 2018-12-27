Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC77211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeL0QZv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33363 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbeL0QZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so16692575ljd.0
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuT+7NMktV5SYOapeFt8h/XsAWWG22jYdIE8EgWILM8=;
        b=CmOtJhaoy+rr1izLqTSXM+NOTgwV4QISARWOdwcyRNoxrUsLUvshldWNIydMuyYCty
         Sz3KF1E84UVFnmPXFsJgdrv+BeJhxS9sa6CzlaySttKnfDE9d14LP5iopZ37Tk91mtRx
         7Repe43nyOmajoCkG3TpvRfOFYw1ShksWU+PnnCUM1+c6IZMLYQecXLgMhQgBHyKYm/Y
         QdpUMj8quYywYN9GdO0UoYGAqdCWC8Srb65RqwuGtEzuWvTZ0EnkvbxXZdJzOA31qea2
         mCAI/sPJNJLg39jU8wDbD3PMAsiozeB/20vFk5O+TJ9D6EdIMnr+RP4PEbQ0VxiekFHF
         7YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuT+7NMktV5SYOapeFt8h/XsAWWG22jYdIE8EgWILM8=;
        b=o09sGRrjSvm4w/In3IS0JKnhn57PPeVOtveqxo6ih8aXlSpmz3HZL1zpQQE9bB6BLB
         ogNc6r/c2sbEW99YhNEaFJ5pqgJZ/2L1ZoqHCrDGm9ikCeSr5lmAReovDjM8R/hLwybw
         Ikms1ju1XLHIMQvv/op76W6f4wsEtDUn5QD1XiIgawfyRo6gpktbNfHCFqza7z8nsMtg
         poXdMvuEOsZgw/udExDFIGWNAPk8Hk0oS8O/LnAu6gXf5OXqgyIbDhn64YX1Xh4WWFeF
         GZvWGcn+0ORHWnkcmip36ijU2US81vGG2O/kjiOHSw955jEIjgU8CbXqht3j+gABMi6w
         6kZQ==
X-Gm-Message-State: AJcUukezPiCFhbxnAAigaiLUqzRIIwa30OUs0zq+dGN+TtHQC375s13n
        Um2W7CcCCt5YRsFuvSJGYssUcjQI
X-Google-Smtp-Source: ALg8bN52ewmspuq7Zq58Jpa/iohzTzmypVpbc73YNTIAeXH9uOkdRalVDTP8BBpjr6CgKl6zboleUw==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr14579202ljb.106.1545927947383;
        Thu, 27 Dec 2018 08:25:47 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:46 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/75] parse-options: add one-shot mode
Date:   Thu, 27 Dec 2018 17:25:23 +0100
Message-Id: <20181227162536.15895-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to help reimplement diff_opt_parse() using parse_options().
The behavior of parse_options() is changed to be the same as the
other:

- no argv0 in argv[], everything can be processed
- argv[] must not be updated, it's the caller's job to do that
- return the number of arguments processed
- leave all unknown options / non-options alone (this one can already
  be achieved with PARSE_OPT_KEEP_UNKNOWN and
  PARSE_OPT_STOP_AT_NON_OPTION)

This mode is NOT supposed to stay here for long. It's to help
converting diff/rev option parsing. Once that work is over and we can
just use parse_options() throughout the code base, this will be
deleted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 23 ++++++++++++++++++++---
 parse-options.h | 17 +++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6932eaff61..d47e217b07 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -415,15 +415,23 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 const struct option *options, int flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->argc = ctx->total = argc - 1;
-	ctx->argv = argv + 1;
-	ctx->out  = argv;
+	ctx->argc = argc;
+	ctx->argv = argv;
+	if (!(flags & PARSE_OPT_ONE_SHOT)) {
+		ctx->argc--;
+		ctx->argv++;
+	}
+	ctx->total = ctx->argc;
+	ctx->out   = argv;
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
 		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+	if ((flags & PARSE_OPT_ONE_SHOT) &&
+	    (flags & PARSE_OPT_KEEP_ARGV0))
+		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
 }
 
@@ -535,6 +543,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	for (; ctx->argc; ctx->argc--, ctx->argv++) {
 		const char *arg = ctx->argv[0];
 
+		if (ctx->flags & PARSE_OPT_ONE_SHOT &&
+		    ctx->argc != ctx->total)
+			break;
+
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
@@ -609,6 +621,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 		continue;
 unknown:
+		if (ctx->flags & PARSE_OPT_ONE_SHOT)
+			break;
 		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
 			return PARSE_OPT_UNKNOWN;
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
@@ -622,6 +636,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+	if (ctx->flags & PARSE_OPT_ONE_SHOT)
+		return ctx->total - ctx->argc;
+
 	MOVE_ARRAY(ctx->out + ctx->cpidx, ctx->argv, ctx->argc);
 	ctx->out[ctx->cpidx + ctx->argc] = NULL;
 	return ctx->cpidx + ctx->argc;
diff --git a/parse-options.h b/parse-options.h
index 1947cb27cf..043d296ea4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -27,7 +27,8 @@ enum parse_opt_flags {
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16
+	PARSE_OPT_NO_INTERNAL_HELP = 16,
+	PARSE_OPT_ONE_SHOT = 32
 };
 
 enum parse_opt_option_flags {
@@ -169,10 +170,18 @@ struct option {
 	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
 
-/* parse_options() will filter out the processed options and leave the
- * non-option arguments in argv[]. usagestr strings should be marked
- * for translation with N_().
+/*
+ * parse_options() will filter out the processed options and leave the
+ * non-option arguments in argv[]. argv0 is assumed program name and
+ * skipped.
+ *
+ * usagestr strings should be marked for translation with N_().
+ *
  * Returns the number of arguments left in argv[].
+ *
+ * In one-shot mode, argv0 is not a program name, argv[] is left
+ * untouched and parse_options() returns the number of options
+ * processed.
  */
 int parse_options(int argc, const char **argv, const char *prefix,
 		  const struct option *options,
-- 
2.20.0.482.g66447595a7

