Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463D5C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiAMQzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiAMQzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:55:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D3C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:55:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id x4so11251200wru.7
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ze9tPKoK1cYwIUmq7cmJ5XbUNZoavgI0yexiO3wqY3E=;
        b=CMTXJu6o1p4bxZeZctLpjGCcplh9E5pfbiyJ+/xWAwFhwHloY3JYQkuzEJ+Bndo/FW
         A8ke+77KapfVqwpCuREPddu2FpCS7yvqmExtnDH6OGJSmE90UPyEVnYDFSDPaAYeP7vX
         cb/toRGljlbxOtrq1g4spWBw/EDzEdo/e/n50vKmzbCFsqFywvt33SBtKE5noub5TvUM
         Ej7RZq5AjKupQRgBQ5DBo74YNszfvZzJu6MGCGLerPw8dvR8GeoG8DzGFZ8InlD5QFr4
         mHnLa6+1eZus7TKKqQYigk1JlOQ6iQkfB9phUuB0Aa6Y5RXD8lxR2CXeii5mgdz7ZrgM
         1yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ze9tPKoK1cYwIUmq7cmJ5XbUNZoavgI0yexiO3wqY3E=;
        b=6exS4A4hSoj5aZ2fGcbU0ahnt3mYHwK+EICZQF5yF6h9juAyaINKwDZiPsg9Nc529W
         uk794qx++Loq5TGhFL8yHFz95gHr/Muu5BngDSsiPyJX8VBv2rgmimCBXxvZDyZ2N2/d
         KmUFEs3Li9o226HJdyXX5gWmQEy4ENvYkHEMDHoYII86UX4R/kyblu45igk2BGclc4/7
         bD5FR8jDgEWFd3kJvFKwHpRNR3WCjnjF/a8JjMQm2Hd0UoYNB94AN7UPjKXym4TJEwRE
         vyCFi/rP6u16YTc13WNfH703uW7fRjukjzeeXiZfPzCfq1a0cffN1sickAeZ6GEGyhnH
         by3A==
X-Gm-Message-State: AOAM530WKCLvS7UT+SSJQUVtLGvv486wtmAAfC/6q82Z+WbyKyv6O70i
        vlsN2pC6o1YnOyATcykm9Olf/Era4cw=
X-Google-Smtp-Source: ABdhPJxYOg72FXBRvPmM2VbBdMdvfc4BI52HJ1UCzCGcUHpLDf7i1dkUzPEaMpSN7s/03E0rMt+6Tg==
X-Received: by 2002:adf:e992:: with SMTP id h18mr4679232wrm.612.1642092936085;
        Thu, 13 Jan 2022 08:55:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm3503181wro.45.2022.01.13.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:55:35 -0800 (PST)
Message-Id: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 16:55:34 +0000
Subject: [PATCH] reftable: avoid initializing structs from structs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Apparently, the IBM xlc compiler doesn't like this.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    reftable: avoid initializing structs from structs
    
    Apparently, the IBM xlc compiler doesn't like this.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1188%2Fhanwen%2Freftable-xlc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1188/hanwen/reftable-xlc-v1
Pull-Request: https://github.com/git/git/pull/1188

 reftable/merged_test.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 24461e8a802..abd34849fca 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -207,11 +207,11 @@ static void test_merged(void)
 		},
 	};
 
-	struct reftable_ref_record want[] = {
-		r2[0],
-		r1[1],
-		r3[0],
-		r3[1],
+	struct reftable_ref_record *want[] = {
+		&r2[0],
+		&r1[1],
+		&r3[0],
+		&r3[1],
 	};
 
 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
@@ -250,7 +250,7 @@ static void test_merged(void)
 
 	EXPECT(ARRAY_SIZE(want) == len);
 	for (i = 0; i < len; i++) {
-		EXPECT(reftable_ref_record_equal(&want[i], &out[i],
+		EXPECT(reftable_ref_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
 	}
 	for (i = 0; i < len; i++) {
@@ -345,10 +345,10 @@ static void test_merged_logs(void)
 			.value_type = REFTABLE_LOG_DELETION,
 		},
 	};
-	struct reftable_log_record want[] = {
-		r2[0],
-		r3[0],
-		r1[1],
+	struct reftable_log_record *want[] = {
+		&r2[0],
+		&r3[0],
+		&r1[1],
 	};
 
 	struct reftable_log_record *logs[] = { r1, r2, r3 };
@@ -387,7 +387,7 @@ static void test_merged_logs(void)
 
 	EXPECT(ARRAY_SIZE(want) == len);
 	for (i = 0; i < len; i++) {
-		EXPECT(reftable_log_record_equal(&want[i], &out[i],
+		EXPECT(reftable_log_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
 	}
 

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
