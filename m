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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D3C64E7D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D8120857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXeqB1Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgKYWNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbgKYWNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:06 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D8C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:06 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so3387560wra.11
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z8Lynq2MuI0q+564gtYy6+RX8SHso0xZGcVDlMLOvdM=;
        b=KXeqB1Cz4ZsQpTeNWr2CVhcJ7x9GmJLnj7+WVyJiROVvr35GBzSeMKvcDHnliG7Jnk
         0b3E5qQtyaXynVJXMqPK93I1BNPSr4lf4oe5PYZ9tRIQryFjv+RELBElLWmljbwN6+Os
         aB6pAnJJnZL/neU5Z1Qoja5Qc2We98ql78CocWj5WvAnmORoGSN0doBWnEG++nUbXWZu
         jH9/JGEJ42PJjawvzKFWXZqNXBEcVjgxUQNclp/4eJ0eLbq/WDmQZBY6txceyWU3mg6u
         SoRL0E0gpim7SPI75yGNHrQ7kLK0XUQ4qn8RZz2EY+K2C1gQA6bejiuqjVEUcPI1rW9f
         l/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z8Lynq2MuI0q+564gtYy6+RX8SHso0xZGcVDlMLOvdM=;
        b=AxZGTmdgFlLZ+7MJqtfW3HxS7MZJsjfpUV0tOzvXLNw1wwO3YA36qzgj4LbgzbEF3V
         g6n3YR8L4Uph9IvUzvHPoi4KocDbwlHkeqVdEOzCr1knLN88KPgkRHcojjuz46ipHJZ6
         paBBTHFnMz98SjuZDvjFZkEaz6/wwuEhmtkuYkYcIsGsVdwRF94bwS4xIyKSU+pMn/HW
         JP6aovhD0bCm7IUd5Z7RThYBiuDCDba9YnBWAE6fcXS9yVhoR4kxTxzv4FlJvgVd6COo
         5ZICgi4tCAcZUy37K33A9S+gGvfjC1ctUIRLohNrXY0ffJiiCUx2hbgwjT/1JbpWNvM0
         MXqQ==
X-Gm-Message-State: AOAM531NFYJGwA7y+c9YEpbYa/yKEv4yoq9mDk6ZANtb4eGj6HxOeI6q
        6GY1iv2CbsUDIU9mNDI6sb5622M1PJg=
X-Google-Smtp-Source: ABdhPJyuszrR+DGONFDabywm1/3y3OroAvvero7srKrN2j3f/YH16Rawgb+BoboFAIDBh7IM3jhXgw==
X-Received: by 2002:adf:f00f:: with SMTP id j15mr64348wro.102.1606342384786;
        Wed, 25 Nov 2020 14:13:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm5583879wmh.44.2020.11.25.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:04 -0800 (PST)
Message-Id: <763401da97289ea00eed372c6ed40ad508781681.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:54 +0000
Subject: [PATCH v3 6/8] config: plumb --fixed-value into config API
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

The git_config_set_multivar_in_file_gently() and related methods now
take a 'flags' bitfield, so add a new bit representing the --fixed-value
option from 'git config'. This alters the purpose of the value_pattern
parameter to be an exact string match. This requires some initialization
changes in git_config_set_multivar_in_file_gently() and a new strcmp()
call in the matches() method.

The new CONFIG_FLAGS_FIXED_VALUE flag is initialized in builtin/config.c
based on the --fixed-value option, and that needs to be updated in
several callers.

This patch only affects some of the modes of 'git config', and the rest
will be completed in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/config.c  | 16 ++++++++++-----
 config.c          |  5 +++++
 config.h          |  7 +++++++
 t/t1300-config.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d0adbed872..8049d8f5fc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -616,6 +616,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
 	char *value;
+	int flags = 0;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -779,6 +780,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			error(_("--fixed-value only applies with 'value-pattern'"));
 			usage_builtin_config();
 		}
+
+		flags |= CONFIG_FLAGS_FIXED_VALUE;
 	}
 
 	if (actions & PAGING_ACTIONS)
@@ -842,7 +845,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2], 0);
+							      argv[0], value, argv[2],
+							      flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
@@ -851,7 +855,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value,
-							      CONFIG_REGEX_NONE, 0);
+							      CONFIG_REGEX_NONE,
+							      flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
@@ -860,7 +865,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -887,7 +892,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1], 0);
+								      argv[0], NULL, argv[1],
+								      flags);
 		else
 			return git_config_set_in_file_gently(given_config_source.file,
 							     argv[0], NULL);
@@ -897,7 +903,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], NULL, argv[1],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/config.c b/config.c
index ac6aace166..d827167d83 100644
--- a/config.c
+++ b/config.c
@@ -2402,6 +2402,7 @@ struct config_store_data {
 	size_t baselen;
 	char *key;
 	int do_not_match;
+	const char *fixed_value;
 	regex_t *value_pattern;
 	int multi_replace;
 	struct {
@@ -2431,6 +2432,8 @@ static int matches(const char *key, const char *value,
 {
 	if (strcmp(key, store->key))
 		return 0; /* not ours */
+	if (store->fixed_value)
+		return !strcmp(store->fixed_value, value);
 	if (!store->value_pattern)
 		return 1; /* always matches */
 	if (store->value_pattern == CONFIG_REGEX_NONE)
@@ -2803,6 +2806,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			store.value_pattern = NULL;
 		else if (value_pattern == CONFIG_REGEX_NONE)
 			store.value_pattern = CONFIG_REGEX_NONE;
+		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
+			store.fixed_value = value_pattern;
 		else {
 			if (value_pattern[0] == '!') {
 				store.do_not_match = 1;
diff --git a/config.h b/config.h
index 8ad1085b74..34901e2b64 100644
--- a/config.h
+++ b/config.h
@@ -269,6 +269,13 @@ int git_config_key_is_valid(const char *key);
  */
 #define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
 
+/*
+ * When CONFIG_FLAGS_FIXED_VALUE is specified, match key/value pairs
+ * by string comparison (not regex match) to the provided value_pattern
+ * parameter.
+ */
+#define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
+
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f6f071006d..413fcbba03 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1991,4 +1991,54 @@ test_expect_success 'refuse --fixed-value for incompatible actions' '
 	test_must_fail git config --file=config --fixed-value --unset-all dev.null
 '
 
+test_expect_success '--fixed-value uses exact string matching' '
+	test_when_finished rm -f config initial &&
+	META="a+b*c?d[e]f.g" &&
+	git config --file=initial fixed.test "$META" &&
+
+	cp initial config &&
+	git config --file=config fixed.test bogus "$META" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=$META
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	cp initial config &&
+	git config --file=config --fixed-value fixed.test bogus "$META" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-\EOF &&
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	cp initial config &&
+	test_must_fail git config --file=config --unset fixed.test "$META" &&
+	git config --file=config --fixed-value --unset fixed.test "$META" &&
+	test_must_fail git config --file=config fixed.test &&
+
+	cp initial config &&
+	test_must_fail git config --file=config --unset-all fixed.test "$META" &&
+	git config --file=config --fixed-value --unset-all fixed.test "$META" &&
+	test_must_fail git config --file=config fixed.test &&
+
+	cp initial config &&
+	git config --file=config --replace-all fixed.test bogus "$META" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=$META
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	git config --file=config --fixed-value --replace-all fixed.test bogus "$META" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=bogus
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

