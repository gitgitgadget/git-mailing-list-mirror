Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792DC7EE22
	for <git@archiver.kernel.org>; Sat,  6 May 2023 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjEFLeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFLeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 07:34:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF57681
        for <git@vger.kernel.org>; Sat,  6 May 2023 04:34:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643990c5319so1782620b3a.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683372857; x=1685964857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KtVkhhUsiSi79JGED6DbeKTUQS+ilt169uapZxp7LM=;
        b=M3QkMIocnHPdyVjShGQI2lFAOyvm7UoXrzY+y04b9+0ma3dg+4cGS/88FDIC0pMR3D
         BZ8W9FctasTUV7IhsfcMfRzqWnCxSY+zRiZ3rrShQppkm55Pg0MsCFFqcV2Evd3UjqH+
         0UklEt6lkyo+xuZY8EM0RpMX/XwkraB4Z1PCo7wCQEqSq84ndlQ2KaIuZeV+kb97Bb3z
         TKL0n2wzc99KcIf3DwoYSKw0ARtugl4T7lRVVmrURU9R0HffTkAWwwZw/TjNfQE7JLrG
         sWlq/JuUBF0U86aqWL4lyDo29/zatXwwSFokBS+2JO8W77nKKkiUgV3/MIqTOqNeh7PG
         NDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683372857; x=1685964857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KtVkhhUsiSi79JGED6DbeKTUQS+ilt169uapZxp7LM=;
        b=c3esnYl6n0rwvK/s6/Ra9JZlSemn9hE/qvnyVQpFV5xOqVNvnvT3AJZhHm742v2sh2
         RHdZFRNgOnt/YDCyVVH5llAObvNsOQ3WjG2q+9UjUbqxd5A1jPlLSsXxHxqLjT1DoedZ
         5Slh7nWrQw4QI7oKVv/bz3tBBevBy9NqQ6p/Pt+mVVLKBcdOSv5zz6FFOR70fdKDrUcR
         EAojk1eFdWTh74vqryJsZ/Fyl8virG52rVlIFU+lvzJv0rqH6u1JpMawKQolbDfoVmcl
         mgg/9xeLC3NKfbsn6yZWAwmQY54PxXrM/zqUW4hpwVtUweyz5HVbKIU3PKzsoZVsx3gC
         lUoA==
X-Gm-Message-State: AC+VfDwX2nQxgp/5NJMC9qQNqUJtvS/Zu/5rpZ+OKf8GN8zSw06T2nQ9
        dzt7ass66lB2UtrzeIuEGoY=
X-Google-Smtp-Source: ACHHUZ5VvgzF0wPRx9aLGpb4MPv8l9l9WCuUhYzXKzKaUhEu8nbT1O0CAYQjmaf5YnF23d9oQLPHdQ==
X-Received: by 2002:a05:6a00:21d4:b0:623:c117:f20e with SMTP id t20-20020a056a0021d400b00623c117f20emr6043799pfj.19.1683372856672;
        Sat, 06 May 2023 04:34:16 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id e19-20020a62ee13000000b0062e0c39977csm3001244pfi.139.2023.05.06.04.34.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 04:34:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com,
        adlternative@gmail.com
Subject: [PATCH 1/1] push: introduce '--branches' option
Date:   Sat,  6 May 2023 19:34:08 +0800
Message-ID: <20230506113408.61529-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20230506113408.61529-1-tenglong.tl@alibaba-inc.com>
References: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
 <20230506113408.61529-1-tenglong.tl@alibaba-inc.com>
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

