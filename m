Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CEC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF82722C9C
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 08:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLUISM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 03:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgLUIRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 03:17:49 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43EC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 00:17:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 75so8089780ilv.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 00:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHi1AYWI9I8+8LSFhX3hfp+W44m4rzS9YUUxOGaMIQU=;
        b=Km/8F7vroQdGF3wcKJVyaSiYoAnafGduHvwW/0elYp2QveALaN36ebyJwRwNQDJrxw
         JnUwEpvg/0qQ/rkakd9OE63RdNCxuOkmjekUrESuytm2n/iv26LVO/9W9gG8U/AEckvo
         ayyh5Unwh+i5882qfa7MQXqsOBiWcEKpDmF5s8a+mKUU69InjNLnOhU0t/KQZj3VNBPI
         kUF/Z2CQMujm8yihoKfooDrkmpWFN3suqwuWYam3iVkPOnhrt4FcWBsu3UhAtzFa7zot
         BNIUHgBxg3BJowiJHszzljhEAsxx3XUjtHEQbfIw8VmSm0fkXLNls8nWnnhATm6Im1H2
         k1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tHi1AYWI9I8+8LSFhX3hfp+W44m4rzS9YUUxOGaMIQU=;
        b=b8l9JHcLkDpyvD/YyBr6alTxsVCONGYB5vaVMRUNuFpwuN7lZ/kwflTGC+ipZY4RzW
         5xN7OyeLAvLZMm7IrLtU7ihp+bFUz7uf+JabiH8gQnL3myIUcglGZCe8m9zAvvBnR7wf
         N0POYj3HugjWW1suxjG34RqK2QbozK72nn8aszgr17z6GYo8Z+ajKXkXLnkhIOVL0Wjx
         ysrSevuTrJZtoCr1mXf2zq+snvGRO6ZRMXHEuWAyQ/dhc1E6YkGBFq8LnF8iWR6MLVNN
         DLn1dNdk2e0w8SOsLyzZvQMinE7Pqp6lkQp/iW6NIPJDG5a/IhOnhkqqBakc4o7+SiuI
         nfnA==
X-Gm-Message-State: AOAM530cBS6GdVMO8Y4nq8W33E+TVqBjsobzsJofLVApKRJ0h043p9Xq
        ZBHiyAzytB3w4QT3Ur8JP3FYPqTzZ8/KZg==
X-Google-Smtp-Source: ABdhPJziO4PMIM+cAHHKh5WfmhH2aRRY4ry8q66n80kt5weG/QqWR0gkxyaTr5t6FS+ScNPWylXHZA==
X-Received: by 2002:a92:4019:: with SMTP id n25mr15459255ila.25.1608538626375;
        Mon, 21 Dec 2020 00:17:06 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n10sm13075379ila.69.2020.12.21.00.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 00:17:05 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/1] worktree: teach `repair` to fix multi-directional breakage
Date:   Mon, 21 Dec 2020 03:16:01 -0500
Message-Id: <20201221081601.55546-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.30.0.rc1.243.g5298b911bd
In-Reply-To: <20201221081601.55546-1-sunshine@sunshineco.com>
References: <20201208173705.5770-1-sunshine@sunshineco.com>
 <20201221081601.55546-1-sunshine@sunshineco.com>
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
otherwise well-formed. The inference is intentionally simple-minded.
For each worktree path specified as an argument, `git worktree repair`
manually reads the ".git" gitfile at that location and, if it is
well-formed, extracts the <id>. It then searches for a corresponding
<id> in <repo>/worktrees/ and, if found, concludes that there is a
reasonable match and updates <repo>/worktrees/<id>/gitdir to point at
the specified worktree path. In order for <repo> to be known, `git
worktree repair` must be run in the main worktree or bare repository.

`git worktree repair` first attempts to repair each incoming
/path/to/worktree/.git gitfile to point at the repository, and then
attempts to repair outgoing <repo>/worktrees/<id>/gitdir files to point
at the worktrees. This sequence was chosen arbitrarily when originally
implemented since the order of fixes is immaterial as long as one side
of the two-way link between the repository and a worktree is sound.
However, for this new repair technique to work, the order must be
reversed. This is because the new inference mechanism, when it is
successful, allows the outgoing <repo>/worktrees/<id>/gitdir file to be
repaired, thus fixing one side of the two-way link. Once that side is
fixed, the other side can be fixed by the existing repair mechanism,
hence the order of repairs is now significant.

Two safeguards are employed to avoid hijacking a worktree from a
different repository if the user accidentally specifies a foreign
worktree as an argument. The first, as described above, is that it
requires an <id> match between the repository and the worktree. That
itself is not foolproof for preventing hijack, so the second safeguard
is that the inference will only kick in if the worktree's
/path/to/worktree/.git gitfile does not point at a repository.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  5 +++++
 builtin/worktree.c             |  2 +-
 t/t2406-worktree-repair.sh     | 26 +++++++++++++++++++++
 worktree.c                     | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

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
index 1fe468bfe8..f73741886b 100755
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
@@ -176,4 +186,20 @@ test_expect_success 'repair multiple gitdir files' '
 	test_must_be_empty err
 '
 
+test_expect_success 'repair moved main and linked worktrees' '
+	test_when_finished "rm -rf main side mainmoved sidemoved" &&
+	test_create_repo main &&
+	test_commit -C main init &&
+	git -C main worktree add --detach ../side &&
+	sed "s,side/\.git$,sidemoved/.git," \
+		main/.git/worktrees/side/gitdir >expect-gitdir &&
+	sed "s,main/.git/worktrees/side$,mainmoved/.git/worktrees/side," \
+		side/.git >expect-gitfile &&
+	mv main mainmoved &&
+	mv side sidemoved &&
+	git -C mainmoved worktree repair ../sidemoved &&
+	test_cmp expect-gitdir mainmoved/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile sidemoved/.git
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
2.30.0.rc1.243.g5298b911bd

