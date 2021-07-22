Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952BAC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D14D61279
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhGVEYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhGVEYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B4C0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l7so4457765wrv.7
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EmP26rVYFu+5DDOXiB3E0xPtqgcGXQ2j4BGSsFSir/M=;
        b=Owuz0ZnIejgk+xFWymvcA50KgO5tAlyFg3r85nfBUbfztqBJGssBkqyT+BgKunXtNE
         OvAtEqZmlxCKHbpJPV6X9GpiPZWrhb7rqyuKcVfSlaUf8VNCZGEKNN5Dw1A9T8e8t70W
         7/Qp8pjENooJi0lQrTO364lU+1gidw4bOXfha8gzIfz5XD8sKOvB3mx/XSCG+VkwREoK
         Jt5i18cnGWzGe+9/BqavsC5ZssQInQ6Ozm9W5D1PqIhyggqCqrf8zu0N3dYfO/aNiABb
         QrdlELezazOfmyj+sytxVeHAU0Gi1fg74OZNoFSuqfx1Ko84BmLPlR+EC5p8d+lwAbDm
         4GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EmP26rVYFu+5DDOXiB3E0xPtqgcGXQ2j4BGSsFSir/M=;
        b=F/jr75StDx5ZPZD5LoBQqMkqrfPDIWaSorQYGwgvsSw+7g5N0b2dkI52hUQDYi9InD
         fF8828PTNS1jKBsCUqCH58TSVinXU0yFawSEU1cqto1z4QGn+5/zHkvRlR0ScM6NJoWI
         LjgMpd2jao8WaD7zFa/EITKbtuRsmJt4FUdD0j0VgveZB/gPRUYcD843hmRny8hlr9tb
         pHpIrLZZ5r75c6i15A6Ofi+cmKN+vAe1J9yojqx0OwGOMxCiODLUU/ly2GZyaq6e71Xd
         fQ3/Czn5clZkF5rK5VGvs5A/chYeJV37dk6N6L9hE4DVJVyKfa/5pxYnrAkzjEbQpIhC
         eZwQ==
X-Gm-Message-State: AOAM532g03yOTz4r7A4fCznkYKrBcn6u/GyIwhVxf3EN4vl/HVVLIaK5
        z5BBqvs5LyY4o1LK5PHVOkgrr1GWGDY=
X-Google-Smtp-Source: ABdhPJz9yGk8h0mejz1m4vJ4w5J+FIuW3ZYBX6ZdYAWUSYOjOsEp7PiyiAbaBrBB/2KfxezkNFXUZg==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr46991404wra.291.1626930296495;
        Wed, 21 Jul 2021 22:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm12712982wrw.77.2021.07.21.22.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:56 -0700 (PDT)
Message-Id: <768dec715582640ca6a48b3e158d1a61e422d0cc.1626930290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:50 +0000
Subject: [PATCH v3 8/8] pull: fix handling of multiple heads
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
        Felipe Contreras <felipe.contreras@gmail.com>,
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
index 2f1d1f4037d..b311ea6b9df 100644
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
