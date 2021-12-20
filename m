Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhLTXfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhLTXfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:35:15 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72EC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so72436pga.9
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y5iy9GKGO7c99lxEWkkTlHdC/uDSZaYW556ObBpX7FI=;
        b=MhKnOGwsdEtteS4+xKXhxPYLQj/NhpAogKvkaijbXJuOSBMfBbJ4Oj69fzk9RDJewN
         h71RuTBNYWR5Cs1vYZrLaUQMwTNN3oqI4+sZOzF22aIWIrJmaDcL923B84bAwEXtGQa5
         MRJOOhCJPT6Tcii4leUH7de2VwvcqT6HiLYfV5N6PTO2WJbmXyTkXcGd52qIpQ+O1DCJ
         RMkdUHO/2yZc2YzYaoSAuPFdUqwVlCKoEdkULE0OwtNdwu7omUjPIaQQyYRmWgdCAdFl
         MBB7B8iWbc5NnQmBkJMx56MpLIhMDajp4/hNIdr4Y1kXLDxtmutpMhzNh8zfp/pcEWPD
         d+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y5iy9GKGO7c99lxEWkkTlHdC/uDSZaYW556ObBpX7FI=;
        b=6muwU5DZOjVqwzw9SGtm/Cr53I+44InjUEteWzikDRZAzrQlaQTIn1d0JOEz3pvW8m
         8b2KO3XaOAOCOt4JntQ1DWX8L5SZjS0Yp0A3pGtu/gPntJ/fZXsgZBI2sAY4tp0+tXAG
         6UUFJCtcfZUwffhsnZqEaxiZqR2Na4u4Yp39Je57c+rthk08yyVJHRrYpuGfrSlOpyjY
         8Jk+w7Qz8pyGG8YZTCcvjtGzkM69QwPs37kD/CSep76cQ7tVyLK0ZMlA4h93Arkcwnxh
         NEweNGjPWK4Dr4kl2lQhIxKOerJLMVwea0QpmYjD8uidrt/8MWlMuC8/x3Ef+ASfhver
         ZgmQ==
X-Gm-Message-State: AOAM530iID90tnOU8O5NXLbFYA78vmLCau5Rv54WEww29m+CUTvgUWqf
        QixzxShztueNXYg+ocoNoLsqxYCiz9nklVcRs6e3HYtbHncqBe7po3wotzUFxfkF6aw+wRkutWa
        lGAGqPySzl1fn3wsnfSCp2TQR8tK3HzaRwfPmXe9qtgIdwoNMd5I8GtbTgnQz8ms=
X-Google-Smtp-Source: ABdhPJzUUbdptOz6zbEtASJmCaXmWc+rmeQJZ1ebipotd+QQu9kui/R2fQs8/IJInUhWj1AzhxrxtpoUJ7vXYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ea02:b0:149:927:7e66 with SMTP id
 s2-20020a170902ea0200b0014909277e66mr224829plg.70.1640043315106; Mon, 20 Dec
 2021 15:35:15 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:34:56 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <20211220233459.45739-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v6 2/5] branch: make create_branch() always create a branch
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
index e271a4e0a7..de680f311d 100644
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

