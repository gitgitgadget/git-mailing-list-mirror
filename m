Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E106C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FF820674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ussHstnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfK0PNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfK0PNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so11175924pfd.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMrsALJBItk45lz95Supq0IXRiFpPbM5ypdJSQL2TXk=;
        b=ussHstnEKWLq0AKX7RRJ7MV5vZzk2Ki7ILoP/Oq+DFHtcCHeVe0AhtEhun83ywHcGG
         c4WTDYP2EU9yCUglpEQa2IQVkPi3v0kXqylRHaZ75uUTA3oR59GnxjxFL6/iLUQevjon
         SXsVaVq7VU31xgnaKGouieF4vfADsFQUzjDRnA1ZWJPt4U6F8fYZ0YLfzRec4x+uOS81
         6sqSJ3nLHgWCeKdPhbiGM6A1XZgedNBx6yHYpCXW6sVZ8Ac2yAZZsj2cn5J+6VQRv4b0
         p2cYyAfTjk6hKvWZQt8jAW4F9mTPQyci2NPRfd2ZrVPRSqSR68FOKiw05jK4boUA46MT
         wZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMrsALJBItk45lz95Supq0IXRiFpPbM5ypdJSQL2TXk=;
        b=tWQNb4OMZYeH2+cQObhHLdWZRA3fOCK9MFc1FclnF2iGkYw9MTwlPUvBUkhzeuzOG5
         IcPs6h/+7w9tzlZHGVo8Jv5xVPQxPD0tuljOvDaASlnYMssfKsNfSd/DW851DjxOg00O
         aCP79tj5Lg2j0WU1cHRrtbKGhgUuIdtQpHEfWPHtKOQma6iWtzHFvX+tfDjouUtdxkOe
         RuoxQXa3YPywl2bD4nDGP5i4ihsZTDEMwJ5fQR07847BRsIwSuyXRznSRyboIpmTjDlq
         5xvbbzLH+NNEbMeM0mnEraxTLp0cB1OTtN1DD5JZGLGYxdH9EE+c3iBTslvIJE5PxcaB
         qn/Q==
X-Gm-Message-State: APjAAAVhztVpL8iglWI8g4U2x1XdzaAfAC2x+ZJ6NArYac25vcbQlTXg
        qA4JmdszCL1knn9QELQkY/Rf7Vbg
X-Google-Smtp-Source: APXvYqzVME7KSIAjpZudEH5sK8UepepKC45iO74yypsyTFRupwQDgYZVn/zBkyDy7ubk2tKESomhDA==
X-Received: by 2002:a65:66d7:: with SMTP id c23mr2769952pgw.40.1574867633629;
        Wed, 27 Nov 2019 07:13:53 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:53 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/5] mingw: use {gm,local}time_s as backend for {gm,local}time_r
Date:   Wed, 27 Nov 2019 22:13:21 +0700
Message-Id: <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Windows doesn't provide gmtime_r(3) and localtime_r(3),
we're providing a compat version by using non-reentrant gmtime(3) and
localtime(3) as backend. Then, we copy the returned data into the
buffer.

By doing that, in case of failure, we will dereference a NULL pointer
returned by gmtime(3), and localtime(3), and we always return a valid
pointer instead of NULL.

Drop the memcpy(3) by using gmtime_s, and localtime_s as backend on
Windows, and make sure we will return NULL in case of failure.

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 compat/mingw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe609239dd..7b21f4eee5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <conio.h>
+#include <errno.h>
 #include <wchar.h>
 #include "../strbuf.h"
 #include "../run-command.h"
@@ -986,16 +987,16 @@ int pipe(int filedes[2])
 
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
-	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
-	memcpy(result, gmtime(timep), sizeof(struct tm));
-	return result;
+	if (gmtime_s(result, timep) == 0)
+		return result;
+	return NULL;
 }
 
 struct tm *localtime_r(const time_t *timep, struct tm *result)
 {
-	/* localtime() in MSVCRT.DLL is thread-safe, but not reentrant */
-	memcpy(result, localtime(timep), sizeof(struct tm));
-	return result;
+	if (localtime_s(result, timep) == 0)
+		return result;
+	return NULL;
 }
 
 char *mingw_getcwd(char *pointer, int len)
-- 
2.24.0.158.gd77a74f4dd.dirty

