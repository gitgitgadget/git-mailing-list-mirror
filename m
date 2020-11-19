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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2325EC64E7B
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B085D22256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS4Qxh/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgKSPwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgKSPwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DCC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so7002995wrt.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wnPa/yXaCbLPuMwyJevPtUDswrTQEOLursxTVQ0r5yU=;
        b=KS4Qxh/pCQxnGC43EYhwVdY6KbYF2Vs7Gmw1/194tD/Jbzai6ohE+PNVonkLFdgvY5
         WA2cjByIfnohcUozcXB9mHU9DBkbVH6WpLVISkf3WyzAtYNVqPOheAWiDgHWYOwXzyuw
         x3/cu0H1Tkgyo+eP1MKTIBSh/tCG5MiiFnmWJPV9cKaPVywT1bypVWCEV2obrPMA7JA+
         TcokfrfdVFxpGn7ueZ/MI/glpBtkqgKmLx37rMCVzsIybDzXNrVEVjhDTyoH7Kmem8fI
         jJdT0akShbDJ9JjxVMUC0SMRo+jS5W2yuaWIbDuo+nln7Rre+LM/2K8tja+4aD8YVmoJ
         pYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wnPa/yXaCbLPuMwyJevPtUDswrTQEOLursxTVQ0r5yU=;
        b=BBLUyBt8R5s+rYTZNlu6K6G03qo+DOZa/dj2iKPV87NeXPVDulct+AXdrl8I8WU+d7
         dOsxEZkL76oy70xjqe1GRlN1bgt6IujOEWLf8iZB80izv3uBvuBjOVwYJYSVS2fAM2LS
         rSSZIm6OlRwpu8DU9rtqjLyR3XWv4Zvo+zOPcOkK2KdR4TKk119O72VzJA540Ix6amSL
         v0yET8F1dkc+50HSAgUq6yqen2ZUs4qRjuCMqOU1ACX551ZL9zgdcMKHnkFkjUDiEFG+
         BNxs37yzxTLA14NKapLUUmrugKtlmh/6YWTyRBWX7Gty3IS20DoLCpoaWsFkUG54djep
         1byw==
X-Gm-Message-State: AOAM530zbuGF/4XM+k5ecN5EZnyuljF9f8hmhsytEuCSvCXJJPurRfxU
        BXXwX71KIuC4t/xHilRF6DC//5QYUag=
X-Google-Smtp-Source: ABdhPJxIpNKSlQnbNFM9VY2j/4ctsarGcSHt4mS2FgBlzL+TP2fURWGo8g8nmmbIl/oor43dEEaAzQ==
X-Received: by 2002:a5d:614e:: with SMTP id y14mr11718738wrt.25.1605801148974;
        Thu, 19 Nov 2020 07:52:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm499781wmf.0.2020.11.19.07.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:28 -0800 (PST)
Message-Id: <7c8e3769c723405a421de3b44b4c90ce48b26e4d.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:22 +0000
Subject: [PATCH 6/7] config: implement --literal-value with --get*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
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
 t/t1300-config.sh | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6ab5a0d68f..1d5cfab8f1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -14,6 +14,7 @@ static const char *const builtin_config_usage[] = {
 
 static char *key;
 static regex_t *key_regexp;
+static const char *value_regex;
 static regex_t *regexp;
 static int show_keys;
 static int omit_values;
@@ -298,6 +299,8 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
+	if (literal && strcmp(value_regex, (value_?value_:"")))
+		return 0;
 	if (regexp != NULL &&
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
@@ -308,7 +311,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	return format_config(&values->items[values->nr++], key_, value_);
 }
 
-static int get_value(const char *key_, const char *regex_)
+static int get_value(const char *key_, const char *regex_, int flags)
 {
 	int ret = CONFIG_GENERIC_ERROR;
 	struct strbuf_list values = {NULL};
@@ -345,7 +348,9 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	if (regex_) {
+	if (regex_ && (flags & CONFIG_FLAGS_LITERAL_VALUE))
+		value_regex = regex_;
+	else if (regex_) {
 		if (regex_[0] == '!') {
 			do_not_match = 1;
 			regex_++;
@@ -850,19 +855,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
index ed12b4f7a0..8531d01c7c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2026,4 +2026,28 @@ test_expect_success '--literal-value uses exact string matching' '
 	test_cmp_config bogus literal.test
 '
 
+test_expect_success '--get and --get-all with --literal-value' '
+	GLOB="a+b*c?d[e]f.g" &&
+	q_to_tab >.git/config <<-EOF &&
+	[literal]
+	Qtest = bogus
+	Qtest = $GLOB
+	EOF
+
+	git config --get literal.test bogus &&
+	test_must_fail git config --get literal.test "$GLOB" &&
+	git config --get --literal-value literal.test "$GLOB" &&
+	test_must_fail git config --get --literal-value literal.test non-existent &&
+
+	git config --get-all literal.test bogus &&
+	test_must_fail git config --get-all literal.test "$GLOB" &&
+	git config --get-all --literal-value literal.test "$GLOB" &&
+	test_must_fail git config --get-all --literal-value literal.test non-existent &&
+
+	git config --get-regexp literal+ bogus &&
+	test_must_fail git config  --get-regexp literal+ "$GLOB" &&
+	git config --get-regexp --literal-value literal+ "$GLOB" &&
+	test_must_fail git config --get-regexp --literal-value literal+ non-existent
+'
+
 test_done
-- 
gitgitgadget

