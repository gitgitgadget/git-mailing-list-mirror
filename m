Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EBC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D787261159
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIUC7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349417AbhIUC0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AADC1E326E
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so32432533wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0cRBVJ/03yTTIfUEPh6Sf5kKJOmQpC/BMvdrPYyidI=;
        b=HDDsb66fYC61gM0kwcuAG1OaV/a/iSAlPhgHLU64saSpPdfR2v+o/vZhASYQ2VcnI7
         qZZDbrubVrW/erEcSMxOYiJXTIpsxRKdGNU3RT2BGXAmK+dDQW8/M5kV5xTrjm2zllyG
         byV96iYFnHQOxvlLyd4hD3lHN9qIpb+/qLnOfZ+V+DJy1p1t32VoVQ1HAeEJwgJ0vTXX
         lLvNcMXeEC3tTWQvf7Ho85tJGXKdzgG/+CY3JugvbDImWMgKXbp26lAOrv0hWxDL0CjZ
         tPkGwOUROv0qxgF8ok4llVxM7+Rbdx3AvyI57SglJZbjK+SxPpbh/MBSLRetTARomkLg
         ch2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0cRBVJ/03yTTIfUEPh6Sf5kKJOmQpC/BMvdrPYyidI=;
        b=sGamzG1wT4N3ekLF/PTXOdNVCQd1vpaNO92342vPTm0uV8LHcrrPePmEeMNiVDHwXw
         PDUhNWq/KFjP+1NZImOnoUXiQq1bOso4J9sZ3YJ5o7AqqHu5oilOIaiQqRgk7HQmEKIQ
         jw2XEUBSdmH+2S0CQVPAgd5aryHDuCvov0+VVVQrsibSNCTxsnJ+h4hbcJHePtjvYjQJ
         /tJL/K1TV/Xmjdcq8IAeiIfLdO7c3FPcm/se8khcl5ly48J/CfRf3Bt/zpyRPWSmDhW/
         wGa4yIQQRv6qxGENbmrTab17b0RgD+2tFfGUC/y5F567ppeQaldfYkilm1tFaxhv9VZA
         xrfA==
X-Gm-Message-State: AOAM532ZPUNmpeci9BqpxitbA0/Y7zUAlilcTvv0Y+HFPkMc716S6XFA
        p6bQxqvxcir+lDEMTX4NQ2yQq4aSX2gdlA==
X-Google-Smtp-Source: ABdhPJymk4n/FV6Qxrh+/Osn9o1awy5pVCKY31vpz8MsXxJzSi+C0KWn02whLQLQr1wkgL9CgByCAw==
X-Received: by 2002:adf:9d45:: with SMTP id o5mr30379607wre.226.1632164670238;
        Mon, 20 Sep 2021 12:04:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 05/17] cat-file tests: move bogus_* variable declarations earlier
Date:   Mon, 20 Sep 2021 21:04:09 +0200
Message-Id: <patch-v7-05.17-fc93c2c2530-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the short/long bogus bogus object type variables into a form
where the two sets can be used concurrently. This'll be used by
subsequently added tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..ea6a53d425b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,36 +315,39 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
-bogus_type="bogus"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+test_expect_success 'setup bogus data' '
+	bogus_short_type="bogus" &&
+	bogus_short_content="bogus" &&
+	bogus_short_size=$(strlen "$bogus_short_content") &&
+	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+
+	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
+	bogus_long_content="bogus" &&
+	bogus_long_size=$(strlen "$bogus_long_content") &&
+	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+'
 
 test_expect_success "Type of broken object is correct" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of broken object is correct" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
-bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
 test_expect_success "Type of broken object is correct when type is large" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of large broken object is correct when type is large" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
-- 
2.33.0.1098.g29a6526ae47

