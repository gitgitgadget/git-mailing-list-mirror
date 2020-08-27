Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C9C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7334920738
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG/wKWiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgH0IXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgH0IXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD8C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:07 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v2so4184045ilq.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdQuL54/QmlfS75KksDb6aG7WJADBdeDPPR29tmxWiE=;
        b=rG/wKWiPrq+F/N4qo5EAG3LZZQl+UxT9Wk4QxBjPuDl1GWrbonCOpE+Lb9F+foeLgL
         VUglCvs+eWpSTCdJ1yiHbyPWcBDOqrCFKOvqLYkX/J3XP013nJ/x+sgWUGqFk+WeWdX4
         Gwx4Nn7XLxK5MfDWGx3KO7cPPlkRIPet+DPc8kbcVzu6AYbMbRopvMZBqa9k+A+os6lP
         DqkUWia+JTBCNmET7MSIgO1QMa4kHJBVX0WtSY27K8dGhBVACdn+idxDKJOzGGv7ex7Y
         +PsOI1jWl3ygyy/c++n63g5Hfhy0n8EDPktk9Nq/i2sN32UY1H6YtWGGqCdfSlHd0Xvm
         jDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HdQuL54/QmlfS75KksDb6aG7WJADBdeDPPR29tmxWiE=;
        b=JwruGhhWVnZ2LfFvYxf2VBhG6lU/nhWzskJpmG+JHTfU92OW4oAYC0Zw9XWWV/Feun
         wME2Nh9MDeLbd7hVXpRcUWz9kZTQkDaQlwCGJb4Xo2aphWERxX5MGyMUdYAAPBxLmniP
         k7JZxWJZW4RZN2l0hxfmNuaJuJgQ7DQufuVmVuxYwx+FYUUcc3A4D2+k3PuAJn/U9tNb
         ZJ8++cY9sVd5Q6p2myxPiohk8DFQL4bLQnh1u7Oy7joqwTVQ0yeMMkqj9BR/pcWBCuNF
         ZgtohVLEvgOA0Wks8A5y9oEm1ghh8MO+ae6Jg8pF7AjgSrb2L6XssshFOEsBJfFdxK6C
         yuPA==
X-Gm-Message-State: AOAM530Q0vOnVledLeFSscD6KJMzJirI5mgRvBhnNRbyL3gy6nS9Xe19
        l5Myy/6uvZc2kwyWCHVYGCt+I4z3PlU=
X-Google-Smtp-Source: ABdhPJzk+oZsDEwL/9wqNxW7lAqOKYStTcAQw9S83vjKqhj4U8VDRlU6xO4LT7+thWuIdKoCUQ9+/w==
X-Received: by 2002:a05:6e02:1107:: with SMTP id u7mr16575891ilk.165.1598516585981;
        Thu, 27 Aug 2020 01:23:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/5] worktree: teach "repair" to fix worktree back-links to main worktree
Date:   Thu, 27 Aug 2020 04:21:26 -0400
Message-Id: <20200827082129.56149-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .git file in a linked worktree is a "gitlink" which points back to
the .git/worktrees/<id> entry in the main worktree or bare repository.
If a worktree's .git file is deleted or becomes corrupted or outdated,
then the linked worktree won't know how to find the repository or any of
its own administrative files (such as 'index', 'HEAD', etc.). An easy
way for the .git file to become outdated is for the user to move the
main worktree or bare repository. Although it is possible to manually
update each linked worktree's .git file to reflect the new repository
location, doing so requires a level of knowledge about worktree
internals beyond what a user should be expected to know offhand.

