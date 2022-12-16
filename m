Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B18C4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiLPJgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 04:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLPJgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 04:36:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C726554
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 01:35:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c17so2778571edj.13
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=TiUyleXGk6CrIGm3vFQiEKTXjKuaD/zoeW/Ta/3IbM/BjKcz9Hc+X8pUdDy4SgAJ+9
         HP2INKPkmTAUj/lumfMnreg10KxTjBBsCCj2ffVbMHTrkK+gGB59IUl7NJZkUFC2DRLp
         0MM5+DFJml66PhbzciLMliHX1sZo8scoGqZ6a7bZm22SzRQ7Ivdw3c1jdhhSOtDzTADM
         WrTuU/D0Z80+snecIfmsS2moAAwHz6hLtkq1w4UVYTjlQt3D7jen/nmm9dglNWXW6BtI
         Cb4j537Golnpd7P31yTuSLWtVxrrNQXbjpVey7R37VSG7D60WiMbX8XdTKWKsn4Gk5GO
         ccDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=q+EK/Jn+R2AlbMKDfwDg6zUGrgLxpbhPjtmmkVuSaedRZnL2SRbomPjmUftGs6wZom
         2b0c5Frq2M9Xo0RZqZazhWJOLsAXTNReKuU9KSK05MaPqBAjtbJhTkMtl1CTPZ6td77M
         pSKAOcCs8Z5lWzfgrB19AKKhhsXZ2DYlPjBNoyKW32Z4s/P0lS5YMG8tFwKODwPE48Qr
         n6noFZ0CsOR/S+vgxnq+guiDiiuoERbcuOQ5G3vLIM9pN8gZW5CSb4bjez6jF+XOXuxP
         2gFU36VB88YTA7ivZmku6yjryrQxxq10RgSfERq+BcGKOu2MAJ5Ugy5j9BcTNGbOjmHI
         YYBA==
X-Gm-Message-State: ANoB5plbFO30gJ9JQoBBsJqnhSySoqmvtJa7hmrZlWWAVxOGDKe2Sjeb
        tw7ctcF36G5IgkvMPPeLlsz2BdQk/VLYBA==
X-Google-Smtp-Source: AA0mqf41TIlnx+dU6IaHLNcZawKOyAZWIx401LZVZSvR+U4R9NVSpvU32lfB28epm38q41zAZQ5QAA==
X-Received: by 2002:a05:6402:3209:b0:46a:c6d3:9a41 with SMTP id g9-20020a056402320900b0046ac6d39a41mr29287190eda.14.1671183357731;
        Fri, 16 Dec 2022 01:35:57 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id x12-20020a05640225cc00b00459f4974128sm655538edb.50.2022.12.16.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 01:35:57 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/2] t0003: move setup for `--all` into new block
Date:   Fri, 16 Dec 2022 10:35:51 +0100
Message-Id: <20221216093552.3171319-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216093552.3171319-1-karthik.188@gmail.com>
References: <20221216093552.3171319-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.39.0

