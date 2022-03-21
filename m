Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F9C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbiCUUg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiCUUgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:36:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920C8AE5A
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q8so10941020wrc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UVjVoys6lo8xOpwzsyK2BzcJ74cu4P+3MVZKY5XAoCQ=;
        b=TcyOfS9FCBiouolZJK4eUXGyS35jL5O7N1XU5VYGdrNyMHjJoxpjR0rBGJ2uKqVKmU
         0jQ/FQpYeDqceDMWi35/j8gV8ptiaRw/YiOjTvtxRSasMOAZWg4YPgrhujCHJ4FNRK06
         zUb03LPBMRkEHqXHcQhhtaBAyWAQFXbNhaPkYRN9ILAYolbzVWuyV2ZrLF7PA/N7Nh3N
         kjQoQsazxGeUh7d0oYJSG1Ruwz4059blA46mwKBIJrtpGafl2QIKVsuzz1B0vmn+98rv
         7qthxx9oJRRRQKfrFcWn+TRvfWcp3jQRL6QAFO7qSHVNs+lsmcwicVLei1JbbmRXQO9i
         b5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UVjVoys6lo8xOpwzsyK2BzcJ74cu4P+3MVZKY5XAoCQ=;
        b=zQQHYuMAlpk8w4ytC00/5w39g8ydeZBIfAyF5VNLvpyAmxX+X0sMyjjOyp30gVgMmo
         WQYt0wATifV/prMZr9wgTgmM2rSKxim/xA/P5vdlRdkkFEc6ZZ+3H5xSOBQLS1D2ZEG2
         vKVxO6mKNs4MxaSVRGTZkFwuTbhFvaAPYFfZZSN06iYW3qCikVgmB5KT5qPrs1yGnFCA
         hxj+/h+sPSeoG4XJFxnQUNW13AcGwRHN8S3c66UNbAlk2L5uSG4yGM4jSGyYW2IZ57y5
         mK614xY6YSzHKG2wTv+MGHOrIV2/6pBu83ZqEpcNKCr/zwdJX0bFEEAbKVHxmckUEmnB
         aLSg==
X-Gm-Message-State: AOAM532aLF+3vdUiTy8TvNLXtVIdhOZo0wVzGKZIlsxPYdExyoa3LIay
        Vs2qqk3QIzx6v1ZQkz8sTejpghS6vkE=
X-Google-Smtp-Source: ABdhPJzwKWRy836Kp2CNrRMdUZvcMYTuAx5EYIDNJdi2whEJZX4yOfliCCC7sniRVIfz6vivthinfQ==
X-Received: by 2002:adf:db4b:0:b0:203:e76f:fc45 with SMTP id f11-20020adfdb4b000000b00203e76ffc45mr18771082wrj.549.1647894892683;
        Mon, 21 Mar 2022 13:34:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm399489wmq.17.2022.03.21.13.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:52 -0700 (PDT)
Message-Id: <f89e9b4ae24718116d0275333f4ece1d4024ab6b.1647894889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:46 +0000
Subject: [PATCH 1/4] reset: do not make '--quiet' disable index refresh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update '--quiet' to no longer implicitly skip refreshing the index in a
mixed reset. Users now have the ability to explicitly disable refreshing the
index with the '--no-refresh' option, so they no longer need to use
'--quiet' to do so. Moreover, we explicitly remove the refresh-skipping
behavior from '--quiet' because it is completely unrelated to the stated
purpose of the option: "Be quiet, only report errors."

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  5 +----
 builtin/reset.c             |  7 -------
 t/t7102-reset.sh            | 32 +++++---------------------------
 3 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 89ddc85c2e4..bc1646c3016 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -114,10 +114,7 @@ OPTIONS
 --no-refresh::
 	Proactively refresh the index after a mixed reset. If unspecified, the
 	behavior falls back on the `reset.refresh` config option. If neither
-	`--[no-]refresh` nor `reset.refresh` are set, the default behavior is
-	decided by the `--[no-]quiet` option and/or `reset.quiet` config.
-	If `--quiet` is specified or `reset.quiet` is set with no command-line
-	"quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
+	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
 
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
diff --git a/builtin/reset.c b/builtin/reset.c
index c8a356ec5b0..7c3828f6fc5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -430,13 +430,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	/*
-	 * If refresh is completely unspecified (either by config or by command
-	 * line option), decide based on 'quiet'.
-	 */
-	if (refresh < 0)
-		refresh = !quiet;
-
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 1dc3911a060..8b62bb39b3d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -485,25 +485,12 @@ test_reset_refreshes_index () {
 }
 
 test_expect_success '--mixed refreshes the index' '
-	# Verify default behavior (with no config settings or command line
-	# options)
-	test_reset_refreshes_index
-'
-test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
-	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
-	# determine refresh behavior
-
-	# Config setting
-	! test_reset_refreshes_index "-c reset.quiet=true" &&
-	test_reset_refreshes_index "-c reset.quiet=false" &&
-
-	# Command line option
-	! test_reset_refreshes_index "" --quiet &&
-	test_reset_refreshes_index "" --no-quiet &&
+	# Verify default behavior (without --[no-]refresh or reset.refresh)
+	test_reset_refreshes_index &&
 
-	# Command line option overrides config setting
-	! test_reset_refreshes_index "-c reset.quiet=false" --quiet &&
-	test_reset_refreshes_index "-c reset.refresh=true" --no-quiet
+	# With --quiet & reset.quiet
+	test_reset_refreshes_index "-c reset.quiet=true" &&
+	test_reset_refreshes_index "" --quiet
 '
 
 test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
@@ -522,15 +509,6 @@ test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
 	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
 '
 
-test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
-	# Verify that *both* --refresh and `reset.refresh` override the
-	# default non-refresh behavior of --quiet
-	test_reset_refreshes_index "" "--quiet --refresh" &&
-	test_reset_refreshes_index "-c reset.quiet=true" --refresh &&
-	test_reset_refreshes_index "-c reset.refresh=true" --quiet &&
-	test_reset_refreshes_index "-c reset.refresh=true -c reset.quiet=true"
-'
-
 test_expect_success '--mixed preserves skip-worktree' '
 	echo 123 >>file2 &&
 	git add file2 &&
-- 
gitgitgadget

