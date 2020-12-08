Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B7C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146FE23B32
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgLHRjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgLHRjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 12:39:14 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C344C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 09:38:34 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n14so17657214iom.10
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkmNxsUJy6R+zkcZVStkDbpPr1eFwnE/wS9ROpuRTSY=;
        b=Seck/l7B46Gi2ti0zev4EjOqFlXd2zoU11/43hyelrMcenC10neR4swN17rVZ0NVK+
         NlmQKKK3isJcaqrddqMD3ZPerOKVddu0BMOlxPtFWQdrd1HrZCZEIq4U6+D9ePOf16aN
         sH+PZXme+slvFp/yo1Hqjto7Ud319j4nxtioi9J9cFNC09IJdxsdYBJRdt0Oyay6f2x4
         zmvq7J76j7Nw3FtQLtYoSN3WX7uDcPOdevK1jS922hNxBuS11HJHD3kCVg3jyKOTqZgN
         y3NQdt92qGjTtXD6pMT62I53qgn2BPgI5TViRInNefKv/gMC0byfM4AvnTcLbfre0UUY
         EnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WkmNxsUJy6R+zkcZVStkDbpPr1eFwnE/wS9ROpuRTSY=;
        b=MIbkT5RhrYRJQIqZaMp2Abbj6E+7FepxeWJdELYKfObOn0u3a5ktxLENAO9n4b5cuJ
         blad9gtrlFBR5bejylUN42rPw/Ka4JZF5d225+3Cp0CU+0XAO9uazWrSe7EdjO9zll1G
         3EX+6Hj//7W/a3y0blhWdoWvENppkWzccfxlRTdWHaKJ3fo4lQgZlzb1BVQMzPk6AqIe
         m21hxFiEI70S+mW1T4hPT4eM5UZk5+me7+znUMMSqxZJ+jUQfRXNIEVDZb3x7EdN9VSf
         EvfpUjtQ/5rvDXePs9vmk6SNnD8yl4xOP7W/TWkkcj1kTsgS/T4m+ftPy/36suUwkGw5
         eL1Q==
X-Gm-Message-State: AOAM5314+qLMgVuTIpweY0PL7g09c5ovvbjLcidqwfTHFsaaYTXuxepA
        NdkhorFXaSx68sML2ZZ0lEqgJ+VqUfA=
X-Google-Smtp-Source: ABdhPJwANJd37GpQC5AjGt9shKEgRYuxPoZr1L4mM807VGd0eRnolKFY/i/Psc4rYGGpBpnZiiEOAA==
X-Received: by 2002:a6b:db01:: with SMTP id t1mr13241748ioc.10.1607449113038;
        Tue, 08 Dec 2020 09:38:33 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id z18sm9853853ilb.26.2020.12.08.09.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:38:32 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: teach `repair` to fix multi-directional breakage
