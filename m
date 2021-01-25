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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B74C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9AD22583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbhAYSNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbhAYRzr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290ABC0611C0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so13823457wrz.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sGydUQb2UhpH1D9fSdUXsEtwvQkgf63UmO/XmLlG58Q=;
        b=nrVxuFXv1jSNqCWL3ojs2GMb6uP4Z9C0gMgF+ymI6lFXuYtSV3zI8CWfyj7/OmPUAW
         yg94N80Wh1Li08uskACsVFdryLhkqpkcY6W4zoib3y01MeIsfRqQtIe0WxBZN06hYuD3
         2Hwgh+agnBBjcULtsFPF7LOv7uTm3VRfxFaVuCdce+sN6y+cVlZTd8SfmaDsfqVmIiuW
         TeAYUyiyBpryl///somROsxAd928nL6ihKpMUp89iAXZ1wASvfr3gFbERldZqQ+QbwFA
         PhgDbqIFPjMZWU3OsIk/gwlc94yAchnBbJLaiscX1jEfQMPvrqGo0TWfD/jkAStw2r89
         dkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sGydUQb2UhpH1D9fSdUXsEtwvQkgf63UmO/XmLlG58Q=;
        b=adEa3THeIrVvXu6p2LtuEn+WUhpukSecJff8IjFGzOO45GTFzY9pgYhuEUr4XlwcM6
         QDFil0iaM2kmvYf4WR0eKOfBLnGfn11lUvrG26/AyTKZmTzIrzSC6Hzjr/giydr7HWcc
         Md4LzXxmCUb0aKsbsg215DbTvaV+ccSmY6WMQISLM1L5s7YgxXQUk0zEHHdkuDpLkmw/
         4bRp+chMz+0AzQrbEAWVLBZqP+Wh/qcPlGi/cR3ZujiJzGrL9tZhlMPmplWAajZVYICm
         azl9YhLP1zDcUsencM9jI4e0RoxnFCIJ0xFd02W2ujWbg9IpEMEVvo2mZM3xn5229dl2
         zYMg==
X-Gm-Message-State: AOAM532oJow6uXQ1FYZDT7lnZtEFqeicaZW+TfxocTQ3hPGT4I1SCib2
        JBL82lv6PHQWAhRp16j8b3Ie/zoZf2M=
X-Google-Smtp-Source: ABdhPJzPSwyY5jlmpLzEuXSGY+17z/CipZdb70VrJDkSizsFtNKoRtW78PETbhaXVjocWHUOk3hjAQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr2290669wrt.124.1611596555807;
        Mon, 25 Jan 2021 09:42:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm7999483wrn.77.2021.01.25.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:35 -0800 (PST)
Message-Id: <6b9f935b87aec1806f48294574924fc26c4abbc7.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:09 +0000
Subject: [PATCH 23/27] submodule: die_path_inside_submodule is sparse aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Since we already do not collapse a sparse directory if it contains a
submodule, we don't need to expand to a full index in
die_path_inside_submodule(). A simple scan of the index entries is
sufficient.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 submodule.c                              |  2 --
 t/t1092-sparse-checkout-compatibility.sh | 24 +++++++++++-------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index f80cfddbd52..487d083e4ef 100644
--- a/submodule.c
+++ b/submodule.c
@@ -346,8 +346,6 @@ void die_path_inside_submodule(struct index_state *istate,
 {
 	int i, j;
 
-	ensure_full_index(istate);
-
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		int ce_len = ce_namelen(ce);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ae594ab880c..2e8efe6ab37 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -390,29 +390,27 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
-	test_region index ensure_full_index trace2.txt &&
+	test_region index ensure_full_index trace2.txt
+'
+
+test_expect_success 'sparse-index is not expanded' '
+	init_repos &&
+
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c core.fsmonitor="" status -uno &&
+	test_region ! index ensure_full_index trace2.txt &&
 
 	rm trace2.txt &&
 	echo >>sparse-index/README.md &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" add -A &&
-	test_region index convert_to_sparse trace2.txt &&
-	test_region index ensure_full_index trace2.txt &&
+	test_region ! index ensure_full_index trace2.txt &&
 
 	rm trace2.txt &&
 	echo >>sparse-index/extra.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" add extra.txt &&
-	test_region index convert_to_sparse trace2.txt &&
-	test_region index ensure_full_index trace2.txt
-'
-
-test_expect_success 'sparse-index is not expanded' '
-	init_repos &&
-
-	rm -f trace2.txt &&
-	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" status -uno &&
 	test_region ! index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

