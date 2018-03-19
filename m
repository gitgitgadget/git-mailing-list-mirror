Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4A11F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032333AbeCSV1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:27:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46543 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933614AbeCSQAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id s10so6310251wra.13
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ad91QVvejp8/WCXPKOVo9a8UU5DN3J/tIptAk2MGSjE=;
        b=K4LogFwio87xAO4C058RQ1GaNhM6xcOraklHBUGGGQDxoYP9ByOKeA5C8ULq5uy7PI
         Q+E1fsS37GgFW6zSqAr54EpAtaCA43Nbll2v3fjPYPrZOMRF4gPVfoTidXCMrNBacxbh
         DuWj3NpwQF+IF+Gx1ZllZ8rMu/ZPnfdtfHPzINMtMvsV8KWA9OIAYVbkwDtap2+anRcb
         tXono1i2vddR45AtumefU8BVJ7HPWFkGpIgSast1AUEX/9Qo8IcAWpZNRiuU+CA+5sVd
         5sIEkvIbx0WcXI6vwpzcI76VyLW4Vw+zyhq8fJlOPipxJPPNRU+4wvP0TxagBRU/GYvt
         FLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ad91QVvejp8/WCXPKOVo9a8UU5DN3J/tIptAk2MGSjE=;
        b=bB2R4I0hYUQhndpv2N8ViRb5qbE3693iBcN7c27MSwLoMCzJSWSf+Iwkq2id3E4Eyb
         UQq5FuMDGoLtTgSwIfZoCKgvVgjbdhKSLaDeB98paKRMjo5IqlVvu2D9u16lAE0KefQE
         gcnBgQMhyp692ScMcvNpPe7NLgN7sIfn6VE5N+f6FZGnoueqpMfqn9Uk9h/tB1WqMMTy
         LhzfE1z1XVBwA9/+16xX9qIIi/SdKNKtDovogsBY3+pz8Hc+MD2RdHbUvBbTci9swm2c
         JL/6nhzgICK5LPiP1l64Lf1XZH731NUvQBgamGEuU2qAWLdiDm8ujixfWxCYL3thdlC6
         SnfA==
X-Gm-Message-State: AElRT7EYCCQs86w8ERzxv+oMboc2u5x41PC+OvmNOaJKvoNavrXQboUX
        cQ0lkedsEVx1AnMkqKmtB5X/XA==
X-Google-Smtp-Source: AG47ELvgKVfApVLU2/AL/9sp+Roxyva57bSnLK8d2uC0aygM45nqOeJYZwvQsDZt2oitT/tpHD3y4A==
X-Received: by 10.223.189.131 with SMTP id l3mr9481140wrh.140.1521475209602;
        Mon, 19 Mar 2018 09:00:09 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.11])
        by smtp.gmail.com with ESMTPSA id 96sm401168wrk.54.2018.03.19.09.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 09:00:08 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC][PATCH v5] Make options that expect object ids less chatty if id is invalid
Date:   Mon, 19 Mar 2018 17:59:29 +0200
Message-Id: <20180319155929.7000-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.2.346.g16307f54f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually, the usage should be shown only if the user does not know what
options are available. If the user specifies an invalid value, the user
is already aware of the available options. In this case, there is no
point in displaying the usage anymore.