Date:   Tue,  8 Dec 2020 12:37:05 -0500
Message-Id: <20201208173705.5770-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git worktree repair` knows how to repair the two-way links between the
repository and a worktree as long as a link in one or the other
direction is sound. For instance, if a linked worktree is moved (without
using `git worktree move`), repair is possible because the worktree
still knows the location of the repository even though the repository no
longer knows where the worktree is. Similarly, if the repository is
moved, repair is possible since the repository still knows the locations
of the worktrees even though the worktrees no longer know where the
repository is.

However, if both the repository and the worktrees are moved, then links
are severed in both directions, and no repair is possible. This is the
case even when the new worktree locations are specified as arguments to
`git worktree repair`. The reason for this limitation is twofold. First,
when `repair` consults the worktree's gitfile (/path/to/worktree/.git)
to determine the corresponding <repo>/worktrees/<id>/gitdir file to fix,
<repo> is the old path to the repository, thus it is unable to fix the
`gitdir` file at its new location since it doesn't know where it is.
Second, when `repair` consults <repo>/worktrees/<id>/gitdir to find the
location of the worktree's gitfile (/path/to/worktree/.git), the path
recorded in `gitdir` is the old location of the worktree's gitfile, thus
it is unable to repair the gitfile since it doesn't know where it is.

Fix these shortcomings by teaching `repair` to attempt to infer the new
location of the <repo>/worktrees/<id>/gitdir file when the location
recorded in the worktree's gitfile has become stale but the file is
otherwise well-formed.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This patch addresses a limitation of `git worktree repair` in which it
is unable to repair the two-way links between the repository and
secondary worktrees if both the repository and the worktrees have been
moved manually. This limitation was known at the time `repair` was
introduced but I left it and other bells-and-whistles unimplemented
because bare bone `repair` was already fairly complex and I worried
about reviewer fatigue. However, a recent report[1] by Philippe, in
which he encountered exactly this situation, prompted me to think about
how `repair` should deal with the case, and this patch is the result.

[1]: https://lore.kernel.org/git/63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com/

 Documentation/git-worktree.txt |  5 +++++
 builtin/worktree.c             |  2 +-
 t/t2406-worktree-repair.sh     | 25 +++++++++++++++++++++
 worktree.c                     | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index af06128cc9..02a706c4c0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -143,6 +143,11 @@ locate it. Running `repair` within the recently-moved working tree will
 reestablish the connection. If multiple linked working trees are moved,
 running `repair` from any working tree with each tree's new `<path>` as
 an argument, will reestablish the connection to all the specified paths.
++
+If both the main working tree and linked working trees have been moved
+manually, then running `repair` in the main working tree and specifying the
+new `<path>` of each linked working tree will reestablish all connections
+in both directions.
 
 unlock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 197fd24a55..71287b2da6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1052,10 +1052,10 @@ static int repair(int ac, const char **av, const char *prefix)
 	int rc = 0;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	repair_worktrees(report_repair, &rc);
 	p = ac > 0 ? av : self;
 	for (; *p; p++)
 		repair_worktree_at_path(*p, report_repair, &rc);
+	repair_worktrees(report_repair, &rc);
 	return rc;
 }
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 1fe468bfe8..687342bfa7 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -104,6 +104,16 @@ test_expect_success 'repo not found; .git not file' '
 	test_i18ngrep ".git is not a file" err
 '
 
+test_expect_success 'repo not found; .git not referencing repo' '
+	test_when_finished "rm -rf side not-a-repo && git worktree prune" &&
+	git worktree add --detach side &&
+	sed s,\.git/worktrees/side$,not-a-repo, side/.git >side/.newgit &&
+	mv side/.newgit side/.git &&
+	mkdir not-a-repo &&
+	test_must_fail git worktree repair side 2>err &&
+	test_i18ngrep ".git file does not reference a repository" err
+'
+
 test_expect_success 'repo not found; .git file broken' '
 	test_when_finished "rm -rf orig moved && git worktree prune" &&
 	git worktree add --detach orig &&
@@ -176,4 +186,19 @@ test_expect_success 'repair multiple gitdir files' '
 	test_must_be_empty err
 '
 
+test_expect_success 'repair moved main and linked worktrees' '
+	test_when_finished "rm -rf orig moved" &&
+	test_create_repo orig/main &&
+	test_commit -C orig/main init &&
+	git -C orig/main worktree add --detach ../side &&
+	sed s,orig/side/\.git,moved/side/.git, \
+		orig/main/.git/worktrees/side/gitdir >expect-gitdir &&
+	sed s,orig/main/.git/worktrees/side,moved/main/.git/worktrees/side, \
+		orig/side/.git >expect-gitfile &&
+	mv orig moved &&
+	git -C moved/main worktree repair ../side &&
+	test_cmp expect-gitdir moved/main/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile moved/side/.git
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index f84ceae87d..821b233479 100644
--- a/worktree.c
+++ b/worktree.c
@@ -644,6 +644,42 @@ static int is_main_worktree_path(const char *path)
 	return !cmp;
 }
 
+/*
+ * If both the main worktree and linked worktree have been moved, then the
+ * gitfile /path/to/worktree/.git won't point into the repository, thus we
+ * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we may
+ * be able to infer the gitdir by manually reading /path/to/worktree/.git,
+ * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
+ */
+static char *infer_backlink(const char *gitfile)
+{
+	struct strbuf actual = STRBUF_INIT;
+	struct strbuf inferred = STRBUF_INIT;
+	const char *id;
+
+	if (strbuf_read_file(&actual, gitfile, 0) < 0)
+		goto error;
+	if (!starts_with(actual.buf, "gitdir:"))
+		goto error;
+	if (!(id = find_last_dir_sep(actual.buf)))
+		goto error;
+	strbuf_trim(&actual);
+	id++; /* advance past '/' to point at <id> */
+	if (!*id)
+		goto error;
+	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
+	if (!is_directory(inferred.buf))
+		goto error;
+
+	strbuf_release(&actual);
+	return strbuf_detach(&inferred, NULL);
+
+error:
+	strbuf_release(&actual);
+	strbuf_release(&inferred);
+	return NULL;
+}
+
 /*
  * Repair <repo>/worktrees/<id>/gitdir if missing, corrupt, or not pointing at
  * the worktree's path.
@@ -675,6 +711,11 @@ void repair_worktree_at_path(const char *path,
 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
+	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
+		if (!(backlink = infer_backlink(realdotgit.buf))) {
+			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
+			goto done;
+		}
 	} else if (err) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
 		goto done;
-- 
2.29.2.684.gfbc64c5ab5

