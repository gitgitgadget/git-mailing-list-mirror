Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9CC2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F329F21D82
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuo/3L6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393721AbgDPOQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730548AbgDPOPw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 10:15:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E114C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so1381368ejb.9
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=00Fq8NcqNhmK2jNCpYyknDJsphQZcR/l65bOtkRAxWI=;
        b=Wuo/3L6knAkjtu5o9tWzYr8/Lw1JS6Typb/ZnY/U05XokTIT5KHALgGeDncBNdU/AN
         PBYxKh4caNBgivM4vTIrj9W4y9a0gNGZrABLuDbBpVCCA8TsAsmJyqOY3HAYAHm4MWaf
         EFPc4qFJNS0xtXemwrL5p71hjCibCqm7EETqSnhpQQSyeKp0sboO1oLReFdPqOVU29YD
         SuAHsi7FlttpvxjXEdK/sd+bRTP/PQ+kkuhnwPPwR7Tb1RppyGzZPQmfxVemh5Qf0w+v
         7JP7H46//oe5XN7OfTc4KR++OGZXba6ZWHoBj6USmwcg0/Vs/J+8DufiyyaV4qBchTYC
         4LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=00Fq8NcqNhmK2jNCpYyknDJsphQZcR/l65bOtkRAxWI=;
        b=FmEzFekqna0a6W6q1zMFht2am57mCONG3QrjhbIVMJrAvXFR1Q0zQRCpucR0XRzvcb
         rAyxtgMLa45KJMrU66Yodamn4fYMeYdjFuF6lW9yagiLSu8AYNtlB7TQQdEDRcOkBNwv
         9PdnUa+RY8CGogUfgrMl1JfFRg23nqTGG8dzplD9/8z8rNWRs6qZAqvBirssfRwjKqOB
         6Q0vxD8uIl+RoM6XxKE7Isn32BISCCYth+EuTRgRTcWfo9NvWh2ZBo0bGz1956bCehgN
         BNPHNMolJSRCUJ8mV2EWhNszH5Cd4ZQbH7OQGE8/Wf8RmwspcbVVc85X7cY9EoFHNz4a
         FWRw==
X-Gm-Message-State: AGi0PuaHwl2/S2HVvxnwgpbqkGEkCnXNJdL2luW192mUi//HanMXwKCa
        1sWqTa7oLe+pyca2k0Olvilmiqtu
X-Google-Smtp-Source: APiQypLJFz2aLuedq+E0IWtseqfvT0qxmPtun5y6gDcdRj/Os9Xo69whJAxe4XCXXSX8Pw76PTvNSQ==
X-Received: by 2002:a17:906:3709:: with SMTP id d9mr10299838ejc.94.1587046550676;
        Thu, 16 Apr 2020 07:15:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm1317116edo.12.2020.04.16.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:15:50 -0700 (PDT)
Message-Id: <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
In-Reply-To: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 14:15:47 +0000
Subject: [PATCH v3 0/2] log: add log.excludeDecoration config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was something hinted at in the "fetch" step of the background
maintenance RFC. Should be a relatively minor addition to our config
options.

