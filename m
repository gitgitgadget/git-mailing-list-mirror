Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A8C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiBOIck (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiBOIch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72AADFEE
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so30644656wrc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZbtwX0GLSsu8C3WqwPHVHg7l/tECBP6cyoIzbFydJU=;
        b=GAtPpS6qwWsIsBtVHJDqI7/MTRZ1b/DSPLilyQpi9AWu1kdGxbsgQg1yiCs5N9C6LX
         bwlwMg12tL5GUESQTzl6ylSPPsZv3EgHz2lWIfcWKJgNnwnTmLfzk18wlihiPjxM5Z0G
         EHoVtXhZaCiDaTmxYnRxOIX4sPZdL0h9Ncn1yYk8hEfw44Fc2shVfshnbDs37ZowaLJJ
         uigG20Hclnt9ODqDVzsee+tFH3S3SPyce+kGU50MRRuppCAo2g0E0O+Ya0iadub1Y0bs
         9Abf7CkJQoSLdutTNqtMdT9u2PapcL8nSJTImrm15b91PB7K03hDQCrt3iv53V++POVm
         lh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dZbtwX0GLSsu8C3WqwPHVHg7l/tECBP6cyoIzbFydJU=;
        b=O1gWCQuIxtNQLyg/+1+e9C1niiItvy0JnEsJPSCtTCUFrkrHMzR0pQjBccbZpKKhPl
         8v/fddyevq31VY7Am9bMist/wJ5Vhh9sZzdxAVf6MyDN3L+huTx/yBR6gSfTgFk7o8lq
         KExFfAzvIdX4NIE15aQcaXSRWXJBss1mgyG1BTloqsOQMe3WAdWsnknlFHWWybC5SGbO
         0RC9GM54eBPosTVHktgADLX3rh9EB6F7LNQ4/sUg9j6r7jsjl6eT9xN3A1gd60J+ZdMG
         6uoJDofC+neiffv1HzUQH83AJFcPsPJc4Srpl90QJFOBTAMJJsTB0G1i+aC/JgSThPru
         lj4w==
X-Gm-Message-State: AOAM533fMq6vkG3v2byhRoHdxodJHJDfDsZ5RX6MA9SpJlCBoRVoOjJ6
        cqeY7duvSD56SiiaJ5eamWk5iGbngHQ=
X-Google-Smtp-Source: ABdhPJwEuwlgEy3lmn4CW2X5lzHLVPqpw7ZbT92aoDF2tMLxt8f3QB6mkJEjFAU6e7mams54kR91Xg==
X-Received: by 2002:a05:6000:108a:: with SMTP id y10mr2207451wrw.464.1644913946123;
        Tue, 15 Feb 2022 00:32:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187sm14327721wma.22.2022.02.15.00.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:25 -0800 (PST)
Message-Id: <5536fe6498e460e217a74c743f92c42b1615f9e5.1644913943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:18 +0000
Subject: [PATCH v2 1/6] sparse-checkout: correct reapply's handling of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4e256731d6 ("sparse-checkout: enable reapply to take
--[no-]{cone,sparse-index}", 2021-12-14) made it so that reapply could
take additional options but added no tests.  Tests would have shown that
the feature doesn't work because the initial values are set AFTER
parsing the command line options instead of before.  Add a test and set
the initial value at the appropriate time.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          |  6 +++---
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a311483a7d2..fcd574f5fc1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -789,15 +789,15 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
 
-	reapply_opts.cone_mode = -1;
-	reapply_opts.sparse_index = -1;
-
 	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3592d124424..ce5e7c19efa 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -495,6 +495,34 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak sparse-checkout disable
 '
 
+test_expect_success 'reapply can handle config options' '
+	git -C repo sparse-checkout init --cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --no-cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --cone --sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget

