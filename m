Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF1C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCSQ5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCSQ5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:57:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D114217
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so1274471wmq.3
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6w9w5bq3vkK/foMpRrVhwI66oAIXLiuC0qZEivYiyk=;
        b=JeHf8C1eS+PgdCEzSUFpRaE4ik8c8Tw+FwikqTRol9c7ErFksSbBbOCGtFyWD6wf+/
         MaoY9/ORHcZhd4j8cUdmQBpfiRQY8LCZcXOl6LSIw8geTm2h+YLOx2BKBAkdmv/Dj9Gu
         0/Pj3r/SIW7/XEESk6QfeOQgWVZaT8CwJuV30TxwC5CZ29Qj/FV57VhyYVoqb0AzZ1XE
         jYarvds/8xUVLJtXsOS0ylMXRvqhv3a6Vi12Dy1fYFHxw8KWVvkEmePPT4ArYMQuDeV5
         VTt7q0xhEn1zxUYSxkVFz++y1UIyP/SpfHH7enrnMyM9mlv5gLYFmEO06JYnc78RrxyM
         0oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679245017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6w9w5bq3vkK/foMpRrVhwI66oAIXLiuC0qZEivYiyk=;
        b=ZcvFIc/MapU5wgVrZhyx5C6G3j6DoeI0eCS2/YgzILh8rBgyB5wfAV/NSJevoiAeUO
         eifiQCIfPlb/a9qIS1+UWCFhyecVaWM6+b31MMbo7FOZ6BAQwaCMW3UQF7BVq/JAX0pz
         A6xsu8hGsk9cEq7Kq56MOp8DKrd1okBd+4eE2Vuysu0KTms1ll2Y/nfLCQWmsqzJ7+44
         RdFgob+iesCoaLUAjjfrmg7Tn3lNy9S9HLT5zGguSCjnOyNj3rakkwOWKfsYFNWMObtW
         f5xOkaqBOY2XivIaX3fijIh6geDeBOEi6gO5c1Y6emgKKcGpUpFwmTkqSgaxyX5msYOm
         dL4A==
X-Gm-Message-State: AO0yUKX5RobH3Zc8z++lTljyqXe+5WhZLypjJXEoEM2EBL7Flb/r5tj8
        YGxCzZSELDxkN04CX/ZiOw/Ke0PQL/o=
X-Google-Smtp-Source: AK7set+4xrVpVzZ7bojbdf88sytjU4bT4/kTzWCGtC3ml1SWIugTvFbcyth+XLidM/F72R5YWRLEVA==
X-Received: by 2002:a7b:ce8e:0:b0:3ed:9e29:4c38 with SMTP id q14-20020a7bce8e000000b003ed9e294c38mr5893703wmj.31.1679245017103;
        Sun, 19 Mar 2023 09:56:57 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id bd20-20020a05600c1f1400b003e21dcccf9fsm13848568wmb.16.2023.03.19.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:56:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] parse-options.h: use designated initializers in OPT_* macros
Date:   Sun, 19 Mar 2023 17:56:48 +0100
Message-Id: <20230319165648.656738-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
In-Reply-To: <20230319165648.656738-1-szeder.dev@gmail.com>
References: <20230319165648.656738-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use designated initializers in the expansions of the OPT_* macros to
make it more readable which one-letter macro parameter initializes
which field in the resulting 'struct option'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.h | 309 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 243 insertions(+), 66 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 7e99322bab..26f19384e5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -158,71 +158,202 @@ struct option {
 	parse_opt_subcommand_fn *subcommand_fn;
 };
 
