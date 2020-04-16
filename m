Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B8C352BE
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421362063A
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um7mR4nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393133AbgDPOQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730559AbgDPOPy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 10:15:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1946C061A10
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g16so1305587eds.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ys0LBWyVi3n/oxQCNkcsLHfVSgkRBBMfZkipFhyjIj8=;
        b=um7mR4nTiAqRpXbtwgpRSZR2zkjhl3YxNkEY7hGW/oLzyaOROmPX5jxaptzv/htctf
         Q0tBjE8+O+E2wwbSGBwgnSw1Y98Ll99LJ1tUqCYlb5N8CJSVZYc+79qSnrvpyMKLPx24
         cvCbPU94mEj7hchkJAFMC9+ftolkQNxDhF3pEQUyU0mnH7Rrlzny7Yj/cxjkNTPrPQ7Z
         x0CdnH49SfEUMv1tkykOhsXN8l5liQtddqHWQ+/hmJ97MHlKdSa0J3x6RuL4Y8h45ggp
         wDL5XED5dbitPxYJ9lVLA+cnKQdt+J9/eNO376Tq44kwOklF7eu7eujlKgELTMgw8oht
         c7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ys0LBWyVi3n/oxQCNkcsLHfVSgkRBBMfZkipFhyjIj8=;
        b=qp6/pVQZ+bZKp9gkhcwkmsBNP6KCRNosoIO65JdStwsUD6rN+uSa+d8rMzIz8n3NuJ
         0/FCPRH9jblDoxWtTlpZJOMh++IIRZTahLdYbuw0VKN9dqVUxPZCxjjYyqVIBwMQMJWy
         1RFpVm9mh3CTrTOfEYNNCdFickcYRRpvraauEWUrqfKrUCbScpnY5MxJzQS4mq16Uq7w
         IVezQHi5nTDTAPPRH8BGbrUkSo9Bd62zjYJ6nSdHCvqbexSyt4Ea7468aS0dJlANaRR/
         v0OFWKd3qGKW8DFmG1TgY+VaC1gPqIFvhuCMfyoJufCDCrpY8lSvZR9Drbo2cZJMmTZR
         t7zw==
X-Gm-Message-State: AGi0Puaj89vJlkjpibNze9FWlgsF+79+JPY63I+vNKP7B6Db5Rq9tpOb
        QxPbJS0JnZT2+2cZluOPm9Z9Cgl6
X-Google-Smtp-Source: APiQypLMh4EndNpXIHr3UhfveCGSd4FJ8/SJO7NHJaLznrlYhM9XSokogUaSspy2NNk12NOA06yPUg==
X-Received: by 2002:aa7:d91a:: with SMTP id a26mr30997068edr.236.1587046552098;
        Thu, 16 Apr 2020 07:15:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c19sm3071267ejd.48.2020.04.16.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:15:51 -0700 (PDT)
Message-Id: <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 14:15:49 +0000
Subject: [PATCH v3 2/2] log: add log.excludeDecoration config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 'git log', the --decorate-refs-exclude option appends a pattern
to a string_list. This list is used to prevent showing some refs
in the decoration output, or even by --simplify-by-decoration.

