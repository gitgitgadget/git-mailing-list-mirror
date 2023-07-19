Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A85C001E0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGSR4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGSRzz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:55 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E91FCD
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5701e8f2b79so75390647b3.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689789353; x=1692381353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsXApdL/BEiMg9Mv8Z6UigEeVhsNWnyFPeatoWo8c7g=;
        b=I61RQVW5J0WXuCa4PjTLChSRzuaO5rAZpZ3r+fl7QoJVPuHOjVhFYPY/z15yuPHPqG
         FaMP3oIWkmR0P8aSfgZeHOYRQApLoD28k+WAgr6pvVA60ca3BDDNhAvjig759pr4DuVe
         JuNSwBPxSzQWvgAOQAoBnMKJXXEyag8d78F6khBWr70tfFrghpz8kItc6hpep8ztb43j
         z+aMJtTmhodoSxubdTkLdl/MZdqd48XUEKpfNCzh5jujmk9YWskC7V1CgJlBbe3nyzgN
         nHwFR/K6vy4jdoqWWwH6xka1cXUJRUEgYO3/SkZxjnkat9sp0HnPoWpLVUjiFogx7X96
         8uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789353; x=1692381353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsXApdL/BEiMg9Mv8Z6UigEeVhsNWnyFPeatoWo8c7g=;
        b=BJuhNGf/tTHsZDdDrC2dSB3weCIBGL/+63Q6p26EwUzSDC3y1BSBXGeN/ZXlq/WcqG
         q0J9pfPeCLut6BftAyU+HLGB3Tgqis1jUhIct4E4rDBg8gg02oNJSTBRp6RPG/u3mWsz
         fkEF15ubg55CNT4fPhgiHkSMctE5jRCmrM/gOV/H/cCKSedILThA07lT5Sv5DypFSfMF
         yUGAJanx7fY8dgX1QI+PJJVDIb7MDqnMP2vmWruebuAxL/FFo1XJivg2+xbgAzn185or
         H7JBSSDZxmD8bpXz+E4y7UYZCJ0vKYR8xb3F1I+OmkNFSdu9/6boVCAyO5nGu5H5PRK8
         tH9A==
X-Gm-Message-State: ABy/qLZ18ppAMpOnMACeeYcgHHqkPZOBfYPDHGIF6Lg4WyZb5TwNuGTr
        k1eKo5ggf8MNzbY0i9CmcVj/BLq8B2BAdm5UC+1KgQ==
X-Google-Smtp-Source: APBJJlHlQ6wNvN2VQjSB14Pm5G6BoitZudY/T2+V8QzoqviedNnIYrgzXnbLgCDpxigZjVQ3ewTw2A==
X-Received: by 2002:a81:8315:0:b0:579:f5e3:ad07 with SMTP id t21-20020a818315000000b00579f5e3ad07mr3576384ywf.14.1689789353495;
        Wed, 19 Jul 2023 10:55:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i65-20020a819144000000b00577466cc1f8sm1120215ywg.108.2023.07.19.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:55:53 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:55:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] fixup! t4216: test changed path filters with high bit
 paths
Message-ID: <5bac3bc2e5b85f553e39b9a334ead372d97eb753.1689789226.git.me@ttaylorr.com>
References: <ZLgc5q0FrL1s7j0j@nand.local>
 <cover.1689789226.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 0cf208fdf55..c49528b947a 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,17 +404,9 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
-get_bdat_offset () {
-	perl -0777 -ne \
-		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
-		.git/objects/info/commit-graph
-}
-
 get_first_changed_path_filter () {
-	BDAT_OFFSET=$(get_bdat_offset) &&
-	perl -0777 -ne \
-		'print unpack("H*", substr($_, '$BDAT_OFFSET' + 12, 2))' \
-		.git/objects/info/commit-graph
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
 }
 
 # chosen to be the same under all Unicode normalization forms
@@ -428,7 +420,7 @@ test_expect_success 'set up repo with high bit path, version 1 changed-path' '
 
 test_expect_success 'setup check value of version 1 changed-path' '
 	(cd highbit1 &&
-		printf "52a9" >expect &&
+		echo "52a9" >expect &&
 		get_first_changed_path_filter >actual &&
 		test_cmp expect actual)
 '
-- 
2.41.0.366.g215419bf3c2.dirty
