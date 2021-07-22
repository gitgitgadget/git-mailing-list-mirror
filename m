Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4538C432BE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB79060EB4
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhGVUs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhGVUsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE90C0613C1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z8so177344wru.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBIsRCe4J3ywO/HwV61EtjmFfldDclMkFr6D5F5d3/s=;
        b=rif/z1w/tTDnKDOFhZbqWDoibTns4i5k48+NS8+ErCDpWDvA4i4RtFIKP/qSir1dOO
         7dHKlOEOg/xXXuNTyOnVJLKQW2lkRQmsVv85vuz8dkER/lohg80FQ9hGDLVGX+nXrb/H
         GSJUYslx7xTGpBT0Z/Q0n/XEXByf3rViz+GUUl1gmZFCsAosUOQQsYVJna2hAJ4BM58f
         Mbuiv5dfMpKtGyIaMI9o2dhmtkEpy4A7a7XahdO3AbsdjWVnhxuRbVHbvE+kHCbITDxh
         KDV+v+sxj9vImWTZaWrWktBlgiAJBzaSWs3lSCTP5p2ElIqouSp+iNjJbksuIE2sZEOt
         dGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBIsRCe4J3ywO/HwV61EtjmFfldDclMkFr6D5F5d3/s=;
        b=ErNAa8CyhO6J+oqIhS4ScYFKq3itCQmEmw3CQhcYfD3SAzzx/6QFodm46XrM/jVKO/
         e6zrfdIK5bvEUYdPSLMeYJivw7lWUpqCyUJtDnchVlRQxg7U59KU66qPzshvzCz06Egb
         QTbcY6Rtp9O7kppjPwIK0l4hELC3yRaqNLoSdVIaed/ZDsnYarvhEbT/SkeLH7llLJE/
         5J4PwtfO09qFT5dKNVJOzu0EDuYK1nZYD8YxWcx9W+Fq5ObnmDEkclCZOUwPCoC77ks+
         6OunuE65UYXjjjw4AJSc+oTO1qgq5KvtJzMBtt3/PvoocWwUKZZaPobVyvlRAYPN/ti/
         cbJg==
X-Gm-Message-State: AOAM530K1w6ChRWrWoDcpZ1nj3mC7yODcbORbRQ/nNtvbKGEjyP+X+bM
        a/5CEfx8LocA8ZDjoCh4eWYnvuIKeLI=
X-Google-Smtp-Source: ABdhPJxThU+Ki9dJvwBzGIR8v3gvhoRDyGI9S02RWmJt6IIzm4b+z75ZN+otmZHFxbAAkq9F/eUFnQ==
X-Received: by 2002:a5d:6482:: with SMTP id o2mr1830768wri.367.1626989332729;
        Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm25501441wmh.44.2021.07.22.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
Message-Id: <05dead16f1cbc8d967edf101e170049bbe121cb4.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:43 +0000
Subject: [PATCH v2 07/11] t1405: mark test for 'git pack-refs' as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The outcome of the pack-refs operation is not checked. This was apparently
forgotten in the commit introducing this test: 16feb99d (Mar 26 2017, "t1405:
some basic tests on main ref store").

I tried adding the obvious check this, but it seems to fail on the freebsd_12
builder.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 92b04873247..3517f54961d 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -9,8 +9,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 RUN="test-tool ref-store main"
 
-test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	test_commit one &&
+
+test_expect_success 'setup' '
+	test_commit one
+'
+
+test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	N=`find .git/refs -type f | wc -l` &&
 	test "$N" != 0 &&
 	$RUN pack-refs 3 &&
-- 
gitgitgadget