Therefore, teach "git worktree repair" how to repair broken or outdated
worktree .git files automatically. (For this to work, the command must
be invoked from within the main worktree or bare repository, or from
within a worktree which has not become disconnected from the repository
-- such as one which was created after the repository was moved.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 10 ++++-
 builtin/worktree.c             | 11 ++++++
 t/t2406-worktree-repair.sh     | 72 ++++++++++++++++++++++++++++++++++
 worktree.c                     | 53 +++++++++++++++++++++++++
 worktree.h                     | 11 ++++++
 5 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index ae432d39a8..acb0ea1c2e 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -98,7 +98,10 @@ with `--reason`.
 move::
 
 Move a working tree to a new location. Note that the main working tree
-or linked working trees containing submodules cannot be moved.
+or linked working trees containing submodules cannot be moved with this
+command. (The `git worktree repair` command, however, can reestablish
+the connection with linked working trees if you move the main working
+tree manually.)
 
 prune::
 
@@ -115,6 +118,11 @@ repair::
 
 Repair working tree administrative files, if possible, if they have
 become corrupted or outdated due to external factors.
++
+For instance, if the main working tree (or bare repository) is moved,
+linked working trees will be unable to locate it. Running `repair` in
+the recently-moved main working tree will reestablish the connection
+from linked working trees back to the main working tree.
 
 unlock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88af412d4f..62e33eb7f5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1030,6 +1030,16 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void repair_cb(int iserr, const char *path, const char *msg, void *cb_data)
+{
+	if (!iserr)
+		printf_ln(_("repair: %s: %s"), msg, path);
+	else {
+		fprintf_ln(stderr, _("error: %s: %s"), msg, path);
+		*(int *)cb_data = 1;
+	}
+}
+
 static int repair(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -1040,6 +1050,7 @@ static int repair(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	repair_worktrees(repair_cb, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index cc679e1a21..9379a63130 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -8,4 +8,76 @@ test_expect_success setup '
 	test_commit init
 '
 
+test_expect_success 'skip missing worktree' '
+	test_when_finished "git worktree prune" &&
+	git worktree add --detach missing &&
+	rm -rf missing &&
+	git worktree repair >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
+test_expect_success "don't clobber .git repo" '
+	test_when_finished "rm -rf repo && git worktree prune" &&
+	git worktree add --detach repo &&
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_must_fail git worktree repair >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep ".git is not a file" err
+'
+
+test_corrupt_gitlink () {
+	butcher=$1 &&
+	problem=$2 &&
+	repairdir=${3:-.} &&
+	test_when_finished 'rm -rf corrupt && git worktree prune' &&
+	git worktree add --detach corrupt &&
+	git -C corrupt rev-parse --absolute-git-dir >expect &&
+	eval "$butcher" &&
+	git -C "$repairdir" worktree repair >out 2>err &&
+	test_i18ngrep "$problem" out &&
+	test_must_be_empty err &&
+	git -C corrupt rev-parse --absolute-git-dir >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'repair missing .git file' '
+	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken"
+'
+
+test_expect_success 'repair bogus .git file' '
+	test_corrupt_gitlink "echo \"gitdir: /nowhere\" >corrupt/.git" \
+		".git link broken"
+'
+
+test_expect_success 'repair incorrect .git file' '
+	test_when_finished "rm -rf other && git worktree prune" &&
+	test_create_repo other &&
+	other=$(git -C other rev-parse --absolute-git-dir) &&
+	test_corrupt_gitlink "echo \"gitdir: $other\" >corrupt/.git" \
+		".git link incorrect"
+'
+
+test_expect_success 'repair .git file from main/.git' '
+	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken" .git
+'
+
+test_expect_success 'repair .git file from linked worktree' '
+	test_when_finished "rm -rf other && git worktree prune" &&
+	git worktree add --detach other &&
+	test_corrupt_gitlink "rm -f corrupt/.git" ".git link broken" other
+'
+
+test_expect_success 'repair .git file from bare.git' '
+	test_when_finished "rm -rf bare.git corrupt && git worktree prune" &&
+	git clone --bare . bare.git &&
+	git -C bare.git worktree add --detach ../corrupt &&
+	git -C corrupt rev-parse --absolute-git-dir >expect &&
+	rm -f corrupt/.git &&
+	git -C bare.git worktree repair &&
+	git -C corrupt rev-parse --absolute-git-dir >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index 62217b4a6b..029ce91fdf 100644
--- a/worktree.c
+++ b/worktree.c
@@ -571,3 +571,56 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 	return ret;
 }
+
+/*
+ * Repair worktree's /path/to/worktree/.git link if missing, corrupt, or not
+ * pointing at <repo>/worktrees/<id>.
+ */
+static void repair_dotgit(struct worktree *wt,
+			  worktree_repair_cb *cb, void *cb_data)
+{
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf repo = STRBUF_INIT;
+	char *backlink;
+	const char *repair = NULL;
+	int err;
+
+	/* missing worktree can't be repaired */
+	if (!file_exists(wt->path))
+		return;
+
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+	strbuf_addf(&dotgit, "%s/.git", wt->path);
+	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+
+	if (err == READ_GITFILE_ERR_NOT_A_FILE)
+		cb(1, wt->path, _(".git is not a file"), cb_data);
+	else if (err)
+		repair = _(".git link broken");
+	else if (fspathcmp(backlink, repo.buf))
+		repair = _(".git link incorrect");
+
+	if (repair) {
+		cb(0, wt->path, repair, cb_data);
+		write_file(dotgit.buf, "gitdir: %s", repo.buf);
+	}
+
+	free(backlink);
+	strbuf_release(&repo);
+	strbuf_release(&dotgit);
+}
+
+static void repair_noop_cb(int iserr, const char *path, const char *msg,
+			   void *cb_data) {}
+
+void repair_worktrees(worktree_repair_cb *cb, void *cb_data)
+{
+	struct worktree **worktrees = get_worktrees();
+	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
+
+	if (!cb)
+		cb = repair_noop_cb;
+	for (; *wt; wt++)
+		repair_dotgit(*wt, cb, cb_data);
+	free_worktrees(worktrees);
+}
diff --git a/worktree.h b/worktree.h
index 516744c433..7d085c7b91 100644
--- a/worktree.h
+++ b/worktree.h
@@ -89,6 +89,17 @@ int validate_worktree(const struct worktree *wt,
 void update_worktree_location(struct worktree *wt,
 			      const char *path_);
 
+typedef void worktree_repair_cb(int iserr, const char *path, const char *msg,
+				void *cb_data);
+
+/*
+ * Visit each registered linked worktree and repair corruptions. For each
+ * repair made or error encountered while attempting a repair, the callback, if
+ * non-NULL, is called with the path of the worktree and a description of the
+ * repair or error, along with the callback user-data.
+ */
+void repair_worktrees(worktree_repair_cb *, void *cb_data);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.28.0.461.g40977abb40

