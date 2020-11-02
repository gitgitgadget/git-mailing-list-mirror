Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA370C388F2
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F4022275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrZqi1gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKBXzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgKBXzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:55:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BFDC061A48
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:55:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n18so16524894wrs.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zah1rpPiypc+IzYCb6VAdx7i1+oP3iBoqrFal2KjUq4=;
        b=WrZqi1gS2VDDWGMfDmtkogUtMz0jHUUNh0jzBLiBY9pO5rD1uLiK1NnDGq2yOZhbOU
         hr3Hno7PjBwqoNz7V52LY130Jqt7h4HUHNTmXNMjXGyHWcf1auJ6VCN3IQVKD9zIKdGH
         S5CrzdHtxZqL/KoAlTskHfIqYUDb1YTu1BURwwcufvv2ZdyMZOnFg0QZiykHzgDlNscL
         Xjw44Z/Vyz+bV/LZ3jTVVmozg8JncsqTd1Ee2cID7k3RUbGFGklVaDE0o1qhhZ8PzO8u
         mQhfRnbemIwZ15kXpqPrVEi/qAYWMa766PoC46K32ESMqNnAHqpv6m99AuwbnmDTwcsP
         bodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zah1rpPiypc+IzYCb6VAdx7i1+oP3iBoqrFal2KjUq4=;
        b=pKQDi4ScqNaj/gCeSqsyh7WR7S1iwxiyCOwMuYu985SmFagDSNv18NBpGrsosG+KTV
         nUcD1O42rIyIxse2kY2F9WJfT74msD4y9OF6wjMFRZhl7aMYRNUqPzRAwaBgNqC7uuTj
         sb5D1t1dLxR2t1plYSzaVJfqBQZpFMxU1YYmby6CHXEVlJp1Oms8cncYdRraYMHLtlKP
         mgu8O9IbaFLT6k5PXwYHPwylmzxK/BEe7ohIKbjaFTaEXJAclTf1uNI5EGhqZi+cu2+z
         1mMc8kvwzYGydbbV5SFm0F8iMZycYhXiEikDH6Jcq2WRK1+gCJLrrX69l6kWR4Yw7TH2
         ie2A==
X-Gm-Message-State: AOAM530PXwIh5NnHX4/rID9D2hhn0FHC/HETl0RIM0VFNB03Sh5Vr9PZ
        SAFV0iVFzNTU/b2PYO+ItBOtdCSm7ic=
X-Google-Smtp-Source: ABdhPJzOkPJ/64WXOf2O8sXb/gpB1J2jKD6+GOicArBJGlbIgnIlovhEx6Yr8HsAcBMjK6Uc+c7Tdw==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr21885487wrp.332.1604361312078;
        Mon, 02 Nov 2020 15:55:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm23863129wrj.60.2020.11.02.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:55:11 -0800 (PST)
Message-Id: <3704ecd9a82ae9d8fb705dd179b9ad2c9240d04d.1604361307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.761.git.1604361307.gitgitgadget@gmail.com>
References: <pull.761.git.1604361307.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:55:07 +0000
Subject: [PATCH 4/4] t5515: use `main` as the name of the main branch for
 testing (conclusion)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the previous three commits, We prepared the `t5515` script and the
files in `t/t5515/` for the upcoming change of the default branch name
to `main`. The changes were made over the course of three commits
because the overall patch would have been too big to send to the Git
mailing list for review.

Naturally, the test could not pass in the transitional stages and was
therefore disabled via the `PREPARE_FOR_MAIN_BRANCH` prereq. Now that
the transition is complete, we can re-enable it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5515-fetch-merge-logic.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 1a81991cf7..50f14101c5 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -11,16 +11,11 @@ test_description='Merge logic in fetch'
 GIT_TEST_PROTOCOL_VERSION=0
 export GIT_TEST_PROTOCOL_VERSION
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
-	test_skip="In transit for the default branch name 'main'"
-	test_done
-}
-
 build_script () {
 	script="$1" &&
 	for i in one three_file main topic_2 one_tree three two two2 three2
-- 
gitgitgadget
