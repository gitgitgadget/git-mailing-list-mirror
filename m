Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B0C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiKDN0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiKDNZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A52FFD2
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x2so7610576edd.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKusFQLb1DWa/HlXidk0/KiTUv3NQWC6oGAaBfVspaI=;
        b=ODdwbIt7BrTbmrNmG5RMvUvc8oJxH6o7ufRIYH7FKTrQ9LsR73vUYI3O01UMzLO2pW
         2iumeVqelh8LNp5GSHAJQGxuqW8fxS2LPZNHnf299XgdhOl+krxvdQpvbCz6+aUHsGA7
         XVpqo+K+Osd112d1L1jkk9mz0b7JUAn7a99vizEOamPXp3GfKRCN+kgmxbV3OC/QR/ry
         m983ejmCJ5KmfrgRZuv/i2vDCayiuHZ+lNz7nVtf6bzS+w0iPjCsSkoDzsgSNEqjdnkR
         NXI2tDIymWurnTwarM0rt/ogtD4aJao43fYvT8s+Lf9r+PgLQ8hIxu5Cf+A1zN9ZTmkP
         jCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKusFQLb1DWa/HlXidk0/KiTUv3NQWC6oGAaBfVspaI=;
        b=mlFR+yFyGtBTA02mSqVEPWpYf7F1W4dQpysjJqA4KlOvQk56NOj1rkuVlxcusDw1o/
         5y7CN8dTROfrzDT4tm28dfmB3IDMXhVmtr4A+6IdHge0jwqVxW14ysplXnF5RiWStIov
         e4rpsDqQMhNcdDc3nHbo1vvY2J2SCUaW+1meSnE4NMx5vWsotlwDP7Y5xCbvjgGqW04H
         NgpCfasRg17yiWQ2nDP3PPD3gN09mzGZIKT/UnU2dfY5pLNl3lHkQX1Lp21nB8xbB+PW
         i98oZdGwtBWarbNWvQPQQG7TC1KGxVG3pfH4Yb/1CgF9qGhQNQZCu8W6sKft/JLDvaAb
         IcPw==
X-Gm-Message-State: ACrzQf2vYPM5ewEZ6Z3bRdjRTbhx4eGGdqvtAuFbjebazmqHdCyL7Iyz
        FrTqF4rQJXjmxMYIs2NRROqczyAaCKGXWQ==
X-Google-Smtp-Source: AMsMyM5XwuB/UDdwpP4Q03MRm8lgV3lIQZEMFPfxSiN5vQtOP437OQELVnR7yYFPxDNblb6XOsTkpw==
X-Received: by 2002:a05:6402:187:b0:464:163b:36b8 with SMTP id r7-20020a056402018700b00464163b36b8mr12298279edv.213.1667568301279;
        Fri, 04 Nov 2022 06:25:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:25:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND() to one *_fn  type
Date:   Fri,  4 Nov 2022 14:22:46 +0100
Message-Id: <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the OPT_SUBCOMMAND() API was implemented in [1] it did so by
adding a new "subcommand_fn" member to "struct option", rather than
allowing the user of the API to pick the type of the function.

An advantage of mandating that "parse_opt_subcommand_fn" must be used
is that we'll get type checking for the function we're passing in, a
disadvantage is that we can't convert e.g. "builtin/bisect--helper.c"
easily to it, as its callbacks need their own argument.

Let's generalize this interface, while leaving in place a small hack
to give the existing API users their type safety. We assign to
"typecheck_subcommand_fn", but don't subsequently use it for
anything. Instead we use the "defval" and "value" members.

A subsequent commit will add a OPT_SUBCOMMAND() variant where the
"callback" isn't our default "parse_options_pick_subcommand" (and that
caller won't be able to use the type checking).

1. fa83cc834da (parse-options: add support for parsing subcommands,
   2022-08-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c |  9 ++++++---
 parse-options.h | 25 +++++++++++++++++++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a1ec932f0f9..1d9e46c9dc7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -427,7 +427,8 @@ static enum parse_opt_result parse_subcommand(const char *arg,
 	for (; options->type != OPTION_END; options++)
 		if (options->type == OPTION_SUBCOMMAND &&
 		    !strcmp(options->long_name, arg)) {
-			*(parse_opt_subcommand_fn **)options->value = options->subcommand_fn;
+			if (options->callback(options, arg, 0))
+				BUG("OPT_SUBCOMMAND callback returning non-zero");
 			return PARSE_OPT_SUBCOMMAND;
 		}
 
@@ -506,8 +507,10 @@ static void parse_options_check(const struct option *opts)
 			       "That case is not supported yet.");
 			break;
 		case OPTION_SUBCOMMAND:
-			if (!opts->value || !opts->subcommand_fn)
-				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand function");
+			if (!opts->value || !opts->callback)
+				optbug(opts, "OPTION_SUBCOMMAND needs a value and a callback function");
+			if (opts->ll_callback)
+				optbug(opts, "OPTION_SUBCOMMAND uses callback, not ll_callback");
 			if (!subcommand_value)
 				subcommand_value = opts->value;
 			else if (subcommand_value != opts->value)
diff --git a/parse-options.h b/parse-options.h
index b6ef86e0d15..61e3016c3fc 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
  *			 the option takes optional argument.
  *
  * `callback`::
- *   pointer to the callback to use for OPTION_CALLBACK
+ *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SUBCOMMAND.
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
  *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
+ *   OPTION_SUBCOMMAND stores the pointer the function selected for
+ *   the subcommand.
+ *
  *   CALLBACKS can use it like they want.
  *
  * `ll_callback`::
  *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
  *
  * `subcommand_fn`::
- *   pointer to a function to use for OPTION_SUBCOMMAND.
- *   It will be put in value when the subcommand is given on the command line.
+ *   pointer to the callback used with OPT_SUBCOMMAND() and
+ *   OPT_SUBCOMMAND_F(). Internally we store the same value in
+ *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
+ *   common case type safety.
  */
 struct option {
 	enum parse_opt_type type;
@@ -217,12 +222,24 @@ struct option {
 #define OPT_ALIAS(s, l, source_long_name) \
 	{ OPTION_ALIAS, (s), (l), (source_long_name) }
 
+static inline int parse_options_pick_subcommand_cb(const struct option *option,
+						   const char *arg UNUSED,
+						   int unset UNUSED)
+{
+	parse_opt_subcommand_fn *fn = (parse_opt_subcommand_fn *)option->defval;
+	*(parse_opt_subcommand_fn **)option->value = fn;
+	return 0;
+}
+
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
 	.type = OPTION_SUBCOMMAND, \
 	.long_name = (l), \
 	.value = (v), \
 	.flags = (f), \
-	.subcommand_fn = (fn) }
+	.defval = (intptr_t)(fn), \
+	.subcommand_fn = (fn), \
+	.callback = parse_options_pick_subcommand_cb, \
+}
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
 
 /*
-- 
2.38.0.1452.g710f45c7951

