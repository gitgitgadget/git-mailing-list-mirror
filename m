Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiCJApl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiCJApg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:45:36 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9081124C32
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:44:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dcfa6bab2aso27614407b3.22
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cp6IOYH4t5C+BU7osL6iM6GPWAHCzdtti9ip2r2AJak=;
        b=A3UHWus1wqTTCztH3TaKr4LOEpiFRqfbJ8SprDIY5ULsp2aj69jhWSq4kn8MSkbfNM
         oa0Ngon/WqcQvgwo7xeE8qxWurwVS44oRyLwaZuaPOxepuhcqpG8yeQTsWqxfy3OxRfO
         EEDAxzEoLw9kak/UrM7WdcH4Fg3DVyrD7LOPvQe91hjIxXqeU7HTmmcSWMc4DVgmkrZ4
         hgu8BTUBaQNg/JGmRd/39DtuSK/3ejrN170DGu3h+agvvjeVjF8SYcpPCu77N4ERRu00
         AOqzYbqNdbgaH/MFjVmQN74vlh9ymq9nlOBitFyANddErz3PFlk9si1u4zNlMnMlfK0U
         H2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cp6IOYH4t5C+BU7osL6iM6GPWAHCzdtti9ip2r2AJak=;
        b=ZCuUWjOz4EYePKArzYcX2zBwc5EqaH9PBUZGFfu1z0Tah0aTBrl9go8tfPawrLD0xM
         QmIXjQJK1aLUI7ucKvgMZPb43e1hZ2Hbd553SZLT5musf8VRrQ+nOys5UvxkqmtJ+pfi
         R7imxUIPQfMOhZUvQYnBzszy1TVppIyzwmVYyC2LMWuhkxsqYsE0LDVzniNPzHvB5zkD
         kHqv8BODThVjIv2tzQXIiK7uSU89Y2jaevPxtObfrYIdun3cm6QktBRRr7HCMRxKWvkD
         p2YCADHSKyx2wdBEHkw0kw/f3+O8hwXJpC/7XpmDqlei7pN+RU+aynUes7e+iJnx5He5
         RHQg==
X-Gm-Message-State: AOAM533pEIXtVRFTNUQuy2FQzzAJzS/Aenap+MktH0XVquy7+YKPmrwI
        kXdkaK9cYHbCCq7DiTwKRmI2kVHJGX0ttkApqDGNs4FvpZq6i6fDzFUy62nV0FhFDLwrMtv0EGb
        cMeasMhA40GPyLQgknKrAXPLqmv3EbsjOSknLQJ8nKds16LOh6G/CjbvpQu5Hk/ewRMCY1G8Q+A
        ==
X-Google-Smtp-Source: ABdhPJzwnpc4zLxRVBg7paNPLvIKZnp/sMEIGYXdl5CVE1tIUo1L2Tmt1Iq17GTrkxlk9wkhGkfeelW/FIBK27PXPFg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e0ed:468:c28b:9b23])
 (user=emilyshaffer job=sendgmr) by 2002:a25:8487:0:b0:628:9d12:64d5 with SMTP
 id v7-20020a258487000000b006289d1264d5mr2068983ybk.70.1646873074912; Wed, 09
 Mar 2022 16:44:34 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:44:22 -0800
In-Reply-To: <20220310004423.2627181-1-emilyshaffer@google.com>
Message-Id: <20220310004423.2627181-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 2/3] introduce submodule.hasSuperproject record
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
 builtin/submodule--helper.c        | 11 +++++++
 submodule.c                        | 12 +++++++
 t/t7400-submodule-basic.sh         |  4 +++
 t/t7406-submodule-update.sh        |  8 +++++
 t/t7412-submodule-absorbgitdirs.sh | 50 ++++++++++++++++++++++++++++--
 6 files changed, 89 insertions(+), 2 deletions(-)

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
index c5d3fc3817..eda9ed550e 100644
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
 
@@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 
 	free(prefixed_path);
 
+	/*
+	 * This entry point is always called from a submodule, so this is a
+	 * good place to set a hint that this repo is a submodule.
+	 */
+	git_config_set("submodule.hasSuperproject", "true");
+
 	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
 		return do_run_update_procedure(&update_data);
 
diff --git a/submodule.c b/submodule.c
index c689070524..aafbd628ad 100644
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
@@ -2127,6 +2129,16 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
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
index 40cf8d89aa..53c8bf699d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -115,6 +115,10 @@ inspect() {
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.hasSuperproject is set.
+	test_cmp_config -C "$sub_dir" true --type=bool "submodule.hasSuperproject"
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..ec2397fc69 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
+	(cd super &&
+	 test_unconfig submodule.hasSuperproject &&
+	 git submodule update &&
+	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
+	)
+'
+
 test_done
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..4c33a98efa 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,9 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	test_cmp_config -C sub1 true --type=bool submodule.hasSuperproject
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -61,7 +63,9 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	test_cmp_config -C sub1/nested true --type=bool submodule.hasSuperproject
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
+	test_cmp_config -C sub4 true --type=bool submodule.hasSuperproject
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
+	test_cmp_config -C sub5 true --type=bool submodule.hasSuperproject
+	)
+'
+
 test_done
-- 
2.35.1.616.g0bdcbb4464-goog

