Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850131F404
	for <e@80x24.org>; Thu, 22 Mar 2018 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCVSoz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 14:44:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45225 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeCVSoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 14:44:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id h2so9743070wre.12
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wogdp1/VpCT9PKy6bjsBt2W4ZOcRwlJUxR27+yh0CcY=;
        b=lMEWGyRZScbnHbP8MlKVqdqjGvA7ZNNz2ZDQ9bj6zkNXwtD89+p3VwFaTinmUSxi3O
         lV0QpvDB7IOuYmp3tS3NVuQkMg1+RdC38U8T8u4nPPulVTosWob3np30Zf9Ov09rkQAd
         /Y9Z29Y0BzQSE0KDteFYlxN4VITKfhxzAywY5WWtDcFE0Wm+7ZRVAS4zmMgLXL43i21g
         k71yJD8O45H+HNoAZFCII5OHjkOMvKM7hhiDXhE1FHs56GV/pqtN7f9gN4jIkDT0WJtt
         22Ux9/xaNGS8Ctl5R5/tx83izNC2fsCwJPs0mcByu00rDZ+WGX2o9wIDjEbDrwTxHIsi
         sIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wogdp1/VpCT9PKy6bjsBt2W4ZOcRwlJUxR27+yh0CcY=;
        b=btPmPVFC1qr3cXSJVPVBy0tNSnA+g4e/vT5hEf6teY/ECiXoqJQ+SDTZ0VnBoBNORw
         nD6lLa4Z/vXx+FHPScfDuTkECGSzB0WquO/5Bsy1nm0w7nZZ8uUe3HJNK99+y/7d/Hbk
         ISqM+qmA16WsLi3x11M3fZM8ncHvqRISUgbPx7eKKIE/NVo2GDu4LpJ/O5IxmPWdBL4w
         /qCgTwAHa3sGT/1OlCOhnsGmS4VK7BoxtmWiSQfapqdwN/XwpBnTsBSSlS3DwW6JsfZh
         Rm+X4gbyxFmxg7vdZPa1XyMNCj9NpxiWHlC2TfZklqRGlOQoI3QWp2ffHGcaW4SEXsat
         Zieg==
X-Gm-Message-State: AElRT7G9l4GE2XmwUvoWO+ANc1Ceaa3hxysub0Ashei1SDoyrl7gdlI/
        MTsJ5CR6bnBWmgmUCqkde2SdCw==
X-Google-Smtp-Source: AG47ELsiiktQYU6PPKDTr8MeCh2i8+JYS8zgCXQNzoclCpkT0MC3owHdrk3cGEaWtp653/FnPV/s6w==
X-Received: by 10.223.133.182 with SMTP id 51mr19125470wrt.226.1521744292654;
        Thu, 22 Mar 2018 11:44:52 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.10])
        by smtp.gmail.com with ESMTPSA id k1sm9010716wrf.66.2018.03.22.11.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 11:44:51 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC][PATCH v7] parse-options: do not show usage upon invalid option value
Date:   Thu, 22 Mar 2018 20:43:51 +0200
Message-Id: <20180322184351.2392-1-ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.16.2.680.g81703d34b
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

The only differences between this patch and the previous one [1] are
related to t/t0041-usage.sh tests, based on Junio's feedback.

[1] https://public-inbox.org/git/20180320175005.18759-1-ungureanupaulsebastian@gmail.com/

 builtin/blame.c               |   1 +
 builtin/shortlog.c            |   1 +
 builtin/update-index.c        |   1 +
 parse-options.c               |  20 ++++---
 parse-options.h               |   1 +
 t/t0040-parse-options.sh      |   2 +-
 t/t0041-usage.sh              | 107 ++++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   6 +-
 8 files changed, 125 insertions(+), 14 deletions(-)
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
index 125e84f98..0f7059a8a 100644
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
@@ -476,7 +478,6 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
-	int err = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
 	ctx->opt = NULL;
@@ -505,7 +506,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
-				goto show_usage_error;
+				return PARSE_OPT_ERROR;
 			case -2:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
@@ -518,7 +519,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			while (ctx->opt) {
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
-					goto show_usage_error;
+					return PARSE_OPT_ERROR;
 				case -2:
 					if (internal_help && *ctx->opt == 'h')
 						goto show_usage;
@@ -550,9 +551,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
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
@@ -563,10 +566,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	}
 	return PARSE_OPT_DONE;
 
- show_usage_error:
-	err = 1;
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, err);
+	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -585,6 +586,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
+	case PARSE_OPT_ERROR:
 		exit(129);
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
diff --git a/parse-options.h b/parse-options.h
index ab1cc362b..dd14911a2 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -200,6 +200,7 @@ enum {
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
index 000000000..5b927b76f
--- /dev/null
+++ b/t/t0041-usage.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='Test commands behavior when given invalid argument value'
+
+. ./test-lib.sh
+
+test_expect_success 'setup ' '
+	test_commit "v1.0"
+'
+
+test_expect_success 'tag --contains <existent_tag>' '
+	git tag --contains "v1.0" >actual 2>actual.err &&
+	grep "v1.0" actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'tag --contains <inexistent_tag>' '
+	test_must_fail git tag --contains "notag" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'tag --no-contains <existent_tag>' '
+	git tag --no-contains "v1.0" >actual 2>actual.err  &&
+	test_line_count = 0 actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'tag --no-contains <inexistent_tag>' '
+	test_must_fail git tag --no-contains "notag" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'tag usage error' '
+	test_must_fail git tag --noopt >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "usage" actual.err
+'
+
+test_expect_success 'branch --contains <existent_commit>' '
+	git branch --contains "master" >actual 2>actual.err &&
+	test_i18ngrep "master" actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'branch --contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'branch --no-contains <existent_commit>' '
+	git branch --no-contains "master" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'branch --no-contains <inexistent_commit>' '
+	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'branch usage error' '
+	test_must_fail git branch --noopt >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "usage" actual.err
+'
+
+test_expect_success 'for-each-ref --contains <existent_object>' '
+	git for-each-ref --contains "master" >actual 2>actual.err &&
+	test_line_count = 2 actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'for-each-ref --contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'for-each-ref --no-contains <existent_object>' '
+	git for-each-ref --no-contains "master" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_line_count = 0 actual.err
+'
+
+test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
+	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "error" actual.err &&
+	test_i18ngrep ! "usage" actual.err
+'
+
+test_expect_success 'for-each-ref usage error' '
+	test_must_fail git for-each-ref --noopt >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_i18ngrep "usage" actual.err
+'
+
+test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3b905406d..c59d0384f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -927,10 +927,8 @@ test_expect_success 'rebase --exec works without -i ' '
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
2.16.2.680.g81703d34b

