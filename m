Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB81C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6F223CA
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj+bwh4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfKTIcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:32:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45208 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfKTIcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 03:32:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so27017369wrs.12
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+7nYEtwgunVIidhQ+4BNMcV+FBfKCSdYHVjr1cNEDxk=;
        b=bj+bwh4tDr0Yw8Xsc9OzZbgLQKKXPUBqqdt6TuPSI7ojF4Sn79PWgbwIbmoY97jnlO
         Lcv+K+kCY9m80xi5LJkaO1hh+AwbszkUaKLZMPUEi4sblr0qSat80NyEHm65d61Tdwqr
         3FQXpJkSpKXSfHmxeL0oxS88MB5BBhP2cq6zOmJQghXzkV0DZtaKFM5aNG2Mpx+T3KbU
         9Enq0A1hg8Dyot5ekP2eyUCtRhxPq9oSbNzwhHOabNpyYqzg4EdbTdY94J3lIe341fST
         tJWDzayzpEnGmiyxpbtEKFNiY5iaiOu05l4aCHgoVEzlLSdoODsjAuoKZx2QENgTKd58
         LRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+7nYEtwgunVIidhQ+4BNMcV+FBfKCSdYHVjr1cNEDxk=;
        b=buC0KbAJPvWEk4PrttOqVh9JC09SW+Mc4mjuuE+szdY+BjPmNFEBDxcRBmH7281wm6
         aWWGvpiQg7hO+K9/kxaSFdhrNFykQoM2ruU0CByzLmuKrCt51Tk26dK09NTp6Ds9LiGT
         t27B4uc3hv5wkkYnxwqoEjs1p59hDmU4oPZg4cbSDgo6lvw9WWpCAFWu6chmkz32mgKG
         mvNTP1FW31l5p1eCPx03kk1Wo9dmDU/+CcZzSGjukAWiEbJo3ywIW1ty/YMXlL45ho7O
         KkZvBAS61LXgilGLfoWfEQ5H0RPcGrjw5O0oM7fnmDXazuKpMH1ERkswgIFr7KksnDFi
         wPww==
X-Gm-Message-State: APjAAAUsnm2Yd9crQu/aM/NsOovyoNWXwKk0D6DqWc8SnhO/eveHxCPK
        n6Jp2B1qyAWJDQ3rqa/Ug+tWUn4e
X-Google-Smtp-Source: APXvYqwyM11IwLjPRNrd82yay8bcVaYr127uUp1M9XvqdPz4KJc09CnVpuayVzAwRFx5HBhXcs3oLA==
X-Received: by 2002:adf:dc02:: with SMTP id t2mr1673892wri.39.1574238739504;
        Wed, 20 Nov 2019 00:32:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm5595282wmk.48.2019.11.20.00.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 00:32:19 -0800 (PST)
Message-Id: <ea7880f2d07ef65f8b41f6786ff789f7a0ff8fd7.1574238737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.v4.git.1574238737.gitgitgadget@gmail.com>
References: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
        <pull.424.v4.git.1574238737.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Nov 2019 08:32:17 +0000
Subject: [PATCH v4 1/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utsav Shah <utsav@dropbox.com>

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat
which can be inefficient on certain filesystems. This significantly slows
down commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered
unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
also now correctly copies over fsmonitor validity state from the source
index. Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard
internally) go from 8s or more to ~2s on a 250k file repository on a
mac.

Changes since the last version are:
* The sanity checks around accessing the fsmonitor_dirty bitmap have
been moved to another patch, which is in message id [1]
* Unintended indentation changes in fsmonitor have been removed
* A comment explaining what untracked->use_fsmonitor means has been
re-added (it was dropped in the previous version)
* A few "helped-by" entries have been added to the patch

[1]: (xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com)

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
Signed-off-by: Utsav Shah <utsav@dropbox.com>
---
 fsmonitor.c                 | 23 +++++++++++++++++------
 t/t7519-status-fsmonitor.sh |  9 +++++++--
 unpack-trees.c              |  6 +++++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..0d270da80f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -189,13 +189,26 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 		if (bol < query_result.len)
 			fsmonitor_refresh_callback(istate, buf + bol);
+
+		/* Now mark the untracked cache for fsmonitor usage */
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
 	} else {
+
+		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
+		 * if we actually changed entries or not */
+		int is_cache_changed = 0;
 		/* Mark all entries invalid */
-		for (i = 0; i < istate->cache_nr; i++)
-			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		for (i = 0; i < istate->cache_nr; i++) {
+			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
+				is_cache_changed = 1;
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+			}
+		}
 
 		/* If we're going to check every file, ensure we save the results */
-		istate->cache_changed |= FSMONITOR_CHANGED;
+		if (is_cache_changed)
+			istate->cache_changed |= FSMONITOR_CHANGED;
 
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
@@ -257,9 +270,7 @@ void tweak_fsmonitor(struct index_state *istate)
 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
-			/* Now mark the untracked cache for fsmonitor usage */
-			if (istate->untracked)
-				istate->untracked->use_fsmonitor = 1;
+			refresh_fsmonitor(istate);
 		}
 
 		ewah_free(istate->fsmonitor_dirty);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..69908b6a9b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -106,6 +106,8 @@ EOF
 
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git update-index --fsmonitor &&
 	git update-index --fsmonitor-valid dir1/modified &&
 	git update-index --fsmonitor-valid dir2/modified &&
@@ -164,6 +166,8 @@ EOF
 
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git add new &&
 	git add dir1/new &&
 	git add dir2/new &&
@@ -218,11 +222,12 @@ test_expect_success '*only* files returned by the integration script get flagged
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-	EOF
 	clean_repo &&
 	dirty_repo &&
+	write_integration_script &&
 	git add . &&
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git commit -m "to reset" &&
 	git reset HEAD~1 &&
 	git status >actual &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..fc5ceb932c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1504,6 +1504,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
+	if (o->src_index->fsmonitor_last_update)
+		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
@@ -2384,7 +2387,8 @@ int oneway_merge(const struct cache_entry * const *src,
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
+			!(old->ce_flags & CE_FSMONITOR_VALID)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
gitgitgadget
