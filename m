Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8607C64E75
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A975E2080A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E65AuErJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgKWQFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732604AbgKWQFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32EC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so3294957wrn.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/mzC/Rybws/oBN+M7CZOHIgfp554qaNQMVxBORSPwoY=;
        b=E65AuErJ8HuVLr+n0kYLofJ8rJ70/HgP44A8gPUIow1BIUmlAgjIfbac6Uwd+b81rg
         vYjSzHIDEg9WSxiCZv/6W52yquqDTB2ie6GacB1tFW8AovgmPr/3tncaGyxVzYNP43FB
         tsa0zYHYo2kMst7tMuMyrE0o3OxwlogJV4mDmiaLhuAyaz6ueWCot+AvjDSCNEMfUPBE
         6Ep0y6bGgepCbn0ksKgSxUjKroqg6aF9+fQuJxQelgUQDovavh0Cs9BagEbXeHAHo4AO
         yWKRtmjJPbBqhMza9oVxsGpDgzfd7T/ec1AkJJizv8LA0NfIYPDaHifedOcH0B+egNCO
         SwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/mzC/Rybws/oBN+M7CZOHIgfp554qaNQMVxBORSPwoY=;
        b=sincRnXogDwFtk2eiVAWYfqUUuR7O4sJ4SAb9bGDcRvE4rM2Q2OfGq5gPByYRuBD6M
         c3N6LEfyc+rm28SgbzJeZHHIZJoomvySHjrx3EX3STn+lPDjR4w1fnbH3sBA1K7DPTS/
         n5h4WIloNuQgK4rNm9ud1DqHGtEBlAmuK9l/BwtJFChHhtHBr3Ju6Ntm8BeVkOQ2fjw3
         Ee2EIM/6p92AVngUuVNpvDB/ApkhuRm0wMqpLuHSsLw7R35hpeyEMBTCksGPqPYAl+sV
         /BGkF3C+CyDuZAo65OouuPUeB43YK7I5Fr0ljmbqTzSwQ/oG9uGJCsTCBIW9aQABTqm9
         DBAw==
X-Gm-Message-State: AOAM532LOuXe3qJhF13gkbBpPDs3Dxc2w6/p/TQiF+Ac1zqtUibq8Omb
        fnQbfCZBLDXx/sQ0MJ2LEXWdHsKT2UU=
X-Google-Smtp-Source: ABdhPJzTe/xyk8tOgSaoOWzTzLognrltgnjexEYONOgu73sGOSdCDcKtrHfpiBDp2Lw0saDw4rl05w==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr348404wrw.139.1606147520789;
        Mon, 23 Nov 2020 08:05:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm19419245wmf.0.2020.11.23.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:20 -0800 (PST)
Message-Id: <8e0111c7b4b2c766c61df30c4ae93bd2d724de06.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:06 +0000
Subject: [PATCH v2 6/7] config: implement --fixed-value with --get*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The config builtin does its own regex matching of values for the --get,
--get-all, and --get-regexp modes. Plumb the existing 'flags' parameter
to the get_value() method so we can initialize the value_regex argument
as a fixed string instead of a regex pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/config.c  | 15 ++++++++++-----
 t/t1300-config.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3e49e04411..d3772b5efe 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -14,6 +14,7 @@ static const char *const builtin_config_usage[] = {
 
 static char *key;
 static regex_t *key_regexp;
+static const char *value_regex;
 static regex_t *regexp;
 static int show_keys;
 static int omit_values;
@@ -288,6 +289,8 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
+	if (fixed_value && strcmp(value_regex, (value_?value_:"")))
+		return 0;
 	if (regexp != NULL &&
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
@@ -298,7 +301,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	return format_config(&values->items[values->nr++], key_, value_);
 }
 
-static int get_value(const char *key_, const char *regex_)
+static int get_value(const char *key_, const char *regex_, int flags)
 {
 	int ret = CONFIG_GENERIC_ERROR;
 	struct strbuf_list values = {NULL};
@@ -335,7 +338,9 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	if (regex_) {
+	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
+		value_regex = regex_;
+	else if (regex_) {
 		if (regex_[0] == '!') {
 			do_not_match = 1;
 			regex_++;
@@ -859,19 +864,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		return get_value(argv[0], argv[1], flags);
 	}
 	else if (actions == ACTION_GET_ALL) {
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		return get_value(argv[0], argv[1], flags);
 	}
 	else if (actions == ACTION_GET_REGEXP) {
 		show_keys = 1;
 		use_key_regexp = 1;
 		do_all = 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1]);
+		return get_value(argv[0], argv[1], flags);
 	}
 	else if (actions == ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 30e80ae9cb..13211b6bf4 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2040,4 +2040,26 @@ test_expect_success '--fixed-value uses exact string matching' '
 	test_cmp expect actual
 '
 
+test_expect_success '--get and --get-all with --fixed-value' '
+	GLOB="a+b*c?d[e]f.g" &&
+	rm -f config &&
+	git config --file=config fixed.test bogus &&
+	git config --file=config --add fixed.test "$GLOB" &&
+
+	git config --file=config --get fixed.test bogus &&
+	test_must_fail git config --file=config --get fixed.test "$GLOB" &&
+	git config --file=config --get --fixed-value fixed.test "$GLOB" &&
+	test_must_fail git config --file=config --get --fixed-value fixed.test non-existent &&
+
+	git config --file=config --get-all fixed.test bogus &&
+	test_must_fail git config --file=config --get-all fixed.test "$GLOB" &&
+	git config --file=config --get-all --fixed-value fixed.test "$GLOB" &&
+	test_must_fail git config --file=config --get-all --fixed-value fixed.test non-existent &&
+
+	git config --file=config --get-regexp fixed+ bogus &&
+	test_must_fail git config --file=config --get-regexp fixed+ "$GLOB" &&
+	git config --file=config --get-regexp --fixed-value fixed+ "$GLOB" &&
+	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
+'
+
 test_done
-- 
gitgitgadget

