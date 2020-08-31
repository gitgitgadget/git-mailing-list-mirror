Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBCC433E7
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482212072D
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyS1ELMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgHaG7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgHaG7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7AEC061755
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l8so4827318ios.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CJJa4kEA1ZML0Bx7zOmTmNSwC4jaZoRn+dElykuMk4=;
        b=uyS1ELMGb+/H5LqJuznxhlBo/HmstrF9BjzIvEqffNlWdQqTQlKmBztrtF/DBuUZ9p
         qXPy0kHqGYCrsCC826UaOjzroyo74ZK2hoq8Bm3+FLFt9oqUwDnncuaGbROu9JMA/w/V
         P0afPAZW4Q8JMV/kRNkN6S+H98PSOLZUuwApGDYfhwRQ6J2Ly1A/YJSamsHS9PgpbrNC
         O98RhLDzRT11i82Uib0yMksrP2Ng1cs3zvUCzeraGHj8dv7E2F1znPvZYuoQnpZzRAP7
         lHo4LDRYUD5dKDVYoGXaumRv7//P7ZnrEY6VMSP2Oeg3Hi42rIpSxgxy+RODztahLZ9/
         uslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3CJJa4kEA1ZML0Bx7zOmTmNSwC4jaZoRn+dElykuMk4=;
        b=eXJ+6jAmZzpyY0hDFXW3KkUATEO5XDr2kmRePWSWvirNz5EaadN35zllz26wjOEMrg
         5emmksboJrgoCQxW2i+jo2I2DGDpZxYvQkp3nRKCTttLpjnM0VWB1/Gulo2C343gisNj
         41fGpoI5px26dGbi1kHW6uRGBxmOZOuipIfJqiluj0gzwB5YoGczKd79QB+Ub6M7NZZW
         hEJXPx4Wk3T+RyxgMrsGwHb7+dSBCpkWx80IfEuRDT/DeeyxzqaALwWclfYQ1rKHm0vs
         zC479YbEOzajbE7X8Pn32/WqgLsk3h4ruoXuJV/jnAzPRGCZ/fKmVd1p52KLozUfZLp1
         sdBw==
X-Gm-Message-State: AOAM531MctkgxaaO+y5++Fk3bzzGMDM+A3T/19qIWLkynhJjsYjwhYkc
        xP+qHu+we5iigSW/weyVZpqP9Dc70K4=
X-Google-Smtp-Source: ABdhPJz7d+N050CkmSn/A9UOz0vYj9Y1zvxwtnjCgCFHoTcKx2abpzNF5itqGQ3+VENn3g2Q1MRVGg==
X-Received: by 2002:a02:94c8:: with SMTP id x66mr35888jah.64.1598857144309;
        Sun, 30 Aug 2020 23:59:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] worktree: teach "repair" to fix worktree back-links to main worktree
Date:   Mon, 31 Aug 2020 02:57:57 -0400
Message-Id: <20200831065800.62502-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200831065800.62502-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The .git file in a linked worktree is a "gitfile" which points back to
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
 builtin/worktree.c             | 12 +++++
 t/t2406-worktree-repair.sh     | 82 ++++++++++++++++++++++++++++++++++
 worktree.c                     | 61 +++++++++++++++++++++++++
 worktree.h                     | 11 +++++
 5 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index ae432d39a8..34fe47cecd 100644
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
+the main working tree will reestablish the connection from linked
+working trees back to the main working tree.
 
 unlock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88af412d4f..68b0032428 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1030,6 +1030,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void report_repair(int iserr, const char *path, const char *msg, void *cb_data)
