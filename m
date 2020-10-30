Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6727EC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9372076E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9rXdVPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgJ3Lqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJ3Lqo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:46:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733FBC0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:46:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b3so209314wrx.11
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YpHGG8rzbBas8C/sh3S+K7fnjCD4AsC497U7lowOouI=;
        b=L9rXdVPm/IJEWTn8cKc8dOUHvLDb2FuY9Tqtk4X943myvCDuMGUS/IMPOsneVE31hY
         xEX4I7tw42O4i7X4L+LhBdp+OwvNW+lFg6pBNNwXxTf57RQ1TzrrTKyefKnjjMCrEduT
         PbfDOFB6u3sRqYVIfcmm03KkYimYRPLQVdAPgv38wifCTIEnmvAjOlppLH7fld1urw2Y
         qsIwOIRrd65DnHfCzgjLlK7D2fhmPb1ignZ4tnm+JIDuzGWIs9ZKmkX8+Ac+EoLZRvzc
         Nx38U/Bkd0eR0Hp83m8kWYgabZPH9n5vyFfGUV0PVIcQNi9TaDDLfJ802ko4sV4rluWW
         SEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YpHGG8rzbBas8C/sh3S+K7fnjCD4AsC497U7lowOouI=;
        b=N71GWEkuSSW96bW6JReI7VIrcPnGXxPBkFgLHgo/3ZF20XA5sOilE/XyxFByCQ+qtl
         LzFrXeQ/omxUKpYRfshFNm4XPmvzlLkueAe/4zuQX8bshskuCtK20fl/qyitQSSi/7MQ
         Icd9I3TqYOewBqkA+QQKIRWJON8/kHm8Hn+ZPMN9qwMm4pXgxcjQvSTRy4ffyl2A0kZR
         /WmzWEZuBA5/payFKAjgGWaUhuhnMgzs+y8LjCsVUU2QtBWec9IAEZ9189tFLq1NH4TM
         jGtMsFCJoS0caW6A+COHqEKdkTSPlVG7bHqwjpRGkgcmuaJ8Hvg+yPKO7eQ8pKXHKXQw
         txrg==
X-Gm-Message-State: AOAM533i/uMDbWEWhMgNvKKBRQpKZTO58jN9D2K4TnzJXKKDEJy66eSc
        DN77xmvkztftE8vXOih27Njgkqra4PQ=
X-Google-Smtp-Source: ABdhPJzgFKfsH0uk02tpWzszYwjFoCjnnUpnINarS6WGWvx/DsNm5dDxbkban30M6e+guPXoBo/K+A==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr2659221wrj.177.1604058402945;
        Fri, 30 Oct 2020 04:46:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm5414011wmg.32.2020.10.30.04.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:46:42 -0700 (PDT)
Message-Id: <pull.906.git.git.1604058401991.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Oct 2020 11:46:41 +0000
Subject: [PATCH] Fix potential segfault on cloning invalid tag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sohom Datta <sohom.datta@learner.manipal.edu>,
        Sohom Datta <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom Datta <sohom.datta@learner.manipal.edu>

Git allows users to create tags pointing to object hashes
that may or may not be commits. When a tag that doesn't
point to a commit is used with the -b (--branch) parameter
of git clone, git segfaults as it assumes that the tag will
always reference a commit.

Add a check to make sure that lookup_commit_reference returns a commit
before detaching HEAD.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    Fix potential segfault on cloning invalid tag
    
    The bug can be reproduced by running git tag 1.4.0 $(git rev-parse
    :filename) on the parent repository and then cloning the repo using git
    clone --branch 1.4.0 file://path/to/repo. The output should be something
    along the lines of:
    
    Cloning into '<path/to/repo>'...
    remote: Enumerating objects: 8, done.
    remote: Counting objects: 100% (8/8), done.
    remote: Compressing objects: 100% (5/5), done.
    remote: Total 8 (delta 1), reused 0 (delta 0), pack-reused 0
    Receiving objects: 100% (8/8), done.
    Resolving deltas: 100% (1/1), done.
    error: object d670460b4b4aece5915caf5c68d12f560a9fe3e4 is a blob, not a commit
    zsh: segmentation fault (core dumped)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-906%2Fsohomdatta1%2Fsegfault-while-cloning-invalid-tag-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-906/sohomdatta1/segfault-while-cloning-invalid-tag-v1
Pull-Request: https://github.com/git/git/pull/906

 builtin/clone.c           | 2 ++
 t/t5610-clone-detached.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..b4760ac887 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -727,6 +727,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
 							   &our->old_oid);
+		if ( !c )
+			die(_("%s does not point to a commit."), our->name);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", &c->object.oid, NULL, REF_NO_DEREF,
 			   UPDATE_REFS_DIE_ON_ERR);
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 8b0d607df1..c7fd2c5f5c 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -15,6 +15,7 @@ test_expect_success 'setup' '
 	echo two >file &&
 	git commit -a -m two &&
 	git tag two &&
+	git tag four $(git rev-parse :file) &&
 	echo three >file &&
 	git commit -a -m three
 '
@@ -72,5 +73,9 @@ test_expect_success 'cloned HEAD matches' '
 test_expect_success 'cloned HEAD is detached' '
 	head_is_detached detached-orphan
 '
+test_expect_success 'cloning invalid tag' '
+	test_must_fail git clone "file://$PWD" -b four 2>err &&
+	test_i18ngrep "does not point to a commit." err
+'
 
 test_done

base-commit: ad27df6a5cff694add500ab8c7f97234feb4a91f
-- 
gitgitgadget
