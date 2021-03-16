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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86061C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1C6501D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhCPCNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCPCNf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30005C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so298222wmq.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxaQuxGuJTZzi1LlLL+4afGZBo2P7/482a+g5i2B/8o=;
        b=ZGQ5Qn4da/3rS3Dg2jdA+Y88Q2z5nl1dcwNlu7fvv4ptuLXBGwb7eWapFHvzKBo61G
         bkOVsj8MZOBj3Ad6DT5OfsZRMrfGcRjL0My469waOW58zHnIJwgq6uBVWKlNtZaXDMcm
         j5OuotIQlaischyr9N/AW7qyYke5gK+Uu4YJg1+o5sWM+1lGV9KLigAbryB+NONyJV3Y
         VWzbiXl/7N3g7LJOqrCOYwa+vMIXN6QvxOsMclYdxRFFvc/MnkDzcdtU+xS1X8utW2ls
         cAXi43DtCbEnWjJnrGQYN8O79LOTJR7Yge8ySh/xVtu0eoMGn5VtLAO9TqqUENV/TAKd
         PKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxaQuxGuJTZzi1LlLL+4afGZBo2P7/482a+g5i2B/8o=;
        b=O6CbPmGox6pyKVaUYfXCMugOV5MT+FY1QTliefMazgpVz9gj3apTTTKGPw+snZvbC2
         MPA9LmL64sWNGTAh3pCqdc5I1oWPdjsnGRe/NZmCz+iuO6WZBJj45syhlISOjeywv2KF
         CEAmFUKdyDUwg1DkleiSNv0j4X3Aw9UV67jqrSsGSQzwY4Y8Zm5G044UR6o6vdxEwa8r
         d6gE8wSaCNbC6xzI8OmVwAx8flkvAZNDkXJbiy9TmbEwtXm6cNhndf0UE7GasXFa2W8n
         /C64h1GcOleDzal+r83MK8ttbGN0FrrBOzfzGvpxQQlC0o+wxD1wr9vHUy6aFygDXhTa
         Uc/g==
X-Gm-Message-State: AOAM5339CYURfn5opTJnCkDEklLJcNEmkzz98BihDj6cjJzB2nlzE2oq
        cUcY5jaWrf9rofQ6UkCTc9bnt4WcFUiTGA==
X-Google-Smtp-Source: ABdhPJxNrTfpsjPvPQ8x3HRfH2RNq4O21ZMO2HBcYFgHyEp2MKlwGtZ/R6FeODOsacV3RWJJNpNXyg==
X-Received: by 2002:a1c:86:: with SMTP id 128mr2219962wma.41.1615860813613;
        Mon, 15 Mar 2021 19:13:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/29] cache.h: add a comment to object_type()
Date:   Tue, 16 Mar 2021 03:12:46 +0100
Message-Id: <20210316021312.13927-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment to the object_type() function to explain what it
returns, and what the "mode" is in the "else" case.

The object_type() function dates back to 4d1012c3709 (Fix rev-list
when showing objects involving submodules, 2007-11-11). It's not
immediately obvious to someone looking at its history and how it's
come to be used.

Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
objects involving submodules, 2007-11-11) about wanting to move away
from users of object_type() relying on S_ISLNK(mode) being true here
we do currently rely on that. If this is changed to a condition to
only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
have failing tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c2f8a8eadf6..ae0c0bef5c2 100644
--- a/cache.h
+++ b/cache.h
@@ -451,11 +451,16 @@ enum object_type {
 	OBJ_MAX
 };
 
+/*
+ * object_type() returns an object of a type that'll appear in a tree,
+ * so no OBJ_TAG is possible. This is mostly (and dates back to)
+ * consumers of the tree-walk.h API's "mode" field.
+ */
 static inline enum object_type object_type(unsigned int mode)
 {
 	return S_ISDIR(mode) ? OBJ_TREE :
 		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
+		OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */
 }
 
 /* Double-check local_repo_env below if you add to this list. */
-- 
2.31.0.rc2.211.g1d0b8788b3

