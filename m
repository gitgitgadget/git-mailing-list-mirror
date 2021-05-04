Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE65C43460
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A37611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhEDCNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhEDCNU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28719C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n2so7617438wrm.0
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUnXWMvnUu3h+DNbCL2dlFWVnyBiQFKDUiNGfM7jfOE=;
        b=ROBgGiKSGJrakczz0JXlDaVqy6xTWBhf1OOCzjZ0n6+sVVBDJ5pf8FbnrbaTUNkZ8S
         dgbvJe8iacuWZ/pbQ0/+YGSoAlWFNT4CM4yfBB0nSHhYU37NifAA5uwRkgTKyWf4p2bW
         cNOQIbo5Y8oDbaSmjrFnpTogiaXO/uoHtXx+cFVxWYBMokTLlJK+RE0OZiHdx2hWnyqI
         STkoDd2sHp6HCgeMbioh35NuDG9xnaSenC2rL/sm16x8IeA5WQ9OTTYPZ9pQnIaCL4b6
         KHDV+jPF28TVjFNYJ+/MYkpRxZDxNw8uGNBpj+1xfdfWSVCjnHLFWhsm0LjJRPn7hb9j
         PkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUnXWMvnUu3h+DNbCL2dlFWVnyBiQFKDUiNGfM7jfOE=;
        b=EpEM4migRK1vogwcXFxILC3cvgdzEl6jsSuCjX2ckAGbnAKtySa4Z/pbFFH0xNrL5U
         IVtUr5TEDTgmqlGJzaGgu1dZ42ren7vDA06kHnYjocsaknJQfxtqplqxBPCsfISFjLyp
         d+bnkVwu+BV61/gnUJL5Z1Tga7sf78M4E5Op+egharGWE60FftWeOn5ixwPQHt+onB66
         w4lP/NnGnsH+1IDHyUm0WDaMl8JjrD7h/EocoalUYdjw7QVrtXJm9Mw6qCCpgT54ZJ/o
         dr5xvvanP21RyxZ5sh1C8Ybeb2oVV7wuPldWY5CoNRyuX9W0trScxqmsyiNEGn7CHxIK
         WvaQ==
X-Gm-Message-State: AOAM531NU0WnggDdtzHeBQlVwgVZqoq3gkQRVGPr/P/asTCC1bRVTjnq
        kKiXOVBOxBL4Pusx6Xmmmshxn4TPZTE=
X-Google-Smtp-Source: ABdhPJxpRIqBGXRZp15x47cb2AmoTcKPbSRTQnwoF8n0CDZoIYKmqOC4v7zgUtf0Dlr/s20hzTvsMw==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr28470133wrp.341.1620094344917;
        Mon, 03 May 2021 19:12:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm19217954wrd.81.2021.05.03.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:24 -0700 (PDT)
Message-Id: <887b151c26ff0f175f2da431d77cd377bd066990.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:10 +0000
Subject: [PATCH v2 04/13] fast-rebase: write conflict state to working tree,
 index, and HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, when fast-rebase hit a conflict, it simply aborted and left
HEAD, the index, and the working tree where they were before the
operation started.  While fast-rebase does not support restarting from a
conflicted state, write the conflicted state out anyway as it gives us a
way to see what the conflicts are and write tests that check for them.

This will be important in the upcoming commits, because sequencer.c is
only superficially integrated with merge-ort.c; in particular, it calls
merge_switch_to_result() after EACH merge instead of only calling it at
the end of all the sequence of merges (or when a conflict is hit).  This
not only causes needless updates to the working copy and index, but also
causes all intermediate data to be freed and tossed, preventing caching
information from one merge to the next.  However, integrating
sequencer.c more deeply with merge-ort.c is a big task, and making this
small extension to fast-rebase.c provides us with a simple way to test
the edge and corner cases that we want to make sure continue working.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/helper/test-fast-rebase.c | 51 +++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 39fb7f41e8c1..fc2d46090434 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -91,7 +91,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
-	int clean = 1;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
 	struct commit *commit;
@@ -176,11 +175,10 @@ int cmd__fast_rebase(int argc, const char **argv)
 		free((char*)merge_opt.ancestor);
 		merge_opt.ancestor = NULL;
 		if (!result.clean)
-			die("Aborting: Hit a conflict and restarting is not implemented.");
+			break;
 		last_picked_commit = commit;
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
-	fprintf(stderr, "\nDone.\n");
 	/* TODO: There should be some kind of rev_info_free(&revs) call... */
 	memset(&revs, 0, sizeof(revs));
 
@@ -189,24 +187,39 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (result.clean < 0)
 		exit(128);
 
-	strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
-		    oid_to_hex(&last_picked_commit->object.oid),
-		    oid_to_hex(&last_commit->object.oid));
-	if (update_ref(reflog_msg.buf, branch_name.buf,
-		       &last_commit->object.oid,
-		       &last_picked_commit->object.oid,
-		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-		error(_("could not update %s"), argv[4]);
-		die("Failed to update %s", argv[4]);
+	if (result.clean) {
+		fprintf(stderr, "\nDone.\n");
+		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
+			    oid_to_hex(&last_picked_commit->object.oid),
+			    oid_to_hex(&last_commit->object.oid));
+		if (update_ref(reflog_msg.buf, branch_name.buf,
+			       &last_commit->object.oid,
+			       &last_picked_commit->object.oid,
+			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
+			error(_("could not update %s"), argv[4]);
+			die("Failed to update %s", argv[4]);
+		}
+		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
+			die(_("unable to update HEAD"));
+		strbuf_release(&reflog_msg);
+		strbuf_release(&branch_name);
+
+		prime_cache_tree(the_repository, the_repository->index,
+				 result.tree);
+	} else {
+		fprintf(stderr, "\nAborting: Hit a conflict.\n");
+		strbuf_addf(&reflog_msg, "rebase progress up to %s",
+			    oid_to_hex(&last_picked_commit->object.oid));
+		if (update_ref(reflog_msg.buf, "HEAD",
+			       &last_commit->object.oid,
+			       &head,
+			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
+			error(_("could not update %s"), argv[4]);
+			die("Failed to update %s", argv[4]);
+		}
 	}
-	if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
-		die(_("unable to update HEAD"));
-	strbuf_release(&reflog_msg);
-	strbuf_release(&branch_name);
-
-	prime_cache_tree(the_repository, the_repository->index, result.tree);
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
-	return (clean == 0);
+	return (result.clean == 0);
 }
-- 
gitgitgadget

