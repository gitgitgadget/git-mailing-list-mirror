Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC7A20798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965005AbcKKX5o (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:57:44 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36460 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756505AbcKKX5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:57:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so14180084pfz.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9+5FoieVwd5QRDjfknL9+C0NctHxz3Xi4QADh8tZos=;
        b=lQuUK0JpkTy4owL0CcrlrXHJj3/iuGkVl34lcSukU1UxedyGfduJkBuQj6OYmPOqaO
         ZNPof62CytzFixC9Hui1lNbOMiGBdcGS8uucylZwewmsgsKoVfbUWx2EgT4k7nsxKl+n
         stTlQNFBc8gn3VirsrAi4wOXDpDFzZcGqaYEt3+qBR9c/w/jd9b4dwgQ8iIUlsKT61Xz
         A16T2/a1Xyi1PxyecW/8gL10Pwk8J4Xl3oxGZY2BOyq5WxJSwdMibAowRKi+dqy/5RT1
         6ZbghvmdwSa3n2DnehyFjVsHkgEPjpsS14dCk5OUrIcLDTfUyj+VRX6dijUSIs5+pPYv
         N9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e9+5FoieVwd5QRDjfknL9+C0NctHxz3Xi4QADh8tZos=;
        b=gB/4gAqfPhAVw1ENH4R3ChCFFVkm1zFp9A7WiOCssihPrmiLI13bz+4EAgxTNe/6oc
         bqL+kzrXqQVPxMpzNWvHAndFWgvVXRcWi7AWWaxxdgOQ0Iqm+bqv4buaPBqudSzVTv2b
         rsQIBOUGQ/rwkQUPhMx6T8ayQ5cn/ERz3Ice2GERh3Pk/VKsGuVmnGudTGXFYCwd/uQi
         /q/wt26MtuBS+ZJK5un6e5YBd60dH9aw/ZO3+HZrNdUhTYRkR/r1ZkjZ0kixGOjQ7emv
         sQFQti5KqL6PTLpobcKwV0wYj+lDsYEkV2DsCD7KkLQLs7sEeqFMf4m/otRYtzFBnsH0
         cTmg==
X-Gm-Message-State: ABUngvf3FT1cuHcFfTIkoiS1WoGVi0p2MIn9/yeypfplLv9uSEZFEavRazb6OheUQpbxBJs9
X-Received: by 10.99.56.82 with SMTP id h18mr48061624pgn.55.1478908300275;
        Fri, 11 Nov 2016 15:51:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id r74sm17568314pfl.79.2016.11.11.15.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 15:51:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v3 6/6] grep: search history of moved submodules
Date:   Fri, 11 Nov 2016 15:51:13 -0800
Message-Id: <1478908273-190166-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478908273-190166-1-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
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
 builtin/grep.c                     | 18 +++++++++++++++--
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 93e5405..1879432 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -548,6 +548,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 		name = gs->name;
 
 	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
@@ -615,8 +616,21 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 			  const char *filename, const char *path)
 {
 	if (!(is_submodule_initialized(path) &&
-	      is_submodule_populated(path)))
-		return 0;
+	      is_submodule_populated(path))) {
+		/*
+		 * If searching history, check for the presense of the
+		 * submodule's gitdir before skipping the submodule.
+		 */
+		if (sha1) {
+			path = git_path("modules/%s",
+					submodule_from_path(null_sha1, path)->name);
+
+			if(!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
+	}
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3d1892d..ee173ad 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -127,6 +127,47 @@ test_expect_success 'grep tree and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep history with moved submoules' '
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	git -C parent commit -m "add file" &&
+
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	git -C parent mv sub sub-moved &&
+	git -C parent commit -m "moved submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub-moved/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD^:file:foobar
+	HEAD^:sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ > actual &&
+	test_cmp expect actual &&
+
+	rm -rf parent sub
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.8.0.rc3.226.g39d4020