+{
+	if (!iserr) {
+		printf_ln(_("repair: %s: %s"), msg, path);
+	} else {
+		int *exit_status = (int *)cb_data;
+		fprintf_ln(stderr, _("error: %s: %s"), msg, path);
+		*exit_status = 1;
+	}
+}
+
 static int repair(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -1040,6 +1051,7 @@ static int repair(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	repair_worktrees(report_repair, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index cc679e1a21..ef59cdce95 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -8,4 +8,86 @@ test_expect_success setup '
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
+test_expect_success 'worktree path not directory' '
+	test_when_finished "git worktree prune" &&
+	git worktree add --detach notdir &&
+	rm -rf notdir &&
+	>notdir &&
+	test_must_fail git worktree repair >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep "not a directory" err
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
+test_corrupt_gitfile () {
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
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken"
+'
+
+test_expect_success 'repair bogus .git file' '
+	test_corrupt_gitfile "echo \"gitdir: /nowhere\" >corrupt/.git" \
+		".git file broken"
+'
+
+test_expect_success 'repair incorrect .git file' '
+	test_when_finished "rm -rf other && git worktree prune" &&
+	test_create_repo other &&
+	other=$(git -C other rev-parse --absolute-git-dir) &&
+	test_corrupt_gitfile "echo \"gitdir: $other\" >corrupt/.git" \
+		".git file incorrect"
+'
+
+test_expect_success 'repair .git file from main/.git' '
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" .git
+'
+
+test_expect_success 'repair .git file from linked worktree' '
+	test_when_finished "rm -rf other && git worktree prune" &&
+	git worktree add --detach other &&
+	test_corrupt_gitfile "rm -f corrupt/.git" ".git file broken" other
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
index 62217b4a6b..3ad93cc4aa 100644
--- a/worktree.c
+++ b/worktree.c
@@ -571,3 +571,64 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 	return ret;
 }
+
+/*
+ * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
+ * pointing at <repo>/worktrees/<id>.
+ */
+static void repair_gitfile(struct worktree *wt,
+			   worktree_repair_fn fn, void *cb_data)
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
+	if (!is_directory(wt->path)) {
+		fn(1, wt->path, _("not a directory"), cb_data);
+		return;
+	}
+
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+	strbuf_addf(&dotgit, "%s/.git", wt->path);
+	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+
+	if (err == READ_GITFILE_ERR_NOT_A_FILE)
+		fn(1, wt->path, _(".git is not a file"), cb_data);
+	else if (err)
+		repair = _(".git file broken");
+	else if (fspathcmp(backlink, repo.buf))
+		repair = _(".git file incorrect");
+
+	if (repair) {
+		fn(0, wt->path, repair, cb_data);
+		write_file(dotgit.buf, "gitdir: %s", repo.buf);
+	}
+
+	free(backlink);
+	strbuf_release(&repo);
+	strbuf_release(&dotgit);
+}
+
+static void repair_noop(int iserr, const char *path, const char *msg,
+			void *cb_data)
+{
+	/* nothing */
+}
+
+void repair_worktrees(worktree_repair_fn fn, void *cb_data)
+{
+	struct worktree **worktrees = get_worktrees();
+	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
+
+	if (!fn)
+		fn = repair_noop;
+	for (; *wt; wt++)
+		repair_gitfile(*wt, fn, cb_data);
+	free_worktrees(worktrees);
+}
diff --git a/worktree.h b/worktree.h
index 516744c433..4fcb01348c 100644
--- a/worktree.h
+++ b/worktree.h
@@ -89,6 +89,17 @@ int validate_worktree(const struct worktree *wt,
 void update_worktree_location(struct worktree *wt,
 			      const char *path_);
 
+typedef void (* worktree_repair_fn)(int iserr, const char *path,
+				    const char *msg, void *cb_data);
+
+/*
+ * Visit each registered linked worktree and repair corruptions. For each
+ * repair made or error encountered while attempting a repair, the callback
+ * function, if non-NULL, is called with the path of the worktree and a
+ * description of the repair or error, along with the callback user-data.
+ */
+void repair_worktrees(worktree_repair_fn, void *cb_data);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.28.0.531.g41c3d8a546

