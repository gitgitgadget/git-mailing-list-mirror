Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77654C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E987206C0
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LtzcHu2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEEBOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgEEBOC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:14:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD962C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:14:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so277842pgk.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHhSGMGzCi6ysuU18iYcv3qCsk++2Ddth7iq5fAYkqc=;
        b=LtzcHu2MkpkKfL5q/q9kIMb0bUiLy9JrrhuktLaZOpnG5TzdwrgK9LeccMi8swj7r1
         2Mes3kziuXhxrCRmqIb65GDR0czTqkLAG7PO32SPq7ygtEVI/QX+ETi4q2Yyml7mArvj
         51J17HBHZywSHh7EMKw0eWPvmiRxX+y4RJAK8otGC4FmO2iLI0tMkyl7j87V1lVVX7f4
         itFuUBFnkQlxM84fMO8TIlQF5GdWl3QXRb5NF1UzjcbslIKwIHSTjK9rJOQPVheWKryC
         5xRx2mIQ2lrOEOiUZzN66GLqTPIovW0tKS5GqCqbtC6owlDR4nPzkUg4IhwjyOweGyry
         aYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHhSGMGzCi6ysuU18iYcv3qCsk++2Ddth7iq5fAYkqc=;
        b=HfSRfyWQ0TJfFzyTma2KI2CXpK/zaDHDP0roaBrsspr15qb53FupOKmKxOcQl/ozyC
         kPF2yTJ2lDv2Ddxo06JhKSkm4AWeBS2u46DEiLz0JagzGvoUcM+AoUKRLAUc0ayWG1Nz
         CS/03iKUO6z0prRAauvXuSPC511HKtAaG7xDewIHaPXKjYq78ExS7mpPhGDqZO0GOfZl
         Urh1J1Osl82tXOMtGSd4F8yIKjHNWtS1aiJfO3FxAsO5/oCZWJcBwfEAzP6ctIEGh2xD
         TIGhcBj3DzSgvqwyEXP+9mxwRJqIEPhlNOTNTCjeX90DhZBvqv/S3mMr2PmcNJLpiyNO
         ULzA==
X-Gm-Message-State: AGi0PuaFQ8d3oJ+Zf+nFQPmmysfaQ+jI4zrZoLxTec/KsXpBQLfeYXJQ
        rwEF8tLtbCYZPPIxtA0cRLVQ/Agc60s7Cg==
X-Google-Smtp-Source: APiQypJ7XFy8bDPS5SNrp9NFtjJfdenbg74Ke80LizNhsdfkDsw/Mv8PXvVX20tB/VTveuiWlgtYCQ==
X-Received: by 2002:a63:6847:: with SMTP id d68mr910358pgc.56.1588641241884;
        Mon, 04 May 2020 18:14:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q7sm252979pgs.13.2020.05.04.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:14:01 -0700 (PDT)
Date:   Mon, 4 May 2020 19:14:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 7/8] t5318: reorder test below 'graph_read_expect'
Message-ID: <f2f018b54c742856fa7283fad1439bfb3ce81570.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the subsequent commit, we will introduce a dependency on
'graph_read_expect' from t5318.7. Preemptively move it below
'graph_read_expect()'s definition so that the test can call it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 39e2918a32..89020d3d44 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -42,15 +42,6 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-test_expect_success 'exit with correct error on bad input to --stdin-commits' '
-	cd "$TRASH_DIRECTORY/full" &&
-	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
-	# valid tree OID, but not a commit OID
-	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "invalid commit object id" stderr
-'
-
 graph_git_two_modes() {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
@@ -91,6 +82,15 @@ graph_read_expect() {
 	test_cmp expect output
 }
 
+test_expect_success 'exit with correct error on bad input to --stdin-commits' '
+	cd "$TRASH_DIRECTORY/full" &&
+	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
+	# valid tree OID, but not a commit OID
+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	test_i18ngrep "invalid commit object id" stderr
+'
+
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
-- 
2.26.0.113.ge9739cdccc

