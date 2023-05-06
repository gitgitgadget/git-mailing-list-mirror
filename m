Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943B6C77B7F
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjEFL2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjEFL1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:27:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4287EF9
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:27:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaec6f189cso18312885ad.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683372473; x=1685964473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KtVkhhUsiSi79JGED6DbeKTUQS+ilt169uapZxp7LM=;
        b=lWMpYpbc0msw12goGhCRMaQIuBFeMmpACLGN/Ek42VIlx7UZVopCZRK4YSpAR7U8+o
         sxkiIbA44+i342salHLSs8F1B25l+WRgJerx0IArXLsyzO3y7LXkdaC2oeFs9O0ww4bY
         5YNjG/8KewKsC+0GWEyDAm3Cav8bIGmj4feIBKWMVvma/RqXwPssvpWBFLm7b2X/QcTC
         0wHM5EHgAyUs497nItmKKahcwoWquyQyf7tHDSFk1N1GsJjXe96G9mSvVjoxBa8JW2d5
         +4SaTkTbWyuIbdu/BK87RagreP3o7E+HSN0p+mMEivaecf6pIZBz2jL8ajRhQyayeQ8/
         JbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683372473; x=1685964473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KtVkhhUsiSi79JGED6DbeKTUQS+ilt169uapZxp7LM=;
        b=em5FI1FnlfCHf3q2jfxGRCyMJo0gSTOCOpxPCAvERXZnU/VLHSXDHfGh3vbw0CjAZF
         U7Rqqc4RtfR/G9ZdfLJ9e7mYl48uvvZclKs6rEJkt3+yNd13eVBO66YAhAZD/INnoxPY
         FMjuBUj3C5ks1AhGgJlVFAJ9gkPYwbBGZxQKJ75qrlgC7SwbD0w3V4E1MzN6iibsiIBi
         zPaFyhR3w8bZpBQyC5Uy0ASG/+zWSYVn0AJu2CVH6PTrEkSihwrYqGvHi4qaUhesULTX
         lDiZMvzdAx78cBLYQhmrnAfRB4cXMZv4+Ybcr5TSr1m3/Xkn5PXAQYPJ15FcULcpf/yo
         3vjg==
X-Gm-Message-State: AC+VfDwbCXWyjTpA4q4fvSmyadO6W/uO/1gb+e8muAS2DNsqA+tZdo7v
        Vd2Q85giqv+i96mZSgmb4YxMr2KWsPDaw//xL3Q=
X-Google-Smtp-Source: ACHHUZ4Qeh3aF7ldJIWxeQuiGhAfzCKaBhmImo/mjG/Z/W/artZwpq42q6QVY6Cu5mYFVid6nUOcGw==
X-Received: by 2002:a17:903:2292:b0:1a9:bdf8:f551 with SMTP id b18-20020a170903229200b001a9bdf8f551mr4922223plh.69.1683372473143;
        Sat, 06 May 2023 04:27:53 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001aaeba5ce0fsm3402920plb.68.2023.05.06.04.27.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:27:52 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH 1/1] push: introduce '--branches' option
Date:   Sat,  6 May 2023 19:27:40 +0800
Message-ID: <20230506112740.61454-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20230506112740.61454-1-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-2-tenglong.tl@alibaba-inc.com>
 <20230506112740.61454-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The '--all' option of git-push built-in cmd support to push all branches
(refs under refs/heads) to remote. Under the usage, a user can easlily
work in some scenarios, for example, branches synchronization and batch
upload.

The '--all' was introduced for a long time, meanwhile, git supports to
customize the storage location under "refs/". when a new git user see
the usage like, 'git push origin --all', we might feel like we're
pushing _all_ the refs instead of just branches without looking at the
documents until we found the related description of it or '--mirror'.

To ensure compatibility, we cannot rename '--all' to another name
directly, one way is, we can try to add a new option '--heads' which be
identical with the functionality of '--all' to let the user understand
the meaning of representation more clearly. Actually, We've more or less
named options this way already, for example, in 'git-show-ref' and 'git
ls-remote'.

At the same time, we fix a related issue about the wrong help
information of '--all' option in code and add some test cases in
t5523, t5543 and t5583.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-push.txt |   3 +-
 builtin/push.c             |   7 ++-
 t/t5523-push-upstream.sh   |  12 +++-
 t/t5543-atomic-push.sh     |   5 +-
 t/t5583-push-branches.sh   | 115 +++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 7 deletions(-)
 create mode 100755 t/t5583-push-branches.sh

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5bb1d5aa..297927d8 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
@@ -147,6 +147,7 @@ already exists on the remote side.
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 
 --all::
+--branches::
 	Push all branches (i.e. refs under `refs/heads/`); cannot be
 	used with other <refspec>.
 
diff --git a/builtin/push.c b/builtin/push.c
index 6001e4ae..d616fa83 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -593,11 +593,12 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
-		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL),
+		OPT_BIT( 0 , "all", &flags, N_("push all branches"), TRANSPORT_PUSH_ALL),
+		OPT_ALIAS( 0 , "branches", "all"),
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOL('d', "delete", &deleterefs, N_("delete refs")),
-		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
+		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --branches or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
@@ -640,7 +641,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
-		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--mirror/--tags");
+		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--branches/--mirror/--tags");
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index c9acc076..1b8d6098 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -61,12 +61,20 @@ test_expect_success 'push -u :topic_2' '
 	check_config topic_2 upstream refs/heads/other2
 '
 
-test_expect_success 'push -u --all' '
+test_expect_success 'push -u --all(the same behavior with--branches)' '
 	git branch all1 &&
 	git branch all2 &&
 	git push -u --all &&
 	check_config all1 upstream refs/heads/all1 &&
