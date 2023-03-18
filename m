Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86EC61DA4
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCRPrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCRPrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B41DB83
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so31290976ede.8
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7k/lcP0By6gbC7MFqksaAdhGbjPogHyvJ00FCXooYA=;
        b=Vwy/SXczvblR8N9H7eqVumgfZSU+kLdtb40mec//5W2evyC7lygWAcVJGFGCylTOsN
         cehNtB4osE2Ee0g+dpOAe77S1KOh6iBWyrjPzVaQptamK3YVpPPtqpdv17kNcgY5hzpa
         DvBLP382tU65alB59GOYB32XxzhuiZQAhUMjK7QXaM258QFwUIKtRp7M/b9M8MoCn8Ox
         JCPkX99RQ0t6UV7PRSI4mQh//R9vGjixVcvtHrsE6X6aAOeATfDQlE4DQGP9XDOvpCvw
         +YVIVgOoUZ2y7GSglqwT+LMzsSGq5napGgt2f7/06EcMXdy/ZdUS8Tu7KfvRCrxchhl8
         X+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7k/lcP0By6gbC7MFqksaAdhGbjPogHyvJ00FCXooYA=;
        b=BmEdbnPRjvHUmYnAzMazoyLrVqaouOWk5zU3+6tZhkIDJr8L46glNKkvmg5FQCU2Dr
         xKWxGlXuK7jPE9CDOlDaCtt+VH4qvKdRfROlmEqj/zTZSwpOClhLbSjao8/pipJggRxb
         MyxCiqNSpKZsrhOy8EkQ5r48Gw7r8d8dzLRhUNjQXiwuOHFvBTx02Sx3BeR4VvE9zyrb
         btLZHb4ChfrCYexvBAUXklvawe17oxrdywFzk679aXUXSkWKYhHTRDDD6hC/2I6FYo8+
         m/ACSGW1ilpIvJhh2ZWQf+2jFthO0H9iWPgTkdHNPVzyZWuEhl4uN3SXficV4n6mRycm
         IhMg==
X-Gm-Message-State: AO0yUKWj0C2ZUCnTcdWG/3bHEaHNV9j5aLY12DKzVRsGPSuUD9hCvlpv
        2A+34jjpwzrQBo4eiUZ65QprRLZHXz7U2goVxvs=
X-Google-Smtp-Source: AK7set/h0pu7XG/ShCv0CfEfZvlDz1FWyyXBGhW3H52TBpiJsjSdxtBV4N2nm0kX/5c9jFIHABFUlg==
X-Received: by 2002:a17:906:c359:b0:933:4c93:69ee with SMTP id ci25-20020a170906c35900b009334c9369eemr394379ejb.45.1679154411950;
        Sat, 18 Mar 2023 08:46:51 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:51 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/7] t1005: assert output of ls-files
Date:   Sat, 18 Mar 2023 16:46:40 +0100
Message-Id: <20230318154646.131344-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'reset should work' in t1005-read-tree-reset.sh compares two files
"expect" and "actual" to assert the expected output of "git ls-files".
Several other tests in the same file also create files "expect" and
"actual", but don't use them in assertions.

Assert output of "git ls-files" in t1005-read-tree-reset.sh to improve
test coverage.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1005-read-tree-reset.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 12e30d77d0..26be4a2b5a 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -41,7 +41,8 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'two-way reset should remove remnants too' '
@@ -56,7 +57,8 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain reset should remove remnants too' '
@@ -71,7 +73,8 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s &&
 	git reset --hard &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f should remove remnants too' '
@@ -86,7 +89,8 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
@@ -101,7 +105,8 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f HEAD &&
 	git ls-files -s >actual &&
-	! test -f old
+	! test -f old &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.40.0

