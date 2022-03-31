Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152AC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiCaTRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbiCaTR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:17:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5E0235746
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h1so464795edj.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=untBgpF7Mqren7I6pH8aVsNs0+ch0RSlgkQomuNXOzM=;
        b=LgycVERijefJdqi8E0WjuDBDJdehwkEXdiDP6brJARYOrUxT51nYzu/t4IrLR+HS7C
         7vGu5l6pPQiqg+KYiUArQFeBfZyvLIL3DhT3A++UPgGm4PbdimAstLPlWvEt3r9NL2Kt
         vBYHRb6PSNND395RJqXy4FxZQwlCzPecCGincwJ7vmiaZ13hLtJq68kB1P2tOEKp2FVV
         i09quAWwvksKDJdCm0NKy3HL3cu4+m3Jm3HwIjKK4BVfKdtBaJxei9Cm2+Cy2P6nYpcV
         dOrbNySnHt9GJxVLHYc6sgD/D+ZraKaopA/4W1IOyBZlPJg2KHcLlku8S77Ok2iHFAxG
         REDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=untBgpF7Mqren7I6pH8aVsNs0+ch0RSlgkQomuNXOzM=;
        b=nhxBD5aCPy7Q5e45c3Ef+q2h/rfoxYejE238djBd0fKuVJE0gMMqxSAxppLSMIUorz
         Hcu04j3dbPeeCoGAlUIgx+bRQAkHj7L/RAzwuLY3PYAgRshlqzXffZXJYvwos59DUcJW
         BAfDnyKyH7D2pABPiSP/fMdHseD+QaffiJA2L7eFVqMQq25njUmJIQ35jFcA0LnontXD
         dLVPJEscXIkQdhnfxicNA0qYj0Tn8/5mL+BDRmn1fl9QjfTo96KpRO5C30+jhEnD3d8M
         z87GBz08iNH/vp/t4sxnUZDKSJJTtcoR+bPgvx5ky6gYJR+3MNslf3XYLQHTBbU7GmsA
         eFHA==
X-Gm-Message-State: AOAM530/BX1yjsOVCMytakOyCuePrAv3xCyBvO9qiWS0ny063LIKSCyV
        uhexImkJjxAru5RWQJF/TRZqCWr2VFpEtUX1BoEBnA==
X-Google-Smtp-Source: ABdhPJyk5c1Q8xSddaZwLxYpye6IEgz3RHKKYM0gKJZiQYRK4+1Xyx4MG27di4IROyV9upCpGBifaA==
X-Received: by 2002:a05:6402:454:b0:416:2db7:685b with SMTP id p20-20020a056402045400b004162db7685bmr17814896edw.43.1648754138926;
        Thu, 31 Mar 2022 12:15:38 -0700 (PDT)
Received: from a35b75bc573c.europe-west4-b.c.codatalab-user-runtimes.internal (81.245.204.35.bc.googleusercontent.com. [35.204.245.81])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm106181ejc.117.2022.03.31.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:15:38 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        khalid.masum.92@gmail.com
Subject: [PATCH v2 3/3] t3501: test cherry-pick revert with oids
Date:   Thu, 31 Mar 2022 19:15:25 +0000
Message-Id: <20220331191525.17927-4-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331191525.17927-1-khalid.masum.92@gmail.com>
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
 <20220331191525.17927-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 we did a revert of a file we had so that it's the same as in
"initial", but now it's at a different path, which we can exhaustively
do by checking the blob OIDs

Signed-off-by: Labnann <khalid.masum.92@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index bd19c272d6..08103923ab 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -72,8 +72,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
-	test_cmp_rev_parse HEAD^ rename2 &&
-	test_path_is_file opos &&
+	test_cmp_rev_parse rename2 HEAD^ &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -83,9 +82,8 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test_cmp_rev_parse HEAD^ rename1 &&
-	test_path_is_file spoo &&
-	! grep "Add extra line at the end" spoo &&
+	test_cmp_rev_parse rename1 HEAD^ &&
+	test_cmp_rev_parse initial:oops HEAD:spoo &&
 	git reflog -1 | grep revert
 
 '
-- 
2.35.1

