Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49623C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1875F206C0
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SIfRq1b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIBGSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBGSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7DC061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so3389755qkf.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4y+U4GTGlNUPsaLRPbaZMHdUUBXALPwCNHtrAHuNn4=;
        b=SIfRq1b6IVuFbSvetDrVnTB9dU2ocWtrI0OJmGy20tlLd/uGGRWGdn6D6GnDBF/nI3
         BhuFgDzDB6m1m8O4RqegM0heR9ID3yJE0JkvThst5DGlvM5C+4U+vARrDaHX9oc9WyIj
         P5sYSuikEa3PPSa5vDD1A/Z14p3VdSFRafK2HlYYJBwnZWOuBjfqi3W+a2vjITqcgzEJ
         O7Ppn+aVtRMggeTSbGXDORC7l5Zf1L9amT2D0/H97CvC+llETABr8aQxr9txlBHLLD6I
         k5x1Pwm10KjBFSShzmqksaTUXXg88m5qRNvjrta9fLOqOWtMTX3NWjk+CG411t0d9B79
         ANkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4y+U4GTGlNUPsaLRPbaZMHdUUBXALPwCNHtrAHuNn4=;
        b=FGrxMeunTUM+Xtzj8pokpJq5AjzLJWFf3N/+sUtFRGDZ0zZWyQGoTSUvH3ew1/PZKI
         NW7T9X1LsDNPcJVNJKbHKPtScNaVXyECxueI7Jt4k5iqFTUogHucWZJdbSkNFYd6O5oz
         gev5Kk/yy6/xsuVbBdjXit/xB0BU4msUg/GlzP3PDzlO8pDdDvqjPzr5K3nMVGbxajRX
         pnfvvXVXrFOh2v4VNLkOtIuGK/Ol0KVfUN/fykk3F3xHsIDtJcQ+LOBkl5vDbbL2xPjg
         l3JEln2HE2hXJ17fGwRl/g1FySQu6MnDdRInhs7SvubHOeveHowh0R8vU3xlPtCrVRS1
         9e5Q==
X-Gm-Message-State: AOAM530X83wmKInLODxla9kZU9sSEs0/ichKzC/Z8wYGcEKV65p/UlVN
        rGutwtsnpFydTMKnoSaupdLsa7M0o3YLRw==
X-Google-Smtp-Source: ABdhPJxoXdC9rHHaAiApMUdu8e1zgm+iCHJ915J/KkNzskc/KdD0/ge8p8BJ7Zfp6xkAqAS4eQkOHw==
X-Received: by 2002:a37:7bc1:: with SMTP id w184mr5478098qkc.403.1599027483780;
        Tue, 01 Sep 2020 23:18:03 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:02 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 3/8] t/helper/test-config: be consistent with exit codes
Date:   Wed,  2 Sep 2020 03:17:32 -0300
Message-Id: <85e1588d6c5431c32fe0262671df1d247d98b83e.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test-config helper can return at least three different exit codes to
reflect the status of the requested operation. And these codes are
checked in some of the tests. But there is an inconsistent place in the
helper where an usage error returns the same code as a "value not found"
error. Let's fix that and, while we are here, document the meaning of
each exit code in the file's header.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index a6e936721f..9e9d50099a 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,11 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * Exit codes:
+ *     0:   success
+ *     1:   value not found for the given config key
+ *     2:   config file path given as argument is inaccessible or doesn't exist
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -80,10 +85,10 @@ int cmd__config(int argc, const char **argv)
 
 	git_configset_init(&cs);
 
-	if (argc < 2) {
-		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		goto exit1;
-	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+	if (argc < 2)
+		die("Please, provide a command name on the command-line");
+
+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
-- 
2.28.0

