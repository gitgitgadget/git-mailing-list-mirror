Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91716C49EA7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E7B613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhFXT0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhFXT0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337DC06175F
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o22so3781931wms.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6B3RsESOOCGfTiADvXWGXFJpRYMtKXSFxLHzqG5jWOo=;
        b=hPS+0JtCpStx9bKNYv28SY72l+DHrO9X7MFqZg09IsEZ2CBZiDaxIbLr0i0BMwF0M3
         kvOIPyN4lfzddrbT9XgIrKS3074wDmOyfxlCGeS38WgwjPRjZI9B7E2rLigFVb2TqyK2
         mtL1w0pBBqRVh9MhpI9I7ZA5XMaz5C6QrGJjY4XV9dBI7GmP4b7hYk8VJ0vfp6l/Ws/3
         JaMyQ4ytlyEDeuSnY9ZZeV41zRQaUBc3nrmmi136E59fRLPjx/8uC/mHcnkYEreW32zb
         I6wyAnRv1ohuRv1IamdkMn++AgXHBsY25+x8jA+QRwL+JDOpU8LkpyGiVR5WX2Lfe46T
         sbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6B3RsESOOCGfTiADvXWGXFJpRYMtKXSFxLHzqG5jWOo=;
        b=Km4iLQuqKAYzy1tMQ3tf/GEPOrhZGk+exu9pzvZ8LSsjsDTEk3cUM7O9l0RwkDwBmN
         RWXBQ/tcN+vu3aCQ/2mOT4PJJ0LOBBZN55N1ohRjzqahdTrEGLaF0K/U6tU9dVoJv6OM
         pTxE49QO4M6sNij6Y2TLpmsk6niVDiH5CA2dabLUeNFABKn59pA6dgHe+LsnMsg4ST14
         WSBbwJkt3Vqn6e0b/QcbIErVLx75L2yWqCVVPV1K1wXgLp6PTwdfjU2wvunv0rSebF1n
         1I1mDE+0MVZN8nHa2LQgJSwwSIEwj5g3Utwgd5vXhgLrAz0B+R6sEJtZjK2X6hXl93J0
         t3+w==
X-Gm-Message-State: AOAM5335Lfs8gtz8RrcdTjECH43SpNhtmgkDvtHpuABSj+y8kwVR5sHo
        +iU2jMqTw9QAsTKBrMItP5AAkWUiqHCixA==
X-Google-Smtp-Source: ABdhPJyZktW1hd6EKGOfp7NYnppO+NycA8iyDF1PmkP+fTrX2NFFwrtjkM8G7Czo3+gwMTQVk9D1jg==
X-Received: by 2002:a05:600c:21cf:: with SMTP id x15mr6142710wmj.78.1624562649247;
        Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/21] cat-file tests: add corrupt loose object test
Date:   Thu, 24 Jun 2021 21:23:44 +0200
Message-Id: <patch-06.21-f0e9d92414e-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for "cat-file" (and by proxy, the guts of
object-file.c) by testing that when we can't decode a loose object
with zlib we'll emit an error from zlib.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index dc01d7c4a9a..7f10a92f0e4 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -404,6 +404,58 @@ test_expect_success "Size of large broken object is correct when type is large"
 	test_cmp expect actual
 '
 
+test_expect_success 'cat-file -t and -s on corrupt loose object' '
+	git init --bare corrupt-loose.git &&
+	(
+		cd corrupt-loose.git &&
+
+		# Setup and create the empty blob and its path
+		empty_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$EMPTY_BLOB")) &&
+		git hash-object -w --stdin </dev/null &&
+
+		# Create another blob and its path
+		echo other >other.blob &&
+		other_blob=$(git hash-object -w --stdin <other.blob) &&
+		other_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$other_blob")) &&
+
+		# Before the swap the size is 0
+		cat >out.expect <<-EOF &&
+		0
+		EOF
+		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# Swap the two to corrupt the repository
+		mv -f "$other_path" "$empty_path" &&
+		test_must_fail git fsck 2>err.fsck &&
+		grep "hash mismatch" err.fsck &&
+
+		# confirm that cat-file is reading the new swapped-in
+		# blob...
+		cat >out.expect <<-EOF &&
+		blob
+		EOF
+		git cat-file -t "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# ... since it has a different size now.
+		cat >out.expect <<-EOF &&
+		6
+		EOF
+		git cat-file -s "$EMPTY_BLOB" >out.actual 2>err.actual &&
+		test_must_be_empty err.actual &&
+		test_cmp out.expect out.actual &&
+
+		# So far "cat-file" has been happy to spew the found
+		# content out as-is. Try to make it zlib-invalid.
+		mv -f other.blob "$empty_path" &&
+		test_must_fail git fsck 2>err.fsck &&
+		grep "^error: inflate: data stream error (" err.fsck
+	)
+'
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.32.0.606.g2e440ee2c94

