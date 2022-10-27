Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085A6FA3742
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 12:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiJ0MMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiJ0MMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 08:12:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F0118763
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 05:12:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w14so1819046wru.8
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CBt0btTx3YzjPK1bPso763gpKBCIuNkHlhbjc/dl/Tc=;
        b=Ju8y7QMx7RRLLrToPFxxhLJGQyrqFsP2+2nVznYrxmznuIpaY3GYcEmHI1LOQirHyt
         jXvySFnCKhRO1t2PzCwAYE/zMV8R/xQ+YVf6uxz2uwzFbZqCry6ZtttL02xC35LzDuF1
         Ivc9sEVz1a9HcWYiqwV2ckGckm8c9Wcg7kRzHcMSG4NGslaY0rbRD80vC0T6RWwFJ2TE
         0DGgLvHLH3Gr3jZp+Sp6JeEOeCaMjQsrpUZ15seJ93+AwpE5j1sK5w4neARmGpmLFoDx
         Bps4WY7A+k6w0qwnfWVisexh7GwIQxyADfOWuRUOegcsRGPf4GPzUq/PmDH5WxGyVKR3
         ATUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBt0btTx3YzjPK1bPso763gpKBCIuNkHlhbjc/dl/Tc=;
        b=lDrEPI+hby40K+MneLcB+iH61AxmXm5fb5wBiYcizJF8SGGkWBGzFL0KMxHtbjxfWD
         yAsgv9iH5xkxfpBjnOzd6dKdEkTQcFVz6HEzAUXP+CyEI895hgFqUbPshXfJ2I2g3y/e
         NcLaUSZjHM5w5DZViGcKpzYZIhbLJLQJm2IPIoz52VSkrQUVpqlPnbiL76AZApWoqQz+
         ovabwo+ONDyXFw4i/2uwwzAkWyT9350fC5+H8GK2ikxO/eYzVoC6W9UnI1c4TywG7paW
         0nrf/G65/pmO8ABMwjw6tFWZCTGCCT1/buPtbLN+0QE5JdHyPUGE0J4G6d+06jbhinc3
         wwCg==
X-Gm-Message-State: ACrzQf3F9eqYXigYrdZXDTm9HZCdPelyuPxHameJnX7uaZArckqUl2QX
        Zi0Xm2WWgaMFPPZtRyNXc12Fiq04G8o=
X-Google-Smtp-Source: AMsMyM7v25iVinggXXQIimVVebn0NBcs/D7RMWHs0b0+ttw2yW1jmcT+Sp3RYzc4DJ6oMJRlPeiplg==
X-Received: by 2002:a05:6000:1885:b0:22e:7869:d43f with SMTP id a5-20020a056000188500b0022e7869d43fmr31760991wri.249.1666872762536;
        Thu, 27 Oct 2022 05:12:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003a682354f63sm5307207wmp.11.2022.10.27.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:12:42 -0700 (PDT)
Message-Id: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Oct 2022 12:12:41 +0000
Subject: [PATCH] merge-tree.c: add --merge-base=<commit> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This option allows users to specify a merge-base commit for the merge.

It will give our callers more flexibility to use the `git merge-tree`.
For example:

    git merge-tree --merge-base=<sha1>^1 source-branch <sha1>

This allows us to implement `git cherry-pick` in bare repositories.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge-tree.c: add --merge-base= option
    
    Thanks for Elijah's work. I'm very excited that merge-ort is integrated
    into the git merge-tree, which means that we can use merge-ort in bare
    repositories to optimize merge performance.
    
    In this patch, I introduce a new --merge-base=<commit> option to allow
    callers to specify a merge-base for the merge. This may allow users to
    implement git cherry-pick and git rebase in bare repositories with git
    merge-tree cmd.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

 Documentation/git-merge-tree.txt |  4 +++
 builtin/merge-tree.c             | 23 +++++++++++++----
 t/t4301-merge-tree-write-tree.sh | 44 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d6c356740ef..e762209b76d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -64,6 +64,10 @@ OPTIONS
 	share no common history.  This flag can be given to override that
 	check and make the merge proceed anyway.
 
+--merge-base=<commit>::
+	Instead of finding the merge-bases for <branch1> and <branch2>,
+	specify a merge-base for the merge.
+
 [[OUTPUT]]
 OUTPUT
 ------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..adc461f00f3 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-store.h"
@@ -402,6 +403,7 @@ struct merge_tree_options {
 	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
+	char* merge_base;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -430,11 +432,18 @@ static int real_merge(struct merge_tree_options *o,
 	opt.branch1 = branch1;
 	opt.branch2 = branch2;
 
-	/*
-	 * Get the merge bases, in reverse order; see comment above
-	 * merge_incore_recursive in merge-ort.h
-	 */
-	merge_bases = get_merge_bases(parent1, parent2);
+	if (o->merge_base) {
+		struct commit *c = lookup_commit_reference_by_name(o->merge_base);
+		if (!c)
+			die(_("could not lookup commit %s"), o->merge_base);
+		commit_list_insert(c, &merge_bases);
+	} else {
+		/*
+		 * Get the merge bases, in reverse order; see comment above
+		 * merge_incore_recursive in merge-ort.h
+		 */
+		merge_bases = get_merge_bases(parent1, parent2);
+	}
 	if (!merge_bases && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	merge_bases = reverse_commit_list(merge_bases);
@@ -505,6 +514,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.allow_unrelated_histories,
 			   N_("allow merging unrelated histories"),
 			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "merge-base",
+			 &o.merge_base,
+			 N_("commit"),
+			 N_("specify a merge-base commit for the merge")),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 013b77144bd..032ff4a1c3d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -819,4 +819,48 @@ test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
 	test_must_fail git -C read-only merge-tree side1 side2
 '
 
+# specify merge-base as parent of branch2.
+# git merge-tree --merge-base=A O B
+#   Commit O: foo, bar
+#   Commit A: modify foo after Commit O
+#   Commit B: modify bar after Commit A
+#   Expected: foo is unchanged, modify bar
+
+test_expect_success 'specify merge-base as parent of branch2' '
+	# Setup
+	git init base-b2-p && (
+		cd base-b2-p &&
+		echo foo >foo &&
+		echo bar >bar &&
+		git add foo bar &&
+		git commit -m O &&
+
+		git branch O &&
+		git branch A &&
+
+		git checkout A &&
+		echo "A" >foo &&
+		git add foo &&
+		git commit -m A &&
+
+		git checkout -b B &&
+		echo "B" >bar &&
+		git add bar &&
+		git commit -m B
+	) &&
+	# Testing
+	(
+		cd base-b2-p &&
+		TREE_OID=$(git merge-tree --merge-base=A O B) &&
+
+		q_to_tab <<-EOF >expect &&
+		100644 blob $(git rev-parse B:bar)Qbar
+		100644 blob $(git rev-parse O:foo)Qfoo
+		EOF
+
+		git ls-tree $TREE_OID >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: db29e6bbaed156ae9025ff0474fd788e58230367
-- 
gitgitgadget
