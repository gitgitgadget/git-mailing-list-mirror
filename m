Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE82C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E75223BE
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaZzdf1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgJSTby (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53774C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so976087wrp.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=To4cs2zA/NoiFJemhQgx+gHS7cbeq1K3P9o2Iymcjf4=;
        b=jaZzdf1QqPqE+A5Xa1wJxw28RFWMzUQ6XFGdgtVELsLw00GVm87Qa25sXtjFAzQZDb
         eva19k1GK6mPt4UB3+Kohb0xmXpISivImuI/HgLsXylFGFwH8d8cD1nG1GtYMlY9ubwZ
         NFSfL6icq9/8pK3qW9gn4vtirTYjpN8hHtfR4/OG0p4VuX7cKUBRTTPBtqAHOn/nkDYx
         tXPjibZ8eqQh+fJLWAWuQc5FmjDEMksp34P6/sNXMbinJQLJhYmnN2h7Rz70t6St3ahH
         1Wm3tVKebF1RE6cqu4NzJhsKQGBZnUBBT1IkiQN7dIPx/gU9QOexeYKhqWfQMgAnD3ai
         yV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=To4cs2zA/NoiFJemhQgx+gHS7cbeq1K3P9o2Iymcjf4=;
        b=IE9jUWYv6cMZyNXnar+rEgSQGRSQqfgd1UJ7RdZHxiDGlmPPJDnAWWZwQs4iWtV4mN
         0bJ7PhI16KYr0ASBB2N5ZMp8N+8wP1CRFzOcHl5/VLUrI/0ITv8GmQb78Sj8FqpR7zbZ
         lfGAV56ptfLNkGVub2n/VqSDVmmPZFIoDlS6gi7hO5bhgHlPCEIpdBmkpXz9IX6jjEuS
         NnXeyFFrCiTF/E61UoYeL7nAVp5ZyQtjpM+7bQPBxIaJQbI2V2i7brAL/b5AUzzAKSzQ
         e41r3tKfbZwKwuRoNifVOcU7UpXRV+skEqlELIVbddY0VgyanGBz/BPycIgCigr6uYnq
         D+KA==
X-Gm-Message-State: AOAM5303zxkz3Fcx04AfTgvlIFDrBgxRKoyjezCy9eimDOqgbxxPjchH
        huSGSQFZQY9nRSfgSvsaz0Cqq/O3ogQ=
X-Google-Smtp-Source: ABdhPJzSLDdS+t88fDoet7REf6DtC5PnVHlnOQLhPIl7FSlTMb6UtYZ7LlsOQx1H7YLfxv08Fte9pA==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr855630wrs.101.1603135911905;
        Mon, 19 Oct 2020 12:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm681072wmc.3.2020.10.19.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:51 -0700 (PDT)
Message-Id: <0d2511d18fb2908b1049afe4da7494f6ed7e26e8.1603135903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:37 +0000
Subject: [PATCH 06/10] t5703: adjust a test case for the upcoming default
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We want to rename the default branch name used by `git init` in the near
future, using `main` as the new name.

In preparation for that, we adjust a test case that wants to rename the
default branch to a different name that however has the same length. We
use `none` as that name because it matches the length of `main`.

As this test case cannot possibly pass until the default branch name is
_actually_ changed, we temporarily guard it behind a special-purpose
prereq, until the test suite is fully converted to use that new default
branch name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5703-upload-pack-ref-in-want.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index d9ecf0f4a9..67f83e7c9b 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -383,14 +383,14 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server loses a ref - ref in want' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
+	echo "s/main/none/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail git -C local fetch 2>err &&
 
-	test_i18ngrep "fatal: remote error: unknown ref refs/heads/raster" err
+	test_i18ngrep "fatal: remote error: unknown ref refs/heads/none" err
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
-- 
gitgitgadget

