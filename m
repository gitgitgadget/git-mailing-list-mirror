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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486F3C6379F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE59246E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTdm17/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgKSPwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgKSPwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF3CC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:29 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so7189035wmb.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OWQ3v9UyitTFDicPlXh4ba1drpNyBkVGV5aCa53kYGI=;
        b=ZTdm17/QvEk5Bw21aK0rngQzUquddxt2Yrdd5gzwWSfnRbfDcTomNOj+PdrP2X5toA
         K5qu6TEb5k53nf9+Oa1UuWfkin6LJQ4vi9zJN1bKnttpDPv4HIhOjWM+xBGmkK+sjbZ6
         BMi8pqtz308x62T0BB9QqXhOQBUsnmhKJtjEYv9rxYDHyvQWOkdDmR+BaSmJSpqSMvsm
         qIFAEVsUWzzG3Xr/Py318bq5vmtPOV4rschulPvZVypvtpwOt8BXDBoKcqplYHKRBBNP
         3vok+r0HTp1bNEgPWoDHsZ0wRqAitFvC53eGWVtDBtQ0Mp0iE0B+2b3IAs7h3Lz7/Tu+
         yxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OWQ3v9UyitTFDicPlXh4ba1drpNyBkVGV5aCa53kYGI=;
        b=Ttk1MyknUOh8P1cxgBfDDmSa15OdGD7BShQ9cAmuWOCOyOAH4cZofXMp3i/+M5y68U
         nTBfShW2bPgGy8u/GjZkFu7WMM1MrAi18A1Wr5NBXUiGw5C9vCog/BLcxrWPI3ed5ogw
         +JHGGSaJJVvjqirF7MHtJWcTvA/j03DGO+QSlpT4MYOaNmUqdm8ZcI5MG5aW0EEufvtQ
         mprR+oJpEKsEfkiBRTpooUlDeCWZ7NXFFyyWccp2Yh1M2rLNlCoggBqqPNgz6P2Yz7ZN
         ubri7cjp6hcoFgRBOdGfiBAIRLvqZZiEAzUSI6Lp+3yNu8HPH02rwVJhNrOBmjKf/Jwj
         O9OQ==
X-Gm-Message-State: AOAM532ra8TPXqD21xy7iCVpFD+fXmCQVg2/UhKkMQdK83MTnuJggqGR
        18IGhlUEz79SXRgU3veOHYWYoyQtAYs=
X-Google-Smtp-Source: ABdhPJyvJ9REJCsmD2jOerhV0GoS3Jg6D/HX9uyE5DyRqssMUiAud0luIpAvX2bJyeiaGVbhVAJqYQ==
X-Received: by 2002:a1c:44f:: with SMTP id 76mr5375874wme.181.1605801148178;
        Thu, 19 Nov 2020 07:52:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm489047wmi.1.2020.11.19.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:27 -0800 (PST)
Message-Id: <5881b2d987e3e8575d054a64fe21fbe7e7967aba.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:21 +0000
Subject: [PATCH 5/7] config: plumb --literal-value into config API
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

The git_config_set_multivar_in_file_gently() and related methods now
take a 'flags' bitfield, so add a new bit representing the
--literal-value option from 'git config'. This alters the purpose of the
value_regex parameter to be an exact string match. This requires some
initialization changes in git_config_set_multivar_in_file_gently() and a
new strcmp() call in the matches() method.

The new CONFIG_FLAGS_LITERAL_VALUE flag is initialized in
builtin/config.c based on the --literal-value option, and that needs to
be updated in several callers.

This patch only affects some of the modes of 'git config', and the rest
will be completed in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/config.c  | 16 +++++++++++-----
 config.c          |  5 +++++
 config.h          |  7 +++++++
 t/t1300-config.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ad6c695737..6ab5a0d68f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -626,6 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
 	char *value;
+	int flags = 0;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -761,6 +762,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		error(_("--literal only applies with 'value_regex'"));
 		usage_builtin_config();
 	}
