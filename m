Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9843C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiHEDGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHEDFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:05:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F8B63A6
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1645572pjl.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ui84gGy//MR5nayXsLtLh2DEca++xowMq/b5JPqYEM=;
        b=n+bBNXlYPCu1h+tFVqUVHGhLX7YLHqdsAQEggT+qgzYuYNDDsZd9CK0Xb1SZkIspET
         1V84KBQEg1SULFp+3Q0XDeePTLQmoE6qAI6NyEyk8A3qW0BCCKC1bE+cKXdaTeyHwB+c
         RQE29+RDE8wwmwU8qBZ/Gs+Uwaes4IOgoYzjCQx2A06GGyBHIo71owhJEvMCauzt5O2w
         Bj05I64c7fmSo3yKSA5mQr2CujGm3fUDrISUlnt9WZC6SiwmzY9UfEOWfxmtJhNLmvAp
         3RZU73P2V/ivDNqkuuXJ8LxECVIZy/fz65CCfZOwLrv0lffMKdqrW/U8AoSqgji/grUa
         VW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ui84gGy//MR5nayXsLtLh2DEca++xowMq/b5JPqYEM=;
        b=tMsgwE1zmDWQiKQSjvKN0iVWuGs7noJvy0L1/mNh6bpddvc54fiKbnjGR0wurQjz9j
         LrvODmNJZmcB4zTbfY8wT8RayNE8e8TyjP8Lc6iAPn8oOUH5gxf1Rd/KetgHFPULOWrW
         FvCtLMrHJaF6BTq8GZeXNJvUs+gRtDR8/pyJHQnWPTBhrICMzylcIwf5iy9gY/4k9+Pb
         EqUE7eNDIdiG5QEIl/wou9bNT+MDnZM/Q9BGnELNFkYiW4jxNXOwGU4OtUnv438ADIIP
         8378lY5CXei7sz3t5hjMxKaCsbtGHk53JIpcSPawP4ZuWkCR4MMJQ2hz8wX/jQrdP5rU
         zEFw==
X-Gm-Message-State: ACgBeo2sXzCW3cdarN1fW8oGTpWMZKa36MnfvlCGQ5w0Lh8z4k8XZJYI
        ooiHpfLcHnb3+uOQ+J4qbyZ7hU3MBlT8zuyf
X-Google-Smtp-Source: AA6agR61PjzisSNcJxOF+vP+tWTn2bDXg0dJhqYvH8x5xhk+vjy3eXCeaujUzyGi6pGgvfZ1+NdoKw==
X-Received: by 2002:a17:902:a9c6:b0:16c:9d5a:fde1 with SMTP id b6-20020a170902a9c600b0016c9d5afde1mr4601867plr.3.1659668754193;
        Thu, 04 Aug 2022 20:05:54 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:53 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 3/9] mv: free the *with_slash in check_dir_in_index()
Date:   Fri,  5 Aug 2022 11:05:22 +0800
Message-Id: <20220805030528.1535376-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*with_slash may be a malloc'd pointer, and when it is, free it.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7c11b8f995..0a999640c9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -133,6 +133,7 @@ static int index_range_of_same_dir(const char *src, int length,
  */
 static int empty_dir_has_sparse_contents(const char *name)
 {
+	int ret = 0;
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
 
@@ -142,14 +143,18 @@ static int empty_dir_has_sparse_contents(const char *name)
 	if (pos < 0) {
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
-			return 0;
+			goto free_return;
 		ce = active_cache[pos];
 		if (strncmp(with_slash, ce->name, length))
-			return 0;
+			goto free_return;
 		if (ce_skip_worktree(ce))
-			return 1;
+			ret = 1;
 	}
-	return 0;
+
+free_return:
+	if (with_slash != name)
+		free((char *)with_slash);
+	return ret;
 }
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
-- 
2.37.0

