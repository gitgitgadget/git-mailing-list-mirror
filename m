Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiFHUJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiFHUJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E1AF1F5
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:09:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a15so21214147wrh.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iFH2Di6aV0LKXtrBPtO+xoD4fNPtx8EAFI7FuSQQ1NI=;
        b=XrnwIB9d/t+stgFGU02X2sfN3sTxmRyIveLcmuUP9EaPUKkI/qe9ElexBQBrEHM0Wh
         2oBprLxLFwZEkRhBY2m939AS1P8WEhPvnD9d/Cmw50N7aELoMJzSbt+2CPmiCbRmL5gM
         fx0EsHRhuDBlZ3+785MEtxN9V40/3DvL8J4aTJbjt48Y2KDX2VEyNLmcstv13obog/X3
         31AjkSFeEOHNvKs6UftcOZhU0o3/35CAdRscLWe9Zh8kh3ROdlxVXMxsHL2q46gjbL7o
         qVNG1+sUfLfMwocB0AQ5onvs3V+qlmo3HgbM6gWxPit8rcxVYfwR5Ir/SdW+tNAtwj3q
         zUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iFH2Di6aV0LKXtrBPtO+xoD4fNPtx8EAFI7FuSQQ1NI=;
        b=q9mzBSyZnhFkAbsuZFj16Q/eo7Iu8brkAbi6//kmPgJCQyl4TruCDw0EXBjN8irigk
         v8vO/Y+GZUczx9fCmriiaZtiRSttyeawElTgaWNVl6rdqGSfwWDMGOdoREVty55Ii1XJ
         /kX8aLaWixIfccVh0tAB2+qopi+j5PHJd1tGkLGZOkQameX92svFJvAj+OgpxObeSwpS
         kpi9UqtUidSDGwNPK4fhT5fhnTFKku3MoWS2nY5WmqFR6X256IUuUQwL9odbQ2nPJjUm
         9vut7wOwngpOax1QKOaSHCJdvumHBKY/KtXrujcX1H0qBGRkLOGnFfO6sDR9yB/OCamy
         0R+g==
X-Gm-Message-State: AOAM533+HHVuqtWrMkWmy3wxUwZ+SMyjBGA5/6aBgbS5BRb0E8BInKsl
        1XOztKu04LyLwn0mZaYZl2bbJxjIHi7FFcz1
X-Google-Smtp-Source: ABdhPJz7+qBbT11w7m6bFlESWAux1ctm7cAE/+gPQXjvRVQgd4wqEXmDYast+q8u26guloqhj0I+LQ==
X-Received: by 2002:a5d:4ec4:0:b0:210:21a5:2007 with SMTP id s4-20020a5d4ec4000000b0021021a52007mr34461369wrv.348.1654718946845;
        Wed, 08 Jun 2022 13:09:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm25540884wms.29.2022.06.08.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:09:05 -0700 (PDT)
Message-Id: <18bad9b0c496fc0ceab1e567aee83f2160ae5d75.1654718942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 20:09:00 +0000
Subject: [PATCH 2/4] branch: check for bisects and rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The branch_checked_out() helper was added by the previous change, but it
used an over-simplified view to check if a branch is checked out. It
only focused on the HEAD symref, but ignored whether a bisect or rebase
was happening.

Teach branch_checked_out() to check for these things, and also add tests
to ensure that we do not lose this functionality in the future.

Now that this test coverage exists, we can safely refactor
validate_new_branchname() to use branch_checked_out().

Note that we need to prepend "refs/heads/" to the 'state.branch' after
calling wt_status_check_*(). We also need to duplicate wt->path so the
value is not freed at the end of the call.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 35 +++++++++++++++++++++++++++--------
 t/t2407-worktree-heads.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 061a11f3415..c0fe6ea0b65 100644
--- a/branch.c
+++ b/branch.c
@@ -385,6 +385,7 @@ static void prepare_checked_out_branches(void)
 	worktrees = get_worktrees();
 
 	while (worktrees[i]) {
+		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
 
 		if (wt->is_bare)
@@ -394,6 +395,29 @@ static void prepare_checked_out_branches(void)
 			strmap_put(&current_checked_out_branches,
 				   wt->head_ref,
 				   xstrdup(wt->path));
+
+		if (wt_status_check_rebase(wt, &state) &&
+		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
+		    state.branch) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strmap_put(&current_checked_out_branches,
+				   ref.buf,
+				   xstrdup(wt->path));
+			strbuf_release(&ref);
+		}
+		wt_status_state_free_buffers(&state);
+
+		if (wt_status_check_bisect(wt, &state) &&
+		    state.branch) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strmap_put(&current_checked_out_branches,
+				   ref.buf,
+				   xstrdup(wt->path));
+			strbuf_release(&ref);
+		}
+		wt_status_state_free_buffers(&state);
 	}
 
 	free_worktrees(worktrees);
@@ -419,9 +443,7 @@ int branch_checked_out(const char *refname, char **path)
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 {
-	struct worktree **worktrees;
-	const struct worktree *wt;
-
+	char *path;
 	if (!validate_branchname(name, ref))
 		return 0;
 
@@ -429,13 +451,10 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
 
-	worktrees = get_worktrees();
-	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
-	if (wt && !wt->is_bare)
+	if (branch_checked_out(ref->buf, &path))
 		die(_("cannot force update the branch '%s' "
 		      "checked out at '%s'"),
-		    ref->buf + strlen("refs/heads/"), wt->path);
-	free_worktrees(worktrees);
+		    ref->buf + strlen("refs/heads/"), path);
 
 	return 1;
 }
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index dd905dc1a5c..12faca7f655 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -21,4 +21,33 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
+test_expect_success 'refuse to overwrite: worktree in bisect' '
+	test_when_finished test_might_fail git -C wt-4 bisect reset &&
+
+	(
+		git -C wt-4 bisect start &&
+		git -C wt-4 bisect bad HEAD &&
+		git -C wt-4 bisect good HEAD~3
+	) &&
+
+	test_must_fail git branch -f wt-4 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
+'
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'refuse to overwrite: worktree in rebase' '
+	test_when_finished test_might_fail git -C wt-4 rebase --abort &&
+
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2 3" \
+			git -C wt-4 rebase -i HEAD~3 >rebase &&
+		git -C wt-4 status
+	) &&
+
+	test_must_fail git branch -f wt-4 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
+'
+
 test_done
-- 
gitgitgadget

