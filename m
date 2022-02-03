Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18442C433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355622AbiBCV72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355621AbiBCV70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C927C061401
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:59:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t91-20020a25aae4000000b0061963cce3c1so8765299ybi.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=otm8OsOeKhmWIBjc8HOa6cAJ7QsBOJqukpdmbJe/fAE=;
        b=GTW/IyXr/A5mfnXWaqjGx9WIwXeSmXqpyz8DoK1ylge7A/dwGcBUR2Ec5iXeOIfvJp
         UpTVblsuUAooRTurOUHjHaSPurl/sEMyHdyGtEi1SHY/WhXkWZT/9XT3+x5wVyzkbM3u
         PjkdWLmx6qJSg08rnoPX41blbLA0I8f/ECMGr9VNhRvnwsBUkQpeSN3pnTbrHiHhNNNp
         CZok5lMDcBHCp5Vxztg9IjnwhonEnV66NcY1Wgmj28RzS7zcQ5vjkL05hG4c3+hvjq+z
         weMmiU9a9s/iE2/iuRLlUO2AhxoQoZ7VJ4ivmpt+sP6a9xHOSH9uhxhLZTB3eYZ4Fn5m
         vYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=otm8OsOeKhmWIBjc8HOa6cAJ7QsBOJqukpdmbJe/fAE=;
        b=u2cmk3eenVgwrQMB78x60Bhrr2KYwMET04y8tF9k71WPFGd9Fw+/R+Hvrl7ZQPzqLC
         L2ruRxCOvJZccKk6axqUotiAnqNfTXyoc/AIUBZM6lMHstPTmMvwGo4BCc0+0XFyKlIp
         mm/6XeU3fjml2o9VCu9xmiu1Wo13IvSg2T3p5pFnJ/xdedP//qPYkIThMoBjYLtF19oQ
         BA66KgDalp+97Tlp17Sj/IpAju3jpJJ5C8csHmLp2O9QZRe61wTbqUgfP0rHkhtGelqm
         m+j17S+RvwGqosFOA7Q/KYvd7LqkNKpzr2adFkRwnMzOyUIOwnCFdzy3udzOBRQnSpKc
         yW9w==
X-Gm-Message-State: AOAM533pDhlatkPoyD1fSoPSn6MpuLPN+dd7QlhflGZJ2/2JorbFMyYk
        ViRFf8wQ4L79zjCe4sIwC2dUA0iJQxa6rJi5siNyvBaO4hrRXa8ZeFp8DxnMSnYxr672CVv8ISo
        AP8z1XfT9IpisJY47cuMJZCWsZRC82v7Qorgvl0ydCsShaUNqrkx45tcV2HemFNZyr4iLdIQO4g
        ==
X-Google-Smtp-Source: ABdhPJygU/ZI0WM98goNHDBiGDxQhv8v5feiLnYySNwhFAa2veb28jmBkH1lCbpJdCj/rKvmhiWjbr3z1EfTjILSvHo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:662:cd2f:9dc:846b])
 (user=emilyshaffer job=sendgmr) by 2002:a81:3986:: with SMTP id
 g128mr103437ywa.129.1643925565311; Thu, 03 Feb 2022 13:59:25 -0800 (PST)
Date:   Thu,  3 Feb 2022 13:59:12 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com>
Message-Id: <20220203215914.683922-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 2/4] introduce submodule.superprojectGitDir record
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a config variable referencing to their superproject's
gitdir. Git commands can rely on this reference to determine whether the
current repo is a submodule to another repo. If this reference is
absent, Git may assume the current repo is not a submodule.

In practice, some commands which specifically reference the submodule
relationship, like 'git rev-parse --show-superproject-working-tree',
will still search the parent directory. Other newly added or implicit
behavior, such as "git status" showing the submodule's status in
relation to the superproject, or a config which is shared between the
superproject and the submodule, should not search the parent directory
and instead rely on this "submodule.superprojectGitDir" config.

By using a relative path instead of an absolute path, we can move the
superproject directory around on the filesystem without breaking the
submodule's pointer. And by using the path from gitdir to gitdir, we can
move the submodule within the superproject's tree structure without
breaking the submodule's pointer, too. Finally, by pointing at the
superproject's worktree gitdir (if it exists), we ensure that we can
tell which worktree contains our submodule.

This commit teaches "git submodule add" to add the aformentioned config
variable. Subsequent commits will teach other commands to do so.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/submodule.txt |  8 ++++++++
 builtin/submodule--helper.c        | 11 ++++++++++
 t/t7400-submodule-basic.sh         | 32 ++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index ee454f8126..bebd25684e 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -91,3 +91,11 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	If this repository is a submodule, the relative path from this repo's
+	gitdir to its superproject's gitdir. Git commands may rely on this
+	reference to determine whether the current repo is a submodule to
+	another repo; if this reference is absent, Git will treat the current
+	repo as though it is not a submodule (this does not make a difference to
+	most Git commands). It is set automatically during submodule creation.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817..0485b384a1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1839,6 +1839,17 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
 
+	/*
+	 * Set the path from submodule's new gitdir to superproject's gitdir.
+	 * The latter may be a worktree gitdir. However, it is not possible for
+	 * the submodule to have a worktree-specific gitdir or config at clone
+	 * time, because "extensions.worktreeConfig" is only valid when set in
+	 * the local gitconfig, which the brand new submodule does not have yet.
+	 */
+	git_config_set_in_file(p, "submodule.superprojectGitDir",
+			       relative_path(absolute_path(get_git_dir()),
+					     sm_gitdir, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 40cf8d89aa..7e4cc89bf5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -109,12 +109,24 @@ submodurl=$(pwd -P)
 
 inspect() {
 	sub_dir=$1 &&
+	super_dir=$2 &&
 
 	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
 	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.superprojectGitDir contains the path from the
+	# submodule's gitdir to the superproject's gitdir.
+
+	super_abs_gitdir=$(git -C "$super_dir" rev-parse --absolute-git-dir) &&
+	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --absolute-git-dir) &&
+
+	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
+	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
+						"$sub_abs_gitdir")" ] &&
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
@@ -138,7 +150,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -240,7 +252,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -256,7 +268,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -272,7 +284,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -288,7 +300,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -304,7 +316,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -320,7 +332,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -351,7 +363,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -492,7 +504,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -551,7 +563,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.35.0.263.gb82422642f-goog

