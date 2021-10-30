Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB4C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2784603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJ3W1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhJ3W1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E8C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso5597548wmf.0
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQvFweo4VY3//ZnVr76+uHRVQTM52KpzMSnpDsoRanM=;
        b=MhjIut3m4TXLXP5/MFALqhUowVFXlGE0DC9uVqT5VNtzJKJM7T57K99zQas/V4WLhh
         1gS+2IWftMIHBeCskcE5n0ijXH7hqgeZ9nuWfbAd2tT2dNOwtZs5M8YjQGxjWX6G63c8
         qDmBj2hgr07YdFbyg5j+BC/CoAhhHF3qKeHQeqP3aMftXXgiHR2nLF7fjd4fMipj0h2K
         rz4K1kIM1tMhDiqm8l2uk/Y7wo7BXRlQl5rUPYCsRVflrAviczLYnEKjG2vfLyOKJ2Dv
         lRvQJr92G7UC2Tn9xF5XcPT7blSWmMdV+Ove55Ky4gWIIwPS+cmWc5EyDJQ22pNIMbj/
         tG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQvFweo4VY3//ZnVr76+uHRVQTM52KpzMSnpDsoRanM=;
        b=59syvhX0huYqTcq4KnMU71NfJ8zG+Y60BVfbhZSDpjzpDGsv2hoB41HN/788MV3XBA
         yZOAfHcOA6I7DiiFIy3RBGm/LNN45Dbk2iONgXdeEwh/BRk3XpKy91VCnx4Bzai7MbaG
         flBTZS3+hEAn7bdLm8Cc4JHtlvegokHMrRph1nyky69pR6a35AyLxzaYatdd9qdfxckU
         yo6CqzPnifucw0x5QOkg1ZJSOhZvGr29xcuM2thoAHajpnl8A44ib1Z8bn6R4dW1RImV
         E57uvnTsxtU9sqwSsmw9feDRDY0GA5ZpNWI0oertq1utvgSa7jnmnboSBSLsM/eqjnQc
         UTSA==
X-Gm-Message-State: AOAM533xI46Odb/8eEHYnWSUhq3i3T3tTqexFdwMrsYlObZaoWMbpdjH
        h2SjdOVJJ6tAYvWPZq7QJFUbnsG+RAs=
X-Google-Smtp-Source: ABdhPJwBbjrM4V9aYVMopy2/isU0LQKbzPh4ebWtFBYPZVZ+qjapJWpdV6e5mMzcsyAdfea053cHlQ==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr5426232wmk.172.1635632668532;
        Sat, 30 Oct 2021 15:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/15] leak tests: mark a read-tree test as passing SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:10 +0200
Message-Id: <patch-01.15-4f5cc53b2cd-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "t1002-read-tree-m-u-2way.sh" test has passed under SANITIZE=leak
since 04988c8d182 (unpack-trees: introduce preserve_ignored to
unpack_trees_options, 2021-09-27) was combined with
e5a917fcf42 (unpack-trees: don't leak memory in
verify_clean_subdirectory(), 2021-10-07), but as both were in-flight
at the time neither could mark it as passing.

It will now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1002-read-tree-m-u-2way.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 9c05f5e1f51..ca5c5510c73 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -8,6 +8,8 @@ test_description='Two way merge with read-tree -m -u $H $M
 This is identical to t1001, but uses -u to update the work tree as well.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
-- 
2.33.1.1570.g069344fdd45

