Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EFC3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6122A20A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXJ0tkue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDTIzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgDTIzB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:55:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043AC061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y19so4291838qvv.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kTTGKq4yRISi6AVG7dlVR3pmmwghy+6w85Tlnfkpl4E=;
        b=tXJ0tkueN3iMamZ6Cbjv9dGCfR6wC6S6MGpu6ZlcITopXYHRwOZNDjOUBKetbbgDib
         yWL8/yMovGtA63eEbHnuOtMO8Hx9AkEqvcCOhwSozQCXDDU4EpP17ABvRBQbmAm2hnxz
         2s6idMAi5jR43dR1FGtQK2n1hDoe2UI/xVG1ARYJk53g3/p/tKor6IxfRSelq2A/KZSy
         fy/lw/N5sY3nn0DRg1L65pIjY5ZsPwgfyCcMb0Cxsvg5hifGR6kzy169GhCduv/bGIm5
         MEM+VHXrIG5kYVqkOG0sYL4daWnnI4MPXG4KMiPiMtX1RAxs1os7sBxzggsSOC70YigV
         h9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTTGKq4yRISi6AVG7dlVR3pmmwghy+6w85Tlnfkpl4E=;
        b=kfkuzlW6AGqJs62sdTk5ja1cKWBXHCfxBUnN1XATycrQO+v1n0nFKP2ih8pof80s+o
         7IyRHqlJWFEP8dK5huSxJTr+HHlJB3zZTSx+KCoR5e9BHTgC4DT0DackbvMEUb4VtXYF
         FtDklmIH8aIHNTmdtwiSrpouB0T6/R9w7WGl9cplIGhhVpAnyZj7vdiRCKfYSGwPFE1U
         nuXtMe7bpEKmKsUvqquvJL4VV8M2ZP//1Dl/GkLpmX2a1IOFxpyenMwONXe+D9dbiFTi
         Kn93oYAH+Em4nHm/AbWGmHU3YIk3SV0KgZCkWH9eXlRE9YUZvjpdgEvr4PKZkUL7M2hg
         Cxrg==
X-Gm-Message-State: AGi0PuYpAvAlsGMLZOAJ5IVOuxAQ/4zHDkmITVBCLZDXTa5TmKFa0xAi
        vKNEfMJU/9uDKuIOVsOO2b8yjWHc
X-Google-Smtp-Source: APiQypKADH59WIFv/0EYjeXF9JSHcR74TqXSz6B+LSxCcetW7wqu/Q9bscylmx5jPXdcf8q+R5pVvQ==
X-Received: by 2002:a0c:e844:: with SMTP id l4mr13596926qvo.247.1587372899612;
        Mon, 20 Apr 2020 01:54:59 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:59 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
Date:   Mon, 20 Apr 2020 04:54:44 -0400
Message-Id: <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9164-git-svn-dcommit-concurrent.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
index 90346ff4e9..8466269bf5 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -92,7 +92,7 @@ test_expect_success 'check if post-commit hook creates a concurrent commit' '
 		echo 1 >> file &&
 		svn_cmd commit -m "changing file" &&
 		svn_cmd up &&
-		test_must_fail test_cmp auto_updated_file au_file_saved
+		! test_cmp auto_updated_file au_file_saved
 	)
 '
 
@@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
 		echo 2 >> file &&
 		svn_cmd commit -m "changing file once again" &&
 		echo 3 >> file &&
-		test_must_fail svn_cmd commit -m "this commit should fail" &&
+		! svn_cmd commit -m "this commit should fail" &&
 		svn_cmd revert file
 	)
 '
-- 
2.26.0.159.g23e2136ad0