This patch applies to "git tag --contains", "git branch --contains",
"git branch --points-at", "git for-each-ref --contains" and many more.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/blame.c               |  1 +
 builtin/shortlog.c            |  1 +
 builtin/update-index.c        |  1 +
 parse-options.c               | 20 ++++----
 parse-options.h               |  1 +
 t/t0040-parse-options.sh      |  2 +-
 t/t0041-usage.sh              | 89 +++++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |  6 +--
 8 files changed, 107 insertions(+), 14 deletions(-)
 create mode 100755 t/t0041-usage.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index 9dcb367b9..e8c6a4d6a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -729,6 +729,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	for (;;) {
 		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_DONE:
 			if (ctx.argv[0])
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e29875b84..be4df6a03 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -283,6 +283,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	for (;;) {
 		switch (parse_options_step(&ctx, options, shortlog_usage)) {
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_DONE:
 			goto parse_done;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58d1c2d28..34adf55a7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1059,6 +1059,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			break;
 		switch (parseopt_state) {
 		case PARSE_OPT_HELP:
+		case PARSE_OPT_ERROR:
 			exit(129);
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_DONE:
diff --git a/parse-options.c b/parse-options.c
index d02eb8b01..47c09a82b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -317,14 +317,16 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 		return get_value(p, options, all_opts, flags ^ opt_flags);
 	}
 
-	if (ambiguous_option)
-		return error("Ambiguous option: %s "
+	if (ambiguous_option) {
+		error("Ambiguous option: %s "
 			"(could be --%s%s or --%s%s)",
 			arg,
 			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			ambiguous_option->long_name,
 			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
 			abbrev_option->long_name);
+		return -3;
+	}
 	if (abbrev_option)
 		return get_value(p, abbrev_option, all_opts, abbrev_flags);
 	return -2;
@@ -434,7 +436,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
-	int err = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -459,7 +460,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				goto show_usage_error;
+				return PARSE_OPT_ERROR;
 			case -2:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
@@ -472,7 +473,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			while (ctx->opt) {
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					goto show_usage_error;
+					return PARSE_OPT_ERROR;
 				case -2:
 					if (internal_help && *ctx->opt == 'h')
 						goto show_usage;
@@ -504,9 +505,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			goto show_usage_error;
+			return PARSE_OPT_ERROR;
 		case -2:
 			goto unknown;
+		case -3:
+			goto show_usage;
 		}
 		continue;
 unknown:
@@ -517,10 +520,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	}
 	return PARSE_OPT_DONE;
 
- show_usage_error:
-	err = 1;
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, err);
+	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -539,6 +540,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
+	case PARSE_OPT_ERROR:
 		exit(129);
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
diff --git a/parse-options.h b/parse-options.h
index af711227a..c77bb3b4f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -188,6 +188,7 @@ enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
 	PARSE_OPT_NON_OPTION,
+	PARSE_OPT_ERROR,
 	PARSE_OPT_UNKNOWN
 };
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 0c2fc81d7..04d474c84 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -291,7 +291,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
-	test_i18ncmp expect.err output.err
+	test_must_be_empty output.err
 '
 
 cat >expect <<\EOF
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
new file mode 100755
index 000000000..2fc08ae70
--- /dev/null
+++ b/t/t0041-usage.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='Test commands behavior when given invalid argument value'
+
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	git init . &&
+	test_commit "v1.0" &&
+	git tag "v1.1"
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	git tag --contains "v1.0" >actual &&
+	grep "v1.0" actual &&
+	grep "v1.1" actual
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	test_must_fail git tag --contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag --no-contains <existent_tag>' '
+	git tag --no-contains "v1.1" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'tag --no-contains <inexistent_tag>' '
+	test_must_fail git tag --no-contains "notag" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'tag usage error' '
+	test_must_fail git tag --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'branch --contains <existent_commit>' '
+	git branch --contains "master" >actual &&
+	test_i18ngrep "master" actual
+'
+
+test_expect_success 'branch --contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch --no-contains <existent_commit>' '
+	git branch --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'branch --no-contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'branch usage error' '
+	test_must_fail git branch --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_expect_success 'for-each-ref --contains <existent_object>' '
+	git for-each-ref --contains "master" >actual &&
+	test_line_count = 3 actual
+'
+
+test_expect_success 'for-each-ref --contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref --no-contains <existent_object>' '
+	git for-each-ref --no-contains "master" >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" 2>actual &&
+	test_i18ngrep "error" actual
+'
+
+test_expect_success 'for-each-ref usage error' '
+	test_must_fail git for-each-ref --noopt 2>actual &&
+	test_i18ngrep "usage" actual
+'
+
+test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ef2887bd8..cac8b2bd8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -919,10 +919,8 @@ test_expect_success 'rebase --exec works without -i ' '
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	set_fake_editor &&
-	test_must_fail git rebase -i --exec 2>tmp &&
-	sed -e "1d" tmp >actual &&
-	test_must_fail git rebase -h >expected &&
-	test_cmp expected actual &&
+	test_must_fail git rebase -i --exec 2>actual &&
+	test_i18ngrep "requires a value" actual &&
 	git checkout master
 '
 
-- 
2.16.2.346.g16307f54f.dirty

