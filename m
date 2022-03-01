Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiCAA1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiCAA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:27:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A664E388
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7c9a42af2so114615087b3.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gkbUvjnljQ703UX7oq1gaK1/LSn2NCsfScR7vzNklxo=;
        b=W1t4a/zkhSA+UQEMxeADJeYgQcsJ9brvRNog2O6mXu81XTblUUK/lgmHna8CMKpFOA
         RR7+qcTIUYEwvjT8YymfVfDbwA5MLhJSoW0wK1X4oWSreTxrxLd9lEuEt8FOwf5iMkn3
         /RQh3hwf3f1XY+9EA5J9aojJ1uyytIKFDbXlMe+d1z1wyrSuTHLFEkuJ30+5bUgbYLMo
         jqg/uPuOczG+/c+4JQT3BkxeeLo66eZtlUY0vxMKohLFFrkTYexJd8TID5vRi+nm9J98
         WLNWR9SgQx27HO+jCexr0oITJPmQEcgR2kq38TvZ607ZiyO8Ww8IfIe8Uh4PhI9ZGcdX
         Ks6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gkbUvjnljQ703UX7oq1gaK1/LSn2NCsfScR7vzNklxo=;
        b=wO9UGLvByqJ0OH9z/1EoPqJFktqPKGmU0+JcaA0zuWCAkHl223Y3rlfhnm6Ect0M+q
         TbPFZXlj+kTQFUf83Thh/v1tSUfG4pTwcDa+DBnTtYA6SjhhuEPC1F7MWJC+lVdGjzUq
         F1AgDa402W4EJ6BfxOc4G9ZBb5D23RotIWyACPss2E8QzYq7wDJK3gQ5pE62hxKc+hEI
         HmaAiu0TPU3DTMZggEk4ljQqQF3T3TB+0yPv4KOD6PXmqzXWLZHz7MgJxs5MajXCB0Ai
         j1UnxvUXvhvOMqdRlLA+d6IeVxaAGNXh3eaj6GkyxH+zBgwPmjcism2qAWLovwL3TpaW
         Z7lQ==
X-Gm-Message-State: AOAM5318jLtia7hwv6nz4AbqUuxHqxd1sCOg2PdUyuDP4r5e1pXzRzix
        dMk0eWZjyaRE5UaWwwawPKeASt/ysuyCc7EEtY2Xtt9+J2MUaE9Bd1wm10BOi9TjRv36A4ovK/s
        O4L7U/awVFT7DAIYAHHgKh/VX/zSHNdeOjv+H3yaWvt4PQeO6ejNERrLhj+gEYd1CTNc0W4IvtQ
        ==
X-Google-Smtp-Source: ABdhPJxW/C9Bqhm9N4cFVkw47+N7w/ZcC27DE8S6TaIwCiQaqUSnNBHaHQ1JdfKjmEek1krhE/uYfwzOpq6AYMMVpFU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:3f0e:8f7:9f8d:6e8c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:207:0:b0:61d:c0eb:ecc6 with SMTP
 id 7-20020a250207000000b0061dc0ebecc6mr21322066ybc.648.1646094396195; Mon, 28
 Feb 2022 16:26:36 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:26:12 -0800
In-Reply-To: <20220301002613.1459916-1-emilyshaffer@google.com>
Message-Id: <20220301002613.1459916-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com> <20220301002613.1459916-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v8 2/3] introduce submodule.hasSuperproject record
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a config variable indicating the fact that they are a
submodule. If this config is set to false or unset, Git may assume the
current repo is not a submodule.

Git commands can use this variable to decide whether to traverse the
filesystem and look for a superproject at all. 'git rev-parse
--show-superproject-working-tree' can learn to exit early if this config
is unset or false. Other newly added or implicit behavior - like "git
status" showing the submodule's status in relation to the superproject,
or a config shared between the superproject and submodule - can use this
config to decide whether to search the parent directory to find a
superproject.

Introduce this config everywhere we add a new submodule, or touch one
that already exists, so that we can proliferate it in repos which are
already out in the world using submodules.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/submodule.txt |  6 ++++
 builtin/submodule--helper.c        |  5 +++
 git-submodule.sh                   |  3 ++
 submodule.c                        | 18 +++++++++++
 t/t7400-submodule-basic.sh         |  4 +++
 t/t7406-submodule-update.sh        |  8 +++++
 t/t7412-submodule-absorbgitdirs.sh | 50 ++++++++++++++++++++++++++++--
 7 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index ee454f8126..99d5260b8e 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -91,3 +91,9 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.hasSuperproject::
+	Indicates whether this repository is a submodule. If this config is set
+	to 'true', Git may traverse the filesystem above this submodule in order
+	to identify the superproject. It is set automatically during submodule
+	creation, update, and 'git submodule absorbgitdir'.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817..92986646bc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1839,6 +1839,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
 
+	/*
+	 * Teach the submodule that it's a submodule.
+	 */
+	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..59dffda775 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -449,6 +449,9 @@ cmd_update()
 			;;
 		esac
 
+		# Note that the submodule is a submodule.
+		git -C "$sm_path" config submodule.hasSuperproject "true"
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/submodule.c b/submodule.c
index c689070524..741104af8a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2097,6 +2097,8 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	struct config_set sub_cs;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2127,6 +2129,22 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/*
+	 * Note location of superproject's gitdir. Because the submodule already
+	 * has a gitdir and local config, we can store this pointer from
+	 * worktree config to worktree config, if the submodule has
+	 * extensions.worktreeConfig set.
+	 */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_configset_init(&sub_cs);
+	git_configset_add_file(&sub_cs, config_path.buf);
+
+	git_config_set_in_file(config_path.buf, "submodule.hasSuperproject",
+			       "true");
+
+	git_configset_clear(&sub_cs);
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 40cf8d89aa..833fa01961 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -115,6 +115,10 @@ inspect() {
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.hasSuperproject is set.
+	git -C "$sub_dir" config "submodule.hasSuperproject"
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..422c3cc343 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.hasSuperproject &&
+	 git submodule update &&
+	 git -C submodule config submodule.hasSuperproject
+	)
+'
+
 test_done
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..187fb6bbbc 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,9 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	git -C sub1 config submodule.hasSuperproject
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -61,7 +63,9 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	git -C sub1/nested config submodule.hasSuperproject
 '
 
 test_expect_success 're-setup nested submodule' '
@@ -130,4 +134,46 @@ test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
 	test_i18ngrep "not supported" error
 '
 
+test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
+	# set up a worktree of the superproject
+	git worktree add wt &&
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub4 &&
+	test_commit -C sub4 first &&
+	git submodule add ./sub4 &&
+	test_tick &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub4 &&
+
+	# make sure the submodule noted the superproject
+	git -C sub4 config submodule.hasSuperproject
+	)
+'
+
+test_expect_success 'absorbgitdirs works with a submodule with worktree config' '
+	# reuse the worktree of the superproject
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub5 &&
+	test_commit -C sub5 first &&
+	git submodule add ./sub5 &&
+	test_tick &&
+
+	# turn on worktree configs for submodule
+	git -C sub5 config extensions.worktreeConfig true &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub5 &&
+
+	# make sure the submodule noted the superproject
+	git -C sub5 config submodule.hasSuperproject
+	)
+'
+
 test_done
-- 
2.35.1.574.g5d30c73bfb-goog

