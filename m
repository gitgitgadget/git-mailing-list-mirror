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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5FAC4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629426105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhHEKhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbhHEKhu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448DC061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so5885586wrm.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7R6TW02iBkZDktVvO42XekI9nG/RnDASGSTtRnos/Dw=;
        b=mAwiqGEHNIbpkoa3cwhQv7BOPSXe7bp015pBgdvHyBores5aK6cl9SHEujWN1iMhKU
         L9Xnx5QrR1NRLE953y460uJxh+rsVx/8xoat+CkkTrZv19IqYbc5cPjUcGFsDhnjRoBo
         RThWbDsKZk7BrRx4IlFnFQD/Nqv1VhDuS62NsM47awRO5kYaKxCht1PZtKQmKRgMFzDU
         rVvAkBZPrNILOWDpae0GPNsDe5poI3GgSCucTBmNBocGTaISno8+23IF//5CsEb1fp4E
         RLd8QntpVMie1tSp9bJG61mhqU+5FhcqGuUqdFySO+gQvn9a8GlpXhifK9JSzvzlqrFz
         HR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7R6TW02iBkZDktVvO42XekI9nG/RnDASGSTtRnos/Dw=;
        b=Q8dnfZdlrwEz73IV8V9Xaln4COs5oIPiy6YlI6FSAEpWZ0902DMGALXrv5mL6lYE+R
         J1DIf6fgZe+O668gGSheSChzjz7RDV3JB7JVPtQBHMPj4ib6iounvZgH4sAHUvcqzAsC
         wudVVr60abZm/fhwmLFkK6oaxyO+8NI1x75tH4569p3T3VcUF2AbKPf4IzQTm1KTQ5H5
         nzuwItvWqoGyjRidNY9+pd5MkcOc1Kdlfe+vx5+D/4P9lnUYy78C/JE1Su8bnGroauOa
         qb5Q1ad8FrrLenJxE9DpPOIvLttRx2NK3T5AJM6aIGsCwKrFRPBhZ65z0WLbCmmO5ePa
         QTQw==
X-Gm-Message-State: AOAM532X9PWQ4zOkQtgmnjo+AW2FF90tJLbx1A0lbztNfFsc3exQa5rF
        LZ1rlV69hwjs702zrEz6PI8RXA+Vguam8g==
X-Google-Smtp-Source: ABdhPJx3tD/CbyNcIBGFqUh/SG3Nvmwth9/v4DLKxcmNvTFnIpwA+tkJKwsJ10tXOp8ELieLYEdXog==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr4552956wru.118.1628159854497;
        Thu, 05 Aug 2021 03:37:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] test-lib tests: stop using a subshell in write_sub_test_lib_test()
Date:   Thu,  5 Aug 2021 12:37:22 +0200
Message-Id: <patch-v3-3.9-76f57eadcd-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that this function doesn't handle running the test anymore we can
do away with the sub-shell, which was used to scope an "unset" and
"export" shell variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 58ae316ad5..21fa570d0b 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,20 +1,17 @@
 write_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	mkdir "$name" &&
-	(
-		cd "$name" &&
-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-		test_description='$descr (run in sub test-lib)
+	write_script "$name/$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
+	test_description='$descr (run in sub test-lib)
 
-		This is run in a sub test-lib so that we do not get incorrect
-		passing metrics
-		'
+	This is run in a sub test-lib so that we do not get incorrect
+	passing metrics
+	'
 
-		# Point to the t/test-lib.sh, which isn't in ../ as usual
-		. "\$TEST_DIRECTORY"/test-lib.sh
-		EOF
-		cat >>"$name.sh"
-	)
+	# Point to the t/test-lib.sh, which isn't in ../ as usual
+	. "\$TEST_DIRECTORY"/test-lib.sh
+	EOF
+	cat >>"$name/$name.sh"
 }
 
 _run_sub_test_lib_test_common () {
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