We definitely want this feature for microsoft/git (we would set
log.excludeDecoration=refs/scalar/* in all Scalar repos), but we will wait
for feedback from the community.

Updates in v2:

 * Use for_each_string_list_item()
   
   
 * Update the matching logic to allow --decorate-refs to override the config
   option.
   
   

Updates in v3:

 * Moved and refactored the ref_filter_match() in a preparation patch.
   
   
 * Used Junio's new logic in ref_filter_match()
   
   
 * Updated the config documentation to be more clear.
   
   

Thanks, -Stolee

Derrick Stolee (2):
  log-tree: make ref_filter_match() a helper method
  log: add log.excludeDecoration config option

 Documentation/config/log.txt |  6 ++++
 Documentation/git-log.txt    |  5 +++-
 builtin/log.c                | 16 +++++++++-
 log-tree.c                   | 58 ++++++++++++++++++++++++++++++++++--
 log-tree.h                   |  4 ++-
 refs.c                       | 44 ---------------------------
 refs.h                       | 12 --------
 t/t4202-log.sh               | 51 ++++++++++++++++++++++++++++++-
 8 files changed, 133 insertions(+), 63 deletions(-)


base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-610%2Fderrickstolee%2Flog-exclude-decoration-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-610/derrickstolee/log-exclude-decoration-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/610

Range-diff vs v2:

 -:  ----------- > 1:  6840f8801e4 log-tree: make ref_filter_match() a helper method
 1:  cbdaef4a8e1 ! 2:  96c865e9214 log: add log.excludeDecoration config option
     @@ Commit message
          [1] https://github.com/microsoft/scalar
          [2] https://lore.kernel.org/git/77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com/
      
     +    Helped-by: Junio C Hamano <gister@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/config/log.txt ##
     @@ Documentation/config/log.txt: log.decorate::
       	of the `git log`.
       
      +log.excludeDecoration::
     -+	Exclude the specified patterns from the log decorations. This multi-
     -+	valued config option is the same as the `--decorate-refs-exclude`
     -+	option of `git log`.
     ++	Exclude the specified patterns from the log decorations. This is
     ++	similar to the `--decorate-refs-exclude` command-line option, but
     ++	the config option can be overridden by the `--decorate-refs`
     ++	option.
      +
       log.follow::
       	If `true`, `git log` will act as if the `--follow` option was used when
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
       
      
       ## log-tree.c ##
     -@@ log-tree.c: static int add_ref_decoration(const char *refname, const struct object_id *oid,
     +@@ log-tree.c: static int ref_filter_match(const char *refname,
     + 	struct string_list_item *item;
     + 	const struct string_list *exclude_patterns = filter->exclude_ref_pattern;
     + 	const struct string_list *include_patterns = filter->include_ref_pattern;
     ++	const struct string_list *exclude_patterns_config =
     ++				filter->exclude_ref_config_pattern;
     + 
     + 	if (exclude_patterns && exclude_patterns->nr) {
     + 		for_each_string_list_item(item, exclude_patterns) {
     +@@ log-tree.c: static int ref_filter_match(const char *refname,
     + 	}
     + 
     + 	if (include_patterns && include_patterns->nr) {
     +-		int found = 0;
     + 		for_each_string_list_item(item, include_patterns) {
     + 			if (match_ref_pattern(refname, item)) {
     +-				found = 1;
     +-				break;
     ++				return 1;
     + 			}
     + 		}
     ++		return 0;
     ++	}
       
     - 	if (filter && !ref_filter_match(refname,
     - 			      filter->include_ref_pattern,
     --			      filter->exclude_ref_pattern))
     -+			      filter->exclude_ref_pattern,
     -+			      filter->exclude_ref_config_pattern))
     - 		return 0;
     +-		if (!found)
     +-			return 0;
     ++	if (exclude_patterns_config && exclude_patterns_config->nr) {
     ++		for_each_string_list_item(item, exclude_patterns_config) {
     ++			if (match_ref_pattern(refname, item))
     ++				return 0;
     ++		}
     + 	}
     ++
     + 	return 1;
     + }
       
     - 	if (starts_with(refname, git_replace_ref_base)) {
      @@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flags)
       			for_each_string_list_item(item, filter->include_ref_pattern) {
       				normalize_glob_ref(item, NULL, item->string);
     @@ log-tree.h: struct log_info {
       
       int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
      
     - ## refs.c ##
     -@@ refs.c: static int match_ref_pattern(const char *refname,
     - 
     - int ref_filter_match(const char *refname,
     - 		     const struct string_list *include_patterns,
     --		     const struct string_list *exclude_patterns)
     -+		     const struct string_list *exclude_patterns,
     -+		     const struct string_list *exclude_patterns_config)
     - {
     - 	struct string_list_item *item;
     -+	int found = 0;
     - 
     - 	if (exclude_patterns && exclude_patterns->nr) {
     - 		for_each_string_list_item(item, exclude_patterns) {
     -@@ refs.c: int ref_filter_match(const char *refname,
     - 	}
     - 
     - 	if (include_patterns && include_patterns->nr) {
     --		int found = 0;
     - 		for_each_string_list_item(item, include_patterns) {
     - 			if (match_ref_pattern(refname, item)) {
     - 				found = 1;
     -@@ refs.c: int ref_filter_match(const char *refname,
     - 		if (!found)
     - 			return 0;
     - 	}
     -+
     -+	if (!found &&
     -+	    exclude_patterns_config &&
     -+	    exclude_patterns_config->nr) {
     -+		for_each_string_list_item(item, exclude_patterns_config) {
     -+			if (match_ref_pattern(refname, item))
     -+				return 0;
     -+		}
     -+	}
     -+
     - 	return 1;
     - }
     - 
     -
     - ## refs.h ##
     -@@ refs.h: void normalize_glob_ref(struct string_list_item *item, const char *prefix,
     - 			const char *pattern);
     - 
     - /*
     -- * Returns 0 if refname matches any of the exclude_patterns, or if it doesn't
     -- * match any of the include_patterns. Returns 1 otherwise.
     -+ * Returns 0 if the refname matches any of the exclude_patterns.
     -+ *
     -+ * Returns 0 if include_patterns is non-empty but refname does not match
     -+ * any of those patterns.
     -+ *
     -+ * Returns 0 if refname matches a pattern in exclude_patterns_config but
     -+ * does not match any pattern in inclue_patterns.
     -+ *
     -+ * Otherwise, returns 1.
     -  *
     -- * If pattern list is NULL or empty, matching against that list is skipped.
     -  * This has the effect of matching everything by default, unless the user
     -  * specifies rules otherwise.
     -  */
     - int ref_filter_match(const char *refname,
     - 		     const struct string_list *include_patterns,
     --		     const struct string_list *exclude_patterns);
     -+		     const struct string_list *exclude_patterns,
     -+		     const struct string_list *exclude_patterns_config);
     - 
     - static inline const char *has_glob_specials(const char *pattern)
     - {
     -
       ## t/t4202-log.sh ##
      @@ t/t4202-log.sh: test_expect_success 'decorate-refs with glob' '
       	octopus-a (octopus-a)

-- 
gitgitgadget
