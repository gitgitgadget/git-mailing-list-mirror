Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A97C2D0EC
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E16320719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbUhZ80g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCZEhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39680 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZEhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so2164955pfn.6
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzmrgtIs2YqbXFwWtL5PflOggHAysOA92TYruMqV9bM=;
        b=nbUhZ80gt+tTqCO6EJ9UZfCGl6wIM0ORgueIObaD6+p9OG8Crv6/nyHDqVOaDTNPDq
         LryWACXl8/N90J6PFRhQd6ZeChAwpspTbCWIGlMNS87NNOOfxuQbqcc7/x2OvbVuARi6
         oFiZhM6DTpP0Fb44V1fCDeJCeZCxEPVIDR1jqCWOmYxY03sNWTtPPiyPN/ee/VPYumg0
         SMt+FE2CbqeqJNZYFhXo36I9NhObMz1J9DysHJhFZFoAPAXyHchWLD7nogCTa3U7fvb3
         gmjE8E2Y/yug5Rirnv240ct8tXhq+SRi2fB/2Hya2q+FTYi9/A4IlgWvZcVTF1QJ+HKd
         5Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzmrgtIs2YqbXFwWtL5PflOggHAysOA92TYruMqV9bM=;
        b=F1Af+ki+Mn8D3t4aG4IwiLXqCP91jgoXcz2LLgMbi+dQjWqj+JEhmbOhQVpmAwZat1
         JnyY1v8CIAURXELqku6uAG92Rt+yZXp73zNuX7/bBNgs7PKUHXsc0fuwFNoi8L53z6qA
         hT4sDL9yd8XloFPvn0cZvc34OTw6A/42e1zvhNg5js6bd7sqS6CvNi8KlZ2MTmHXf9IY
         Sen1iHbxJQL3wKJAv5fn+PF6GOe4H4MgcTcaUTEiT818t4auHE8e27k6CI3TxeWWYN5p
         vBxJgsPaODDiNDdta6bniUX64eOxLaBq2wNKqLoxdBKCm54AdgPcJZFVRbldbgxTMOGr
         wqRA==
X-Gm-Message-State: ANhLgQ1JiJWoOuTlrJoBzdsdKGJviYRDn7JwrxMV7DxcbBnjveu6x4Bg
        FVU2z5ldla86OzVecozs3N7akoAv
X-Google-Smtp-Source: ADFU+vuavr1O+l9pRKMePZ/FdGHs1iGMp+HBKjvmGwdZEt8c5jE9sBDM4bg5fRUBpKFKrqBFTyZrNQ==
X-Received: by 2002:a63:6346:: with SMTP id x67mr6413566pgb.67.1585197474051;
        Wed, 25 Mar 2020 21:37:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 4/8] t5003: skip conversion test if unzip -a is unavailable
Date:   Thu, 26 Mar 2020 11:37:34 +0700
Message-Id: <bc6bcc786d5858dd12fcfa667bbbdae4989e3d6c.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
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

