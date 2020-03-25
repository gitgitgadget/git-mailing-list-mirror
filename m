Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF54CC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA37920789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp2+7d+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgCYPHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:07:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44171 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYPHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 11:07:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so1151470pfb.11
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzmrgtIs2YqbXFwWtL5PflOggHAysOA92TYruMqV9bM=;
        b=Yp2+7d+DlV2agUcabgoJZY4AgHsKZGEcp75Prcvr1bjiOFEMOS1yfgiPBFvCJKXPqY
         fEBE3tCq26vDuOat0fswn8eMq09XDPhSwOHRMG4F00+z2bzhIHH2RvZBpKvWRXmH8QLc
         I+Ugk60yf4aDqeK8sMtBFYYiGK98R/ojd/4TC7vl5cri43xPbTiZtsx8paTp7GYrlHG1
         emu25EeFLMyRx2SiS5pBy7UKscNsa4pDEs8waHby7yKUX9JfTU4en8USHYWgklTUgWue
         zQmqksuyxL/Lxpq+PpxlHOwvG+3LPRteMgQwFWRCBdBylTAHa1tBdWEILgEJKpj/0a5J
         9KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzmrgtIs2YqbXFwWtL5PflOggHAysOA92TYruMqV9bM=;
        b=hXCmexGLnlXF8EirHW1zLz3oMMcm8LUPVd75Du2W5XsChu6Qiz848StBqJ3Oyg+wNm
         /hwX9FfyTzlnjxdg3z+tzSphoEbOfoNvCIA8X56wVlzEfGYQkH3U4mAhRbQfJI+4tSDv
         LcoFMQuHQVynXZyEev+g168DwXk7sy1HeJ8LZGRU5tkLdMrvrfZimOaRHB5YkjqvtdfS
         g9P5jvYIbbe5STLdENEaXQGG1+L/iEGm+4A/qUsvt2PYfUBOV04jAYtZPZBe/LCpGyDQ
         /DehRFyLqG+bDu50NffMg8SfaUsT1Ldi0yQtmAfyk3yEIoEr46jDlG1rQfUTHTqSj75h
         eCFA==
X-Gm-Message-State: ANhLgQ3jcSd0Py9p3FQqhWnYkjgK1UJKrWr2pYFiqNMydA0xeIy7Y3Hs
        FlwcTu120Bv1HUE7ESeXRIvicfzL
X-Google-Smtp-Source: ADFU+vu98gLbnMvbiuqMk9WJHVCqwTqVPCNYIWlr2h1gAokvHpKPw92Slq9WFyn6EqbuXIqURip6Qg==
X-Received: by 2002:a62:d407:: with SMTP id a7mr3859818pfh.57.1585148819872;
        Wed, 25 Mar 2020 08:06:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id f127sm18232538pfa.112.2020.03.25.08.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:06:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 4/8] t5003: skip conversion test if unzip -a is unavailable
Date:   Wed, 25 Mar 2020 22:06:17 +0700
Message-Id: <e5b09c290c1ff0fb0d7171927194e598e46daae2.1585148327.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585148327.git.congdanhqx@gmail.com>
References: <cover.1585148327.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alpine Linux's default unzip(1) doesn't support `-a`.

Skip those tests on that platform.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5003-archive-zip.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index df1374a312..3b76d2eb65 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -11,6 +11,10 @@ test_lazy_prereq UNZIP_SYMLINKS '
 	test -h symlink
 '
 
+test_lazy_prereq UNZIP_CONVERT '
+	"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -35,33 +39,33 @@ check_zip() {
 	extracted=${dir_with_prefix}a
 	original=a
 
-	test_expect_success UNZIP " extract ZIP archive with EOL conversion" '
+	test_expect_success UNZIP_CONVERT " extract ZIP archive with EOL conversion" '
 		(mkdir $dir && cd $dir && "$GIT_UNZIP" -a ../$zipfile)
 	'
 
-	test_expect_success UNZIP " validate that text files are converted" "
+	test_expect_success UNZIP_CONVERT " validate that text files are converted" "
 		test_cmp_bin $extracted/text.cr $extracted/text.crlf &&
 		test_cmp_bin $extracted/text.cr $extracted/text.lf
 	"
 
-	test_expect_success UNZIP " validate that binary files are unchanged" "
+	test_expect_success UNZIP_CONVERT " validate that binary files are unchanged" "
 		test_cmp_bin $original/binary.cr   $extracted/binary.cr &&
 		test_cmp_bin $original/binary.crlf $extracted/binary.crlf &&
 		test_cmp_bin $original/binary.lf   $extracted/binary.lf
 	"
 
-	test_expect_success UNZIP " validate that diff files are converted" "
+	test_expect_success UNZIP_CONVERT " validate that diff files are converted" "
 		test_cmp_bin $extracted/diff.cr $extracted/diff.crlf &&
 		test_cmp_bin $extracted/diff.cr $extracted/diff.lf
 	"
 
-	test_expect_success UNZIP " validate that -diff files are unchanged" "
+	test_expect_success UNZIP_CONVERT " validate that -diff files are unchanged" "
 		test_cmp_bin $original/nodiff.cr   $extracted/nodiff.cr &&
 		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
 		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
 	"
 
-	test_expect_success UNZIP " validate that custom diff is unchanged " "
+	test_expect_success UNZIP_CONVERT " validate that custom diff is unchanged " "
 		test_cmp_bin $original/custom.cr   $extracted/custom.cr &&
 		test_cmp_bin $original/custom.crlf $extracted/custom.crlf &&
 		test_cmp_bin $original/custom.lf   $extracted/custom.lf
-- 
2.26.0.rc2.357.g1e1ba0441d

