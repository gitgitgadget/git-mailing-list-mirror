Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8314EC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbiEaQ7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbiEaQ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4169731
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so11442562wrb.0
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ewv5VJNagEHLL6yRxGV/cAQ+Z7Jha3ZxcyIs3rX5RMM=;
        b=L/ANpRhU536Cn5wWcyTY4sh+c2qMCesq/Fd02r5q2HeCWM2KMebieh4rSZR2ydJMFQ
         5WZz2gtf0S6RHF1+LZItp2lsURMeLH1pxcANSplqtOzUEVvpraO129/xYltRLbecDhgp
         AmNfysJaREs/QOdYr43lvN09u8BEMYg+7FfvCwkc86ll4R8dYrE/dcsIEsy9TxgPk/Hg
         HzxuEGwEQ2zZPz7brt28M8butBofanCmF3IKGz3JnK/3r2LV75FAiK4Q6AxlARZFviWx
         8BUlH752Mgg/WIup3QIu4wiHQr/11CT/dCfLmGBMT2OVa+WTCQH486OCfeEzbNpWg2bI
         csKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ewv5VJNagEHLL6yRxGV/cAQ+Z7Jha3ZxcyIs3rX5RMM=;
        b=K/GNYwyDRDS/F6hVtOv6mLf9uMLB6LXWbecTC0ybGTs0fsWsEc6yydMChePmoqZBvg
         QmocDXVgI3iK9t3aXkiTbS4sKN5Dt7X2k6Y7c4h4oc6FOhySYw7JUGhM0G7V5IRxVq7L
         dAVMZ+ltcwuhsK8AW3A00qXvA3I5Ct2sxPFEl3IJyU01GyXmXQUD6IK9ErOhUaBtQFKX
         q4vqIqv6T1AHAws6I33T2wMaiMTetXgWERF1E1/o37BkeTaW+iT55AT5jJ2d9kKTlKWB
         i+acKhzPmHUzex9002xx5T8Jy6F7dAGzd2QY0MKkCO6FYaeXoE/iSmk4PzyMkRcLvSn+
         15rA==
X-Gm-Message-State: AOAM531wCNkzkK6TEbnHGEJtZChR//5vlGbLUKtfLNZIESrg0BH9IVgq
        POxuYuVq3xlNnKlgPhFo+yBRroGK0Wc/Dw==
X-Google-Smtp-Source: ABdhPJwnDYELW6pwWSLg880xcqsIEiWJ1h+tsTbTSN84Gp0l7ULv7nydonLqI4CX07J6At5KW+teTg==
X-Received: by 2002:a05:6000:1542:b0:20f:f809:cf89 with SMTP id 2-20020a056000154200b0020ff809cf89mr29185848wry.361.1654016346646;
        Tue, 31 May 2022 09:59:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] parse-options.c: use new bug() API for optbug()
Date:   Tue, 31 May 2022 18:58:45 +0200
Message-Id: <patch-v2-3.6-4a7089fbbf2-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run into bugs in parse-options.c usage it's good to be able to
note all the issues we ran into before dying. This use-case is why we
have the optbug() function introduced in 1e5ce570ca3 (parse-options:
clearer reporting of API misuse, 2010-12-02)

Let's change this code to use the new bug() API introduced in the
preceding commit, which cuts down on the verbosity of
parse_options_check().

There are existing uses of BUG() in adjacent code that should have
been using optbug() that aren't being changed here. That'll be done in
a subsequent commit. This only changes the optbug() callers.

Since this will invoke BUG() the previous exit(128) code will be
changed, but in this case that's what we want, i.e. to have
encountering a BUG() return the specific "BUG" exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6e57744fd22..78b46ae9698 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -14,15 +14,15 @@ enum opt_parsed {
 	OPT_UNSET = 1<<1,
 };
 
-static int optbug(const struct option *opt, const char *reason)
+static void optbug(const struct option *opt, const char *reason)
 {
-	if (opt->long_name) {
-		if (opt->short_name)
-			return error("BUG: switch '%c' (--%s) %s",
-				     opt->short_name, opt->long_name, reason);
-		return error("BUG: option '%s' %s", opt->long_name, reason);
-	}
-	return error("BUG: switch '%c' %s", opt->short_name, reason);
+	if (opt->long_name && opt->short_name)
+		bug("switch '%c' (--%s) %s", opt->short_name,
+		    opt->long_name, reason);
+	else if (opt->long_name)
+		bug("option '%s' %s", opt->long_name, reason);
+	else
+		bug("switch '%c' %s", opt->short_name, reason);
 }
 
 static const char *optname(const struct option *opt, enum opt_parsed flags)
@@ -441,28 +441,27 @@ static void check_typos(const char *arg, const struct option *options)
 
 static void parse_options_check(const struct option *opts)
 {
-	int err = 0;
 	char short_opts[128];
 
 	memset(short_opts, '\0', sizeof(short_opts));
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
-			err |= optbug(opts, "uses incompatible flags "
-					"LASTARG_DEFAULT and OPTARG");
+			optbug(opts, "uses incompatible flags "
+			       "LASTARG_DEFAULT and OPTARG");
 		if (opts->short_name) {
 			if (0x7F <= opts->short_name)
-				err |= optbug(opts, "invalid short name");
+				optbug(opts, "invalid short name");
 			else if (short_opts[opts->short_name]++)
-				err |= optbug(opts, "short name already used");
+				optbug(opts, "short name already used");
 		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
 		     !(opts->flags & PARSE_OPT_NONEG) ||
 		     opts->long_name))
-			err |= optbug(opts, "uses feature "
-					"not supported for dashless options");
+			optbug(opts, "uses feature "
+			       "not supported for dashless options");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
@@ -471,7 +470,7 @@ static void parse_options_check(const struct option *opts)
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
-				err |= optbug(opts, "should not accept an argument");
+				optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
 			if (!opts->callback && !opts->ll_callback)
@@ -494,10 +493,9 @@ static void parse_options_check(const struct option *opts)
 		}
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
-			err |= optbug(opts, "multi-word argh should use dash to separate words");
+			optbug(opts, "multi-word argh should use dash to separate words");
 	}
-	if (err)
-		exit(128);
+	BUG_if_bug("invalid 'struct option'");
 }
 
 static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
-- 
2.36.1.1100.g16130010d07