-#define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
-				      PARSE_OPT_NOARG|(f), NULL, (b) }
-#define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), (v), NULL, \
-				       (h), PARSE_OPT_NOARG|(f) }
-#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
-					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
+#define OPT_BIT_F(s, l, v, h, b, f) { \
+	.type = OPTION_BIT, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG|(f), \
+	.callback = NULL, \
+	.defval = (b), \
+}
+#define OPT_COUNTUP_F(s, l, v, h, f) { \
+	.type = OPTION_COUNTUP, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG|(f), \
+}
+#define OPT_SET_INT_F(s, l, v, h, i, f) { \
+	.type = OPTION_SET_INT, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG | (f), \
+	.defval = (i), \
+}
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
-#define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
-#define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
-#define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
+#define OPT_CALLBACK_F(s, l, v, a, h, f, cb) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.flags = (f), \
+	.callback = (cb), \
+}
+#define OPT_STRING_F(s, l, v, a, h, f) { \
+	.type = OPTION_STRING, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.flags = (f), \
+}
+#define OPT_INTEGER_F(s, l, v, h, f) { \
+	.type = OPTION_INTEGER, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = (f), \
+}
 
-#define OPT_END()                   { OPTION_END }
-#define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
+#define OPT_END() { \
+	.type = OPTION_END, \
+}
+#define OPT_GROUP(h) { \
+	.type = OPTION_GROUP, \
+	.help = (h), \
+}
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
-#define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
-					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
-					    (set), NULL, (clear) }
-#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_BITOP(s, l, v, h, set, clear) { \
+	.type = OPTION_BITOP, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG|PARSE_OPT_NONEG, \
+	.defval = (set), \
+	.extra = (clear), \
+}
+#define OPT_NEGBIT(s, l, v, h, b) { \
+	.type = OPTION_NEGBIT, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG, \
+	.defval = (b), \
+}
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
 #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
-#define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE_F(s, l, v, h, i, f)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), NULL, (i) }
+#define OPT_HIDDEN_BOOL(s, l, v, h) { \
+	.type = OPTION_SET_INT, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, \
+	.defval = 1, \
+}
+#define OPT_CMDMODE_F(s, l, v, h, i, f) { \
+	.type = OPTION_SET_INT, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), \
+	.defval = (i), \
+}
 #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
 
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
-#define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
-				      N_("n"), (h), PARSE_OPT_NONEG }
+#define OPT_MAGNITUDE(s, l, v, h) { \
+	.type = OPTION_MAGNITUDE, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = PARSE_OPT_NONEG, \
+}
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
-#define OPT_STRING_LIST(s, l, v, a, h) \
-				    { OPTION_CALLBACK, (s), (l), (v), (a), \
-				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
-#define OPT_EXPIRY_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
-	  parse_opt_expiry_date_cb }
+#define OPT_STRING_LIST(s, l, v, a, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.callback = &parse_opt_string_list, \
+}
+#define OPT_UYN(s, l, v, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG, \
+	.callback = &parse_opt_tertiary, \
+}
+#define OPT_EXPIRY_DATE(s, l, v, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("expiry-date"), \
+	.help = (h), \
+	.callback = parse_opt_expiry_date_cb, \
+}
 #define OPT_CALLBACK(s, l, v, a, h, cb) OPT_CALLBACK_F(s, l, v, a, h, 0, cb)
-#define OPT_NUMBER_CALLBACK(v, h, cb) \
-	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
-	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (cb) }
-#define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
-				       N_("file"), (h) }
-#define OPT_COLOR_FLAG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
-		parse_opt_color_flag_cb, (intptr_t)"always" }
+#define OPT_NUMBER_CALLBACK(v, h, cb) { \
+	.type = OPTION_NUMBER, \
+	.value = (v), \
+	.help = (h), \
+	.flags = PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
+	.callback = (cb), \
+}
+#define OPT_FILENAME(s, l, v, h) { \
+	.type = OPTION_FILENAME, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("file"), \
+	.help = (h), \
+}
+#define OPT_COLOR_FLAG(s, l, v, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("when"), \
+	.help = (h), \
+	.flags = PARSE_OPT_OPTARG, \
+	.callback = parse_opt_color_flag_cb, \
+	.defval = (intptr_t)"always", \
+}
 