-	check_config all2 upstream refs/heads/all2
+	check_config all2 upstream refs/heads/all2 &&
+	git config --get-regexp branch.all* > expect &&
+	git config --remove-section branch.all1 &&
+	git config --remove-section branch.all2 &&
+	git push -u --branches &&
+	check_config all1 upstream refs/heads/all1 &&
+	check_config all2 upstream refs/heads/all2 &&
+	git config --get-regexp branch.all* > actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'push -u HEAD' '
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 70431122..04b47ad8 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -117,7 +117,10 @@ test_expect_success 'atomic push fails if one branch fails' '
 		test_commit five &&
 		git checkout main &&
 		test_commit six &&
-		test_must_fail git push --atomic --all up
+		test_must_fail git push --atomic --all up >output-all 2>&1 &&
+		# --all and --branches have the same behavior when be combined with --atomic
+		test_must_fail git push --atomic --branches up >output-branches 2>&1 &&
+		test_cmp output-all output-branches
 	) &&
 	test_refs main HEAD@{7} &&
 	test_refs second HEAD@{4}
diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
new file mode 100755
index 00000000..29a5c560
--- /dev/null
+++ b/t/t5583-push-branches.sh
@@ -0,0 +1,115 @@
+#!bin/sh
+
+test_description='check the consisitency of behavior of --all and --branches'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+delete_refs() {
+	dir=$1
+	shift
+	rm -rf deletes
+	for arg in $*
+	do
+		echo "delete ${arg}" >>deletes
+	done
+	git -C $dir update-ref --stdin < deletes
+}
+
+test_expect_success 'setup bare remote' '
+	git init --bare remote-1 &&
+	git -C remote-1 config gc.auto 0 &&
+	test_commit one &&
+	git push remote-1 HEAD
+'
+
+test_expect_success 'setup different types of references' '
+	cat >refs <<-EOF &&
+	update refs/heads/branch-1 HEAD
+	update refs/heads/branch-2 HEAD
+	EOF
+
+	git tag -a -m "annotated" annotated-1 HEAD &&
+	git tag -a -m "annotated" annotated-2 HEAD &&
+	git update-ref --stdin < refs
+'
+
+test_expect_success '--all and --branches have the same behavior' '
+	test_when_finished "delete_refs remote-1 \
+			   refs/heads/branch-1 \
+			   refs/heads/branch-2" &&
+	git push remote-1 --all &&
+	commit=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+	$commit refs/heads/branch-1
+	$commit refs/heads/branch-2
+	$commit refs/heads/main
+	EOF
+
+	git -C remote-1 show-ref --heads >actual.all &&
+	delete_refs remote-1 refs/heads/branch-1 refs/heads/branch-2 &&
+	git push remote-1 --branches &&
+	git -C remote-1 show-ref --heads >actual.branches &&
+	test_cmp actual.all actual.branches &&
+	test_cmp expect actual.all
+'
+
+test_expect_success '--all or --branches can not be combined with refspecs' '
+	test_must_fail git push remote-1 --all main >actual.all 2>&1 &&
+	test_must_fail git push remote-1 --branches main >actual.branches 2>&1 &&
+	test_cmp actual.all actual.branches &&
+	grep "be combined with refspecs" actual.all
+'
+
+test_expect_success '--all or --branches can not be combined with --mirror' '
+	test_must_fail git push remote-1 --all --mirror >actual.all 2>&1 &&
+	test_must_fail git push remote-1 --branches --mirror >actual.branches 2>&1 &&
+	test_cmp actual.all actual.branches &&
+	grep "cannot be used together" actual.all
+'
+
+test_expect_success '--all or --branches can not be combined with --tags' '
+	test_must_fail git push remote-1 --all --tags >actual.all 2>&1 &&
+	test_must_fail git push remote-1 --branches --tags >actual.branches 2>&1 &&
+	test_cmp actual.all actual.branches &&
+	grep "cannot be used together" actual.all
+'
+
+
+test_expect_success '--all or --branches can not be combined with --delete' '
+	test_must_fail git push remote-1 --all --delete >actual.all 2>&1 &&
+	test_must_fail git push remote-1 --branches --delete >actual.branches 2>&1 &&
+	test_cmp actual.all actual.branches &&
+	grep "cannot be used together" actual.all
+'
+
+test_expect_success '--all or --branches combines with --follow-tags have same behavior' '
+	test_when_finished "delete_refs remote-1 \
+			   refs/heads/branch-1 \
+			   refs/heads/branch-2 \
+			   refs/tags/annotated-1 \
+			   refs/tags/annotated-2" &&
+	git push remote-1 --all --follow-tags &&
+	git -C remote-1 show-ref > actual.all &&
+	cat >expect <<-EOF &&
+	$commit refs/heads/branch-1
+	$commit refs/heads/branch-2
+	$commit refs/heads/main
+	$(git rev-parse annotated-1) refs/tags/annotated-1
+	$(git rev-parse annotated-2) refs/tags/annotated-2
+	EOF
+
+	delete_refs remote-1 \
+		    refs/heads/branch-1 \
+		    refs/heads/branch-2 \
+		    refs/tags/annotated-1 \
+		    refs/tags/annotated-2 &&
+	git push remote-1 --branches --follow-tags &&
+	git -C remote-1 show-ref >actual.branches &&
+	test_cmp actual.all actual.branches &&
+	test_cmp expect actual.all
+'
+
+test_done
-- 
2.40.1.446.gf331623a.dirty

