Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537ECC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382337AbiAXWcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582627AbiAXWPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:15:33 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF5C04A2C7
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:04 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so10523299pga.9
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z2cI7+fidAOey6BoZpTflTD7ym3i9+9ULEDvvtZ51HM=;
        b=XbXnTbuyoV/aY6Fkx4QH+iJmyy4TPbMRj0EWcprwGS6hNcOlJvWagcSqLNNf6m/MsH
         G4edIQRc7Vb/8AMARKWS5dilyhQLNXPfeYEu94mkHU0KQSGcDfWFMVrgs9Kf6xniXlOf
         r8xSkLpfg/CgncOv/g1G/Czz/Imo2WbvEQl5ECzgE4dO1VfdX2y+wCh/c8wPnDo5IoTJ
         19HwcN8Gych+r4nPL42PSiUscPoE5jekXXAl6ZPBNo4YTsIWKBV4foban+YPRMvxa9Yh
         UGfnwewOBD58EmfQRXdVL50B1HdB3PiFrj5cJZOYFdPY9UIZKMAq70eGXFXyvsWWxT/U
         88zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z2cI7+fidAOey6BoZpTflTD7ym3i9+9ULEDvvtZ51HM=;
        b=hbSpCT+Tjm0GTjpZUn3PN3UTekrfoyrdJyZw6QmG2LkC81L4P/U3xGWtUHSdB06ZWT
         FSY2gaIcE7HmqNHBRIcT12K0c1Ef2jvrcW+qSbWTPMcXbm7nk5/dAruY4+9LGtkQu4iE
         z9KPyiawfnPRNCPnmZFl0ywNskWKDSgX/aOJggyQNmP3aWNBNbN6zIC9BYfzWKdZB2M+
         tGUadV04kVAAEZRflH1Y4fhUki3FJwV1jHSYWpXlLF9ppzU6ldkEAnFbx5PYJmsIyxOQ
         ERvWBBNya1D76cltWlCqO/2HcEx18HhyPtdWm1hI6qy96JMgPgH3Q4zYZa//Qcv9nOcG
         /lbw==
X-Gm-Message-State: AOAM531HsY7oryPz5TAYioY/Lgm36MrqUvhsVPdVE9Go7N8IsAzmIsQF
        LG/hY6N8RNB/QQMRk7Px7wJzoDDJo7+VFl2ByA3IgtYR1FECydzUfY20jSWapAUSKJzC/vssV6K
        SAlsfFsOgVlPTHsyyAauu2ai/UP9WBX1R+OvhgtWAYYii7p82B2mSr0VSqAq+4XA=
X-Google-Smtp-Source: ABdhPJyUSwvNOsuNbbKIosURuBc0pw1Ig4KMzDc7VA5MYstPa4jiUMzr8eSzu/V0LRFDM/jRyApNLqIRwRkdeA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c111:b0:14b:528d:3745 with SMTP
 id 17-20020a170902c11100b0014b528d3745mr5759376pli.38.1643057103993; Mon, 24
 Jan 2022 12:45:03 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:38 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220124204442.39353-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 2/6] branch: make create_branch() always create a branch
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

