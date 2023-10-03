Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE6E7545F
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjJCSvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbjJCSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9FB4
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:50:58 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umDwynSP3ekhPR2E/4c/hx7m3d1pddWKCdfHEGRx5U4=;
        b=JsgleSiCrB2SrE43CeSew9Y17cbz6tOuQnHV4Dq/EP1bc7XvYFzcuRzD0YCWpMzbp2W6I8
        /EacCVDl30AsBSCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umDwynSP3ekhPR2E/4c/hx7m3d1pddWKCdfHEGRx5U4=;
        b=uHv5tPMYbp7m6F6v/IxMrKO384HEdSH5upagcgc8XoJ8m+z5qBP1DKIRf6ZVPMPLQlDFaw
        Evqhir/es3T3Hq7PaGTtbsQqjs3WzS4yhFB56pxQy68bGwnJI5SOnw7mNFTLIEduipa13Y
        ncjDynAxwDc+1UWl4BacXpJRwvQ9rV3vbw15N43l9klChBZKkI/CHPAz951X/jviMx6Zs8
        F0leJPWBQZdU6vqFNuEsnEFYEcINZBiL0JknOC5P7jyRg79eJCJZoy9o5tHalpX8pRkqi6
        EQXBsldJ/i6Bq2sERaFost1vt43ohOziEzPSOSZ5JK7AG+Dou+FW6L8pPnAOK9RiepWmPP
        Y2GJhaCD7htcMQ5k1gGigQrjdVtaA2CKlk+bSNL4hYK9w8zJb3RkI3LNUpjJd7IWAvg1xa
        nQ/NS6kp2bLilwfLlXTa7SB4My+ZMmNPjTo08dQdBbDuk1Lh/m0ph0noSC1eafZEJLJ4Qi
        RviDgjVtp431cLhWKoyRu+HD4rKzyy1n1UaygxlnjFMcCuK3QBzhqY6IEsVAFuyTKjTfbJ
        OBtGe0oxhhZ95B1v1oVbzi4Nh18y9dTSNPUhssE0j6/hKFnk7dUkKDd7pXTunTybIeCjGr
        PEWlkYac9o5HfQaB84bOZsChQ1hgubMmyTZeq4MCLXUAG4OmsxFqg=
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 4/6] t7419, t7420: Use test_cmp_config instead of grepping .gitmodules
Date:   Tue,  3 Oct 2023 20:50:45 +0200
Message-ID: <20231003185047.2697995-4-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
 <20231003185047.2697995-1-heftig@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a test function to verify config files. Use it as it's more
precise.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7419-submodule-set-branch.sh | 10 +++++-----
 t/t7420-submodule-set-url.sh    |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 5ac16d0eb7..3cd30865a7 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -44,53 +44,53 @@ test_expect_success 'submodule config cache setup' '
 
 test_expect_success 'ensure submodule branch is unset' '
 	(cd super &&
-		! grep branch .gitmodules
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch
 	)
 '
 
 test_expect_success 'test submodule set-branch --branch' '
 	(cd super &&
 		git submodule set-branch --branch topic submodule &&
-		grep "branch = topic" .gitmodules &&
+		test_cmp_config topic -f .gitmodules submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch --default' '
 	(cd super &&
 		git submodule set-branch --default submodule &&
-		! grep branch .gitmodules &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -b' '
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
-		grep "branch = topic" .gitmodules &&
+		test_cmp_config topic -f .gitmodules submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		b
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'test submodule set-branch -d' '
 	(cd super &&
 		git submodule set-branch -d submodule &&
-		! grep branch .gitmodules &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.submodule.branch &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index d6bf62b3ac..aa63d806fe 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -49,7 +49,7 @@ test_expect_success 'test submodule set-url' '
 		cd super &&
 		test_must_fail git submodule update --remote &&
 		git submodule set-url submodule ../newsubmodule &&
-		grep -F "url = ../newsubmodule" .gitmodules &&
+		test_cmp_config ../newsubmodule -f .gitmodules submodule.submodule.url &&
 		git submodule update --remote
 	) &&
 	git -C super/submodule show >actual &&
-- 
2.42.0

