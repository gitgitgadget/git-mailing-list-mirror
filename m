Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B1C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5021120732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq/X8xUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgC2KNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:13:51 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53249 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 06:13:51 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so6180124pjb.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mtXxRJ2x9PcTEy4SnASZlKe+5EyHxhucFVvsErHnEo=;
        b=nq/X8xUa0VyOsYT/eD+UMA4+1RdqXUGiX3/oAkGbUyjW8cvI3Cq1xPfTqmYFW57xDy
         Y/FGURcRfAZYnZT30D5VNTTaSr+miUsgC2WbrmzYPvZ3WeO/3LdV/+MnQu+DopMT1x0o
         iSxnxReOu4IZwr988rcP5fflluD2Th1laJ6Fd+PdodxdRJgFbasifZQtiEq/L7u5aVGh
         Id2eqVERwsRE4owrZwBLMLoEaS2oEUxUF6OZJ4YvF1hviDCwMkhbR0/C6Y4hRqp45p3J
         DQ20jxhMwRtiMrcFwCdKydNNbtTAD+5iUuhbDeZezbe7ilTpdyKunYwk2MAoslnQSTrT
         QQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mtXxRJ2x9PcTEy4SnASZlKe+5EyHxhucFVvsErHnEo=;
        b=oYbjD3O5EFDpJEDllJm8+9ekMsf0AUWTPtfTmZI51GnppqAlzp6VLcos+I8MoHaDMx
         rOOKSas+8LEDwPDnjzTCu+thfAA+37+HQwM7BO1+NCKyKjmPAA9Ioyw2a217nnr1bhQz
         2ApZ/4f0P4/0xZmVqdqpJFxPSCRLLGHXHQyiK1uwhmWKHimChyrB/H9frdKytnrkrPM4
         L67c9vWJzr/uHfN30MEJDz6t66dE2MCIbsFNsPNeGBJB90dqfJ7v1BVSpByWWFX3YpkK
         M4gIzYj8qnHqzfeJyDdFIo6bKb8eLm6ZCsQmlhdMX37bED8DajYWwmqmJNZxqabV55of
         pklg==
X-Gm-Message-State: ANhLgQ2H4q4xCbqvcZk+iNBCum5RRGPVv4mEewYC/gJKxDuMvhN9SUN0
        w6gUUSlyKaeJ6nU8DfEQiyem/yXS
X-Google-Smtp-Source: ADFU+vvvyRjUAR3UKL/4LxDl7AhUnXIiqpqksYOQH7esXYC66xjfvYCmynRk1cM+bxiPLE+2Ta3IGw==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr9566771pjg.65.1585476829555;
        Sun, 29 Mar 2020 03:13:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:f121:1d2a:e7e0:840f:1f18])
        by smtp.gmail.com with ESMTPSA id v26sm7757386pfn.51.2020.03.29.03.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:13:49 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 4/4] t3402: use POSIX compliant regex(7)
Date:   Sun, 29 Mar 2020 17:12:33 +0700
Message-Id: <a4eacb4362f29857bb40907e6326d1b0c12d3eb6.1585474409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.302.g234993491e
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com> <cover.1585474409.git.congdanhqx@gmail.com> <20200318173051.25875-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`\?` is undefined for POSIX BRE, from:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02

> The interpretation of an ordinary character preceded
> by an unescaped <backslash> ( '\\' ) is undefined, except for:
> - The characters ')', '(', '{', and '}'
> - The digits 1 to 9 inclusive
> - A character inside a bracket expression

This test is failing with busybox grep.

Fix it by using character class.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
Needs to be applied on top of jt/rebase-allow-duplicate 

Cc: Jonathan Tan <jonathantanmy@google.com>

 t/t3402-rebase-merge.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 290c79e0f6..e8bab8102d 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -228,15 +228,15 @@ test_expect_success '--skip-cherry-pick-detection refrains from reading unneeded
 	git -C client rev-list --objects --all --missing=print >missing_list &&
 	MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
 	ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
-	grep "\\?$MERGE_BASE_BLOB" missing_list &&
-	grep "\\?$ADD_11_BLOB" missing_list &&
+	grep "[?]$MERGE_BASE_BLOB" missing_list &&
+	grep "[?]$ADD_11_BLOB" missing_list &&
 
 	git -C client rebase --merge --skip-cherry-pick-detection origin/master &&
 
 	# The blob from the merge base had to be fetched, but not "add 11"
 	git -C client rev-list --objects --all --missing=print >missing_list &&
-	! grep "\\?$MERGE_BASE_BLOB" missing_list &&
-	grep "\\?$ADD_11_BLOB" missing_list
+	! grep "[?]$MERGE_BASE_BLOB" missing_list &&
+	grep "[?]$ADD_11_BLOB" missing_list
 '
 
 test_done
-- 
2.26.0.302.g234993491e

