Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F27C1F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 17:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdG1RSc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 13:18:32 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35354 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdG1RS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 13:18:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id e75so19894501pfj.2
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fo+LX4EPT4yr9cXlvH2U897TjGx52u7ENrNnH3bVQPM=;
        b=f8M3qev4IfcEa2yDn/czrRiUW3Rs934j4ibXA5zHRc5d6idwY2BIMy9DEIYIfxsYil
         lgKgjvhurPebluWhIQyZUTCJDnp3XE0+OlHCZOQZTshWQsgUNTVH+dGpn/puuZrOKCUF
         sM3jRCzz4as43NY9N5qNEa9Vfbr1lbA4H/Jv+0d6GfRMLrlobZnaEc+D/28v5MsLKIRU
         +0HTe+Ie5eMcCgFhE0vtw+gA8sU96/ExoSSNg4piZBrjb7qzo+1cbuae6apwlTcNdrlv
         SBWLsNnHJRz7MsN38F7Y+QwsmY35yXxLW4YJ9q0M+XnQuKJgYV4GkPf8qNyfR3u0AsE7
         oXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fo+LX4EPT4yr9cXlvH2U897TjGx52u7ENrNnH3bVQPM=;
        b=jTY5EyTd/sXuJ6r2CTvEBGAlm4V7/AJ75+2w5iBBCBGBwxa6UwYl2gKoPTqsQSHBBR
         0+yu1NgxgDQL9YWzCaQkD3AO9mnDQE7e86pPnkcqFN4OvHKAMY6D1LACif+kDoDGGJT1
         W9wLu/GCfs7+GkiaJb/XaQPxq8SxQmG4+8yerSW29/GT0q4Qpc29thQB/yB6AImGiu7U
         g7zgcOdycVPzKu8auSN3Y/kBdZmHqEs5rFtXGKbkjc9zqbGiZaBePyTdVSF/ArmY/5in
         /bgUl8+zdn0b1OMEcdSxKt7AwhBcO8bhumePilCZLpU96wBFp1kCrL44xEl1ius8e4tR
         VMOA==
X-Gm-Message-State: AIVw110ONt4fh3xSgCwUobwwaWvj6yg4TZEj1J6D6x/YtG1y2pZ5xQ8t
        8hJ1etT2J77li51lwX4Qrw==
X-Received: by 10.99.125.11 with SMTP id y11mr8140187pgc.19.1501262308752;
        Fri, 28 Jul 2017 10:18:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d9da:4cf2:5968:beb4])
        by smtp.gmail.com with ESMTPSA id z74sm44934487pfd.112.2017.07.28.10.18.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 10:18:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] t6500: mark tests as SHA1 reliant
Date:   Fri, 28 Jul 2017 10:18:17 -0700
Message-Id: <20170728171817.21458-3-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170728171817.21458-1-sbeller@google.com>
References: <20170728171817.21458-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first test marked relies on hard coded sha1:

	# We need to create two object whose sha1s start with 17
	# since this is what git gc counts.  As it happens, these
	# two blobs will do so.
	test_commit 263 &&
	test_commit 410 &&

The next two seem to rely on state from the first one, I did not
investigate.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t6500-gc.sh | 6 +++---
 t/test-lib.sh | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 41b0be575d..3900baa01d 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,7 +43,7 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
-test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
+test_expect_success SHA1 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
 	test_config pack.writebitmaps true &&
@@ -77,7 +77,7 @@ run_and_wait_for_auto_gc () {
 	doesnt_matter=$(git gc --auto 9>&1)
 }
 
-test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
+test_expect_success SHA1 'background auto gc does not run if gc.log is present and recent but does if it is old' '
 	test_commit foo &&
 	test_commit bar &&
 	git repack &&
@@ -95,7 +95,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_line_count = 1 packs
 '
 
-test_expect_success 'background auto gc respects lock for all operations' '
+test_expect_success SHA1 'background auto gc respects lock for all operations' '
 	# make sure we run a background auto-gc
 	test_commit make-pack &&
 	git repack &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b6e53f78a..a5a54c6d4a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1127,6 +1127,10 @@ test_lazy_prereq JGIT '
 	type jgit
 '
 
+test_lazy_prereq SHA1 '
+	false
+'
+
 # SANITY is about "can you correctly predict what the filesystem would
 # do by only looking at the permission bits of the files and
 # directories?"  A typical example of !SANITY is running the test
-- 
2.14.0.rc0.3.g6c2e499285

