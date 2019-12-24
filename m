Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4FC2D0D6
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48D3206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxiY6QST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLXTzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45630 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfLXTzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so18624144edw.12
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ckHsml5tF8rbwrITNsBewcKB/RzAcohGKcZWm6pvdhc=;
        b=YxiY6QSTP5ZlWiwjGTktnoEWK12xSG91i/AxZJA0nTbSB2F3g0SSvJ+1FygnLMEVVb
         9+RRX1i3Mq+PHBk0olhJEFDZ0Ke5+s+tdN/yjflnxEd/e9KMyuSSA4zkoGfwzT1Jjn/K
         H2227n9ojaf0Xjq1q/sW9UB3hc1CcTK4z7oPamLY301Y/XPL4jryKxWee+epJFHj5vGS
         usqYkKsYjG7BxIP+hFoZ8ilagG85OP4fG9iQr/PgVKkMIPMvi+5S2G8M8K69/n1IIkv2
         kxazKXBJbKvm5U7jJCKEgbWzMJ60SkpPVeCFBKdGYeWeR3GRBUYwihb1Hs2GtvMBYuPH
         rwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ckHsml5tF8rbwrITNsBewcKB/RzAcohGKcZWm6pvdhc=;
        b=aGND9lTA5ZoLVuMGVi/e9VlzVvQkQqdzF8L9TS+MX5+qAqda4IaL2rSbgWb7QTPGs3
         RYtmjzCEkvwGp2k3Fj59PMP2x9LI18in4SEudeprq0O2ZDNEmJMHLNAlrPvAHNsPtNDk
         6441wZ8sw4l3nuGyvDaC5q3GXNtxcoaUF7PXiKv91C1CUIN1gHxv0AvwdJxiyj9ORqHk
         P8yYQ6eRn8gDhSrrnwRU/iub9NL2VuLNi6mEM++ad0sDzDZFp3GX3X/Ed2bY5B0vPSY8
         BGDS0vZjgUaxRcKUGNwH9EwSr4Mbs1UX7DjJW5cjoD/xYz2pgVOGhM+Ecpd4fsaI1Lzh
         DQFg==
X-Gm-Message-State: APjAAAUp4/FZUCVKtUHnbqyCiQ4WUWGkkHSBPXSTD9JFtoZWN9DX4pjW
        hRfop9+G7/yWChDG5TEq5zDMnsPw
X-Google-Smtp-Source: APXvYqwcGTi5IIxjJQhBsmEW0vtBstWWNj6xtrTGfYiZPQ1YeBZn9yoEva+XElpaPmyJjL5UwAtRwA==
X-Received: by 2002:a05:6402:17cf:: with SMTP id s15mr40218026edy.189.1577217306440;
        Tue, 24 Dec 2019 11:55:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm2809101ejq.4.2019.12.24.11.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:06 -0800 (PST)
Message-Id: <f2c92853b47dc5f661e9b20fd390bc6d823ad6d9.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:51 +0000
Subject: [PATCH v3 07/15] rebase: allow more types of rebases to fast-forward
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, we dis-allowed rebases using the interactive backend from
performing a fast-forward to short-circuit the rebase operation.  This
made sense for explicitly interactive rebases and some implicitly
interactive rebases, but certainly became overly stringent when the
merge backend was re-implemented via the interactive backend.

Just as the am-based rebase has always had to disable the fast-forward
based on a variety of conditions or flags (e.g. --signoff, --whitespace,
etc.), we need to do the same but now with a few more options.  However,
continuing to use REBASE_FORCE for tracking this is problematic because
the interactive backend used it for a different purpose.  (When
REBASE_FORCE wasn't set, the interactive backend would not fast-forward
the whole series but would fast-forward individual "pick" commits at the
beginning of the todo list, and then a squash or something would cause
it to start generating new commits.)  So, introduce a new
allow_preemptive_ff flag contained within cmd_rebase() and use it to
track whether we are going to allow a pre-emptive fast-forward that
short-circuits the whole rebase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c               | 18 ++++++++++++++----
 t/t3432-rebase-fast-forward.sh |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f1de5c8186..7027e34567 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1493,6 +1493,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
+	int allow_preemptive_ff = 1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1804,11 +1805,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
+	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
+	    (action != ACTION_NONE) ||
+	    (exec.nr > 0) ||
+	    options.autosquash) {
+		allow_preemptive_ff = 0;
+	}
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
 		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
-			options.flags |= REBASE_FORCE;
+			allow_preemptive_ff = 0;
 		else if (skip_prefix(option, "-C", &p)) {
 			while (*p)
 				if (!isdigit(*(p++)))
@@ -2144,12 +2152,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	/*
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
-	 * with new commits recreated by replaying their changes. This
-	 * optimization must not be done if this is an interactive rebase.
+	 * with new commits recreated by replaying their changes.
+	 *
+	 * Note that can_fast_forward() initializes merge_base, so we have to
+	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
-	    !is_interactive(&options)) {
+	    allow_preemptive_ff) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 7432c0e241..40388ccf9f 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -30,6 +30,8 @@ test_rebase_same_head () {
 	shift &&
 	test_rebase_same_head_ $status_n $what_n $cmp_n "" "$*" &&
 	test_rebase_same_head_ $status_f $what_f $cmp_f " --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n " --merge" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
 }
 
 test_rebase_same_head_ () {
-- 
gitgitgadget

