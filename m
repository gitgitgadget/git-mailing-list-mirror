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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EE4C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D261E20857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHR/JkB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgKYWNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732836AbgKYWNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9B0C061A4F
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:07 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so173510wml.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jIEw+ugPWKoj61LuFUVLRI6qNBF0LnVxvBQcTrUDfY0=;
        b=SHR/JkB4ayNr1YPvyf6AHz/e2xMtm+AMxMblqSQvo/SBZKm7DqR2lNz/WDtmEQpG32
         NwD6mcqflKTVahLDM8cc1oyAuDVBPw95wV6zXbTgWEN8D/izNILbXxg/Z4qFpsk12hUa
         /PSk4NteRhscrxsKNT7ogJ9TPbZkcpTTZKX1w0VE3NCMpAwgqCGOIXGHEZQqf64VxRfD
         PMP4uFHMaern+AK8mdAh9ulCexNbXKWvUvadW56nmAPd+7CEQt9k6qVznXwJSIjCj4+2
         AxKB8vQF6U0y2Yhdhy6PZeo4EWGqA1nTaz4BamkXY2k36uYCF65zgHgUf59en60iyg1T
         Fv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jIEw+ugPWKoj61LuFUVLRI6qNBF0LnVxvBQcTrUDfY0=;
        b=nauEJ2qiYEp2K9vNuJaVxv6nuU17KhfYmR7JBxcoEbIjmiG6r/0kfH+QLpc1tr4Rvr
         wC4a52yT57JCoP+im7QX9eV1lJH9dbqSu6PB8rcViwqgx6UFto9W+APCtXkBv5w12Chb
         l1lsM2dkTERI9+gQxumQngQL7abfWewO9oK3EAyKePqk52Pwj9Zo4nosDP6Yr1QcHE/E
         WjxzIZSm+ZvQ4zxqdOg4u5YHuYgPKby8xo1aCGmdcbSo+EpIOaFPDMru5zpBAJ4azuxk
         F7VGvUfQ7YL0dahpVpYeYXsXxeGl5S3fzEPUrwFl0OOixQ0gCf+ajnG5ZYf8bIsGB57v
         aMsQ==
X-Gm-Message-State: AOAM532jJbyx9o0QVr4pWZop9bXU4S5h7xHwGv+lQ5kEARCAv4jMBT74
        Cn4zNrEAxjnWOeI+nRnhY8Y9E5FLbUc=
X-Google-Smtp-Source: ABdhPJyAs3gsjyUfL94PymGuqnyEB0jahfa/xFjFvgAIdMXW5WQkwm/ztEQnjOeWuPPnB/nx5CbjDQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127mr5320857wmb.169.1606342385909;
        Wed, 25 Nov 2020 14:13:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm6702309wmj.17.2020.11.25.14.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:05 -0800 (PST)
Message-Id: <d813c84275cf3c259ec5fa93b5af822937692c81.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:55 +0000
Subject: [PATCH v3 7/8] config: implement --fixed-value with --get*
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The config builtin does its own regex matching of values for the --get,
--get-all, and --get-regexp modes. Plumb the existing 'flags' parameter
to the get_value() method so we can initialize the value-pattern argument
as a fixed string instead of a regex pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/config.c  | 15 ++++++++++-----
 t/t1300-config.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8049d8f5fc..82e36c595e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -14,6 +14,7 @@ static const char *const builtin_config_usage[] = {
 
 static char *key;
 static regex_t *key_regexp;
+static const char *value_pattern;
 static regex_t *regexp;
 static int show_keys;
 static int omit_values;
@@ -288,6 +289,8 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
+	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
+		return 0;
 	if (regexp != NULL &&
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
@@ -298,7 +301,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 	return format_config(&values->items[values->nr++], key_, value_);
 }
 
-static int get_value(const char *key_, const char *regex_)
+static int get_value(const char *key_, const char *regex_, unsigned flags)
 {
 	int ret = CONFIG_GENERIC_ERROR;
 	struct strbuf_list values = {NULL};
@@ -335,7 +338,9 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	if (regex_) {
+	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
+		value_pattern = regex_;
+	else if (regex_) {
 		if (regex_[0] == '!') {
 			do_not_match = 1;
 			regex_++;
@@ -869,19 +874,19 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
index 413fcbba03..ea38ba9ab1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2041,4 +2041,26 @@ test_expect_success '--fixed-value uses exact string matching' '
 	test_cmp expect actual
 '
 
+test_expect_success '--get and --get-all with --fixed-value' '
+	test_when_finished rm -f config &&
+	META="a+b*c?d[e]f.g" &&
+	git config --file=config fixed.test bogus &&
+	git config --file=config --add fixed.test "$META" &&
+
+	git config --file=config --get fixed.test bogus &&
+	test_must_fail git config --file=config --get fixed.test "$META" &&
+	git config --file=config --get --fixed-value fixed.test "$META" &&
+	test_must_fail git config --file=config --get --fixed-value fixed.test non-existent &&
+
+	git config --file=config --get-all fixed.test bogus &&
+	test_must_fail git config --file=config --get-all fixed.test "$META" &&
+	git config --file=config --get-all --fixed-value fixed.test "$META" &&
+	test_must_fail git config --file=config --get-all --fixed-value fixed.test non-existent &&
+
+	git config --file=config --get-regexp fixed+ bogus &&
+	test_must_fail git config --file=config --get-regexp fixed+ "$META" &&
+	git config --file=config --get-regexp --fixed-value fixed+ "$META" &&
+	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
+'
+
 test_done
-- 
gitgitgadget

