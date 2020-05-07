Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07BC28CBC
	for <git@archiver.kernel.org>; Thu,  7 May 2020 01:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9146220747
	for <git@archiver.kernel.org>; Thu,  7 May 2020 01:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYTssc0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEGBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEGBH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 21:07:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42840C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 18:07:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so1361923plk.10
        for <git@vger.kernel.org>; Wed, 06 May 2020 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyBJwj7eKcZd81xsP311n3OI6yxMUA0qCQN8xUFZgt8=;
        b=NYTssc0PoD0PbzlEtFvn2X2y1EyZKXzHveFZBapl+GSty9KcJqe694WT9gR7lns0xg
         aeOEdKrUmZblA0HHkycCjGT9htpiCm0ptRKQrfUx1av853nxMCXmFHSjCgNBWrDbZcDH
         GVu48cs+0XnHKnkwRxg3iXp+4RRybPCC4/Pvf0KUOHGfHyEcLBMnm6tuFlqrT8y4CO3r
         QKjCsMECqaQgVtXKqWtKp7sGUqrQNqe65RIRHNS7xG7h6DvRpChIRsCh0+a6cpmvTGzf
         6uT7vrOk/BaH4Bz9t9eSS+Vna+oVcTcIkAVUk2CMZ3xCksqAu19yNIvZplI1VSdOn9Ll
         raJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qyBJwj7eKcZd81xsP311n3OI6yxMUA0qCQN8xUFZgt8=;
        b=B7qudJ0Igy5QtnnPDuy+hroiEKZ0JX9hjoascxBJq3M+A+HShnIs0tdEq7y9J6aHW3
         3ZMoXVW2VjO13ucU1wMc8YXVghsk1/5Ev5o2Dwpjhv1oGxaSG9CsbXyx5AzHEaTA52Me
         Aol3B/Q5WzUOLcv7hOl9d5PbvKh1RPlvnyl0TbAW6tEqcIMbT+IwxzVM2KuYcSvdpHJ6
         E4PM0juQ5fa7SG1JSDe3cD2G7JcPkfma7h69Vjzi6hLyVBw602k5JIy8qAFdAU8VgxAV
         FVRV7pmYhzvNznYIGjZefOzYHAJcqgxiGFiBmAXIhgnTjASCBtnUPDUGfshbS0xWDM2I
         uXpA==
X-Gm-Message-State: AGi0PuZ+abulgKdxUSbTGtsXI5nH7dJc8+HsjrYOkG3xwxaw6d5sDA2n
        Kxz6CR7PlpCQSwT334sgqPIjwidy
X-Google-Smtp-Source: APiQypImsqI7ejNOb/PafvUa1xeInTizlKbJhGrKSr8M8dPrfqkuxZZeV7U9C0Z4zAHGnnYNxrGQrg==
X-Received: by 2002:a17:902:464:: with SMTP id 91mr11144460ple.261.1588813676321;
        Wed, 06 May 2020 18:07:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id i8sm2608767pgr.82.2020.05.06.18.07.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 18:07:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] t/t0000-basic: make sure subtests also use TEST_SHELL_PATH
Date:   Wed,  6 May 2020 18:07:46 -0700
Message-Id: <20200507010746.83418-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08) allows for
setting a shell for running the tests, but the generated subtests weren't
updated.

Correct that and while at it update it to use write_script.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0000-basic.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 3e440c078d..272f75ce63 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -77,9 +77,7 @@ _run_sub_test_lib_test_common () {
 		# the sub-test.
 		sane_unset HARNESS_ACTIVE &&
 		cd "$name" &&
-		cat >"$name.sh" <<-EOF &&
-		#!$SHELL_PATH
-
+		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
 		test_description='$descr (run in sub test-lib)
 
 		This is run in a sub test-lib so that we do not get incorrect
@@ -94,7 +92,6 @@ _run_sub_test_lib_test_common () {
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
 		cat >>"$name.sh" &&
-		chmod +x "$name.sh" &&
 		export TEST_DIRECTORY &&
 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
 		export TEST_OUTPUT_DIRECTORY &&
@@ -102,7 +99,7 @@ _run_sub_test_lib_test_common () {
 		then
 			./"$name.sh" "$@" >out 2>err
 		else
-			!  ./"$name.sh" "$@" >out 2>err
+			! ./"$name.sh" "$@" >out 2>err
 		fi
 	)
 }
-- 
2.26.2.686.gfaf46a9ccd

