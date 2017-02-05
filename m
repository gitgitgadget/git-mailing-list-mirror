Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3AD1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 21:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbdBEVXn (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 16:23:43 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34244 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbdBEVXm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 16:23:42 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so5405073pfb.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 13:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhrtVJJlz1TCYhN7c7CF/W4m+60MtaX4UUE6l2TDfPQ=;
        b=kL28cMKrfxhtg3AeYA/jVjuTt0C31/CUN6SDZtwqOB+j1trQeUD/F9aIv/RBtuhQsk
         By6P44q0W/Xk2y7CSp87cyQ9OqH5M8sXhWjbrY+AhiZz+qujIw+NvoCet2fRDGkrNmr4
         rKWJSjZOcJdUrWM+7bS8edrCK7nkQXFe3N7BaYaS3OtAspGK+kVS8ur/yCGOZ51WbiVg
         NCZxKNqS4/lJN7z9y5UY7vA1Fi1y64p5vFWBq8nPbvdH2RChTf5QKpzodYMit5MCqZap
         F66zL/mbPi840Gk1v8ATSCX5t+E1ObXyrHY3wpF7MSGsQ9C5Sz0MKNWxIcxiybol5htv
         xe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XhrtVJJlz1TCYhN7c7CF/W4m+60MtaX4UUE6l2TDfPQ=;
        b=fmr9mSuqmGP7elMae9glqx1b6j8j6cmhrNZd6TLCCyt5eyaWhX8/0nnQhRk/Zz/vES
         dqabnJM35QmtQM5ZYWFP7YDtZ8ff6fAAYDJNSeyKVw2gFzqmRLQjVzAJYkeBfIxoY25T
         k1WszZMR/Hd9dyeMmPH0gJLkl5MPYvs+4mp2cNLEkr+GeF4tSWcs8byO8QXRpM7RwYGF
         xfltYJvdsGfwgEjQSgVE1uw9ahJOYbABqba4IfHu/80C0qve6LBJLQRBB1Ql/yPUixh3
         Li8CXk6bA9RYn6L22rBnzTHw4MgKz2W0yR+7k8QNcoK0l67BF28ChLsFJR+UX+fgPWY2
         GVJQ==
X-Gm-Message-State: AIkVDXLA6hlORKUIvG8llgex3NVv+weOtMb78fuw1u5EwaboTcDtQfbxRmTru7WirepNAQ==
X-Received: by 10.84.236.76 with SMTP id h12mr12715758pln.173.1486329821603;
        Sun, 05 Feb 2017 13:23:41 -0800 (PST)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id y6sm83836412pgc.1.2017.02.05.13.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 13:23:40 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH] difftool: fix bug when printing usage
Date:   Sun,  5 Feb 2017 13:23:38 -0800
Message-Id: <20170205212338.17667-1-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.209.g3d1e53e462
In-Reply-To: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git difftool -h" reports an error:

	fatal: BUG: setup_git_env called without repository

Defer repository setup so that the help option processing happens before
the repository is initialized.

Add tests to ensure that the basic usage works inside and outside of a
repository.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This bug exists in both "master" and "next".
This patch has been tested on both branches.

 builtin/difftool.c  |  8 ++++----
 t/t7800-difftool.sh | 13 +++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index b5e85ab079..d13350ce83 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -647,10 +647,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	/* NEEDSWORK: once we no longer spawn anything, remove this */
-	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
-
 	git_config(difftool_config, NULL);
 	symlinks = has_symlinks;
 
@@ -661,6 +657,10 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (tool_help)
 		return print_tool_help();
 
+	/* NEEDSWORK: once we no longer spawn anything, remove this */
+	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
 	else if (difftool_cmd) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index aa0ef02597..21e2ac4ad6 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,6 +23,19 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
 }
 
+test_expect_success 'basic usage requires no repo' '
+	lines=$(git difftool -h | grep ^usage: | wc -l) &&
+	test "$lines" -eq 1 &&
+	# create a ceiling directory to prevent Git from finding a repo
+	mkdir -p not/repo &&
+	ceiling="$PWD/not" &&
+	lines=$(cd not/repo &&
+		GIT_CEILING_DIRECTORIES="$ceiling" git difftool -h |
+		grep ^usage: | wc -l) &&
+	test "$lines" -eq 1 &&
+	rmdir -p not/repo
+'
+
 # Create a file on master and change it on branch
 test_expect_success 'setup' '
 	echo master >file &&
-- 
2.12.0.rc0.209.g3d1e53e462

