Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCBC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0193A61261
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhETM1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhETM0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C94C0438DC
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i7so6838179ejc.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KXuiYIOQlsjo6MK7lONu0XRCHCjrtRY9x15o0FhIpM=;
        b=Sj+yBDmFxm0CzBT1K+3/B6IX8QUjcACVGYP8Weha6c2dMKs9i4F50ZBLEUK4kPNrR5
         i0ekBQ1EGCXU/cFCpNfi/dXgmpBsE0QriKjdxROQM9tMlX+gNYigQGgNiR5LwgOg+sqc
         HD/H5LljieM7wjaleFTwroOd3AVBzpAr/icfZ8IS+wg5QOMhwxVtMA9LWoYfhk9e+n/S
         nTsSfrsIZBsSG1EOpRvKSkiZSGFzRmO2nl/qENuD8wxtasiJhy5Ry8xJMV7UQznNaGgT
         quGEkXY9Vtnw2P9OPMX2JigYtIooSFG8Flt2kUNAJCOyO+X2gDONmLssB6ogranSY59Q
         UCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KXuiYIOQlsjo6MK7lONu0XRCHCjrtRY9x15o0FhIpM=;
        b=BKApENuQFaF5wCftWj0Ai389bDUegw8hIBI++PFi/Hw+g40+ckwgrlBLq2aM1XVSHe
         IThQ2cItRWaLyXhSmXGYcacyZMvjxeEowZXnr4vMK8XCuKtpPTBBrDw5AX8AhrECowMX
         R+k+WI04pQfN6UC3e9DGDshu58gtStSgUUCZhbWSAWiHtZBQN4Nx36TqRBmhjZsdkg5l
         AjwJ5zVblQsrmjA1QQ1QJ8n14oCkleROXkigX/40JG858+3Meb1JFi3E22GA2NQ1iAt6
         hrPI5/FKPB50Zfg6n34Z9VzFDY9cDwIFpayIFH2PlJ1OF2Lpy83XmzBrfVmkx9g1QPZX
         N1tA==
X-Gm-Message-State: AOAM530j/vxdaCIIHlszJTTZjWkIV6vpYSA38yQVgTru35MQ2DyiRfAY
        7ovzG7wOcxJPd1crNaOY/8xbJ/ZdX6Sztw==
X-Google-Smtp-Source: ABdhPJxKLuLZ7bZVpJPWtikxtbNVHL7F/gf69+anZSAkkJXil7vyVC5XAOtZUdmHG/vOCHZ5IibPEA==
X-Received: by 2002:a17:907:20d7:: with SMTP id qq23mr4154450ejb.549.1621509798980;
        Thu, 20 May 2021 04:23:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/17] rev-list tests: test for behavior with invalid object types
Date:   Thu, 20 May 2021 13:22:59 +0200
Message-Id: <patch-05.17-b98da9cc89-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the "rev-list --disk-usage" feature
added in 16950f8384a (rev-list: add --disk-usage option for
calculating disk usage, 2021-02-09) to test for what happens when it's
asked to calculate the disk usage of invalid object types.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6115-rev-list-du.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b71..edb2ed5584 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,15 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+test_expect_success 'setup garbage repository' '
+	git clone --bare . garbage.git &&
+	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
+	git -C garbage.git rev-list --objects --all --disk-usage &&
+
+	# Manually create a ref because "update-ref", "tag" etc. have
+	# no corresponding --literally option.
+	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
+	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
+'
+
 test_done
-- 
2.32.0.rc0.406.g73369325f8d

