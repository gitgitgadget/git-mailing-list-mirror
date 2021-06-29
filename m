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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D3C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04EE61CED
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhF2CPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhF2CPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68DC061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i8so1482633wrc.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CjCwvYNfaftKNON/5Qnsv7Bb6epxLgdnNa3qG/hBIJI=;
        b=R6F5u1fd9r3KA4+G5u81vc9FCOzJWG8Mag1ZoDVopvhUNoH+xqHyXALUgqqpZDUDye
         Eq6i7s9ze5aXxiYzALk3uU1ZnS+ip7/QKRGsQHfl6HcHDcwk6q7+umu5QVm6/Haa6G6K
         sYb1KuKf7OgLdJnuAv8+W6YDgFAACvjmNPC6LrFUqB+yWQwSODrWfJmMl9cXgUygD4eO
         CIcJsGjDDa6l/6NuaX/0bqy800QHQEYq67VgV94XUn+ORLatWYxAeeVUMQRyCVeiIlLM
         aSL5PCM8IGFTeVyOknhywufEQzTm8b6ffdR07eeLlI0M6oDn/fAC8vWxIlvBVO4JN4FV
         +3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CjCwvYNfaftKNON/5Qnsv7Bb6epxLgdnNa3qG/hBIJI=;
        b=MPun1iPlEXVlscnywkKX1yrcpVHa47sx63SA2A5cOBtD83f2GuFIYxX0QsQDiZhtXV
         3gIlpmW0Qh+sGS8p5nI5ghaAndxFYVPnKYU8tkVQaaeJjNJhN3n7VSiyX3/FroWTvhXJ
         0E64VaroLrlfETDafOvt6xgHXs/t/mLgXD8e6/krggM9qLlDFiwjmY8CxrKbNDG8pnJv
         0HPuRYVCtUppkzllxNmSO+q5pSOgBcjhbDJEuDCRw+HAtn0RTR+UA2oTwuQ4aQFh5exb
         7xghhd8ZeB1TiYphtggCItKxr3heSZMRVCHU0pcwQWZoj4zqivY9TSwZEy0vcNTI5tAc
         FL/Q==
X-Gm-Message-State: AOAM532rfqJdDiAjKEROxtYDdOFQO/VkGFnj0RknNhgEBE3fI6Qt/7uZ
        pEipFCtnhpPGA7csXXOmPFg+iazN5bU=
X-Google-Smtp-Source: ABdhPJxt1NFjM2T575t/gBUrLsHajl3JxzHcOHySXbIuWP/N21dPvU6ZI3U49MK5cV8IgSKENCULxA==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr30498352wrm.153.1624932788967;
        Mon, 28 Jun 2021 19:13:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h206sm1097268wmh.33.2021.06.28.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:08 -0700 (PDT)
Message-Id: <eb15bf37685b1f75255451c9fa8aba7d69fc2b14.1624932786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:03 +0000
Subject: [PATCH 2/5] p2000: compress repo names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

By using shorter names for the test repos, we will get a slightly more
compressed performance summary without comprimising clarity.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/perf/p2000-sparse-operations.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index f7f8c012103..597626276fb 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -52,36 +52,36 @@ test_expect_success 'setup repo and indexes' '
 		git commit -a -m "edit $SPARSE_CONE/$l2/a" || return 1
 	done &&
 
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v3 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v3 &&
 	(
-		cd full-index-v3 &&
+		cd full-v3 &&
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
 		git update-index --index-version=3 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-index-v4 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v4 &&
 	(
-		cd full-index-v4 &&
+		cd full-v4 &&
 		git sparse-checkout init --cone &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
 		git update-index --index-version=4 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v3 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v3 &&
 	(
-		cd sparse-index-v3 &&
+		cd sparse-v3 &&
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 3 &&
 		git update-index --index-version=3 &&
 		git checkout HEAD~4
 	) &&
-	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-index-v4 &&
+	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v4 &&
 	(
-		cd sparse-index-v4 &&
+		cd sparse-v4 &&
 		git sparse-checkout init --cone --sparse-index &&
 		git sparse-checkout set $SPARSE_CONE &&
 		git config index.version 4 &&
@@ -92,8 +92,8 @@ test_expect_success 'setup repo and indexes' '
 
 test_perf_on_all () {
 	command="$@"
-	for repo in full-index-v3 full-index-v4 \
-		    sparse-index-v3 sparse-index-v4
+	for repo in full-v3 full-v4 \
+		    sparse-v3 sparse-v4
 	do
 		test_perf "$command ($repo)" "
 			(
-- 
gitgitgadget

