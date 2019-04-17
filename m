Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA55C20248
	for <e@80x24.org>; Wed, 17 Apr 2019 21:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfDQVVe (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 17:21:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46040 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 17:21:34 -0400
Received: by mail-qk1-f202.google.com with SMTP id w124so90362qkb.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1EE0G2KKfuXY5VM0VLlEYGWbeurWknbMdgTKOoJbyRg=;
        b=Qa06F96RQsbpRv09r6AtAZNiNiALmWF81rmPwV5UAiMxxyeNr9CSNnr2F8iEhJ5pda
         axBvpYrpoDzZbOdeGWKHj13TyM1iwb85WtaRpwjkW+cikQ/xSSLZjcGuQzmXmmhkLvPE
         bzET3ZXQJvtxyamlGE2xH43HKAqJfhwNoMrvIrxRTwp4fI/pWTgl6FUsB3sIafKilIuz
         o1hNdKoL1StTBkCxH/ODEP07Yo+BipqM6GlR/AvQq0EP7D2w3AWQAR1vib0/cLoBRZav
         EkYF4RJX35nB1D3WXbUvd9Ne2ULgDy/xspwrAiEENNfsJEL5KX9nRmR88RPsQoFshz2W
         dVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1EE0G2KKfuXY5VM0VLlEYGWbeurWknbMdgTKOoJbyRg=;
        b=ovV+yLvjKZd1nEM7HZiL3QKltd9JGNoA1o0tCbHd1BHyeaUE+UP51moeal4PJ/rj6c
         oiyJ93fU6dBwfhlbA9DoEeS5uQ6OIDmSKJ1LxqZYPGyLaIS0zn+lIGCJsCauRFUt+GlO
         sGy1PzHAGPX0g93TvuqmWSef+AXZoU7OO3g8RHpUw34YVNV6MQulG1IU9YnX2d1B2lUk
         lAX1k0Q5E8vbaYMTetmd4uutpiUSICLqFbBpe00QFfM9XRNtMEG+3wJUCm4MrW+JHw/J
         +9HCjZn6ARrm3Yc0EcjtPkNKraXg9a9K7RmDs4WR2VE70yHvY9SQvIOi7y40ieOnyGEZ
         zKbw==
X-Gm-Message-State: APjAAAWKsoT/Uhcnl8btVAxXBN3QdV7AOvGhWUfOASHCvNHlLexroGuL
        fGoafps0OEp5HMXhqjW1DUJGnRmBITuy0QA4Pc69/hwGehfk7xk6z8A5ZsOfZQ14V5cQCLk3jV9
        k4T3f438EhkqOeYMToWCX3wuWFOjTMhvxxS4BemhTsQms5LZroWgi1TH9Ks3vXstPT0da65NgcF
        Rd
X-Google-Smtp-Source: APXvYqy6EshVH6TG05ARMzFQ6yKFne8k1Z/nmaO0ACCI/8KkwN1/3rk5EsxQJTYyLxkMQGFpFkMSX1wmC9fqsMSv8uLi
X-Received: by 2002:ac8:170d:: with SMTP id w13mr75201303qtj.220.1555536093305;
 Wed, 17 Apr 2019 14:21:33 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:21:28 -0700
Message-Id: <20190417212128.52475-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] worktree: update is_bare heuristics
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes.Schindelin@gmx.de, rappazzo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git branch -D <name>" is run, Git usually first checks if that
branch is currently checked out. But this check is not performed if the
Git directory of that repository is not at "<repo>/.git", which is the
case if that repository is a submodule that has its Git directory stored
as "super/.git/modules/<repo>", for example.

This is because get_main_worktree() in worktree.c sets is_bare on a
worktree only using the heuristic that a repo is bare if the worktree's
path ends in "/.git", and not bare otherwise. This is_bare code was
introduced in 92718b7438 ("worktree: add details to the worktree
struct", 2015-10-08), following a pre-core.bare heuristic. This patch
does 2 things:

 - Teach get_main_worktree() to use is_bare_repository() instead,
   introduced in 7d1864ce67 ("Introduce is_bare_repository() and
   core.bare configuration variable", 2007-01-07) and updated in
   e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
   the "git branch -D <name>" problem described above. However...

 - If a repository has core.bare=1 but the "git" command is being run
   from one of its added worktrees, is_bare_repository() returns false
   (which is fine, since there is a worktree available). However,
   commands like "git worktree list" currently distinguish between a
   repository that has core.bare=1 but has a worktree available, and a
   repository that is truly non-bare (core.bare=0). To preserve this
   distinction, also check core.bare when setting is_bare. If
   core.bare=1, trust it, and otherwise, use is_bare_repository().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t3200-branch.sh | 14 ++++++++++++++
 worktree.c        |  7 +++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..db5c411e76 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -264,6 +264,20 @@ test_expect_success 'git branch --list -d t should fail' '
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
 test_expect_success 'git branch --list -v with --abbrev' '
 	test_when_finished "git branch -D t" &&
 	git branch t &&
diff --git a/worktree.c b/worktree.c
index b45bfeb9d3..5d52b2ba53 100644
--- a/worktree.c
+++ b/worktree.c
@@ -49,18 +49,17 @@ static struct worktree *get_main_worktree(void)
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
+	worktree->is_bare = (is_bare_repository_cfg == 1) ||
+		is_bare_repository();
 	add_head_info(worktree);
 
 	strbuf_release(&path);
-- 
2.21.0.392.gf8f6787159e-goog

