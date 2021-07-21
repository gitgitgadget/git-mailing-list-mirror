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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6AC636C8
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D0C6113B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 01:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGUBCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhGUBCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 21:02:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF59C0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so380319wrc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HiROisDT4T5MvSgx7njmc0Y7ZYyNM7DadaK7YGuEV+0=;
        b=XyJElbFgpiM2qGyoqm+Z+9FnvVS17JGRWgGWE086eMjtq53uaJDFWEmZX1obX1xFoH
         T1YkzLT9N63RWM8yBUF7Igl6nhYYwSZI+Bnybl73u96JrvhmzykSsUhaZlazXnHqIRnb
         HSRk0rLhsBw+2Ib70TX9P0DsI64T4jnAnmtCTQDEh+HClH94Sl4nEFaoCWE3c0S9hhlo
         g0cZ/PoJUcBIIo0c8mlyUftrvpRLE7HTI3leILrRzVhYnRwCxC84Y0ey8P7BTCbYjjjI
         OrT0L3oo/Jj7pofUSqZ3KJYX22o30tIZxZowB1u9ZqQRFq8hfDry1aU8lmM063B7JL9l
         eTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HiROisDT4T5MvSgx7njmc0Y7ZYyNM7DadaK7YGuEV+0=;
        b=Jw2HYaiN43T4l7T4C1ixUcXO+22NZ7UCEX5UQmWEMtuKt2lQJ26FlBkMrE5TPK86cT
         llqkjhsn2kQTAdkQ4dxU4SQ1FFkMzpaNvtcwkipD9ZS+AGxFmHLPghAVvavQPVdWSYUJ
         3OVZZr4pg8MSASQKwSsPjz2czPqXSqvC9jBLOMgfhzKSJXA5sc/MQM26mFsl5djb1cNi
         C+JLdvqPfTAPvLCc3eK8M6G8eYWBkiBfCzAsEP6sHw7qL2aptub7jhspXdNxYsZplSQl
         MjI0frdoPfDWPa5KvhRaNAFGFijDTVyZN+YFrfCCmDQQSuqVaqJ0GGYVggLuJlimld4Y
         m97A==
X-Gm-Message-State: AOAM532meSW5BbkH4KDG6cbUQ9CUo5LIr864XWq0l4ZyuQGbL1opysmM
        N/ZbcQOn4LSSwTpwMbvEZGn7vUQs1Jk=
X-Google-Smtp-Source: ABdhPJwKGsNpD5D330I8FcIXviCCnc8puHxvzp5sUfYgHHwy1YJe+TCg9+X8SuKkSFNGHsG09aDxQQ==
X-Received: by 2002:adf:d1c3:: with SMTP id b3mr20746125wrd.4.1626831751140;
        Tue, 20 Jul 2021 18:42:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm20498426wmc.42.2021.07.20.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 18:42:30 -0700 (PDT)
Message-Id: <f03b15b7eb03de2fe696e12622031bff484c4912.1626831744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
        <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 01:42:24 +0000
Subject: [PATCH v2 8/8] pull: fix handling of multiple heads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With multiple heads, we should not allow rebasing or fast-forwarding.
Make sure any fast-forward request calls out specifically the fact that
multiple branches are in play.  Also, since we cannot fast-forward to
multiple branches, fix our computation of can_ff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c               | 18 ++++++++++++++----
 t/t7601-merge-pull-config.sh |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a15d4154093..d6631d23d17 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -913,12 +913,18 @@ static int run_rebase(const struct object_id *newbase,
 	return ret;
 }
 
-static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_head)
+static int get_can_ff(struct object_id *orig_head,
+		      struct oid_array *merge_heads)
 {
 	int ret;
 	struct commit_list *list = NULL;
 	struct commit *merge_head, *head;
+	struct object_id *orig_merge_head;
 
+	if (merge_heads->nr > 1)
+		return 0;
+
+	orig_merge_head = &merge_heads->oid[0];
 	head = lookup_commit_reference(the_repository, orig_head);
 	commit_list_insert(head, &list);
 	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
@@ -1057,10 +1063,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase && merge_heads.nr > 1)
-		die(_("Cannot rebase onto multiple branches."));
+	if (merge_heads.nr > 1) {
+		if (opt_rebase)
+			die(_("Cannot rebase onto multiple branches."));
+		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
+			die(_("Cannot fast-forward to multiple branches."));
+	}
 
-	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+	can_ff = get_can_ff(&orig_head, &merge_heads);
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 742ed3981c7..1f652f433ee 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -331,7 +331,7 @@ test_expect_success 'Multiple heads warns about inability to fast forward' '
 	test_i18ngrep "You have divergent branches" err
 '
 
-test_expect_failure 'Multiple can never be fast forwarded' '
+test_expect_success 'Multiple can never be fast forwarded' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
 	test_i18ngrep ! "You have divergent branches" err &&
-- 
gitgitgadget
