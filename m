Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7CC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C921D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 03:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkAm2mM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIJDJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIJDHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 23:07:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B881C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 20:07:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so4963531wrn.13
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5AP+HJvqFxbvUyGCiRZD5l7c6wOcPZsNQWobITwgQig=;
        b=AkAm2mM+yAj/CP4a8iquIpD8e0rWaKt7us5hCIF0r2kYs6L48aBb2BRXhFDKad7bWD
         Nc7j5zLk86lps6uhYGmhOJ2ZGoOMhVOVCZ80owBdcNnvdoFYxMccF07BWIRFFEXMM3mS
         TDz7W8wKkhGPEg4vI6bF0MGjxTXqnzFK8uS4D7CB/eZesH7T6CbDwaQuxThRZ8vrkexZ
         UrRe6HNdYGejj2MMK1FdkAzYmqUJEKKg3Qss+5pd9ajJJWyCpWQng/BQx7zwoL67+mt0
         XvZjQM/PWsnxjwwipCnPH4QHYj5UEQ/Or1vTIxxPAin/eny+GC4pd/KfvX4dZkLMWNFS
         1fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AP+HJvqFxbvUyGCiRZD5l7c6wOcPZsNQWobITwgQig=;
        b=q1ICecBIhSvoArzfSOzcfzv9Eu7ij2jEj7+Ht1BQSbBLDFraOSc146pp/NV9ktQzMS
         Nb62V04uywfmJPBgjwNZpcyDy5/unc3dgr6Q42fhUTk0ZOyFu8DtREdXdB3/A+MGoOD1
         iJeakE5t9JdKkShVLoFEqc+AI57tNRE5m5a9X5Nt+760JJmyr9BCf8mHiSIjcz2H/u/d
         aDyeXvUtMM/MIG8SVHt58ETBez+zOkpFyYQEnr4JDbl5YOQJ4U0OhIo7VnFQNhAKYhto
         l92MIjGtc+w2o3vv7OjueaVYiNA/g+vOJVUOgTMTSKllkOx0ULi2ZaneO+DCA+FQ8tgY
         6IkQ==
X-Gm-Message-State: AOAM533/oALfVTvgMt0+SOHhmhjtXQCxjv/k+FAlh+aVCxGsAGAy0NLD
        ovYwZ53PNzh/8HJiYiqOUqya/3JU6WM=
X-Google-Smtp-Source: ABdhPJyNZwBwsricP9GE0nBFzGShWj26orazlbTv+44YCTIHH7aCRIrH4/NVxAG7kNabaAUJDadZBQ==
X-Received: by 2002:adf:e391:: with SMTP id e17mr6393392wrm.289.1599707261023;
        Wed, 09 Sep 2020 20:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h186sm1427849wmf.24.2020.09.09.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 20:07:40 -0700 (PDT)
Message-Id: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Sep 2020 03:07:39 +0000
Subject: [PATCH] ls-files: respect 'submodule.recurse' config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

`git ls-files` learned to recurse into submodules when given
'--recurse-submodules' back in e77aa336f1 (ls-files: optionally recurse
into submodules, 2016-10-07) but it does not respect the
'submodule.recurse' config option which was later introduced in
046b48239e (Introduce 'submodule.recurse' option for worktree
manipulators, 2017-05-31).

Add a 'git_ls_files_config' function to read this configuration
variable, and adjust the documentation and tests accordingly.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    ls-files: respect 'submodule.recurse' config
    
    This follows the approach of 121e43fa53 (pull: honor submodule.recurse
    config option, 2017-09-06)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-732%2Fphil-blain%2Fls-files-submodule.recurse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-732/phil-blain/ls-files-submodule.recurse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/732

 Documentation/config/submodule.txt     |  4 +--
 builtin/ls-files.c                     | 16 ++++++++++-
 t/t3007-ls-files-recurse-submodules.sh | 37 ++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index d7a63c8c12..9ba3adbf48 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -60,8 +60,8 @@ submodule.active::
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
 	applies to all commands that have a `--recurse-submodules` option
-	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
-	`restore` and `switch`) except `clone` and `ls-files`.
+	(`checkout`, `fetch`, `grep`, `ls-files`, `pull`, `push`, `read-tree`,
+	`reset`, `restore` and `switch`) except `clone` .
 	Defaults to false.
 	When set to true, it can be deactivated via the
 	`--no-recurse-submodules` option. Note that some Git commands
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b8..43c7c9bd62 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -512,6 +512,20 @@ static int option_parse_exclude_standard(const struct option *opt,
 	return 0;
 }
 
+/**
+ * Read config variables.
+ */
+static int git_ls_files_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse")) {
+		recurse_submodules = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0, i;
@@ -588,7 +602,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	git_config(git_default_config, NULL);
+	git_config(git_ls_files_config, NULL);
 
 	if (repo_read_index(the_repository) < 0)
 		die("index file corrupt");
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index 4a08000713..30c2c1e0bd 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,43 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files respects submodule.recurse' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git -c submodule.recurse ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--[no-]recurse-submodule and submodule.recurse' '
+	cat >expect-recurse <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	cat >expect-no-recurse <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule
+	EOF
+
+	git -c submodule.recurse ls-files --no-recurse-submodules >actual &&
+	test_cmp expect-no-recurse actual &&
+	git -c submodule.recurse=false ls-files --recurse-submodules >actual &&
+	test_cmp expect-recurse actual &&
+	git -c submodule.recurse=false ls-files --no-recurse-submodules >actual &&
+	test_cmp expect-no-recurse actual &&
+	git -c submodule.recurse ls-files --recurse-submodules >actual &&
+	test_cmp expect-recurse actual
+'
+
 test_expect_success 'ls-files correctly outputs files in submodule with -z' '
 	lf_to_nul >expect <<-\EOF &&
 	.gitmodules

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget
