Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D6C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhLPXdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLPXdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DE6C061746
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y13-20020a17090a134d00b001b10368d9dcso368690pjf.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=seNxExmGCzVUpMy721uqn8oAKM+L1AqLwUaEq+oUCgc=;
        b=IpiJc0Gua6p7qCEi2ALIyjfK1WuPiulCbvEACopZ1O35OLZXi9dAzBOygijlhugDIM
         ZQCXp0ji1t/+YE8t12r2MM5bfVAC4/CNvopQTBkkd5e/1CKuWgSn5JnOTtwvOoq3kg1K
         rpH2EUtKybKTqHIEgnL/mUWxPj3fuKOg/lYBCX3TxIr0LdF7iOzFuyFFSar9GPkgG5wG
         b/5ZRiFIWjOqzCz36qKRohaIuVqvoXGWbjQK0KAPL3zxr81akAM/gcI1cmFpLsvG2TWP
         s1TOfDhaYAE+L1aeF1NN1M9QDbSB5DF2+mDiHTxsawGRUL6fdKVteJTcuBNPHdsElZcn
         Si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=seNxExmGCzVUpMy721uqn8oAKM+L1AqLwUaEq+oUCgc=;
        b=iK69hmlSFwPmKSqkx0YCTN8xbH+KYIxFg4R9J2pUPd/K7ZN5o6b42cUjJzn7sFeoKE
         bNeDdhwP6Ri00nhs5Jm1bH5heudzczi2gZp+Zz4Jrl9Xt66t7/5JRrTCl/8L+NvepzoI
         Tbhkd5rf+xIgKr6oAEfrRx5A3JE0uiejLhnFuN0Y0sAekecPqYKZM4PqaMQiO8/m40CA
         PClualyiHCNDt/1ht+IiSeF1Qdmw6EC0uJZB/TxC5U5Hpmv/hr8mg8o7/GgoSFVqhv6u
         8qv7JraYwtubttplRvxsXRT9UW4ZIYas7sled5HDrhO/K0k5j+qkNUkRlezv0qAYi7sb
         94Rg==
X-Gm-Message-State: AOAM531H4JizuIbwWUM58lee7sJRuTqCEAyGpdPUPGVLms46lCnr76+7
        8d4wEJHqIfJA1dqV9z0ROTbhifkAWlurE6PAd2WOuw1OvHkIGUXHQA0n2vur19K0l6w7mhYpU5C
        WvN7JBeU6sNZwHdtZZhbTgmUMGM2NzFYhMJOHaryibyFFZXzopv/UitWX/7TGgGc=
X-Google-Smtp-Source: ABdhPJwhQdGubFBgJN7HnKtJ4I92q9B4Ejitg9aaAAj0QhhAl7UrPaoVJRRTWKy8ZMfKDHX5PufqgJ24B/Tm2Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:380c:: with SMTP id
 mq12mr538647pjb.32.1639697611402; Thu, 16 Dec 2021 15:33:31 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:21 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211216233324.65126-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 2/5] branch: make create_branch() always create a branch
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

create_branch() was formerly used to set tracking without creating a
branch. Since the previous commit replaces this use case with
dwim_and_setup_tracking(), we can simplify create_branch() so that it
always creates a branch.

Do this simplification, in particular:

* remove the special handling of BRANCH_TRACK_OVERRIDE because it is no
  longer used
* assert that clobber_head_ok can only be provided with force
* check that we're handling clobber_head_ok and force correctly by
  introducing tests for `git branch --force`

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c          | 55 +++++++++++++++++++++--------------------------
 branch.h          |  4 ++--
 t/t3200-branch.sh | 17 +++++++++++++++
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 54e989f3c8..6f474a5505 100644
--- a/branch.c
+++ b/branch.c
@@ -426,15 +426,17 @@ void create_branch(struct repository *r, const char *name,
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
+	if (clobber_head_ok && !force)
+		BUG("'clobber_head_ok' can only be used with 'force'");
+
+	if (clobber_head_ok ?
+			  validate_branchname(name, &ref) :
+			  validate_new_branchname(name, &ref, force)) {
+		forcing = 1;
 	}
 
 	dwim_branch_start(r, start_name, track, &real_ref, &oid);
@@ -442,27 +444,20 @@ void create_branch(struct repository *r, const char *name,
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
index 1bc3795847..7a0ff75ba8 100755
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

