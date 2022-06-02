Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5752EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiFBMZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiFBMZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E811021EE
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p10so6243065wrg.12
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN4T6crDo24ZXbBVpTBnPv/JI3comcXsGR9aPYOIN4E=;
        b=H/GRJGumZlC13Rz+H8ssQ/Ks0es6KtkzpLJ+d1xaVNtvAv0WgZxpSccPDgxd7R449D
         CWaN3Lc6mFNxfaJTIfEbv17cWIp4KU+V+qdb+UQTIOIt/7E7k3RssjqJrbW1DID42w3Q
         2tJdqU556Xc2Gp3LR/VvGopo9+OQuIhPIXlhsskspoFstO6jPIPLCakEySuScH3SLqJm
         NPURkIc90YpjsqZ4uOnfr4IX2b8vVRSj20MVKJP4qLo1XWeMRPYW5sMnPBiwMnEUmlFn
         91cFTxcD73NDz7A6DFDCFNfH3y3C1JP/xNG8egdM0nuVQJeCYxMxmLIqb54EJ/JyWInz
         s43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN4T6crDo24ZXbBVpTBnPv/JI3comcXsGR9aPYOIN4E=;
        b=SONqXg/pBbLntVetoS953Zz6ycoaeEdO/o8HwTGysdSXAfSDSssm5SFGWzNnjcP7yA
         lkcAeqrMil53rAn6g8vW4f7WFk0eBwfJ15t681Xp0KawY/hALmVQJU0i+AA6/FokkCcV
         FpBVfLgiitApZ32g48KUlOE8k0Z0LH7wFiOnxg3jlIMGU85iof0bul4FvSJRc/vjbUfO
         C7R2k2QJFAZXKS2n4QmbezTcvDKz8Um6/DH/FAG2ElEzAccVjzl86QA4XG4R0mFE+j3b
         xnWoPJPJ7fLkcwoqTd5IKjXuK8lKHsAsc8FjABULepT9XcwiueGEPW5TxU4K3a71dqpc
         4mhA==
X-Gm-Message-State: AOAM533F6GxT4TeHrJ8iVDjgSJZ+2GU2R363bU2R+FuYYVRXNUZbTAT3
        D5CzVEosJpo85GcDU9DHebU326ix6/AEzQ==
X-Google-Smtp-Source: ABdhPJz83VdRJLGPJ+8B3WqoR3Rb8tDpzISzNYtG8DAsgaiuT6KLBRLxISCzYxty432gkHnV7DkgnQ==
X-Received: by 2002:a5d:6c64:0:b0:20f:f413:8af8 with SMTP id r4-20020a5d6c64000000b0020ff4138af8mr3456005wrz.129.1654172743613;
        Thu, 02 Jun 2022 05:25:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:42 -0700 (PDT)
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
Subject: [PATCH v3 3/6] parse-options.c: use new bug() API for optbug()
Date:   Thu,  2 Jun 2022 14:25:34 +0200
Message-Id: <patch-v3-3.6-3d8a8e95f4d-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
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
2.36.1.1103.gb3ecdfb3e6a