-#define OPT_NOOP_NOARG(s, l) \
-	{ OPTION_CALLBACK, (s), (l), NULL, NULL, \
-	  N_("no-op (backward compatibility)"),		\
-	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
+#define OPT_NOOP_NOARG(s, l) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.help = N_("no-op (backward compatibility)"), \
+	.flags = PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, \
+	.callback = parse_opt_noop_cb, \
+}
 
-#define OPT_ALIAS(s, l, source_long_name) \
-	{ OPTION_ALIAS, (s), (l), (source_long_name) }
+#define OPT_ALIAS(s, l, source_long_name) { \
+	.type = OPTION_ALIAS, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (source_long_name), \
+}
 
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
 	.type = OPTION_SUBCOMMAND, \
 	.long_name = (l), \
 	.value = (v), \
 	.flags = (f), \
-	.subcommand_fn = (fn) }
+	.subcommand_fn = (fn), \
+}
 #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
 
 /*
@@ -358,34 +489,80 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-#define OPT__VERBOSITY(var) \
-	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
-	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
-	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
-	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
+#define OPT__VERBOSITY(var) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = 'v', \
+	.long_name = "verbose", \
+	.value = (var), \
+	.help = N_("be more verbose"), \
+	.flags = PARSE_OPT_NOARG, \
+	.callback = &parse_opt_verbosity_cb, \
+}, { \
+	.type = OPTION_CALLBACK, \
+	.short_name = 'q', \
+	.long_name = "quiet", \
+	.value = (var), \
+	.help = N_("be more quiet"), \
+	.flags = PARSE_OPT_NOARG, \
+	.callback = &parse_opt_verbosity_cb, \
+}
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
 #define OPT__FORCE(var, h, f) OPT_COUNTUP_F('f', "force",   (var), (h), (f))
-#define OPT__ABBREV(var)  \
-	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
-	  N_("use <n> digits to display object names"),	\
-	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
+#define OPT__ABBREV(var) { \
+	.type = OPTION_CALLBACK, \
+	.long_name = "abbrev", \
+	.value = (var), \
+	.argh = N_("n"), \
+	.help = N_("use <n> digits to display object names"), \
+	.flags = PARSE_OPT_OPTARG, \
+	.callback = &parse_opt_abbrev_cb, \
+}
 #define OPT__SUPER_PREFIX(var) \
 	OPT_STRING_F(0, "super-prefix", (var), N_("prefix"), \
 		N_("prefixed path to initial superproject"), PARSE_OPT_HIDDEN)
 
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
-#define OPT_COLUMN(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
-#define OPT_PASSTHRU(s, l, v, a, h, f) \
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru }
-#define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) \
-	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
-#define _OPT_CONTAINS_OR_WITH(l, v, h, f) \
-	{ OPTION_CALLBACK, 0, (l), (v), N_("commit"), (h), \
-	  PARSE_OPT_LASTARG_DEFAULT | (f), \
-	  parse_opt_commits, (intptr_t) "HEAD" \
-	}
+#define OPT_COLUMN(s, l, v, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("style"), \
+	.help = (h), \
+	.flags = PARSE_OPT_OPTARG, \
+	.callback = parseopt_column_callback, \
+}
+#define OPT_PASSTHRU(s, l, v, a, h, f) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.flags = (f), \
+	.callback = parse_opt_passthru, \
+}
+#define OPT_PASSTHRU_ARGV(s, l, v, a, h, f) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.flags = (f), \
+	.callback = parse_opt_passthru_argv, \
+}
+#define _OPT_CONTAINS_OR_WITH(l, v, h, f) { \
+	.type = OPTION_CALLBACK, \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = N_("commit"), \
+	.help = (h), \
+	.flags = PARSE_OPT_LASTARG_DEFAULT | (f), \
+	.callback = parse_opt_commits, \
+	.defval = (intptr_t) "HEAD", \
+}
 #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
-- 
2.40.0.499.g88fa0b00d2

