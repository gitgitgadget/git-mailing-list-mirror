Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E4C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBF3214D8
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0jymrKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414876AbgDOPoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414847AbgDOPo1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 11:44:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D38C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:44:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i7so5496722edq.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZXwcY/td26iol/E53SNrgVix89S9T6ctgKOL5Yu2O0Q=;
        b=a0jymrKSafg81Wj1aok74kQlnyfhoYkhBdYWU1L1L0y0ZT0Ux3kM0ff2ysZZfuA0wi
         O8GfZtgsFLSZEd+QTrBtr7nBa41fjxzytGVicC2YkAN7JlMlySBjXvQT0PrgLDiHXIge
         74eyWANPzoyq9+rZY89h2lg9spC1jdkNhOSu5OkzjUnbUbI1CfcjKvfO8Tw16ilSX5An
         HhuKzJoltUrC6uTtc1+btl1Ludn8wl5tX499J4O6vN7KBStcLZiCNZtTBpImHcFLIFtz
         g23R4t7tyvcSA5tMg3o3HibQwp7N4injvgqaH1GjB9PXKAY03JIyS9ujfdD/G4tDd/PZ
         pmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZXwcY/td26iol/E53SNrgVix89S9T6ctgKOL5Yu2O0Q=;
        b=nZj9EUtl/zZKSH19XKh132nLuUws0ylu/l8MzoUunuJvYGlTpG4f6W30GWGCuJcUjg
         i1M3GDpXu9A5l34B0mYjOjqMBCDedzp5vojtdFdbB/0XNuS/RzGVXkYa7Kwh2c8zwidN
         WovcVivVRHVPlqw1KK2IWzFoM97tbGx+Ermh4OjYwnODRE179sM4bLyH/j3Iu4UXwBup
         oHR3K1SxQO/0r8LFtkQJZpHT7N/onyNu7N3tjREwC2O16VzDp50ocT3kT+thLNOXR2Eq
         ng0alEREk9hdPZP81nT/cf5lsi57/OUBra3U5uC4jYvSL+Q5ySx6oPta9tLZG+4OA3Ds
         UHMg==
X-Gm-Message-State: AGi0PubfuA22DJTOUq4vEJHexqmW/a0GIhu9pUsVibBVj0jrkQHSk9I8
        4mUW4T72y+QRPr8d5XgchKmMmuPx
X-Google-Smtp-Source: APiQypJEKRWzFYZHxvs6/BTVaTNiSLKYxWETygQ9cuqBqc9M7S7fSv0G5xEuyDKVADmYNT7fhpMazA==
X-Received: by 2002:a17:906:69d1:: with SMTP id g17mr5580647ejs.32.1586965465023;
        Wed, 15 Apr 2020 08:44:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hh1sm2559985ejb.46.2020.04.15.08.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:44:24 -0700 (PDT)
