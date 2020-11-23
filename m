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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA31C6379F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7174F20782
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Sv0g9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgKWQFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgKWQFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01048C061A4D
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so17737485wmb.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NTmAkIple9ObMNDjIA5o3xByUE1KUlDLtweBnHhzkPc=;
        b=E8Sv0g9Ji6HWMnCgGQw3RAzSKR1fZGwiylda6hNMrD2Lr/g3q0VmSImWWyecrohMpV
         BVg4XIDjmbcikYblgMVCM8vNXozSUH6w9bHyfGlHs3AO2JATwkgkzQN0wwgPSGHxEUID
         GNWbf9lhtZKGuC8YUDsShrRlZl0VTKrw+85w47jMZbGtDVirmBAd+YumlV724TiSP36G
         nLQWwKrBIxqDn6NXQPiboh79STXSkGKKhO663V/tQDekg1eMyujJ2sEJal1BoufwKACp
         urV9tMwMnXKMYdHByqt8N8/YkCKmoBx7ObciqmwMFzw1fdLCar3vivN6I7b7jE56rmRp
         bI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NTmAkIple9ObMNDjIA5o3xByUE1KUlDLtweBnHhzkPc=;
        b=i7OCPbuh7wd8YUCK7vNv9J38jpASxhrWTBGjtgXE71o8l62E4xEtazNHQKc/9tu380
         qMoJ7iP2VWpkNRSHRCzvXx92rMErAoe6y8/bGujD5+HlVPF8MPEvrBgqkjmJMG5b5jND
         gcPphqDjcgKL5UBuZkxWE2isCTkPRscsWLGER4ukcjrjlpf3lTU42Nd/P0muQM0gz/Gb
         9H1tJyrUyVi34Ds4/Ni4RkEc2eKAhDyds2EdKGyKA2a2R67ZTgNJRChZPdqESjoOdgWU
         TPIdKFFHpsAKsjXebc/zTnZ/GGCFrKfpsTb+MLLFwlWos9JHFL8BE7p8aNwB9Ux/AyNn
         JQlA==
X-Gm-Message-State: AOAM531eeC9QuA7PPAX1dKbWcUCRX/H8hAFiK2Ldjw7zfm/LyJsLU4oa
        B87GpZnVd6YLabLZPP3RODK11HBpHmo=
X-Google-Smtp-Source: ABdhPJycb+UwLSQopTOEhSi1Em+6mcURdvTIJ6fvWKh30UAJxnJThg6kHNDJ6x1wgatz9zfK+HQQyw==
X-Received: by 2002:a1c:2b03:: with SMTP id r3mr23649977wmr.184.1606147519385;
        Mon, 23 Nov 2020 08:05:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm19502024wmc.46.2020.11.23.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:18 -0800 (PST)
Message-Id: <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:05 +0000
Subject: [PATCH v2 5/7] config: plumb --fixed-value into config API
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

The git_config_set_multivar_in_file_gently() and related methods now
take a 'flags' bitfield, so add a new bit representing the --fixed-value
option from 'git config'. This alters the purpose of the value_regex
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
 builtin/config.c  | 16 ++++++++-----
 config.c          |  5 +++++
 config.h          |  7 ++++++
 t/t1300-config.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index bfb55a96df..3e49e04411 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -616,6 +616,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
 	char *value;
+	int flags = 0;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -769,6 +770,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			error(_("--fixed-value only applies with 'value_regex'"));
 			usage_builtin_config();
 		}
+
+		flags = CONFIG_FLAGS_FIXED_VALUE;
 	}
 
 	if (actions & PAGING_ACTIONS)
@@ -832,7 +835,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], value, argv[2], 0);
+							      argv[0], value, argv[2],
+							      flags);
 	}
 	else if (actions == ACTION_ADD) {
 		check_write();
@@ -841,7 +845,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value,
-							      CONFIG_REGEX_NONE, 0);
+							      CONFIG_REGEX_NONE,
+							      flags);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
@@ -850,7 +855,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		UNLEAK(value);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], value, argv[2],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -877,7 +882,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1], 0);
+								      argv[0], NULL, argv[1],
+								      flags);
 		else
 			return git_config_set_in_file_gently(given_config_source.file,
 							     argv[0], NULL);
@@ -887,7 +893,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
 							      argv[0], NULL, argv[1],
-							      CONFIG_FLAGS_MULTI_REPLACE);
+							      flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
diff --git a/config.c b/config.c
index 096f2eae0d..64bab2b08e 100644
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
+		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
+			store.literal_value = value_regex;
 		else {
 			if (value_regex[0] == '!') {
 				store.do_not_match = 1;
diff --git a/config.h b/config.h
index 80844604ab..977e690be8 100644
--- a/config.h
+++ b/config.h
@@ -269,6 +269,13 @@ int git_config_key_is_valid(const char *key);
  */
 #define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
 
+/*
+ * When CONFIG_FLAGS_FIXED_VALUE is specified, match key/value pairs
+ * by string comparison (not regex match) to the provided value_regex
+ * parameter.
+ */
+#define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
+
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 6dc8117241..30e80ae9cb 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1983,4 +1983,61 @@ test_expect_success 'refuse --fixed-value for incompatible actions' '
 	test_must_fail git config --file=config --fixed-value --unset-all dev.null
 '
 
+test_expect_success '--fixed-value uses exact string matching' '
+	GLOB="a+b*c?d[e]f.g" &&
+	rm -f initial &&
+	git config --file=initial fixed.test "$GLOB" &&
+
+	cp initial config &&
+	git config --file=config fixed.test bogus "$GLOB" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=$GLOB
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	cp initial config &&
+	git config --file=config --fixed-value fixed.test bogus "$GLOB" &&
+	git config --file=config --list >actual &&
+	printf "fixed.test=bogus\n" >expect &&
+	test_cmp expect actual &&
+
+	cp initial config &&
+	test_must_fail git config --file=config --unset fixed.test "$GLOB" &&
+	git config --file=config --fixed-value --unset fixed.test "$GLOB" &&
+	test_must_fail git config --file=config fixed.test &&
+
+	cp initial config &&
+	test_must_fail git config --file=config --unset-all fixed.test "$GLOB" &&
+	git config --file=config --fixed-value --unset-all fixed.test "$GLOB" &&
+	test_must_fail git config --file=config fixed.test &&
+
+	cp initial config &&
+	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=$GLOB
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	cp initial config &&
+	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
+	git config --file=config --list >actual &&
+	cat >expect <<-EOF &&
+	fixed.test=$GLOB
+	fixed.test=bogus
+	EOF
+	test_cmp expect actual &&
+
+	git config --file=config --fixed-value --replace-all fixed.test bogus "$GLOB" &&
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

