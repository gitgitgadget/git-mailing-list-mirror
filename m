Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EABC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351893AbiA2AFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbiA2AFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:05:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54237C061747
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:02 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090ab00100b001b380b8ed35so4671072pjq.7
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z2cI7+fidAOey6BoZpTflTD7ym3i9+9ULEDvvtZ51HM=;
        b=spqdZcjGOTiv1HZCmvjfxQFDqOsBlweVhLHndLMiGs7QEwjqGDYCSyXGR3SiwC7m61
         1ZNCGaUJmf+fbNxLOGaLtSDeX+m8SMN9GiMwrM1v8+j+2GENz03CnsmVVpijJG/MPNVG
         k0RB3yuOYcmiwA/siQ/0UF6mUs5QtmyZnHFs+2BxmMoAzknUrf9+ENZH7leQjEOe3s9f
         XNnPYUtJ23a1xS2f0G2zIctSD4Fm9jqAhViRmEVc3LVJb/YBMb+0fQh8QUx6QK0sUDxr
         kO64FCrUoQsvEYBk+vO/kBbrqK2OrDBt4jnS5j48CRNdys7yahM/pMr15RDW8UR5QFC8
         YHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z2cI7+fidAOey6BoZpTflTD7ym3i9+9ULEDvvtZ51HM=;
        b=pi/xgIoPUT/cYtGjhEmU7gA3ELmx3Vm8UZ+szsmU3lMqNBLRGpY3e1poxmw6PKqtOJ
         oFHG2qj5dO85xc+V25iErPV9ivlgoMdf2YIOgb8Xx7i+KVA+i2Qs1hkgUw2jp2Ull87X
         481sRBWrqTJOgJ/974/9s7wNvjbp3DB0gEi8Rw9xvnb6Q00dnNBYTTPJK1kGMudL02Ho
         FNm2e/SHi0wJfKjqWcB+iNvdRPLSBJqPN3LwfcWbkbYrseo9LGT1VqCqFuSX7Fyto3zr
         t45ug0xnpZLD4FI59nOPRSjp8M2HQxmljWclZ6Il5kDzL/9KhRTjl9nLPDuCajxLv3oa
         gVWw==
X-Gm-Message-State: AOAM53355BW+6NVfWBPh55VaA3u9p4yMAnBsRkTWwl2XgzwudtjXvP95
        f6gdmOtrZhJNY9AV3zUqGwwAqpHikP8CVjm6Ojq/jaKAw2h6L5mT/qzoIdwYhzy+6R7/ixbq1ss
        lS1cN5Bp3j1gW32RiU5yMHHBFCS/4ZWcnNZCj1dSjzecNev1gNCcNxg/lUaF1vFw=
X-Google-Smtp-Source: ABdhPJyPQOGIzj9ffKrOD6YvcE5/REe4/a7xqueYlv6MvMb8lWAihcOsfMVdd7tb277+UOKm3uDUyuLG0Agl7g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b718:: with SMTP id
 d24mr10820987pls.46.1643414701592; Fri, 28 Jan 2022 16:05:01 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:42 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220129000446.99261-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 2/6] branch: make create_branch() always create a branch
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the previous commit, there are no more invocations of
create_branch() that do not create a branch because:

* BRANCH_TRACK_OVERRIDE is no longer passed
* clobber_head_ok = true and force = false is never passed

Assert these situations, delete dead code and ensure that we're handling
clobber_head_ok and force correctly by introducing tests for `git branch
--force`. As a result, create_branch() now always creates a branch.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c          | 57 ++++++++++++++++++++++-------------------------
 branch.h          |  4 ++--
 t/t3200-branch.sh | 17 ++++++++++++++
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index f3a31930fb..df24021f27 100644
--- a/branch.c
+++ b/branch.c
@@ -429,15 +429,19 @@ void create_branch(struct repository *r,
 	char *real_ref;
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
-	int dont_change_ref = 0;
-
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	char *msg;
+
+	if (track == BRANCH_TRACK_OVERRIDE)
+		BUG("'track' cannot be BRANCH_TRACK_OVERRIDE. Did you mean to call dwim_and_setup_tracking()?");
+	if (clobber_head_ok && !force)
+		BUG("'clobber_head_ok' can only be used with 'force'");
+
+	if (clobber_head_ok ?
+			  validate_branchname(name, &ref) :
+			  validate_new_branchname(name, &ref, force)) {
+		forcing = 1;
 	}
 
 	dwim_branch_start(r, start_name, track, &real_ref, &oid);
@@ -445,27 +449,20 @@ void create_branch(struct repository *r,
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
-	if (!dont_change_ref) {
-		struct ref_transaction *transaction;
-		struct strbuf err = STRBUF_INIT;
-		char *msg;
-
-		if (forcing)
-			msg = xstrfmt("branch: Reset to %s", start_name);
-		else
-			msg = xstrfmt("branch: Created from %s", start_name);
-
-		transaction = ref_transaction_begin(&err);
-		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf,
-					   &oid, forcing ? NULL : null_oid(),
-					   0, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
-			die("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
-		free(msg);
-	}
+	if (forcing)
+		msg = xstrfmt("branch: Reset to %s", start_name);
+	else
+		msg = xstrfmt("branch: Created from %s", start_name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+		ref_transaction_update(transaction, ref.buf,
+					&oid, forcing ? NULL : null_oid(),
+					0, msg, &err) ||
+		ref_transaction_commit(transaction, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	free(msg);
 
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
diff --git a/branch.h b/branch.h
index ab2315c611..cf3a4d3ff3 100644
--- a/branch.h
+++ b/branch.h
@@ -52,8 +52,8 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
  *
  *   - force enables overwriting an existing (non-head) branch
  *
- *   - clobber_head_ok allows the currently checked out (hence existing)
- *     branch to be overwritten; without 'force', it has no effect.
+ *   - clobber_head_ok, when enabled with 'force', allows the currently
+ *     checked out (head) branch to be overwritten
  *
  *   - reflog creates a reflog for the branch
  *
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a74b2e06a1..9157382ad0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -42,6 +42,23 @@ test_expect_success 'git branch abc should create a branch' '
 	git branch abc && test_path_is_file .git/refs/heads/abc
 '
 
+test_expect_success 'git branch abc should fail when abc exists' '
+	test_must_fail git branch abc
+'
+
+test_expect_success 'git branch --force abc should fail when abc is checked out' '
+	test_when_finished git switch main &&
+	git switch abc &&
+	test_must_fail git branch --force abc HEAD~1
+'
+
+test_expect_success 'git branch --force abc should succeed when abc exists' '
+	git rev-parse HEAD~1 >expect &&
+	git branch --force abc HEAD~1 &&
+	git rev-parse abc >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
-- 
2.33.GIT

