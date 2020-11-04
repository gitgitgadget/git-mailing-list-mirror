Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C1C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB920691
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGsmBZf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgKDRV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgKDRV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:21:29 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210EC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:21:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so22959938wrq.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yc0qUJ5kjHa93nCAZair6l9eitQl2ey7f000bBkqbb0=;
        b=SGsmBZf27ayQubGgaAI/bbkx3yejezEwMWY2CKVwSqBn+LvQOp1Qv9M9lMx2TL1RNq
         LT5ovvMCQbl7UqkEZndgUUJWpm1D1cxxsWIo4YVvDCJ4jpCTKTRZ99hN1BSzgrpqb5Ot
         Q8aREyTyiFYk6qfZLVmAdo8tCmBfpfxhK8yUqTwd4nRvygwdCd2VhuR8TT9wzO8a9iDN
         e8IhKNWQPy472kNKGe2fALr1XJj1zZpzYjFYOnfVJ6uyqEpuzX0sBJlVw78io23L2xpC
         DiV72ak9UfQMT4ksbNIQWmW/OF8h/BL8ZKKPODBOzeMAZuKK8mYaQ6fkzJj1EDOSmqWh
         jF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yc0qUJ5kjHa93nCAZair6l9eitQl2ey7f000bBkqbb0=;
        b=Ag2yhDrzr3AlAuysv4qEnHT777t+DHmYgnCSJXRrnK+tF0ASThRwB1SGEW9QNOY1iY
         76m6CUdxlwBpe39oOVtxgl6jsycFRAzn8FxNVEnFbdZcPPYdtZ2QmOh30ziNyAxZBedp
         IYnf0v/o1ZCjeAJ+pzokvJ/sjoIrjD+RXzCFc7VmV62ARMOo8kCPVWK73F337YnjoET8
         p7kISTGv9e9mUKXOgThRYND4P7mmh/oo8v44FDw2nk+O7+D+/c9lawMhQ18jeUxietVk
         dxDUUbF1FKAGuemNg0vPdvI7JGISpoHSejLU1nQNqKcOvW2ShYYdP3qqc3D5kQZHXEMb
         m+8w==
X-Gm-Message-State: AOAM533L88U8w5M680fWDH13CLpGGOHi8O/1ip+K9+nLTgqVUOCB2eL2
        DoXhFk+oqRpzRvGbOdhI7QheZWAMMuI=
X-Google-Smtp-Source: ABdhPJw7rwKV/ZoOlaqJLlyD4dd/DqE9VJ+KrdNrWdUR6MSN+eZ+kQvmeA0YoFknf6IF/qOj/Ne7/w==
X-Received: by 2002:adf:8b5d:: with SMTP id v29mr2538207wra.338.1604510486719;
        Wed, 04 Nov 2020 09:21:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm3760240wre.63.2020.11.04.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:21:26 -0800 (PST)
Message-Id: <pull.906.v2.git.git.1604510485432.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
References: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 17:21:25 +0000
Subject: [PATCH v2] Avoid segfault and provide fallback when cloning invalid
 branch/tag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Sohom Datta <sohom.datta@learner.manipal.edu>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom Datta <sohom.datta@learner.manipal.edu>

The Git command to clone a specific branch of a git repository always
assumes that the commit pointed to by the branch are going to valid. It
thus segfaults and crashes whenever a tag or a branch with a invalid
commit is specified.

Aborting the operation is not desirable since the user is left with no
usable git folder to work with despite git having done most of the work
in setting everything up.

This commit is based of David Berardi's commit at
https://lore.kernel.org/git/20191103180716.GA72007@carpenter.lan/

Make git fallback on creating a unborn master branch when encountering
a invalid commit.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    Fix potential segfault on cloning invalid tag
    
    Changes since v1:
    
     * Reworked the patch to use the fallback approach based on feedback
       from Jeff King.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-906%2Fsohomdatta1%2Fsegfault-while-cloning-invalid-tag-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-906/sohomdatta1/segfault-while-cloning-invalid-tag-v2
Pull-Request: https://github.com/git/git/pull/906

