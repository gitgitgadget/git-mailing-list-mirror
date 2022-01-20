Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60483C433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376532AbiATPMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376511AbiATPMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA86C061746
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r7-20020a1c4407000000b0034e043aaac7so287242wma.5
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=iN8tcffPW7Vx2ZhdJzn9MVtkdOCqVT7lFBrsFId2Xs0GKA2ipaz1tPcoaDMtiouCoD
         5XIUvFTsNxNh810Lpao8BUQdSaWwkbwnKK0c1kmpqwVSsKBqkL4JK44HW+Jrt+Zf6g9A
         7HJilFXtjAsksx2ts9qD2NZChq04kowK1d2RxtHefKl5+TgdbbRQqIRR+3q7hy493/QZ
         uWDQwxXaiadSMHEuqMeuYYQwrx2LynZGX0smPvhqllHh5hvoyh5GSRiMlbsSh/Hgwk6s
         eG6cLd57YRdzfxfdYQwLFc3n/OUj62m5lSfMmN3PdhxgcqileUIu5fYwgmmf9iWm5EiW
         cEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY/CPJQ0Q+sLVf7jURIMds3wahY4HaQuVDcXfMmDpdE=;
        b=Gi283BcvUreyiU88to/nBHq+a8UOtVaPNpM0nYfOL9PDuRkb0oMihC8iNFKRnofyjY
         xUySw+15aR6C+ObUUZbhNWhX2x3Gt48t/LUSH4fEyBM/Ap5V1LHNVEk9eBRmyNqs1v1q
         bl9u/06nhRc0WL2aOjoktHswC7dhE0WWdbz0UbodbwQkupfjGipvgUJ7OUyiKJIB8W2k
         KcBkkW96r9DsBo6t+D7y6qSb4wRo/1YWQUoZcsGBX1fH6J5EFwMzf7BCgZ5+pWFLmd5z
         j8U6efU8eDgFI/SGddLQhDWKziL6N9RzmAm5dnU46dSPzEkm2F+YicpU/GQh1viWGZMu
         ky/g==
X-Gm-Message-State: AOAM531o36TlqNXoPCGQKOipvSvgLVbPMNGoo1IT0iayS1ArPgbRM2MU
        Fa4v8R4bXPZgb5qcmQvzEpm3eGBCIe8=
X-Google-Smtp-Source: ABdhPJyZDr0d7wnARwyEawWbs2N9Wb5tRy6ar3j/2+m+JNkJbia0hlktd290TywQ/55CPCsQ1SqekA==
X-Received: by 2002:adf:a34c:: with SMTP id d12mr12084694wrb.80.1642691543599;
        Thu, 20 Jan 2022 07:12:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm2502843wmj.12.2022.01.20.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:23 -0800 (PST)
Message-Id: <004b7a736bf5ed847bad6518a5a9434c6176f98a.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:09 +0000
Subject: [PATCH v6 10/15] reftable: handle null refnames in
 reftable_ref_record_equal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8536bd03aa9..8bbcbff1e69 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
 			      struct reftable_ref_record *b, int hash_size)
 {
 	assert(hash_size > 0);
-	if (!(0 == strcmp(a->refname, b->refname) &&
-	      a->update_index == b->update_index &&
-	      a->value_type == b->value_type))
+	if (!null_streq(a->refname, b->refname))
+		return 0;
+
+	if (a->update_index != b->update_index ||
+	    a->value_type != b->value_type)
 		return 0;
 
 	switch (a->value_type) {
-- 
gitgitgadget

