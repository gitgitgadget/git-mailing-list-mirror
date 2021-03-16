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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C7C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BA564FB2
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhCPCNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCPCNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D085C061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso529139wmq.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHZ5sccKyIWVbuVnj3dt+dlBBvs3KmFFDHDTe3yxFs8=;
        b=D6/EubnoVI2q/uaixFfzgJ19C/jxGLLUzCspwfJ9bMXvU1LgBwkPOCX/xAG5HQnl8t
         DAgM9YR9Cld1ktQJmD8GKEyf+mWD16bszUEislMMz0tW3P/t19usPZFrv9IvmgKWOmj9
         zSM4s01jDAixXy1QyajqgR7TZczcsec8gbW+vMIjFo+iG6p65yxqAfcx8ESFkKcRDJ0Z
         aflLSgEYxQKHb5AMFr3pcO0LoXFI72/XOyepiEQlZbrHuo74yVj5TfNwecpb8sxbdh50
         l6uKs9/p8Gm9FHuFc6SDq9Qxow7FCrQAR7SSjqAF+AXLrEb4fnvLXdYDGKIMLPPGbXAB
         jc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHZ5sccKyIWVbuVnj3dt+dlBBvs3KmFFDHDTe3yxFs8=;
        b=bbVUqbjNX6oEOV1Hb46SZiTRF8AreBo4kE2yGQn/OBv/r8eRH5ClaPpcSw2T15yhmz
         Awq7KyV23rHtzoaGYSOMPlHRxvl22VfmVu2JLk5nxBNmKDOenMHSCBTja5SVItWGq8lB
         BrTqPLQDCtCGJ2uWgeNIITf4bPSttQDZoJmO+Gswdd87lUxbIw4UgwJ8VHOeELjdMhrK
         Uhgl4C25hlryvAjPLxePGFp/LtEcIEzphxwPdrCyOF79TxalW5VnWke+r4DcULAkLoUp
         zvRwAmrj9OlkI1bgAU7VsC7jfrvMLR+L6IjODdJeLzvrNaOuf5dIAtDOte1rCAI3ZNay
         8zkg==
X-Gm-Message-State: AOAM531O3Fcro3/qtRWKpaQebGJVGqllfBnTspd+CialA9HAdJtpUvMy
        iIqvhWG38guXUCJ/SkJLS0mT7+W8ZCasPg==
X-Google-Smtp-Source: ABdhPJyHCIB+1zxhKTPFTMAKzT29vKac1wO0/pq0M4NlsquI/L1C/RsOOp6M+l1LQCcODYJzyGXPWw==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr2284260wmd.180.1615860812036;
        Mon, 15 Mar 2021 19:13:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:31 -0700 (PDT)
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
Subject: [PATCH v2 01/29] diff.c: remove redundant canon_mode() call
Date:   Tue, 16 Mar 2021 03:12:44 +0100
Message-Id: <20210316021312.13927-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a call to canon_mode() from fill_filespec(). This has been
redundant since the tree-walk.c API supplies it pre-canonicalized
since 7146e66f086 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06).

This call to the predecessor of canon_mode() was added back in
4130b995719 ([PATCH] Diff updates to express type changes,
2005-05-26).

This was the only such call in the codebase. The rest are all either
one of these sorts of forms:

    canon_mode(st.st_mode); /* a stat(2) struct */
    canon_mode(S_IFREG | 0644) /* A compile-time literal */

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 6956f5e335c..bf46e6a4d8c 100644
--- a/diff.c
+++ b/diff.c
@@ -3846,7 +3846,7 @@ void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
 		   int oid_valid, unsigned short mode)
 {
 	if (mode) {
-		spec->mode = canon_mode(mode);
+		spec->mode = mode;
 		oidcpy(&spec->oid, oid);
 		spec->oid_valid = oid_valid;
 	}
-- 
2.31.0.rc2.211.g1d0b8788b3

