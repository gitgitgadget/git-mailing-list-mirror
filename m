Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE8E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeBFAVY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41639 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeBFAVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:22 -0500
Received: by mail-pl0-f65.google.com with SMTP id k8so118831pli.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CXQLvLWT12UBiTFYU5NEZMN8f07y3AepmeB5mQQYc4c=;
        b=G9bCjmqRTbJ09mbg1z9FKt7wW0pXSdEKfhsMMwUm1u48KB82u+O1KQsEpr4rnmuBgZ
         mJb+/pGT8u22shPDWsbtsDfR7OLxileGlhnvd1UGUtTXeNr6e1JCSySp1k6EdAnZQsH9
         pl+ccxXk/zcOBvzpFVuBP/7A9tCq3G4Ok/n+MriK1W5H7TdXmeRKBBCE9tfH+dn/X90b
         x1WeBInR0OYNpeH8OJ/6/HzKy6E4x+y8qVNvwnnyevsUSOp8Dfmrap8R6cmR+o+Fs0r8
         kiYMFsWbrz6wsyvn+2AXvnC/fEA4NlBkMacJonKl/6CsOYzNM50+HtXlajgBmY6JEZXr
         nP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CXQLvLWT12UBiTFYU5NEZMN8f07y3AepmeB5mQQYc4c=;
        b=ulDuiRWyKrsKJiD+/aATC8JA9gPvAk2mnOkyssf0g0SdddzBVuD+ThrRYu4QuBfLiZ
         RABISFKKbDjtWBG2a6WkmLqHQSMDw/fTwQWYD2Lj1JJefH9Ro0bF1D18rit14GYlS/Ke
         gyztbm+D65U0fmVZSBif14XM3ewDZiDKVGZXzCGn5/omPQ0dmyHePA8NfQgSP+njpurv
         Y5IK36+++duGYUqo0EqzfTV2+4M6OprcRfaEDo+xvPRZBSiNoYiQrsCUAECrtjAiZpqT
         wvhJpD72l1Ci4NE4YP/o6gpuhYy0ofayZkuwn2db+y9xylrzcnwVLryPsnkjuLv8LmH5
         vJQg==
X-Gm-Message-State: APf1xPDT2Q7uZ9eazzk1PusCfYw+rA9np7I3iFpwkKmUF4w793SHRx8o
        8ht7w7XU4JPeQTs0fOWfePkYTkl6M84=
X-Google-Smtp-Source: AH8x224qKKZC9HND97hN0tvJPIA1qeq8jYrXjVdSbunkFw9fRt1qo1/GcAQFmOj9wpyjvbMd9gWJ1A==
X-Received: by 2002:a17:902:523:: with SMTP id 32-v6mr530115plf.283.1517876481507;
        Mon, 05 Feb 2018 16:21:21 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k90sm19337523pfk.171.2018.02.05.16.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 121/194] sha1_file: allow read_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:36 -0800
Message-Id: <20180206001749.218943-23-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a5ad67143d..6164ba29c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1319,9 +1319,8 @@ int sha1_object_info(struct repository *r,
 	return type;
 }
 
-#define read_object(r, s, t, sz) read_object_##r(s, t, sz)
-static void *read_object_the_repository(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size)
+static void *read_object(struct repository *r, const unsigned char *sha1,
+			 enum object_type *type, unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1329,7 +1328,7 @@ static void *read_object_the_repository(const unsigned char *sha1, enum object_t
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(the_repository, sha1, &oi, 0) < 0)
+	if (sha1_object_info_extended(r, sha1, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
-- 
2.15.1.433.g936d1b9894.dirty

