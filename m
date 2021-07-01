Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E79C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5431A61403
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhGAOun (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGAOuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0AC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g7so8563333wri.7
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qmpK0v+kMbY8lqE5mMlTf3cnnNqYbVpa6kPQCWVcF8=;
        b=goHvE+zwCO8wMxC/gXVhWvNBnzLdsfZZfwTdclzQHQZ41hkvSjqsinDICMIWXdp8Nv
         FAAHNppZ1VAkmLKTUzQnvvQzzPC8iLhtpqGa8YPjjZKcQgWk/bzDsPJusrblk6GgjQIZ
         X2DybOsVe8wPf1qfRYv+l4aDw0KfaTdCyshtsKc1KcjrcNjF+bv/EpBa7HX2CQNvgrLj
         b+TwocJD9Li1B4SCDmrXzFUMvHye3lJ9T9aLLED7AAyPe0IqD+dN+NjBA0/Bm1dxPiNq
         WKjAvhWt5ZHRpzYqiCFZxzJ/OnhJcD7KgFetZLQmgED03pol1XWUFVmov50xQbuFoOFW
         /alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qmpK0v+kMbY8lqE5mMlTf3cnnNqYbVpa6kPQCWVcF8=;
        b=lad21nJHZvF9OtI01L3Nsm1t/Mdh7RxSqHaOqYOzWg9xTWnj9uIIdFdyz2kS/npe79
         m0NdEaC154ASDMmA9svTNjHV8dkhkiY3ta4K3MT1JEOTfHh8PSNNT5KuSZeaZQNIXBdK
         7zqVROzTBGxU7zPs3CZsAwLGgTVjEqly+QOSsVf3OFcD52BK4HDawx4P4CkeBA9V2z/g
         1hqzCdAnWScwIMWj8YjBPMao4d9HM6+eIAA6efABAA+Cao0X12ZjKXzPEs210ASPg9fr
         avLSDIP9SELPtq8NS13lnhnj4t5zsDv9+Gn2UNco3DFGpB+qqQeKj1mOHPYyiKMbTaeB
         GEGA==
X-Gm-Message-State: AOAM532SXM4x3w5pmQIE06cJsF9cA0JTlOt+QQqLfpCFRVJKMMyJnAqB
        PnEHws9HWj0/nrk7ZyUUxUSJJfVb+Yw=
X-Google-Smtp-Source: ABdhPJyZb66uAd75G4HIyLWHJWLGN4OT5YYGGb6Bk2YkCEqJ1LdfwL19k/QpvcAE94uMrNf5pWHF/Q==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr45529386wrv.423.1625150879584;
        Thu, 01 Jul 2021 07:47:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20sm9719761wms.3.2021.07.01.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:59 -0700 (PDT)
Message-Id: <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:34 +0000
Subject: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool touch"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change p7519 to use a single "test-tool touch" command to update
the mtime on a series of (thousands) files instead of invoking
thousands of commands to update a single file.

This is primarily for Windows where process creation is so
very slow and reduces the test run time by minutes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5eb5044a103..f74e6014a0a 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+	test-tool touch sequence --pattern="10_files/%d" --start=1 --count=10 &&
+	test-tool touch sequence --pattern="100_files/%d" --start=1 --count=100 &&
+	test-tool touch sequence --pattern="1000_files/%d" --start=1 --count=1000 &&
+	test-tool touch sequence --pattern="10000_files/%d" --start=1 --count=10000 &&
+
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
@@ -200,15 +201,12 @@ test_fsmonitor_suite() {
 	# Update the mtimes on upto 100k files to make status think
 	# that they are dirty.  For simplicity, omit any files with
 	# LFs (i.e. anything that ls-files thinks it needs to dquote).
-	# Then fully backslash-quote the paths to capture any
-	# whitespace so that they pass thru xargs properly.
 	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			sed '\''s/\(.\)/\\\1/g'\'' | \
-			xargs test-tool chmtime -300 &&
+			test-tool touch stdin &&
 		git status
 	'
 
-- 
gitgitgadget

