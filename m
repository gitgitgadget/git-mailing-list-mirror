Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8AC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F5461153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbhIHJui (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348602AbhIHJue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD39C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so2295790wrc.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZhjzUEqeBPp7tt1U6Ces1LG4VHNm1+/YJdcF6v8aI9E=;
        b=YM80FIwZHvwmgR6QEZPpOVfBj/Cbb6/gENhxWcD92chAXUcqFQOa9SAtvHAqXPVHcY
         8mjy0wnHr96eJUPBQdLbQhDTw8s6WHSFk3GNGcEZOduCwhrQWThzrYFG7opuawLGmTTP
         lbVgsodtxyQilJDAfvVHT9MSLW44VfOzVJTpZijBbiVWYBo0zRIXhAW6JZyHSBLunXiu
         8ThGTrY2mQGEJSwl68QzptI2s3s09MBEavHaqVoYXkjJvPoUPiYPPINUHZVoIv+2Mc4X
         k0UbfvdvOenOEmSLYtK64RGveQFvixo+Ly1mGuKWPT8S0nOnny4atIFYRPFSfUXyEeGQ
         qXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZhjzUEqeBPp7tt1U6Ces1LG4VHNm1+/YJdcF6v8aI9E=;
        b=f4RI0WuiokDnDNOi4ljC/Fu7IjMVnDD8l182aq77QAbwWhJWvopDpqquQD+AmEtloA
         skMAD7leq8225AyIx4QhAM5qCUtsvA61ld40jPzwyWUxixunfLXGSW61+ZsebpTV4u/r
         EUeBwnj/QubVLIa/mJ2DNaAhqbJbrA107qFBNBtV3/DWuoblDuFJJK43vD7LSc0F/BNA
         7eOH39r2Me970g1JLgQ394XmnVeU1GWeQstvleqtDtX+aq1HGXEMxJKO12a400xccOJP
         6STYuFVMTAkuoka1JbB5ZRyn/Qp2+lk8BhMZE0GqNWqNQ2HdvoxKjvv+MHQ7mBULBNZo
         GkKQ==
X-Gm-Message-State: AOAM533y5Mmos8CXmprdEE6B1NrTaGubCh+Y115bE5Hur198q6hRg1oF
        G4HLPnCSR7w2osE/UcAUTErz7+tAET4=
X-Google-Smtp-Source: ABdhPJyAzrRhhjCTBfNxWOSnmVqnTLN+57ze6zjoyiuB2SrxukhBbfJDV2fUEJCUcuQZoHqOxFY01Q==
X-Received: by 2002:adf:e6c9:: with SMTP id y9mr3018289wrm.430.1631094565847;
        Wed, 08 Sep 2021 02:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm1564305wrh.66.2021.09.08.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:25 -0700 (PDT)
Message-Id: <dfa27d7a8e7e0a9e03e228653ebff639a449ac77.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:14 +0000
Subject: [PATCH 03/11] t3407: use test_cmp_rev
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This provides better diagnostics if a test fails

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 0ad21966bc5..8d913d73bad 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -29,7 +29,7 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -39,9 +39,9 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		test_must_fail git rebase --skip &&
-		test $(git rev-parse HEAD) = $(git rev-parse main) &&
+		test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -54,9 +54,9 @@ testrebase() {
 		echo d >> a &&
 		git add a &&
 		test_must_fail git rebase --continue &&
-		test $(git rev-parse HEAD) != $(git rev-parse main) &&
+		! test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -91,7 +91,7 @@ test_expect_success 'rebase --apply --quit' '
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
-	test $(git rev-parse HEAD) = $head_before &&
+	test_cmp_rev HEAD $head_before &&
 	test ! -d .git/rebase-apply
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'rebase --merge --quit' '
 	test_path_is_dir .git/rebase-merge &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
-	test $(git rev-parse HEAD) = $head_before &&
+	test_cmp_rev HEAD $head_before &&
 	test ! -d .git/rebase-merge
 '
 
-- 
gitgitgadget