Range-diff vs v1:

 1:  576b6049b2 < -:  ---------- Fix potential segfault on cloning invalid tag
 -:  ---------- > 1:  02b50572ff Avoid segfault and provide fallback when cloning invalid branch/tag


 builtin/clone.c         | 69 ++++++++++++++++++++++++++++++++++++++---
 t/t5609-clone-branch.sh | 15 +++++++++
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..53930f7536 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -711,10 +711,63 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
-static void update_head(const struct ref *our, const struct ref *remote,
+static struct commit * commit_lookup_helper (const struct ref *our,
+					      const struct ref *remote,
+					      const char *msg,
+					      int *err)
+{
+	const struct object_id *tip = NULL;
+	struct commit *tip_commit =  NULL;
+
+	if (our)
+		tip = &our->old_oid;
+	else if (remote)
+		tip = &remote->old_oid;
+	else {
+		/*
+		 * We have no local branch requested with "-b", and the
+		 * remote HEAD is unborn. There's nothing to update HEAD
+		 * to, but this state is not an error.
+		 */
+		return NULL;
+	}
+
+	if ( !lookup_object(the_repository, tip)) {
+		/**
+		 * We have a object id associated with the tip of the branch
+		 * but the object id doesn't resolve to a object. This will be
+		 * handled downstream in update_ref().
+		 */
+		return NULL;
+	}
+
+	tip_commit = lookup_commit_reference_gently(the_repository, tip, 1);
+	if (!tip_commit) {
+		/*
+		 * The given non-commit cannot be checked out,
+		 * so have a 'master' branch and leave it unborn.
+		 */
+		error(_("non-commit branch cannot be checked out."));
+		create_symref("HEAD", "refs/heads/master" ,msg);
+		*err = -1;
+		return NULL;
+	}
+
+	return tip_commit;
+}
+
+static int update_head(const struct ref *our,
+			const struct ref *remote,
 			const char *msg)
 {
 	const char *head;
+	int err = 0;
+	const struct commit * c;
+	c = commit_lookup_helper(our, remote, msg, &err);
+	if (err < 0) {
+		return -1;
+	}
+
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
@@ -725,8 +778,6 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(the_repository,
-							   &our->old_oid);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
@@ -739,6 +790,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		update_ref(msg, "HEAD", &remote->old_oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
 	}
+
+	return 0;
 }
 
 static int git_sparse_checkout_init(const char *repo)
@@ -1346,7 +1399,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
@@ -1365,7 +1418,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress);
+	if ( err == 0 ) {
+		/*
+		 * Only try to checkout if we successfully updated HEAD; otherwise
+		 * HEAD isn't pointing to the thing the user wanted.
+		 */
+		err = checkout(submodule_progress);
+	}
 
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be052..a589db9aa0 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -20,6 +20,9 @@ test_expect_success 'setup' '
 	 echo one >file && git add file && git commit -m one &&
 	 git checkout -b two &&
 	 echo two >file && git add file && git commit -m two &&
+	 blob=$(git rev-parse HEAD:file) &&
+	 echo $blob > .git/refs/heads/broken-tag &&
+	 echo $blob > .git/refs/heads/broken-head &&
 	 git checkout master) &&
 	mkdir empty &&
 	(cd empty && git init)
@@ -67,4 +70,16 @@ test_expect_success 'clone -b not allowed with empty repos' '
 	test_must_fail git clone -b branch empty clone-branch-empty
 '
 
+test_expect_success 'cloning -b for invalid tag must fail and fallback on remote head' '
+	test_must_fail git clone -b broken-tag parent broken-tag 2>error &&
+	test_i18ngrep "non-commit branch cannot be checked out." error &&
+	(cd broken-tag && check_HEAD master)
+'
+
+test_expect_success 'cloning -b for broken head must fail and fallback on remote head' '
+	test_must_fail git clone -b broken-head parent broken-head &&
+	test_i18ngrep "non-commit branch cannot be checked out." error &&
+	(cd broken-head && check_HEAD master)
+'
+
 test_done

base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
-- 
gitgitgadget
