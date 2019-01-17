Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2755F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfAQNGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfAQNGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so4816939pfb.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jQ6Q5LaFfwGW+Y1iEyFiZTJM84bx8MusO2rgGLwENw=;
        b=CRfa9kze/W2uaiOsbjznkz06IAm0yvdqRKpGJ39vFvzdbjn0+nGTBxPL/NlsEFWAzv
         0w6zg1ONYh3g8q9hVaPMVisuy7RVCGLwxL72iqw99Y4mI0wOaCSlISA7o0y5vOWpoO/b
         gr5fc+I06h4iqG2x06jlrCcHrChT9dGGpjh8F/EyCnpmoG1YZ4JcwLiSn63bdmjoFbL7
         LKrBDaRzglcEGYcAzzgVXl5nPixWDjfDpmDnONWiCa8XduCskUIBPJ0/BBoZ1jsYXdWZ
         ABHm2W92Ra4reLOQTmvJTgdu347FxyrnFPnCdMRS6h3Ct8Fe8J29euiyDLvgpamBWw/9
         KReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jQ6Q5LaFfwGW+Y1iEyFiZTJM84bx8MusO2rgGLwENw=;
        b=T8+6gtTrYnogIU6hPE+CQy0PoIYeXUlDjXUyxo6xJ1EZ9+betJE/NOM0KRBvPyjG6K
         yT3EP+MjCro2/HCeHVRXdPtOqG+5bdH4gXf56iKM5f9JxOQQaPFc53lFSV3EceKh/4DO
         o3yZDrozcywnwiERiaQV3D0rNfDwhkdg6S9E7nhD6xSnMuqKuU44ogrNMgDTm3OJxl7P
         MC9SH9Ux9S/hD+TehDLk9UQJ2oG5dkDAP0LeYHK15CrnA6XVAl+1xGx/07EWhSlGIGXB
         tc1SFuXRxUxu63GtKuuLx0rPh7dIyemBmruKm0AQZ75QEbu0w9BLHkd6EP/05qvZY0N5
         wPRg==
X-Gm-Message-State: AJcUukeTqngqBJLOBZkFPttgIOp+n4l1M1VUDrWi76HZ/vkIwytuGHRe
        GwRYn+/rR0qjBOijFbzUcLMd+3e4
X-Google-Smtp-Source: ALg8bN7CMSSHDV7urYdVyT3qE5UYLROS+lEPICat/Xhy/Sg6wF1LVcdrRnk3VDvANXW+X6ND8PLWxw==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr14708901pfd.11.1547730402668;
        Thu, 17 Jan 2019 05:06:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x27sm3629280pfe.178.2019.01.17.05.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/76] parse-options: add one-shot mode
Date:   Thu, 17 Jan 2019 20:05:01 +0700
Message-Id: <20190117130615.18732-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
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
index 9f84bacce6..eb5de0da29 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -416,15 +416,23 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
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
 		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+	if ((flags & PARSE_OPT_ONE_SHOT) &&
+	    (flags & PARSE_OPT_KEEP_ARGV0))
+		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
 }
 
@@ -536,6 +544,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	for (; ctx->argc; ctx->argc--, ctx->argv++) {
 		const char *arg = ctx->argv[0];
 
+		if (ctx->flags & PARSE_OPT_ONE_SHOT &&
+		    ctx->argc != ctx->total)
+			break;
+
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
@@ -610,6 +622,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 		continue;
 unknown:
+		if (ctx->flags & PARSE_OPT_ONE_SHOT)
+			break;
 		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
 			return PARSE_OPT_UNKNOWN;
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
@@ -623,6 +637,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+	if (ctx->flags & PARSE_OPT_ONE_SHOT)
+		return ctx->total - ctx->argc;
+
 	MOVE_ARRAY(ctx->out + ctx->cpidx, ctx->argv, ctx->argc);
 	ctx->out[ctx->cpidx + ctx->argc] = NULL;
 	return ctx->cpidx + ctx->argc;
diff --git a/parse-options.h b/parse-options.h
index f5e7ec7d23..d663b83973 100644
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