+	if (literal)
+		flags = CONFIG_FLAGS_LITERAL_VALUE;
 
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
@@ -823,7 +826,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2], 0);
+							      argv[0], value, argv[2],
+							      flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
@@ -832,7 +836,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value,
-							      CONFIG_REGEX_NONE, 0);
+							      CONFIG_REGEX_NONE,
+							      flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
@@ -841,7 +846,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -868,7 +873,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1], 0);
+								      argv[0], NULL, argv[1],
+								      flags);
 		else
 			return git_config_set_in_file_gently(given_config_source.file,
 							     argv[0], NULL);
@@ -878,7 +884,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], NULL, argv[1],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/config.c b/config.c
index 4841c68a91..5028c1e736 100644
--- a/config.c
+++ b/config.c
@@ -2402,6 +2402,7 @@ struct config_store_data {
 	size_t baselen;
 	char *key;
 	int do_not_match;
+	const char *literal_value;
 	regex_t *value_regex;
 	int multi_replace;
 	struct {
@@ -2431,6 +2432,8 @@ static int matches(const char *key, const char *value,
 {
 	if (strcmp(key, store->key))
 		return 0; /* not ours */
+	if (store->literal_value)
+		return !strcmp(store->literal_value, value);
 	if (!store->value_regex)
 		return 1; /* always matches */
 	if (store->value_regex == CONFIG_REGEX_NONE)
@@ -2803,6 +2806,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			store.value_regex = NULL;
 		else if (value_regex == CONFIG_REGEX_NONE)
 			store.value_regex = CONFIG_REGEX_NONE;
+		else if (flags & CONFIG_FLAGS_LITERAL_VALUE)
+			store.literal_value = value_regex;
 		else {
 			if (value_regex[0] == '!') {
 				store.do_not_match = 1;
diff --git a/config.h b/config.h
index 266eb22e46..ddb81e1e32 100644
--- a/config.h
+++ b/config.h
@@ -77,6 +77,13 @@ enum config_event_t {
  */
 #define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
 
+/*
+ * When CONFIG_FLAGS_LITERAL_VALUE is specified, match key/value pairs
+ * by string comparison (not regex match) to the provided value_regex
+ * parameter.
+ */
+#define CONFIG_FLAGS_LITERAL_VALUE (1 << 1)
+
 /*
  * The parser event function (if not NULL) is called with the event type and
  * the begin/end offsets of the parsed elements.
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 73f5ca4361..ed12b4f7a0 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1978,4 +1978,52 @@ test_expect_success 'refuse --literal-value for incompatible actions' '
 	test_must_fail git config --literal-value --edit
 '
 
+test_expect_success '--literal-value uses exact string matching' '
+	GLOB="a+b*c?d[e]f.g" &&
+	q_to_tab >initial <<-EOF &&
+	[literal]
+	Qtest = $GLOB
+	EOF
+
+	cp initial .git/config &&
+	git config literal.test bogus "$GLOB" &&
+	q_to_tab >expect <<-EOF &&
+	[literal]
+	Qtest = $GLOB
+	Qtest = bogus
+	EOF
+	test_cmp expect .git/config &&
+	cp initial .git/config &&
+	git config --literal-value literal.test bogus "$GLOB" &&
+	q_to_tab >expect <<-EOF &&
+	[literal]
+	Qtest = bogus
+	EOF
+	test_cmp expect .git/config &&
+
+	cp initial .git/config &&
+	test_must_fail git config --unset literal.test "$GLOB" &&
+	git config --literal-value --unset literal.test "$GLOB" &&
+	test_must_fail git config literal.test &&
+
+	cp initial .git/config &&
+	test_must_fail git config --unset-all literal.test "$GLOB" &&
+	git config --literal-value --unset-all literal.test "$GLOB" &&
+	test_must_fail git config literal.test &&
+
+	cp initial .git/config &&
+	git config --replace-all literal.test bogus "$GLOB" &&
+	q_to_tab >expect <<-EOF &&
+	[literal]
+	Qtest = $GLOB
+	Qtest = bogus
+	EOF
+	test_cmp expect .git/config &&
+
+	cp initial .git/config &&
+	git config --replace-all literal.test bogus "$GLOB" &&
+	git config --literal-value --replace-all literal.test bogus "$GLOB" &&
+	test_cmp_config bogus literal.test
+'
+
 test_done
-- 
gitgitgadget

