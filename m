Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447C020305
	for <e@80x24.org>; Fri, 19 Apr 2019 18:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfDSSTF (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:19:05 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36128 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfDSSS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:18:58 -0400
Received: by mail-pg1-f202.google.com with SMTP id l13so3865562pgp.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=75kljDTxmQfBsaPcgorTDQfA/WnU5ykrdeEFHs9FMcw=;
        b=fcW3UpO6yslav7rxMCtigjXwEEvUoxKkyv+Nz6uh4kqaWhOUKaZsyGU8F2proxTr38
         Hxx/ZlpxLK6RA2M9kzoRm7DMaFNuO7996bdct2Z2BClBRsxHy3bpKF4fhu8teYydXBmx
         KPk5XkhU2cUsoFNscJPscsHMPJVwElB3Sssk1L7pEcLTJeygn4/bDbdh6+adx0sQ78AV
         3t94JTo9XHCZejg68Ma/uIf5MZrvAF/I3Q5zujt0VO3KmLA5Hcvh24IewDzA5FJ0gp+x
         3RSNhyucHAx3Ov1JjlY4Utw1TW5bJEeUSy5FQTR0s7dEv0eAikcoW0FV+Y5FH1JqtrAM
         f3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=75kljDTxmQfBsaPcgorTDQfA/WnU5ykrdeEFHs9FMcw=;
        b=Sobg6JzRmeGnLN8cXumK0jT9DPzZnZ91vN01wmI566u3YdQfN4Bi1E8asNzGmcGFTX
         gpTQNTiFmuPVjXy+0sFJOy6ZUUNqP0eK8TQNp7VEJfsYdFfvSOUnJ5o0jwdJtAmISl54
         Bcp35GzfsBa9+v5N45fXC4FZs2CaK9Pfi8ZTH36Gp9ptIGqhkS81J5LHysmahVmQtucY
         XMMRy8icoORAwmGPwygbvr/ntmtM7ZcD1A+jVcUHOGfcKhm8k0+34pFU0KzBZUCSTJRt
         bRh/6jtLNgPDwBsQk0bR3Wn4wfB2BFyIR2Qz4QgKNpIgAFcsLrQYs/Wk8gFK9xXSHsEM
         mMVA==
X-Gm-Message-State: APjAAAXcFi8k2pT9ZRaqfVOSkPmR8PnyMp2Qpw+fbPZtBk7SOwRAi9iG
        Q3j/InqwBfTpBQCB6ClE9tgOuGdmjqBM0Da+2CYx+c+J3mULO9oR87BPXjtqkvuc+aSSCm05kjg
        O+ID9Q5HguCBFl2Tmv+0/qQvK8jS89gs0XTEqfwG63D60hhkbzVXG/SsDQAEQZ+gXn+/Nazycms
        BF
X-Google-Smtp-Source: APXvYqyIgIO9uU50NKZhW1vwn8QuZ/J+G+TdBvgszqXgVbVVyRMzwJnbmO74UXSkq+NGCIbWewy0biI+LO+Ij2hEqzll
X-Received: by 2002:a63:3284:: with SMTP id y126mr4985863pgy.424.1555694494241;
 Fri, 19 Apr 2019 10:21:34 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:21:28 -0700
In-Reply-To: <20190417212128.52475-1-jonathantanmy@google.com>
Message-Id: <20190419172128.130170-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190417212128.52475-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] worktree: update is_bare heuristics
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, pclouds@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git branch -D <name>" is run, Git usually first checks if that
branch is currently checked out. But this check is not performed if the
Git directory of that repository is not at "<repo>/.git", which is the
case if that repository is a submodule that has its Git directory stored
as "super/.git/modules/<repo>", for example. This results in the branch
being deleted even though it is checked out.

