Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7541C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECEB61019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 07:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhHIH0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhHIH0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 03:26:21 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D9C0613CF
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 00:26:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y130so4724242qkb.6
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYBJVeeufVal5XqI2lKZ5llBzA1kv+2NFoYv7dv9Gvs=;
        b=OOFD6nZY81fkOElzGVjzlfatHS3N36dix4kZLDRlFBYBKZ/w2il6gZ26A52c2Z9Wcu
         IQ/gDG3Ba7vGu45neURi5urJDJCl0V3zGeUXrwEDiZRG5mOQXVbFbYCQYenyj2VkPb7G
         aN9JtjAzbk9ek1tRQ35G/Kl/ib6g7AotcdrmRQhxmu39wex+k9zplOdRp4mi6HqLaXEP
         VToVFGO/2QulP3a9tsRFOVuwTql62eh3AwWYNy5ADbzVq1aGzn1AlLIdPQa9K9Bu6lSi
         +9Zv9O+EpjzvO7noPocAAnaoRIB0MfliAi1gQiD0FqHNJ1jeDXP+h44Git2Gw9okBfCX
         B99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYBJVeeufVal5XqI2lKZ5llBzA1kv+2NFoYv7dv9Gvs=;
        b=E2hi2cnp1xyW17VXbIpW6YN3xzn2GDmSgRRkhh65pKD2iQxzoEmiCZQWrQvbgglOqM
         83/nDqZV9wWiIauNXtl5ViwzqZMHBOGNyWRUKBZcXi0b5gjATi84EMacrkABT//wi+oQ
         HyzNIDe31mEKaBHcm3H+VxozrXu7xE3qF6DLJoadJ7cSZ/ZzZUyq6Ay7cY0Mxm9zzWQV
         ZAYpPuH6QeZrDRO1lpomecqmkk80CJPWqwPQn3ilKax748Lbtma0bnW0OknwYmDja9S6
         d+ZLzY4fo9ETmuU3Ti2FWoJqCUKw7OPZYjS11hCy9tW33HKz48JWsLjXvv87SJRQEsQk
         4TCQ==
X-Gm-Message-State: AOAM5318PlXtd7pJl5d6S/UGx6rn11OT/RiPU9Ihf/agicPhbNjBkKT8
        DHmoRvwZ3fINRbcRcjlvju2WY1c3heI=
X-Google-Smtp-Source: ABdhPJwyplXJJnfMiwS81k80jmSC2nCIiVNJ847+eV/w8ZJ/pFEv2sDoohzZtMWV6e33ENvdvy4dQw==
X-Received: by 2002:a37:994:: with SMTP id 142mr21437612qkj.277.1628493959305;
        Mon, 09 Aug 2021 00:25:59 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r29sm8810822qkm.43.2021.08.09.00.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:25:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     garima.singh@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] test-path-utils: use a C89 compatible format for double printf
Date:   Mon,  9 Aug 2021 00:25:51 -0700
Message-Id: <20210809072551.94391-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809063004.73736-1-carenas@gmail.com>
References: <20210809063004.73736-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a62f9d1ace (test-path-utils: offer to run a protectNTFS/protectHFS
benchmark, 2019-09-04) add a tool for testing that uses a double
variable to keep track of time but prints them with "%lf".

while correct for newer C standards, it is not defined in C89 and
it is not needed, since both float and double will be promoted to
double by printf and should therefore use "%f"; change it accordingly.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/helper/test-path-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 229ed416b0..3d33d2a3e7 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -275,18 +275,18 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
 				for (j = 0; j < nr; j++)
 					verify_path(names[j], file_mode);
 				end = getnanotime();
-				printf("protect_ntfs = %d, protect_hfs = %d: %lfms\n", protect_ntfs, protect_hfs, (end-begin) / (double)1e6);
+				printf("protect_ntfs = %d, protect_hfs = %d: %fms\n", protect_ntfs, protect_hfs, (end-begin) / (double)1e6);
 				cumul += end - begin;
 				cumul2 += (end - begin) * (end - begin);
 			}
 			m[protect_ntfs][protect_hfs] = cumul / (double)repetitions;
 			v[protect_ntfs][protect_hfs] = my_sqrt(cumul2 / (double)repetitions - m[protect_ntfs][protect_hfs] * m[protect_ntfs][protect_hfs]);
-			printf("mean: %lfms, stddev: %lfms\n", m[protect_ntfs][protect_hfs] / (double)1e6, v[protect_ntfs][protect_hfs] / (double)1e6);
+			printf("mean: %fms, stddev: %fms\n", m[protect_ntfs][protect_hfs] / (double)1e6, v[protect_ntfs][protect_hfs] / (double)1e6);
 		}
 
 	for (protect_ntfs = 0; protect_ntfs < 2; protect_ntfs++)
 		for (protect_hfs = 0; protect_hfs < 2; protect_hfs++)
-			printf("ntfs=%d/hfs=%d: %lf%% slower\n", protect_ntfs, protect_hfs, (m[protect_ntfs][protect_hfs] - m[0][0]) * 100 / m[0][0]);
+			printf("ntfs=%d/hfs=%d: %f%% slower\n", protect_ntfs, protect_hfs, (m[protect_ntfs][protect_hfs] - m[0][0]) * 100 / m[0][0]);
 
 	return 0;
 }
-- 
2.33.0.rc1.373.gc715f1a457