Users may want to use their refs space to store utility refs that
should not appear in the decoration output. For example, Scalar [1]
runs a background fetch but places the "new" refs inside the
refs/scalar/hidden/<remote>/* refspace instead of refs/<remote>/*
to avoid updating remote refs when the user is not looking. However,
these "hidden" refs appear during regular 'git log' queries.

A similar idea to use "hidden" refs is under consideration for core
Git [2].

Add the 'log.excludeDecoration' config option so users can exclude
some refs from decorations by default instead of needing to use
--decorate-refs-exclude manually. The config value is multi-valued
much like the command-line option. The documentation is careful to
point out that the config value can be overridden by the
--decorate-refs option, even though --decorate-refs-exclude would
always "win" over --decorate-refs.

Since the 'log.excludeDecoration' takes lower precedence to
--decorate-refs, and --decorate-refs-exclude takes higher
precedence, the struct decoration_filter needed another field.
This led also to new logic in load_ref_decorations() and
ref_filter_match().

There are several tests in t4202-log.sh that test the
--decorate-refs-(include|exclude) options, so these are extended.
Since the expected output is already stored as a file, most tests
could simply replace a "--decorate-refs-exclude" option with an
in-line config setting. Other tests involve the precedence of
the config option compared to command-line options and needed more
modification.

[1] https://github.com/microsoft/scalar
[2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/

Helped-by: Junio C Hamano <gister@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/log.txt |  6 +++++
 Documentation/git-log.txt    |  5 +++-
 builtin/log.c                | 16 ++++++++++-
 log-tree.c                   | 19 ++++++++++----
 log-tree.h                   |  4 ++-
 t/t4202-log.sh               | 51 +++++++++++++++++++++++++++++++++++-
 6 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index e9e1e397f3f..208d5fdcaa6 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -18,6 +18,12 @@ log.decorate::
 	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
+log.excludeDecoration::
+	Exclude the specified patterns from the log decorations. This is
+	similar to the `--decorate-refs-exclude` command-line option, but
+	the config option can be overridden by the `--decorate-refs`
+	option.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index bed09bb09e5..17592234ba4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -43,7 +43,10 @@ OPTIONS
 	If no `--decorate-refs` is given, pretend as if all refs were
 	included.  For each candidate, do not use it for decoration if it
 	matches any patterns given to `--decorate-refs-exclude` or if it
-	doesn't match any of the patterns given to `--decorate-refs`.
+	doesn't match any of the patterns given to `--decorate-refs`. The
+	`log.excludeDecoration` config option allows excluding refs from
+	the decorations, but an explicit `--decorate-refs` pattern will
+	override a match in `log.excludeDecoration`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e2..72192710dcd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -164,9 +164,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	int quiet = 0, source = 0, mailmap;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {&decorate_refs_include,
-						      &decorate_refs_exclude};
+						      &decorate_refs_exclude,
+						      &decorate_refs_exclude_config};
 	static struct revision_sources revision_sources;
 
 	const struct option builtin_log_options[] = {
@@ -236,7 +238,19 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	}
 
 	if (decoration_style) {
+		const struct string_list *config_exclude =
+			repo_config_get_value_multi(the_repository,
+						    "log.excludeDecoration");
+
+		if (config_exclude) {
+			struct string_list_item *item;
+			for_each_string_list_item(item, config_exclude)
+				string_list_append(&decorate_refs_exclude_config,
+						   item->string);
+		}
+
 		rev->show_decorations = 1;
+
 		load_ref_decorations(&decoration_filter, decoration_style);
 	}
 
diff --git a/log-tree.c b/log-tree.c
index ab6d29a746b..fd3fd3316a1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -103,6 +103,8 @@ static int ref_filter_match(const char *refname,
 	struct string_list_item *item;
 	const struct string_list *exclude_patterns = filter->exclude_ref_pattern;
 	const struct string_list *include_patterns = filter->include_ref_pattern;
+	const struct string_list *exclude_patterns_config =
+				filter->exclude_ref_config_pattern;
 
 	if (exclude_patterns && exclude_patterns->nr) {
 		for_each_string_list_item(item, exclude_patterns) {
@@ -112,17 +114,21 @@ static int ref_filter_match(const char *refname,
 	}
 
 	if (include_patterns && include_patterns->nr) {
-		int found = 0;
 		for_each_string_list_item(item, include_patterns) {
 			if (match_ref_pattern(refname, item)) {
-				found = 1;
-				break;
+				return 1;
 			}
 		}
+		return 0;
+	}
 
-		if (!found)
-			return 0;
+	if (exclude_patterns_config && exclude_patterns_config->nr) {
+		for_each_string_list_item(item, exclude_patterns_config) {
+			if (match_ref_pattern(refname, item))
+				return 0;
+		}
 	}
+
 	return 1;
 }
 
@@ -198,6 +204,9 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 			for_each_string_list_item(item, filter->include_ref_pattern) {
 				normalize_glob_ref(item, NULL, item->string);
 			}
+			for_each_string_list_item(item, filter->exclude_ref_config_pattern) {
+				normalize_glob_ref(item, NULL, item->string);
+			}
 		}
 		decoration_loaded = 1;
 		decoration_flags = flags;
diff --git a/log-tree.h b/log-tree.h
index e6686280746..8fa79289ec6 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -8,7 +8,9 @@ struct log_info {
 };
 
 struct decoration_filter {
-	struct string_list *include_ref_pattern, *exclude_ref_pattern;
+	struct string_list *include_ref_pattern;
+	struct string_list *exclude_ref_pattern;
+	struct string_list *exclude_ref_config_pattern;
 };
 
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 0f766ba65f5..78f9ade6870 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -742,7 +742,23 @@ test_expect_success 'decorate-refs with glob' '
 	octopus-a (octopus-a)
 	reach
 	EOF
+	cat >expect.no-decorate <<-\EOF &&
+	Merge-tag-reach
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b
+	octopus-a
+	reach
+	EOF
+	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs="heads/octopus*" >actual &&
+	test_cmp expect.decorate actual &&
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
+		--decorate-refs-exclude="heads/octopus*" \
+		--decorate-refs="heads/octopus*" >actual &&
+	test_cmp expect.no-decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs="heads/octopus*" >actual &&
 	test_cmp expect.decorate actual
 '
@@ -787,6 +803,9 @@ test_expect_success 'decorate-refs-exclude with glob' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="heads/octopus*" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -801,6 +820,9 @@ test_expect_success 'decorate-refs-exclude without globs' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="tags/reach" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -816,11 +838,19 @@ test_expect_success 'multiple decorate-refs-exclude' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="heads/octopus*" \
 		--decorate-refs-exclude="tags/reach" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" \
+		-c log.excludeDecoration="tags/reach" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="heads/octopus*" log \
+		--decorate-refs-exclude="tags/reach" \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
 test_expect_success 'decorate-refs and decorate-refs-exclude' '
-	cat >expect.decorate <<-\EOF &&
+	cat >expect.no-decorate <<-\EOF &&
 	Merge-tag-reach (master)
 	Merge-tags-octopus-a-and-octopus-b
 	seventh
@@ -831,6 +861,21 @@ test_expect_success 'decorate-refs and decorate-refs-exclude' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs="heads/*" \
 		--decorate-refs-exclude="heads/oc*" >actual &&
+	test_cmp expect.no-decorate actual
+'
+
+test_expect_success 'deocrate-refs and log.excludeDecoration' '
+	cat >expect.decorate <<-\EOF &&
+	Merge-tag-reach (master)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh
+	octopus-b (octopus-b)
+	octopus-a (octopus-a)
+	reach (reach)
+	EOF
+	git -c log.excludeDecoration="heads/oc*" log \
+		--decorate-refs="heads/*" \
+		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.decorate actual
 '
 
@@ -846,6 +891,10 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
 		--simplify-by-decoration >actual &&
+	test_cmp expect.decorate actual &&
+	git -c log.excludeDecoration="*octopus*" log \
+		-n6 --decorate=short --pretty="tformat:%f%d" \
+		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual
 '
 
-- 
gitgitgadget
