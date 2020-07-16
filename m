Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E8C433E2
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88651207E8
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/SPZE28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGPSpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPSpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 14:45:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609FCC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g10so5908750wmc.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=O/SPZE28uJOv4UZayljJ40fQTyQUGinTgJRoI30BSxFH3ONFNH91UBIiMmSiEiukQM
         JdOiv4m1PYnHAnvc+iMPj3Z6SGXvnvtlTiGuK4L08iP8zJFuCmdHk7KFwcKt1SkAp5It
         ZpjS1G6keZFAo4NfZ5QC++MdaCTXVfS8Grdp/+B9MYGyHkjKwJDurUGGcreTUqITh10J
         Cfet8SlbZNulvkad7d47dOp1vCct/g+BQ6QXPAvsg8ZbFzRd8Mt7bjNw1nYXbeXtgeDq
         0eGLLHXMBje8lz9dgVfIIRjV0MWXtPbNQ134LqeWfk83PQIbsijTqu+LceJ0bhGnG5F5
         Bbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4tPbBuOlUBUJNGrzExajIWDAcijCiaD6SsrE7Y63AMM=;
        b=fPgri29RYHEH0RUFixDMoH2UHtEe6Z0zOya4Ok2VlgvDxSC1fjTo3ULjQFKGHDs2uZ
         9NfzopslmNlY6/JDogXd7Gpdug2kOnz+q050ph632C0VKfoBBtURtnYkg6MlnzlutJ6J
         H/dci54E7gZuUrzFw4eVk+vUyoUJ0mFZ4psIJrY1+olBZ1asZQGXvBLyUIYXmp+4atms
         ne5DQQCB74VEAT1Dhwu7BbAcgBVvi2DvK04wSdcf8NdpxWSfU2Jt01JUORVeGTx3qm5S
         JwihfEKy3fmg/TGKevSZtVfeLF5pdmgFNi/3HzN6NkUHK/TfLjPuCqY2XWfI9cl9+Uun
         Qq0A==
X-Gm-Message-State: AOAM530eKNFEMQHYwx8S+qDHJ4KGe9b4mY4MdEu7x5rL68FmwuRheTc/
        q4EnKn85dgRpc5xaN+pme5bcqu/E
X-Google-Smtp-Source: ABdhPJz99VWXn7TOwhsUIF3CL+SjZFjYH/ThLZ02OrxWrtg+jH16OX39arcw6ME/9FaaKWS6QVaTAg==
X-Received: by 2002:a05:600c:2202:: with SMTP id z2mr5811725wml.13.1594925143468;
        Thu, 16 Jul 2020 11:45:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm9402798wmj.44.2020.07.16.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:45:43 -0700 (PDT)
Message-Id: <28bd3534d02b7384daf87fb89eb56909883ebec7.1594925141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jul 2020 18:45:39 +0000
Subject: [PATCH v3 1/3] t1400: use git rev-parse for testing PSEUDOREF
 existence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will allow these tests to run with alternative ref backends

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1400-update-ref.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..7414b898f8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -475,57 +475,57 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
-	test_path_is_missing .git/PSEUDOREF &&
+	test_must_fail git rev-parse PSEUDOREF &&
 	test_i18ngrep "could not read ref" err
 '
 
 test_expect_success 'create pseudoref' '
 	git update-ref PSEUDOREF $A &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with no old value given' '
 	git update-ref PSEUDOREF $B &&
-	test $B = $(cat .git/PSEUDOREF)
+	test $B = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with correct old value' '
 	git update-ref PSEUDOREF $C $B &&
-	test $C = $(cat .git/PSEUDOREF)
+	test $C = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
-	test $C = $(cat .git/PSEUDOREF) &&
+	test $C = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref' '
 	git update-ref -d PSEUDOREF &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
 	git update-ref -d PSEUDOREF $A &&
-	test_path_is_missing .git/PSEUDOREF
+	test_must_fail git rev-parse PSEUDOREF
 '
 
 test_expect_success 'create pseudoref with old OID zero' '
 	git update-ref PSEUDOREF $A $Z &&
-	test $A = $(cat .git/PSEUDOREF)
+	test $A = $(git rev-parse PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
-	test $A = $(cat .git/PSEUDOREF) &&
+	test $A = $(git rev-parse PSEUDOREF) &&
 	test_i18ngrep "already exists" err
 '
 
-- 
gitgitgadget

