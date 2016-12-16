Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C6F20489
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758258AbcLPTD4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:56 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34086 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758207AbcLPTDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:46 -0500
Received: by mail-pg0-f50.google.com with SMTP id a1so12117869pgf.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRPXBphKwKxK7d2y/FpN3SCi9xE6IEhcIq4jEp2wLh0=;
        b=PGy9lDRoAJ45aIuL6RatpaLwaCbTaebPkNF05SG/WS81wx2en+vCX/fGR5p+jp6awD
         mZpLvweoVcAHf8+MZ3cuynCd1Wy5/7ffa1DaEHkMVs07Zd/s5hkR8AnXDHPopRwDpwpP
         VaVW8RQmm5pZuxbLHsGR95XdRj/ddfYzm/tsW3AEBAkOVQqGBzDxiSyXOhqwc5o2CPzy
         S/SWgwZdMy9K+LDynhGbVj7jpmeVYJTBRZ5QpItrkb16YGhddSte/sBb6MTUj5yNl+au
         lt2gLlRvnFhDVSo/gACxCfN5AcMuPAOAHAwFxuXFCG0K1x2ct29skhYArlvb7v13leCT
         mQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRPXBphKwKxK7d2y/FpN3SCi9xE6IEhcIq4jEp2wLh0=;
        b=DegTCa2Psc0bECpNHeyS1I1VupRP5UGJLBHr7BU05Fxyrt3FbkfZCGCAHFUVzeVZE9
         zVtoVRj2lVszogAEpOWq5Xs/uqg87cbdAWNjM9UpR1zEbOc+ONjAxydc+LLpewvEwuFT
         oGk1HzngpMCe9no7zZHme3h9UBrV2ygPXkStgiwlQQ0pey39Y1pN724F9wH9EzcgxV9w
         hVIHHyxl+OCx7r/if6Hua7vdsbh2Nk333keOaswj0ReexFsiICtXtyuJlYzjcL1WTBXk
         /1eXxyjjGenT3pTt/yjHfTDlx4ULeN9V3rygHnupqrplfmVjr2E93B0WTvKaKGC5ENJu
         YTbA==
X-Gm-Message-State: AKaTC02rGC5Nq6xFdXiMYAvws5z74ZzglB3AWs9dCWklQiNTuF3yHqYIvI0/W+I/iehMaLR8
X-Received: by 10.99.113.87 with SMTP id b23mr8229498pgn.41.1481915025195;
        Fri, 16 Dec 2016 11:03:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 7/7] grep: search history of moved submodules
Date:   Fri, 16 Dec 2016 11:03:22 -0800
Message-Id: <1481915002-162130-8-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1481915002-162130-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a submodule was renamed at any point since it's inception then if you
were to try and grep on a commit prior to the submodule being moved, you
wouldn't be able to find a working directory for the submodule since the
path in the past is different from the current path.

This patch teaches grep to find the .git directory for a submodule in
the parents .git/modules/ directory in the event the path to the
submodule in the commit that is being searched differs from the state of
the currently checked out commit.  If found, the child process that is
spawned to grep the submodule will chdir into its gitdir instead of a
working directory.

In order to override the explicit setting of submodule child process's
gitdir environment variable (which was introduced in '10f5c526')
`GIT_DIR_ENVIORMENT` needs to be pushed onto child process's env_array.
This allows the searching of history from a submodule's gitdir, rather
than from a working directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                     | 20 +++++++++++++++++--
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5918a26..2c727ef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -547,6 +547,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 		name = gs->name;
 
 	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
@@ -615,8 +616,23 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 {
 	if (!is_submodule_initialized(path))
 		return 0;
-	if (!is_submodule_populated(path))
-		return 0;
+	if (!is_submodule_populated(path)) {
+		/*
+		 * If searching history, check for the presense of the
+		 * submodule's gitdir before skipping the submodule.
+		 */
+		if (sha1) {
+			const struct submodule *sub =
+					submodule_from_path(null_sha1, path);
+			if (sub)
+				path = git_path("modules/%s", sub->name);
+
+			if (!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
+	}
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index d5fc316..67247a0 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -186,6 +186,47 @@ test_expect_success !MINGW 'grep recurse submodule colon in name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep history with moved submoules' '
+	git init parent &&
+	test_when_finished "rm -rf parent" &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	git -C parent commit -m "add file" &&
+
+	git init sub &&
+	test_when_finished "rm -rf sub" &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git -C parent submodule add ../sub dir/sub &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	dir/sub/file:foobar
+	file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	git -C parent mv dir/sub sub-moved &&
+	git -C parent commit -m "moved submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub-moved/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD^:dir/sub/file:foobar
+	HEAD^:file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.8.0.rc3.226.g39d4020

