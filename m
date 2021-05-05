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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B028C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBEE61176
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhEEL50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhEEL5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 07:57:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84863C06174A
        for <git@vger.kernel.org>; Wed,  5 May 2021 04:56:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l13so1510422wru.11
        for <git@vger.kernel.org>; Wed, 05 May 2021 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2X0n99GhToP311xC8295yG4g+3SC6pGzeLRIG4ePD5g=;
        b=JGsHX9haOlgqVBsRpS27r7oirh3Gfq7jXlCSyrElxHwGvh6pk/sjJrqaBhG0CMKg+H
         sbMEgseI21g5ienLlnUTLK6n5uWf1iQhHxtzSCT/LF/rYz6XMRzSWMeCI1txRX8mLxW7
         aXw8RzV1NZkTTuNfLgIy1uz3tIvHHX41BcdiOcEk+flgduFuKbPnnLiLOV7s4bjqSg2w
         houvB2zeg1GQXEQvPnqIJCzGHDGWoQ999ssNwqz9y+GBufFRph11Z9pC/uWI0BDAFdmb
         NS4U7oefBzpEVkgiC/GhRUpYfQq2sKoCrWcon6JJtPzzHTQnr6s+Mu0UNiVYHDggi9x0
         8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2X0n99GhToP311xC8295yG4g+3SC6pGzeLRIG4ePD5g=;
        b=Wgy4b3urDk/I4w7hWK3UFPwfsHNd6IpjA1pRmJwfY/0qNklLg9dG1Bgyb3dxpq/Ojd
         oK0QxKH+Hq1LOy+DEta6fVlymHvlPrcKNr8DS+0OuiRLZRG+cPrTc/mFrWweiAYnBgwK
         hjGwZEoIVtasMsdOMmmSjb2npEApSZr4Birj7eoWk4X43/xkZ8uwTj8ClTZrKD9rMh2+
         7X6m5cQKoN4w0paQsyKdfW4X6kgvNcumvgAzy4QJ3DSPSnUyioStM9bvJB0vntLh3G9s
         I4z2FWs2IBfEtJWyeBqx9H6eb0Tc5MmbQSllHxtxMuafopBKNOnO0B0grhvkX9aBLt4i
         VKjw==
X-Gm-Message-State: AOAM530kK3OTrjjrPVZu7lexIUvEu1hd/g5ef28NIop/sfG/Jesu+Qei
        kljQlMXshpGiHEjMLwEwyPwj7UeCiFY=
X-Google-Smtp-Source: ABdhPJxNDZgyhZn0ANP9EX9utfekzKeb6IJ5yl8eE8LqgtO1YmBJwF4krJ8BMb3cYYr7msCVb2iW1A==
X-Received: by 2002:adf:f607:: with SMTP id t7mr37636968wrp.172.1620215788329;
        Wed, 05 May 2021 04:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm5738070wmb.35.2021.05.05.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:56:28 -0700 (PDT)
Message-Id: <0ee0b7b55691a8923c7fd1610adfe8854163dcfc.1620215786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.v2.git.git.1620215786.gitgitgadget@gmail.com>
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
        <pull.1013.v2.git.git.1620215786.gitgitgadget@gmail.com>
From:   "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 11:56:25 +0000
Subject: [PATCH v2 1/2] git-p4: ensure complex branches are cloned correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joachim Kuebart <joachim.kuebart@gmail.com>

When importing a branch from p4, git-p4 searches the history of the parent
branch for the branch point. The test for the complex branch structure
ensures all files have the expected contents, but doesn't examine the
branch structure.

Check for the correct branch structure by making sure that the initial
commit on each branch is empty. This ensures that the initial commit's
parent is indeed the correct branch-off point.

Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
---
 t/t9801-git-p4-branch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index ff94c3f17df1..50a6f8bad5c5 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -294,11 +294,13 @@ test_expect_success 'git p4 clone complex branches' '
 		test_path_is_file file3 &&
 		grep update file2 &&
 		git reset --hard p4/depot/branch4 &&
+		git diff-tree --quiet HEAD &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
 		! grep update file2 &&
 		git reset --hard p4/depot/branch5 &&
+		git diff-tree --quiet HEAD &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-- 
gitgitgadget

