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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C9C636CB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF946115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhGQPpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhGQPo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25BC0613DE
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f9so15601234wrq.11
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7bvgnX1UOwK2YlUbgGPz6WdTxUzk++lvjU1X/6Tqioc=;
        b=Z8uAs249tzRejZgWmm2a7xCiPxVkqZoOcnhwNyMa5daLtfQnzqrYkBvIV9884WsZeJ
         uojEBC6WtjpYgxUHmuVKBXPZ9zBLYUL3P+xxsVYSzYb0Y8zaA4c4dr04bueOyXKBeAFa
         rU1gkllrwf9NT1NLOHJQnZaNmjrq18qiwYS+kv1zt7B3mZMKBlqsp78/CMUTdmBgJKgV
         /BmAPkco/4bKnrOJMnxUit12/NUpUvoFI/lLzHHBQJ2QApiPcYLyTdxO8UZHxmdsIogk
         sSNoK4/qQW1DIZBfnM2CjDXh30sW4egWfRVsJqG2eokIFzqjTlQ/nRIX42Lg7MO00AOs
         wP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7bvgnX1UOwK2YlUbgGPz6WdTxUzk++lvjU1X/6Tqioc=;
        b=i03Q+CVceECLlFIzUKjZakTgvzown0NDeuAE+x7BaBtuFBcuXRUGWk3mZMQhkaww8v
         ry0Z/4ZvUJhGfRIT06e60WY8X1nCb4TQ/m2Zym54LSl+6hBQfxfBIoju7q1Nt2aFNiy7
         oNRahNV6tbFaIQwTw1O886ubCIrjicklHnT39lFHi4UrIzfJJE5KvxYpXG36yAofKhJa
         hccawVmpud/Jp6xQyP2wlJ5sChCne2ZT7FsbUU3/57DL3vEzNaF8pLKVx1sMqEesUF6s
         RgrHAUFdFHQQjDiDF50+wrg/u+QGPO5CcI2O/G0nchaOCUBPJhMjQLirBWXHn9BclaEF
         ZU7w==
X-Gm-Message-State: AOAM530xI660DdAOfF2D+J9Kk4XJDJBJNPSyrd7vhWk8VTb60kwZAm5o
        rxudAwZ0dniyax5xr4SHpaJKlpbijMY=
X-Google-Smtp-Source: ABdhPJwf0H9h78n1cNxoxzr3CU3kR2Wi7bzN0MxyAYrWcWF9VrLE9hhCD60juUDkWT4tKeHGkOUI+w==
X-Received: by 2002:adf:90e2:: with SMTP id i89mr20103163wri.338.1626536515352;
        Sat, 17 Jul 2021 08:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm14211606wrt.23.2021.07.17.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:55 -0700 (PDT)
Message-Id: <3d8df24677269ddc379e0bfe5a6acc7f1dfd4fee.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:47 +0000
Subject: [PATCH 9/9] pull: fix handling of multiple heads
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With multiple heads, we should not allow rebasing or fast-forwarding.
Also, it seems wrong to have our can_ff computation return true, so fix
that while we are at it too (we won't actually use the can_ff flag due
to setting opt_ff to "--no-ff", but it's confusing to leave it as
computed to be true).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c               | 20 ++++++++++++++++----
 t/t7601-merge-pull-config.sh |  4 ++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3a61b92f328..beaf6ee0653 100644
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
@@ -1046,10 +1052,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
+		if (!opt_ff)
+			opt_ff = "--no-ff";
+	}
 
-	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
+	can_ff = get_can_ff(&orig_head, &merge_heads);
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 673b92afbab..29105b5b1ed 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -297,7 +297,7 @@ test_expect_success 'pull.rebase=true takes precedence over --ff' '
 
 # End of precedence rules
 
-test_expect_failure 'Multiple heads does not warn about fast forwarding' '
+test_expect_success 'Multiple heads does not warn about fast forwarding' '
 	git reset --hard c1 &&
 	git pull . c2 c3 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
@@ -307,7 +307,7 @@ test_expect_success 'Cannot fast-forward with multiple heads' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
-	test_i18ngrep "Not possible to fast-forward, aborting" err
+	test_i18ngrep "Cannot fast-forward to multiple branches" err
 '
 
 test_expect_success 'Cannot rebase with multiple heads' '
-- 
gitgitgadget
