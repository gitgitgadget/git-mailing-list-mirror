Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB6C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiAZNGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiAZNGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8331C061771
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e8so23879943wrc.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lcKW21KfIFpmvlE4yMQWb+ek/SqePBY3AOIEy94txuU=;
        b=oAKsV/oN2FfXmApHsSZscoy+f9Yk2JXlvZHGRdcYAHG+76KVbDPkkFcEVG7AkAgnfX
         3ah4c2kTNZwxjnZt6BQuHPGQ/N/CnhCTdmF1GK772Gz4RrFoM4LY5YqEB0HJuztHXnnQ
         D1k0xS8OKc2vsvny6CudO+JuTqJMurNpjQkLeM2BcadlUpVfsGiWOeykjHa8YBUs73B2
         S2iQW5Y49fuXwLxZEAePq67UbUM7tN9Vx7TQyUo4ii2i4l8J7gqJ0O5kieASK7xynHUp
         R2une7OjTvMG/gwcHG8yDz+VyAhP66uP+IvIYCHw80zMUCRdc0Ccz3DByvXL+bYHg6JH
         cR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lcKW21KfIFpmvlE4yMQWb+ek/SqePBY3AOIEy94txuU=;
        b=yI/LIT4DHaOOVsnbBCjtk5i1ZMYd7qGBJQQsrbAL3rvYEeSHpsFYMi7zR4SJjAGCkm
         4R0D2PMUiSNxslO9IgvFfDrOd3W+wmDRGmtDgx5d2EIYl16ahapWdqd/v0I7TlpUbsd0
         7F9pphHLPVFZfbq6PEFz0qjE0spnewRdZZ6NMCIiSZVXWujb24HMR5gVgq15p3wUUGda
         TZOJ1+/YKXgIAuTFjduVyRBtNSZolM1Iy7oDS2UmePNt65eymGOfgPPeQJtWdcMoKMws
         tTr2mfW71q4mizPwxfcrBCdaM0kiL90m5mjyfw0vfu+96FNRYmsTyzhX6NUbZ165Cvv1
         ag9A==
X-Gm-Message-State: AOAM530c9tublYkVaw8oVvM8m+NkB9odgAgjgANTcbz6dRiB8x5MKZC0
        +Rcc9JqFmRRi/8TBts2ILb5XDue2hoI=
X-Google-Smtp-Source: ABdhPJwhcXZFJjSA1h/8s19DzF1b0q6qXHUPmk1YBwvaG+47Fl46JET/Zn2gLZm6+Of6m4pF8us3rQ==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr17686613wry.393.1643202362299;
        Wed, 26 Jan 2022 05:06:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm10533146wrn.106.2022.01.26.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:06:01 -0800 (PST)
Message-Id: <0ef0e9781127df7485069c6e84786b08d4841422.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:48 +0000
Subject: [PATCH v3 13/14] rebase --apply: set ORIG_HEAD correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of a rebase, ORIG_HEAD is updated to the tip of the
branch being rebased. Unfortunately reset_head() always uses the
current value of HEAD for this which is incorrect if the rebase is
started with "git rebase <upstream> <branch>" as in that case
ORIG_HEAD should be updated to <branch>. This only affects the "apply"
backend as the "merge" backend does not yet use reset_head() for the
initial checkout. Fix this by passing in orig_head when calling
reset_head() and add some regression tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c           |  1 +
 reset.c                    |  4 +++-
 reset.h                    |  4 ++++
 t/t3418-rebase-continue.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b55a9cff05d..e942c300f8c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1769,6 +1769,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
+	ropts.orig_head = &options.orig_head,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/reset.c b/reset.c
index e02915c0f65..448cb3fd785 100644
--- a/reset.c
+++ b/reset.c
@@ -15,6 +15,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
 	const char *reflog_head = opts->head_msg;
@@ -43,7 +44,8 @@ static int update_refs(const struct reset_head_opts *opts,
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", head,
+			update_ref(reflog_orig_head, "ORIG_HEAD",
+				   orig_head ? orig_head : head,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
 			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
diff --git a/reset.h b/reset.h
index 7ef7e43ea8c..a28f81829d8 100644
--- a/reset.h
+++ b/reset.h
@@ -22,6 +22,10 @@ struct reset_head_opts {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
+	 */
+	const struct object_id *orig_head;
 	/*
 	 * Optional branch to switch to.
 	 */
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 22eca73aa3e..130e2f9b553 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -308,4 +308,30 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_orig_head_helper () {
+	test_when_finished 'git rebase --abort &&
+		git checkout topic &&
+		git reset --hard commit-new-file-F2-on-topic-branch' &&
+	git update-ref -d ORIG_HEAD &&
+	test_must_fail git rebase "$@" &&
+	test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
+}
+
+test_orig_head () {
+	type=$1
+	test_expect_success "rebase $type sets ORIG_HEAD correctly" '
+		git checkout topic &&
+		git reset --hard commit-new-file-F2-on-topic-branch &&
+		test_orig_head_helper $type main
+	'
+
+	test_expect_success "rebase $type <upstream> <branch> sets ORIG_HEAD correctly" '
+		git checkout main &&
+		test_orig_head_helper $type main topic
+	'
+}
+
+test_orig_head --apply
+test_orig_head --merge
+
 test_done
-- 
gitgitgadget

