Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75BFC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC627611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETGLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhETGLI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E26C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c14so14507041wrx.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gUnXWMvnUu3h+DNbCL2dlFWVnyBiQFKDUiNGfM7jfOE=;
        b=sVHIqLvEMCmyGyeDzjtPgnxwBikcIjAlr972JdDe5HQxKXc10cujJoLaSpb9CDX14u
         XcfjsGKqNI+l+YxVkaa27eC0IDDxaaboW3cvb/dUxMLpxrrN1pvYhhJFo2KGcN5KXs8p
         dZzEg0rWiQEW08qg620WhYjB+RIvN4qd1A93Y5t7PuZlhp0Y5+NP4Pme6YzskT3aW6G7
         bFV6+5vXSS8JRKufsQcXwM/6a3BKAKN1bcoPNjuEH8qCxGQk0rXS4xRWpUBlRb5yRxYO
         Fn7hAY1x8Bx9Rzskws/Q0nM7Jc4Db/r+p415aClZqzE/qcORGkfpy9H993x0ptYdyXiW
         SzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gUnXWMvnUu3h+DNbCL2dlFWVnyBiQFKDUiNGfM7jfOE=;
        b=Oxxa15lY8U2WAwhSUoKPxsv+c5bXi+q/lUqx8TZB6PNTDt4VVVsHJ8DAOXyCYG58yR
         s0nBx8Cxy1v2rkxc2t9w4w4GXj0/MQd/Ei4j8+xsw7+1HdEeQQyshDhi4+hae0aOIah1
         vzpT7hdgnu5Vqw2NYZrfQnhE2hkJTvaLS2gyQhnPFYf9kIjGoWoOkPY4iimzKPBhHOBB
         /IZMUmfCf1I4UE1lhV1cuIJT8wH8OhQ/2sAWkcUkHl6ZLSgIIPtlNTqor3TuMNIUKR3k
         S7la/Uzt0xxOBLzbANB4IEDO60nsxtGa1zyXCXg6oWfiC5K/2EWGOGoavv+3kh+PzEqo
         UBOA==
X-Gm-Message-State: AOAM530N7pqIcDDHOISyIEknVfJRecW8z5LBeqW1jgFrXW+2jREr2/Ag
        5vdiwD3droo4V7BgkX/Jnt596oXUh6A=
X-Google-Smtp-Source: ABdhPJz8Y9nQYOrpJORYqDy+5Oj8Yn8xkgU/ddC7W3GlDWrTooqXWZiVZKen/kpn8oh3GAvCVBG+Hw==
X-Received: by 2002:a05:6000:4d:: with SMTP id k13mr2458279wrx.98.1621490986161;
        Wed, 19 May 2021 23:09:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d141sm757151wmd.21.2021.05.19.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:45 -0700 (PDT)
Message-Id: <cfd8cbef17f03a97b20196bebf7abc04572a79b2.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:32 +0000
Subject: [PATCH v3 04/13] fast-rebase: write conflict state to working tree,
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

