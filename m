Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E5C74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCZWdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZWdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:33:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F85254
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l37so4019916wms.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679869984;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toK5B9WWBmA3jJXXLztDdz8Jxjtik+Fe/YbmP8A/VnQ=;
        b=N0USfUX7uFM9HN1spchrCcy9ud+TXEaaNO4w8tWHPCzW/utyVy0m2rQLXyc2ZQ0EE+
         3Oc0/SSHBn1IIVXPAa0xTEjmTIRskY2WtBL5Xo5FLonjbBWwB0C7fKxM1jGyAbkjbGdW
         wRE2p1AZYOuak2nFoZ3STLsf+pLRn/qfTxZUWlplpm63+u1aSNfInKOFT7D5NOTvRO/E
         9M3Vo/+vpEMtlcfZcGIWTngMP1x4nUwfeT7Kmf5NrvIC/Su5s9XOPIrJ7qk8GlZSxNS/
         1AmhaHLUgTTplQjj8p34ZaK2NaAZKeN/d84VtNW29P4ksGjBhXZLDrJIMBvFGFO+psFg
         0oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679869984;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toK5B9WWBmA3jJXXLztDdz8Jxjtik+Fe/YbmP8A/VnQ=;
        b=1jhUrM0o7BDZ4DNDOah5Ydkf2W8w/lJX/Pr2G+5K+ByLdbQN0SJjH4TQrCJBy4UqoN
         xSHITM71KeRMGztL3i9+UHE7SrdmTJsbDcINlsXF0BmumC84310f3UN3WLkxXOAC/8NL
         N/RFyRtHGfdJo6Xhl5cTUSCBBqVvI9iLPpzKAhOLvJXylUwxlTYufP1SBJ64Jr/tZr5O
         tv9v9AJ/U8jwxCEltWnhAOjunXFUrqWZlDwpMidtrswyom2/3aapn6c5Yk3EMdqKuh8S
         l0HLNycHwTw1i4GD0bv+Rxu4tTW0UsoIXrHpPVsVQgSJt7B43L5olQckSdDaRHF6h4v1
         g0oQ==
X-Gm-Message-State: AO0yUKXBZIZIcgvNonQoQhV88nSv3S10mGkNSf1GnLMUhQkM47Ds0Yqs
        8Mjm6X+xLPmfInaQgDvNhOU=
X-Google-Smtp-Source: AK7set9syhagd19aw4E/i1ahsbPaDOX/oegGA4WOFsIxDz+Bv+mo6lsZQ2ekCIlkdC61rujEHFc3xA==
X-Received: by 2002:a7b:ca4a:0:b0:3ed:af6b:7fb3 with SMTP id m10-20020a7bca4a000000b003edaf6b7fb3mr8056560wml.2.1679869984357;
        Sun, 26 Mar 2023 15:33:04 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c290b00b003ee20b4b2dasm11595829wmd.46.2023.03.26.15.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:33:04 -0700 (PDT)
Subject: [PATCH v5 1/5] branch: test for failures while renaming branches
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Message-ID: <2c22e77e-314f-1025-3355-740e19b743fa@gmail.com>
Date:   Mon, 27 Mar 2023 00:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we introduced replace_each_worktree_head_symref() in 70999e9cec
(branch -m: update all per-worktree HEADs, 2016-03-27), we implemented a
best effort approach.

If we are asked to rename a branch that is simultaneously checked out in
multiple worktrees, we try to update all of those worktrees.  If we fail
updating any of them, we die() as a signal that something has gone
wrong.  However, at this point, the branch ref has already been renamed
and also updated the HEADs of the successfully updated worktrees.
Despite returning an error, we do not try to rollback those changes.

Let's add a test to notice if we change this behavior in the future.

In next commits we will change replace_each_worktree_head_symref() to
work more closely with its only caller, copy_or_rename_branch().  Let's
move the former closer to its caller, to facilitate those changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c          | 27 ---------------------------
 branch.h          |  8 --------
 builtin/branch.c  | 32 ++++++++++++++++++++++++++++++++
 t/t3200-branch.sh | 15 +++++++++++++++
 4 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/branch.c b/branch.c
index eacef62b7c..b45454593a 100644
--- a/branch.c
+++ b/branch.c
@@ -835,30 +835,3 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 
 	free_worktrees(worktrees);
 }
-
-int replace_each_worktree_head_symref(const char *oldref, const char *newref,
-				      const char *logmsg)
-{
-	int ret = 0;
-	struct worktree **worktrees = get_worktrees();
-	int i;
-
-	for (i = 0; worktrees[i]; i++) {
-		struct ref_store *refs;
-
-		if (worktrees[i]->is_detached)
-			continue;
-		if (!worktrees[i]->head_ref)
-			continue;
-		if (strcmp(oldref, worktrees[i]->head_ref))
-			continue;
-
-		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_create_symref(refs, "HEAD", newref, logmsg))
-			ret = error(_("HEAD of working tree %s is not updated"),
-				    worktrees[i]->path);
-	}
-
-	free_worktrees(worktrees);
-	return ret;
-}
diff --git a/branch.h b/branch.h
index ef56103c05..30c01aed73 100644
--- a/branch.h
+++ b/branch.h
@@ -155,12 +155,4 @@ int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 void die_if_checked_out(const char *branch, int ignore_current_worktree);
 
-/*
- * Update all per-worktree HEADs pointing at the old ref to point the new ref.
- * This will be used when renaming a branch. Returns 0 if successful, non-zero
- * otherwise.
- */
-int replace_each_worktree_head_symref(const char *oldref, const char *newref,
-				      const char *logmsg);
-
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..c7ace2f2da 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -509,6 +509,38 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
+/*
+ * Update all per-worktree HEADs pointing at the old ref to point the new ref.
+ * This will be used when renaming a branch. Returns 0 if successful, non-zero
+ * otherwise.
+ */
+static int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+					     const char *logmsg)
+{
+	int ret = 0;
+	struct worktree **worktrees = get_worktrees();
+	int i;
+
+	for (i = 0; worktrees[i]; i++) {
+		struct ref_store *refs;
+
+		if (worktrees[i]->is_detached)
+			continue;
+		if (!worktrees[i]->head_ref)
+			continue;
+		if (strcmp(oldref, worktrees[i]->head_ref))
+			continue;
+
+		refs = get_worktree_ref_store(worktrees[i]);
+		if (refs_create_symref(refs, "HEAD", newref, logmsg))
+			ret = error(_("HEAD of working tree %s is not updated"),
+				    worktrees[i]->path);
+	}
+
+	free_worktrees(worktrees);
+	return ret;
+}
+
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a8a48287c..7abd938e15 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -239,6 +239,21 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	git worktree prune
 '
 
+test_expect_success 'git branch -M fails if updating any linked working tree fails' '
+	git worktree add -b baz bazdir1 &&
+	git worktree add -f bazdir2 baz &&
+	touch .git/worktrees/bazdir1/HEAD.lock &&
+	test_must_fail git branch -M baz bam &&
+	test $(git -C bazdir2 rev-parse --abbrev-ref HEAD) = bam &&
+	git branch -M bam baz &&
+	rm .git/worktrees/bazdir1/HEAD.lock &&
+	touch .git/worktrees/bazdir2/HEAD.lock &&
+	test_must_fail git branch -M baz bam &&
+	test $(git -C bazdir1 rev-parse --abbrev-ref HEAD) = bam &&
+	rm -rf bazdir1 bazdir2 &&
+	git worktree prune
+'
+
 test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
 	git checkout -b baz &&
 	git worktree add -f bazdir baz &&
-- 
2.39.2