This is because get_main_worktree() in worktree.c sets is_bare on a
worktree only using the heuristic that a repo is bare if the worktree's
path does not end in "/.git", and not bare otherwise. This is_bare code
was introduced in 92718b7438 ("worktree: add details to the worktree
struct", 2015-10-08), following a pre-core.bare heuristic. This patch
does 2 things:

 - Teach get_main_worktree() to use is_bare_repository() instead,
   introduced in 7d1864ce67 ("Introduce is_bare_repository() and
   core.bare configuration variable", 2007-01-07) and updated in
   e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
   the "git branch -D <name>" problem described above. However...

 - If a repository has core.bare=1 but the "git" command is being run
   from one of its secondary worktrees, is_bare_repository() returns
   false (which is fine, since there is a worktree available). However,
   treating the main worktree as non-bare when it is bare causes issues:
   for example, failure to delete a branch from a secondary worktree
   that is referred to by a main worktree's HEAD, even if that main
   worktree is bare.

   In order to avoid that, also check core.bare when setting is_bare. If
   core.bare=1, trust it, and otherwise, use is_bare_repository().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, everyone, for your reviews.

Changes:
 - s/ends/does not end/ in commit message (thanks, Duy)
 - better rationale for using (is_bare_repository_cfg == 1) in commit
   message, and added test to check that
 - added NEEDSWORK

Range-diff against v1:
1:  d0934b13ae ! 1:  62be513269 worktree: update is_bare heuristics
    @@ -6,12 +6,13 @@
         branch is currently checked out. But this check is not performed if the
         Git directory of that repository is not at "<repo>/.git", which is the
         case if that repository is a submodule that has its Git directory stored
    -    as "super/.git/modules/<repo>", for example.
    +    as "super/.git/modules/<repo>", for example. This results in the branch
    +    being deleted even though it is checked out.
     
         This is because get_main_worktree() in worktree.c sets is_bare on a
         worktree only using the heuristic that a repo is bare if the worktree's
    -    path ends in "/.git", and not bare otherwise. This is_bare code was
    -    introduced in 92718b7438 ("worktree: add details to the worktree
    +    path does not end in "/.git", and not bare otherwise. This is_bare code
    +    was introduced in 92718b7438 ("worktree: add details to the worktree
         struct", 2015-10-08), following a pre-core.bare heuristic. This patch
         does 2 things:
     
    @@ -22,12 +23,14 @@
            the "git branch -D <name>" problem described above. However...
     
          - If a repository has core.bare=1 but the "git" command is being run
    -       from one of its added worktrees, is_bare_repository() returns false
    -       (which is fine, since there is a worktree available). However,
    -       commands like "git worktree list" currently distinguish between a
    -       repository that has core.bare=1 but has a worktree available, and a
    -       repository that is truly non-bare (core.bare=0). To preserve this
    -       distinction, also check core.bare when setting is_bare. If
    +       from one of its secondary worktrees, is_bare_repository() returns
    +       false (which is fine, since there is a worktree available). However,
    +       treating the main worktree as non-bare when it is bare causes issues:
    +       for example, failure to delete a branch from a secondary worktree
    +       that is referred to by a main worktree's HEAD, even if that main
    +       worktree is bare.
    +
    +       In order to avoid that, also check core.bare when setting is_bare. If
            core.bare=1, trust it, and otherwise, use is_bare_repository().
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
    @@ -52,6 +55,16 @@
     +	git -C repo2/sub checkout -b work &&
     +	test_must_fail git -C repo2/sub branch -D work
     +'
    ++
    ++test_expect_success 'bare main worktree has HEAD at branch deleted by secondary worktree' '
    ++	test_when_finished "rm -rf nonbare base secondary" &&
    ++
    ++	git init nonbare &&
    ++	test_commit -C nonbare x &&
    ++	git clone --bare nonbare bare &&
    ++	git -C bare worktree add --detach ../secondary master &&
    ++	git -C secondary branch -D master
    ++'
     +
      test_expect_success 'git branch --list -v with --abbrev' '
      	test_when_finished "git branch -D t" &&
    @@ -77,6 +90,13 @@
      	worktree = xcalloc(1, sizeof(*worktree));
      	worktree->path = strbuf_detach(&worktree_path, NULL);
     -	worktree->is_bare = is_bare;
    ++	/*
    ++	 * NEEDSWORK: If this function is called from a secondary worktree and
    ++	 * config.worktree is present, is_bare_repository_cfg will reflect the
    ++	 * contents of config.worktree, not the contents of the main worktree.
    ++	 * This means that worktree->is_bare may be set to 0 even if the main
    ++	 * worktree is configured to be bare.
    ++	 */
     +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
     +		is_bare_repository();
      	add_head_info(worktree);

 t/t3200-branch.sh | 24 ++++++++++++++++++++++++
 worktree.c        | 14 ++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..e9ad50b66d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -264,6 +264,30 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_must_fail git rev-parse refs/heads/t
 '
 
+test_expect_success 'deleting checked-out branch from repo that is a submodule' '
+	test_when_finished "rm -rf repo1 repo2" &&
+
+	git init repo1 &&
+	git init repo1/sub &&
+	test_commit -C repo1/sub x &&
+	git -C repo1 submodule add ./sub &&
+	git -C repo1 commit -m "adding sub" &&
+
+	git clone --recurse-submodules repo1 repo2 &&
+	git -C repo2/sub checkout -b work &&
+	test_must_fail git -C repo2/sub branch -D work
+'
+
+test_expect_success 'bare main worktree has HEAD at branch deleted by secondary worktree' '
+	test_when_finished "rm -rf nonbare base secondary" &&
+
+	git init nonbare &&
+	test_commit -C nonbare x &&
+	git clone --bare nonbare bare &&
+	git -C bare worktree add --detach ../secondary master &&
+	git -C secondary branch -D master
+'
+
 test_expect_success 'git branch --list -v with --abbrev' '
 	test_when_finished "git branch -D t" &&
 	git branch t &&
diff --git a/worktree.c b/worktree.c
index b45bfeb9d3..4f66cd9ce1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -49,18 +49,24 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
-	int is_bare = 0;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
-	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
-	if (is_bare)
+	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
 		strbuf_strip_suffix(&worktree_path, "/.");
 
 	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	worktree->is_bare = is_bare;
+	/*
+	 * NEEDSWORK: If this function is called from a secondary worktree and
+	 * config.worktree is present, is_bare_repository_cfg will reflect the
+	 * contents of config.worktree, not the contents of the main worktree.
+	 * This means that worktree->is_bare may be set to 0 even if the main
+	 * worktree is configured to be bare.
+	 */
+	worktree->is_bare = (is_bare_repository_cfg == 1) ||
+		is_bare_repository();
 	add_head_info(worktree);
 
 	strbuf_release(&path);
-- 
2.21.0.392.gf8f6787159e-goog

