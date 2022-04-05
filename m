Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1BC3527D
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384248AbiDEVrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454961AbiDEP70 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0C14924B
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:07:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z19so11506033qtw.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzOQf8XX8yHzxzCM6w5S6DFj2cSDoEheA1mueGUqqg4=;
        b=AX473G5nj1zio41Ccb+Zt4i+8DKZSqo9QDFMY8OTmhaxsEXaQmavjEGiikDhIMgIyf
         u5738E2Gwip0UMuRDDX4HUeqhiz67NkXr3GNbnKyF90Mo0la0ICtjf3wqRs9b9/IlM/P
         RiQA5NRShy0XzJA+rDEheP8vvmXPSWi5PlYrtxFtE4laJzvkqjaFzFvl24PBhXZxSxPR
         yJ6DO79Ck/RPZmV8rRFfIZSxZINW2jYosRViHHQtfEjSRKasjMUcY4n+oDGeWcyWtls0
         ub9qbD4EJ+ALP2R3WOU9kSrUUDqv3lGf9PHNPykojwOLnszfK+wssLQxT/Q2hflUNqDf
         lXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzOQf8XX8yHzxzCM6w5S6DFj2cSDoEheA1mueGUqqg4=;
        b=hFWukoxloszIe3TvXQMc7EeyNlKvPxeFi+ju1OtFoMBS2g7SGBtXzvybugRCa0YIdg
         TZIpmEujc/x2/SZbHnFg9iJZ5bChWY3W+PyGgIb8dsbUb6nxlfX21i4q6vauu2kHPRhz
         CaCM4oX2tEQExImMaTM0k8jUw03TU7JdXDfHavhDUCVQ864cGRchFl9YjooLK+qDP6pO
         paWI6Dk24yXT9LfZoM4KvZ+mYylFujJ2zTDdFeF+0wrW8aa7ij3fETaxfzlb1Q19kspZ
         7E31vGXtNnkirq2C5xXyHgVRzmGEs4VSv5+IgVa36T03meFGyH56zispHQ2hJDBpyZhR
         6LVg==
X-Gm-Message-State: AOAM533tGBK4zfp8L1bDzlOz0wuEJZMT8ZFr0258cbrsyUTqWGGcSsGt
        fN1WTLY848z9HI7EzBqf7N0=
X-Google-Smtp-Source: ABdhPJxsu9D+s8PXkDgftAT4oaYdOUAdiZq5sDPlDQznVTwovqXY/kEio/wk5LGwzuZjmLVb9IdqtQ==
X-Received: by 2002:a05:622a:2289:b0:2eb:aabd:e554 with SMTP id ay9-20020a05622a228900b002ebaabde554mr3318215qtb.623.1649171232621;
        Tue, 05 Apr 2022 08:07:12 -0700 (PDT)
Received: from e4a2938d721e.us-east4-c.c.codatalab-user-runtimes.internal (42.11.86.34.bc.googleusercontent.com. [34.86.11.42])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm9465508qkp.110.2022.04.05.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:07:12 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
        gitster@pobox.com, khalidmasum@iut-dhaka.edu
Subject: [PATCH v4 1/1] t3501: remove test -f and stop ignoring git <cmd> exit code
Date:   Tue,  5 Apr 2022 15:06:57 +0000
Message-Id: <20220405150657.19801-2-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405150657.19801-1-khalid.masum.92@gmail.com>
References: <20220402192415.19023-1-khalid.masum.92@gmail.com>
 <20220405150657.19801-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test 'cherry-pick after renaming branch', stop checking for
the presence of a file (opos) because we are going to "grep" in it in
the same test and the lack of it will be noticed as a failure anyway.

In the test 'revert after renaming branch', instead of allowing any
random contents as long as a known phrase is not there in it, we can
expect the exact outcome---after the successful revert of "added", the
contents of file "spoo" should become identical to what was in file
"oops" in the "initial" commit. This test also contains 'test -f' that
verifies presence of a file, but we have a helper function to do the same
thing. Replace it with appropriate helper function 'test_path_is_file'
for better readability and better error messages.

In both tests, we will not notice when "git rev-parse" starts segfaulting
without emitting any output.  The 'test' command will end up being just
"test =", which yields success. Use the 'test_cmp_rev' helper to make
sure we will notice such a breakage.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8617efaaf1..9eb19204ac 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -66,8 +66,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
-	test -f opos &&
+	test_cmp_rev rename2 HEAD^ &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
@@ -77,9 +76,9 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
-	test -f spoo &&
-	! grep "Add extra line at the end" spoo &&
+	test_cmp_rev rename1 HEAD^ &&
+	test_path_is_file spoo &&
+	test_cmp_rev initial:oops HEAD:spoo &&
 	git reflog -1 | grep revert
 
 '
-- 
2.35.1.windows.2

