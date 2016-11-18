Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5802D2022D
	for <e@80x24.org>; Fri, 18 Nov 2016 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbcKRT7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:59:18 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34455 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcKRT7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:59:13 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so103323762pgx.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UO68MiS5fFSzBP4+ddlW4LJ9B71mtvy3OQVROYXIU4c=;
        b=EyCR0UsDGaKsPOWMrqA4pfuN3EjdFId3zMEkV6rtCsuy2diBlH7eA8xJb2/Wqj2+C2
         vhS+ljh1DHABnQECM2NvrN635bqlKWddg+cReIjphMuswIMClKG8CiAC/y+GdS3kAYpv
         kov/gejZncsI3N1hOWpeORLFNzzkgpXWh/LExA/Kq6yNQiFyxalmOpu/ug5vy50LPtCV
         mmUvTkFUvLoZNmfSOMoKT+Ue6jV30XgGlJ18u97FGpgwwWPjGcvMDPSZT289cgn02Mvw
         UtwFpqwkSHr1kzuqEOlMVHQQ4DW0yxF7TMjKIkWnqUYg8YnpkUpTNtpFM7ZW1VkTaRL1
         /7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UO68MiS5fFSzBP4+ddlW4LJ9B71mtvy3OQVROYXIU4c=;
        b=WDuG/gHhWWmKjtCEl+NnDj01tzOSgtG9LHjtm6m3OCwEVRkXFpKhPNJT6cWTkDB3L/
         uAVPNqK1AjGHrt/65KnOnWXDwgv1Tv4N69P+BvRRNHYj0qy7Hhnwk+eUxtyrXvaUtvUp
         kEj99IWUpIVqRSkIQ8qgLP6P3iavMdOJ09KOctMG5idFRaiZ1WG5cb6Rt0DYQr6e6jxa
         VCcz1m3WdOAD8746N3Dl3F0sFkzMGgxaf4RSiRDSwx+NBMlQvmYOAfj8Qm9xME3iR1kL
         IHGlqXYBOBDScmSIIW+F0o2bpOIqIuMTPYDrMyLhIW4zR79QIOy5kV3UXVRmBJf3d6xu
         NLsA==
X-Gm-Message-State: AKaTC02gi2jeeBMjS83HFtnXqdR+xsaKggBZCytuooY27OWUrEVNFXnY7ad/9c1uvtGLxzkA
X-Received: by 10.99.42.80 with SMTP id q77mr2980648pgq.170.1479499152307;
        Fri, 18 Nov 2016 11:59:12 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm19850441pfb.42.2016.11.18.11.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 11:59:11 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v4 6/6] grep: search history of moved submodules
Date:   Fri, 18 Nov 2016 11:58:55 -0800
Message-Id: <1479499135-64269-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
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
index 9b795ee..747b0c3 100644
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
+			if(!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
+	}
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index d1fd7ed..7d66716 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -158,6 +158,47 @@ test_expect_success 'grep recurse submodule colon in name' '
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

