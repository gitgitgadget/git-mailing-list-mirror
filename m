Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2DC433E3
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DCB2065D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 21:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEumFOtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGMVzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMVzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 17:55:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F9C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 14:55:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so1649370wmj.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KQoSLg/jnD1um/RTdLWoZLPlocbJLmsJIhj7ARFGxk4=;
        b=qEumFOtPgmEzFWa0FVtML7rvm1p3XJ/u4Jx0JHqeuXlVEPgpvFL7vnfyi3dO+Sc7Kw
         ChnStmY8hmVdqI7AQF0hJbMp2m5DiRDji6tjP25BM26vqbesudVmDvA7Y7kr/nUSQFjU
         zhvXIV12gkxq2qrROjbpZzYwnSktQfgojIslPrbCH5bi7IuIfAAx8MS1F6UOGSM7H3t0
         uLCo3QeEFnUq+6EVUYs6+vXzeCHumsfh0zYX2pfoDFC3+Mmx3oSeLwsUhy2T+fwfmGqd
         2JvDa15ZAKjVBhzjfhscCWPyAKIL+XYBr7KlTHJh9MJMIXdlShgxNx2bJ3WOcsVo0iTa
         RHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KQoSLg/jnD1um/RTdLWoZLPlocbJLmsJIhj7ARFGxk4=;
        b=Dxv2lsfmkptD0NdUfijcDI7xSVNU3pVkTHzyUMc3oDTj99LkUpkb9lc7MTpH36LzaF
         s/ogl8F7Vc3v39Y8Enb/pH6zqqqgISoAbgJpAhC+IiS4qZr15OajKQQNpG/41a+d9+ok
         WDLqBIJdJedVGT/7lv36tw+Q4OSM8ISVd7cPA0vZEF8eM4/6pSc9UgxvQZR6qT301i8h
         AYHNrJ7rRtfNfxgq6rRMtLP/gUyyBU38OcjNStfgsMnnGL5Dq1DxZ6xYoj5w2kxgPgWV
         jVcHSsTG3bbsW04oDN/m8tBoCO4rSUz2WONJBBwDXrSWvikVMUMf8VNQP3dNf0dSSC9N
         pkdQ==
X-Gm-Message-State: AOAM533v1UF6aKkz8yflhUFg1DpU+toXsCgcUN9lQN+RBkKTWoWlmxkl
        Y1Aha3sSPeCbKfkD04zdLTHW2b3M
X-Google-Smtp-Source: ABdhPJz1Kkq4cddzVnfsrWlZAf0L8BHSoQ43LJHJ/fSNaUWDBGeYmo/aiCdL6w9GJrjXEksj2hmbVw==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr1309138wmh.176.1594677322291;
        Mon, 13 Jul 2020 14:55:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b23sm1247710wmd.37.2020.07.13.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:55:21 -0700 (PDT)
Message-Id: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jul 2020 21:55:20 +0000
Subject: [PATCH] setup: warn about un-enabled extensions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When any `extensions.*` setting is configured, we newly ignore it unless
`core.repositoryFormatVersion` is set to a positive value.

This might be quite surprising, e.g. when calling `git config --worktree
[...]` elicits a warning that it requires
`extensions.worktreeConfig = true` when that setting _is_ configured
(but ignored because `core.repositoryFormatVersion` is unset).

Let's warn about this situation specifically, especially because there
might be already setups out there that configured a sparse worktree
using Git v2.27.0 (which does set `extensions.worktreeConfig` but not
`core.repositoryFormatVersion`) and users might want to work in those
setups with Git v2.28.0, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Warn when extensions.* is ignored
    
    I did actually run into this today. One of my pipelines is configured to
    clone a bare repository, then set up a sparse secondary worktree. This
    used to work, but all of a sudden, the git config --worktree
    core.sparseCheckout true call failed because I'm now using v2.28.0-rc0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-675%2Fdscho%2Frepo-format-version-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-675/dscho/repo-format-version-advice-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/675

 cache.h                    |  2 +-
 setup.c                    | 16 +++++++++++++++-
 t/t2404-worktree-config.sh | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 126ec56c7f..da2c71f366 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,7 +1042,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
-	int has_extensions;
+	int has_extensions, saw_extensions;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
diff --git a/setup.c b/setup.c
index dbac2eabe8..0f45e2e174 100644
--- a/setup.c
+++ b/setup.c
@@ -489,6 +489,15 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	read_repository_format(candidate, sb.buf);
 	strbuf_release(&sb);
 
+	if (candidate->version < 1 &&
+	    (candidate->saw_extensions || candidate->has_extensions))
+		advise(_("extensions.* settings require a positive repository "
+			 "format version greater than zero.\n"
+			 "\n"
+			 "Please use the following call to enable extensions.* "
+			 "config settings:\n"
+			 "\"git config core.repositoryFormatVersion 1\""));
+
 	/*
 	 * For historical use of check_repository_format() in git-init,
 	 * we treat a missing config as a silent "ok", even when nongit_ok
@@ -584,8 +593,13 @@ int read_repository_format(struct repository_format *format, const char *path)
 {
 	clear_repository_format(format);
 	git_config_from_file(check_repo_format, path, format);
-	if (format->version == -1)
+	if (format->version == -1) {
+		int saw_extensions = format->has_extensions;
+
 		clear_repository_format(format);
+
+		format->saw_extensions = saw_extensions;
+	}
 	return format->version;
 }
 
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 9536d10919..1c08a45177 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -78,4 +78,19 @@ test_expect_success 'config.worktree no longer read without extension' '
 	test_cmp_config -C wt2 shared this.is
 '
 
+test_expect_success 'show advice when extensions.* are not enabled' '
+	test_config core.repositoryformatversion 1 &&
+	test_config extensions.worktreeConfig true &&
+	git status 2>err &&
+	test_i18ngrep ! "git config core.repositoryFormatVersion 1" err &&
+
+	test_config core.repositoryformatversion 0 &&
+	git status 2>err &&
+	test_i18ngrep "git config core.repositoryFormatVersion 1" err &&
+
+	git config --unset core.repositoryformatversion &&
+	git status 2>err &&
+	test_i18ngrep "git config core.repositoryFormatVersion 1" err
+'
+
 test_done

base-commit: bd42bbe1a46c0fe486fc33e82969275e27e4dc19
-- 
gitgitgadget