Message-Id: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
In-Reply-To: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 15:44:22 +0000
Subject: [PATCH v2] log: add log.excludeDecoration config option
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    log: add log.excludeDecoration config option
    
    This was something hinted at in the "fetch" step of the background
    maintenance RFC. Should be a relatively minor addition to our config
    options.
    
    We definitely want this feature for microsoft/git (we would set
    log.excludeDecoration=refs/scalar/* in all Scalar repos), but we will
    wait for feedback from the community.
    
    Updates in v2:
    
     * Use for_each_string_list_item()
       
       
     * Update the matching logic to allow --decorate-refs to override the
       config option.
       
       
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-610%2Fderrickstolee%2Flog-exclude-decoration-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-610/derrickstolee/log-exclude-decoration-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/610

Range-diff vs v1:

 1:  6aa81243c1f ! 1:  cbdaef4a8e1 log: add log.excludeDecoration config option
     @@ Commit message
          Add the 'log.excludeDecoration' config option so users can exclude
          some refs from decorations by default instead of needing to use
          --decorate-refs-exclude manually. The config value is multi-valued
     -    much like the command-line option.
     +    much like the command-line option. The documentation is careful to
     +    point out that the config value can be overridden by the
     +    --decorate-refs option, even though --decorate-refs-exclude would
     +    always "win" over --decorate-refs.
     +
     +    Since the 'log.excludeDecoration' takes lower precedence to
     +    --decorate-refs, and --decorate-refs-exclude takes higher
     +    precedence, the struct decoration_filter needed another field.
     +    This led also to new logic in load_ref_decorations() and
     +    ref_filter_match().
      
          There are several tests in t4202-log.sh that test the
          --decorate-refs-(include|exclude) options, so these are extended.
     -    Since the expected output is already stored as a file, simply add
     -    new calls that replace a "--decorate-refs-exclude" option with an
     -    in-line config setting.
     +    Since the expected output is already stored as a file, most tests
     +    could simply replace a "--decorate-refs-exclude" option with an
     +    in-line config setting. Other tests involve the precedence of
     +    the config option compared to command-line options and needed more
     +    modification.
      
          [1] https://github.com/microsoft/scalar
          [2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/
     @@ Documentation/config/log.txt: log.decorate::
       	If `true`, `git log` will act as if the `--follow` option was used when
       	a single <path> is given.  This has the same limitations as `--follow`,
      
     + ## Documentation/git-log.txt ##
     +@@ Documentation/git-log.txt: OPTIONS
     + 	If no `--decorate-refs` is given, pretend as if all refs were
     + 	included.  For each candidate, do not use it for decoration if it
     + 	matches any patterns given to `--decorate-refs-exclude` or if it
     +-	doesn't match any of the patterns given to `--decorate-refs`.
     ++	doesn't match any of the patterns given to `--decorate-refs`. The
     ++	`log.excludeDecoration` config option allows excluding refs from
     ++	the decorations, but an explicit `--decorate-refs` pattern will
     ++	override a match in `log.excludeDecoration`.
     + 
     + --source::
     + 	Print out the ref name given on the command line by which each
     +
       ## builtin/log.c ##
     +@@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
     + 	int quiet = 0, source = 0, mailmap;
     + 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
     + 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
     ++	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
     + 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
     + 	struct decoration_filter decoration_filter = {&decorate_refs_include,
     +-						      &decorate_refs_exclude};
     ++						      &decorate_refs_exclude,
     ++						      &decorate_refs_exclude_config};
     + 	static struct revision_sources revision_sources;
     + 
     + 	const struct option builtin_log_options[] = {
      @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
       	}
       
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
      +
      +		if (config_exclude) {
      +			struct string_list_item *item;
     -+			for (item = config_exclude->items;
     -+			     item && item < config_exclude->items + config_exclude->nr;
     -+			     item++)
     -+				string_list_append(&decorate_refs_exclude,
     -+						item->string);
     ++			for_each_string_list_item(item, config_exclude)
     ++				string_list_append(&decorate_refs_exclude_config,
     ++						   item->string);
      +		}
      +
       		rev->show_decorations = 1;
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
       	}
       
      
     + ## log-tree.c ##
     +@@ log-tree.c: static int add_ref_decoration(const char *refname, const struct object_id *oid,
     + 
     + 	if (filter && !ref_filter_match(refname,
     + 			      filter->include_ref_pattern,
     +-			      filter->exclude_ref_pattern))
     ++			      filter->exclude_ref_pattern,
     ++			      filter->exclude_ref_config_pattern))
     + 		return 0;
     + 
     + 	if (starts_with(refname, git_replace_ref_base)) {
     +@@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flags)
     + 			for_each_string_list_item(item, filter->include_ref_pattern) {
     + 				normalize_glob_ref(item, NULL, item->string);
     + 			}
     ++			for_each_string_list_item(item, filter->exclude_ref_config_pattern) {
     ++				normalize_glob_ref(item, NULL, item->string);
     ++			}
     + 		}
     + 		decoration_loaded = 1;
     + 		decoration_flags = flags;
     +
     + ## log-tree.h ##
     +@@ log-tree.h: struct log_info {
     + };
     + 
     + struct decoration_filter {
     +-	struct string_list *include_ref_pattern, *exclude_ref_pattern;
     ++	struct string_list *include_ref_pattern;
     ++	struct string_list *exclude_ref_pattern;
     ++	struct string_list *exclude_ref_config_pattern;
     + };
     + 
     + int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
     +
     + ## refs.c ##
     +@@ refs.c: static int match_ref_pattern(const char *refname,
     + 
     + int ref_filter_match(const char *refname,
     + 		     const struct string_list *include_patterns,
     +-		     const struct string_list *exclude_patterns)
     ++		     const struct string_list *exclude_patterns,
     ++		     const struct string_list *exclude_patterns_config)
     + {
     + 	struct string_list_item *item;
     ++	int found = 0;
     + 
     + 	if (exclude_patterns && exclude_patterns->nr) {
     + 		for_each_string_list_item(item, exclude_patterns) {
     +@@ refs.c: int ref_filter_match(const char *refname,
     + 	}
     + 
     + 	if (include_patterns && include_patterns->nr) {
     +-		int found = 0;
     + 		for_each_string_list_item(item, include_patterns) {
     + 			if (match_ref_pattern(refname, item)) {
     + 				found = 1;
     +@@ refs.c: int ref_filter_match(const char *refname,
     + 		if (!found)
     + 			return 0;
     + 	}
     ++
     ++	if (!found &&
     ++	    exclude_patterns_config &&
     ++	    exclude_patterns_config->nr) {
     ++		for_each_string_list_item(item, exclude_patterns_config) {
     ++			if (match_ref_pattern(refname, item))
     ++				return 0;
     ++		}
     ++	}
     ++
     + 	return 1;
     + }
     + 
     +
     + ## refs.h ##
     +@@ refs.h: void normalize_glob_ref(struct string_list_item *item, const char *prefix,
     + 			const char *pattern);
     + 
     + /*
     +- * Returns 0 if refname matches any of the exclude_patterns, or if it doesn't
     +- * match any of the include_patterns. Returns 1 otherwise.
     ++ * Returns 0 if the refname matches any of the exclude_patterns.
     ++ *
     ++ * Returns 0 if include_patterns is non-empty but refname does not match
     ++ * any of those patterns.
     ++ *
     ++ * Returns 0 if refname matches a pattern in exclude_patterns_config but
     ++ * does not match any pattern in inclue_patterns.
     ++ *
     ++ * Otherwise, returns 1.
     +  *
     +- * If pattern list is NULL or empty, matching against that list is skipped.
     +  * This has the effect of matching everything by default, unless the user
     +  * specifies rules otherwise.
     +  */
     + int ref_filter_match(const char *refname,
     + 		     const struct string_list *include_patterns,
     +-		     const struct string_list *exclude_patterns);
     ++		     const struct string_list *exclude_patterns,
     ++		     const struct string_list *exclude_patterns_config);
     + 
     + static inline const char *has_glob_specials(const char *pattern)
     + {
     +
       ## t/t4202-log.sh ##
     +@@ t/t4202-log.sh: test_expect_success 'decorate-refs with glob' '
     + 	octopus-a (octopus-a)
     + 	reach
     + 	EOF
     ++	cat >expect.no-decorate <<-\EOF &&
     ++	Merge-tag-reach
     ++	Merge-tags-octopus-a-and-octopus-b
     ++	seventh
     ++	octopus-b
     ++	octopus-a
     ++	reach
     ++	EOF
     ++	git log -n6 --decorate=short --pretty="tformat:%f%d" \
     ++		--decorate-refs="heads/octopus*" >actual &&
     ++	test_cmp expect.decorate actual &&
     + 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
     ++		--decorate-refs-exclude="heads/octopus*" \
     ++		--decorate-refs="heads/octopus*" >actual &&
     ++	test_cmp expect.no-decorate actual &&
     ++	git -c log.excludeDecoration="heads/octopus*" log \
     ++		-n6 --decorate=short --pretty="tformat:%f%d" \
     + 		--decorate-refs="heads/octopus*" >actual &&
     + 	test_cmp expect.decorate actual
     + '
      @@ t/t4202-log.sh: test_expect_success 'decorate-refs-exclude with glob' '
       	EOF
       	git log -n6 --decorate=short --pretty="tformat:%f%d" \
     @@ t/t4202-log.sh: test_expect_success 'multiple decorate-refs-exclude' '
       	test_cmp expect.decorate actual
       '
       
     + test_expect_success 'decorate-refs and decorate-refs-exclude' '
     +-	cat >expect.decorate <<-\EOF &&
     ++	cat >expect.no-decorate <<-\EOF &&
     + 	Merge-tag-reach (master)
     + 	Merge-tags-octopus-a-and-octopus-b
     + 	seventh
      @@ t/t4202-log.sh: test_expect_success 'decorate-refs and decorate-refs-exclude' '
       	git log -n6 --decorate=short --pretty="tformat:%f%d" \
       		--decorate-refs="heads/*" \
       		--decorate-refs-exclude="heads/oc*" >actual &&
     -+	test_cmp expect.decorate actual &&
     ++	test_cmp expect.no-decorate actual
     ++'
     ++
     ++test_expect_success 'deocrate-refs and log.excludeDecoration' '
     ++	cat >expect.decorate <<-\EOF &&
     ++	Merge-tag-reach (master)
     ++	Merge-tags-octopus-a-and-octopus-b
     ++	seventh
     ++	octopus-b (octopus-b)
     ++	octopus-a (octopus-a)
     ++	reach (reach)
     ++	EOF
      +	git -c log.excludeDecoration="heads/oc*" log \
      +		--decorate-refs="heads/*" \
      +		-n6 --decorate=short --pretty="tformat:%f%d" >actual &&


 Documentation/config/log.txt |  5 ++++
 Documentation/git-log.txt    |  5 +++-
 builtin/log.c                | 16 ++++++++++-
 log-tree.c                   |  6 ++++-
 log-tree.h                   |  4 ++-
 refs.c                       | 15 +++++++++--
 refs.h                       | 15 ++++++++---
 t/t4202-log.sh               | 51 +++++++++++++++++++++++++++++++++++-
 8 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index e9e1e397f3f..1a158324f79 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -18,6 +18,11 @@ log.decorate::
 	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
+log.excludeDecoration::
+	Exclude the specified patterns from the log decorations. This multi-
+	valued config option is the same as the `--decorate-refs-exclude`
+	option of `git log`.
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
index 52127427ffe..bd8d4c07bb8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -90,7 +90,8 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 	if (filter && !ref_filter_match(refname,
 			      filter->include_ref_pattern,
-			      filter->exclude_ref_pattern))
+			      filter->exclude_ref_pattern,
+			      filter->exclude_ref_config_pattern))
 		return 0;
 
 	if (starts_with(refname, git_replace_ref_base)) {
@@ -155,6 +156,9 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
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
diff --git a/refs.c b/refs.c
index 1ab0bb54d3d..63d8b569333 100644
--- a/refs.c
+++ b/refs.c
@@ -339,9 +339,11 @@ static int match_ref_pattern(const char *refname,
 
 int ref_filter_match(const char *refname,
 		     const struct string_list *include_patterns,
-		     const struct string_list *exclude_patterns)
+		     const struct string_list *exclude_patterns,
+		     const struct string_list *exclude_patterns_config)
 {
 	struct string_list_item *item;
+	int found = 0;
 
 	if (exclude_patterns && exclude_patterns->nr) {
 		for_each_string_list_item(item, exclude_patterns) {
@@ -351,7 +353,6 @@ int ref_filter_match(const char *refname,
 	}
 
 	if (include_patterns && include_patterns->nr) {
-		int found = 0;
 		for_each_string_list_item(item, include_patterns) {
 			if (match_ref_pattern(refname, item)) {
 				found = 1;
@@ -362,6 +363,16 @@ int ref_filter_match(const char *refname,
 		if (!found)
 			return 0;
 	}
+
+	if (!found &&
+	    exclude_patterns_config &&
+	    exclude_patterns_config->nr) {
+		for_each_string_list_item(item, exclude_patterns_config) {
+			if (match_ref_pattern(refname, item))
+				return 0;
+		}
+	}
+
 	return 1;
 }
 
diff --git a/refs.h b/refs.h
index 545029c6d80..7cec33303d7 100644
--- a/refs.h
+++ b/refs.h
@@ -362,16 +362,23 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 			const char *pattern);
 
 /*
- * Returns 0 if refname matches any of the exclude_patterns, or if it doesn't
- * match any of the include_patterns. Returns 1 otherwise.
+ * Returns 0 if the refname matches any of the exclude_patterns.
+ *
+ * Returns 0 if include_patterns is non-empty but refname does not match
+ * any of those patterns.
+ *
+ * Returns 0 if refname matches a pattern in exclude_patterns_config but
+ * does not match any pattern in inclue_patterns.
+ *
+ * Otherwise, returns 1.
  *
- * If pattern list is NULL or empty, matching against that list is skipped.
  * This has the effect of matching everything by default, unless the user
  * specifies rules otherwise.
  */
 int ref_filter_match(const char *refname,
 		     const struct string_list *include_patterns,
-		     const struct string_list *exclude_patterns);
+		     const struct string_list *exclude_patterns,
+		     const struct string_list *exclude_patterns_config);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
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
 

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
