Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA4C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhLPAcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhLPAca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:32:30 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA278C06173E
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id a4-20020a170902ecc400b00142562309c7so7174880plh.6
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+4R0RTnz+dBww7jba/GEcm9ivv2BMaQVdIhIje0vWI8=;
        b=lKg0c5Unp82Doin1B4jtjdIDA9V8qooGlmhuMYSTMC7EskaMqOGxj6O7q2piZLbvJe
         s7Y+jIfS/VdEoykP4iONoA4qVgtKuQMkUckIZZFs2P50EQodFsWZcyUViodvCo49NruN
         GWFYzDwNSj7gxGRRuMEFhpv0nVNaAU+tdWHxQi0jZAUHpJdgrZgVZUN7izdy5QpJq5Sy
         Zg46lbSH/z/AR17jsI3uCntcvTSihiPSIUMtjf4Z0EXjHHhTHSGR9hoi6taCrL6HpNrQ
         2sSBBf4nplDccIRomYyrVBc4VoAIQBRFUQNiRORhRAJAoqTEDPNZUIHU2kWgiKLepdVw
         6Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+4R0RTnz+dBww7jba/GEcm9ivv2BMaQVdIhIje0vWI8=;
        b=5HMfMRYJjgU02/BctsBC4KpCSBpz7BXpMDxqNQA7Ye+WJWP7sbllTDm6vcHkDz0kIP
         jehbIMDzHQwuXJSeJF6Z/ouF0HnyN4vHBVl4WQoOvxBgBA0v4uHFOUWFTM3hWFi2dFT4
         RHa7fhcTWLdFpjuaMN4xe0ldxxY+19s4dP48ip0zE0GeuTGCgoBZFfyKleg9Pf9S3lbR
         d3sFh5CP5EdAK6LnEMXmFxWUrFEf6LPO1cTGnV2UZRUNoLnkhkarINZUjYxLhdfRUSeW
         cxwGUaNe3FKdkz7DnsMs836SMJU8QYM19Qs4rtPdH72Ux8ItXezQhX7+AUB1aiI+RJTc
         c/Ow==
X-Gm-Message-State: AOAM533uaczrPdLvJS4n6IyMc1krLXitIABNEbmyQM9OdqnUKHhzsbJm
        RIl+j8nJ3OqDvjYiDfKGzExFF7OD+om7YM2nlDDlzGsb/6NkcFhOe32v8Ogvxn1utqA8RHKoLKP
        oK062/MMcofMgL+Rdai3xfpL02DPD6iR7NRPQj0M9AJ3BaJYaYtgIFZIYcp6oI2A=
X-Google-Smtp-Source: ABdhPJxwzUjUb1ScZ+Jh/CBPi+daNG+6KTkc8+fkJwEcLs2hKfYbgkZQfcd5rza0TUpVpvpnRGr7i7g55cgyYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e547:b0:141:ddbc:a8d6 with SMTP
 id n7-20020a170902e54700b00141ddbca8d6mr13844682plf.27.1639614750020; Wed, 15
 Dec 2021 16:32:30 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:32:10 -0800
In-Reply-To: <20211216003213.99135-1-chooglen@google.com>
Message-Id: <20211216003213.99135-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com> <20211216003213.99135-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 2/5] branch: make create_branch() always create a branch
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
setup_tracking(), we can simplify create_branch() so that it always
creates a branch.

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
index fc3304e51d..f8944d3117 100644
--- a/branch.c
+++ b/branch.c
@@ -421,15 +421,17 @@ void create_branch(struct repository *r, const char *name,
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
@@ -437,27 +439,20 @@ void create_branch(struct repository *r, const char *name,
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
index 09ab132377..71a72efcb2 100755
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

