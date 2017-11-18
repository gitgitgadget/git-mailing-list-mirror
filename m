Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2002E201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424416AbdKRSJw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:09:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36084 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030837AbdKRSJs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:09:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so11865342wmr.1
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ZFBVfzboGaHxKClDqTrDj7kgeJPH7jJEZjWWglUgbI=;
        b=XYmutQnECoAgYNLctECVzpLBOtZDUToe2p+i/hCOcZEDxt7NjIk0f+FmMoU/mszGKM
         jwLhRKMEEsRvZLKdUFwSxCQswUsysvc82+nACoQbpDodgGdD/JRCtk8qjaV3sfFq1MLM
         o0j2d2eF3+5JRrVKJaqon0IeWW2Ky0kXfmO1E6270hs0G3r7XKpfYvox2b97cXC1B3qS
         783YB1aNzM2L9KEvQA5XZawPM/0axl2h/oloB8zSBgonfeqr7A8fRz1GBdJ/PSgwgV3x
         3MP2IzKvR5ISdyshoGLnjwt9Nf6m8gzZevfGYjb59TSbdFIX65PAaoLwjg8s3pIyufRv
         zaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ZFBVfzboGaHxKClDqTrDj7kgeJPH7jJEZjWWglUgbI=;
        b=XC0/j9tVZnuKuOmKODLWj02E3wBvbbPqpGeIAwtnwMHe3LRu3FaToJeMvRhTqxLWl3
         hpqom6EYmtY8W5ytOnV/wu6NWMSGfm5D4KA7bM/YoQpm8MD6M19QGHeNqUfqPc+1EG4d
         qXnWmAmvE7zwVdcXyIE3c9DWWV0U1UIIpoLwsgFfivWdDsCTZXaceAx1HGIYYCSOSeJi
         snvOVEXmEmZFoY10CxVYm9h/hieLlzKFt46oE95mjW92J7OdO5X7KWNAD5IEpryAAvAh
         Mx4Q4+2slgDw8eRj9bsA2GDCud2x2Pja6vRXBnYuhSv6Qpug61xME7bq8tp3nM3GfBao
         wnYA==
X-Gm-Message-State: AJaThX6INvXQICHNjADnyfBF9u//bsB6ucSvQfoTnuNgo8jBsYCvfFgl
        TvlUT4XEckTeoynXczdLPFPM3STM
X-Google-Smtp-Source: AGs4zMaeaHAubuTVy7z+v0wmkSHHMEEMFnVyVy9bKqtxTK/TmA6Ydp2/d7DXYl+TLA8vWaIMfTMYdw==
X-Received: by 10.28.27.206 with SMTP id b197mr6579477wmb.96.1511028587354;
        Sat, 18 Nov 2017 10:09:47 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g65sm11691931wmd.16.2017.11.18.10.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 10:09:46 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] worktree: make add <path> <branch> dwim
Date:   Sat, 18 Nov 2017 18:11:02 +0000
Message-Id: <20171118181103.28354-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171118181103.28354-1-t.gummerer@gmail.com>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171118181103.28354-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path> <branch>', errors out when 'branch'
is not a local branch.   It has no additional dwim'ing features that one
might expect.

Make it behave more like 'git checkout <branch>' when the branch doesn't
exist locally, but a remote tracking branch uniquely matches the desired
branch name, i.e. create a new branch from the remote tracking branch
and set the upstream to the remote tracking branch.

As 'git worktree add' currently just dies in this situation, there are
no backwards compatibility worries when introducing this feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  7 +++++++
 builtin/worktree.c             | 15 ++++++++++++++
 t/t2025-worktree-add.sh        | 44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b472acc356..3c7c8c3cee 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,6 +52,13 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<branch>`; it is synonymous with `@{-1}`.
 +
+If <branch> is not found but there does exist a tracking branch in
+exactly one remote (call it <remote>) with a matching name, treat as
+equivalent to
+------------
+$ git worktree add -b <branch> <path> <remote>/<branch>
+------------
++
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b9307aa58..92b583ae39 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
@@ -386,6 +387,20 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.new_branch = xstrndup(s, n);
 	}
 
+	if (ac == 2) {
+		struct object_id oid;
+		struct commit *commit;
+		const char *remote;
+
+		commit = lookup_commit_reference_by_name(branch);
+		if (!commit)
+			remote = unique_tracking_name(branch, &oid);
+		if (!commit && remote) {
+			opts.new_branch = branch;
+			branch = remote;
+		}
+	}
+
 	if (opts.new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..e5959800c0 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -6,6 +6,16 @@ test_description='test git worktree add'
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
+
 test_expect_success 'setup' '
 	test_commit init
 '
@@ -314,4 +324,38 @@ test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
 
+test_expect_success '"add" <path> <non-existent-branch> fails' '
+	test_must_fail git worktree add foo non-existent
+'
+
+test_expect_success '"add" <path> <branch> dwims' '
+	test_when_finished rm -rf repo_upstream &&
+	test_when_finished rm -rf repo_dwim &&
+	test_when_finished rm -rf foo &&
+	git init repo_upstream &&
+	(
+		cd repo_upstream &&
+		test_commit upstream_master &&
+		git checkout -b foo &&
+		test_commit a_foo
+	) &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		test_commit dwim_master &&
+		git remote add repo_upstream ../repo_upstream &&
+		git config remote.repo_upstream.fetch \
+			  "refs/heads/*:refs/remotes/repo_upstream/*" &&
+		git fetch --all &&
+		git worktree add ../foo foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		git rev-parse repo_upstream/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.15.0.345.gf926f18f3d

