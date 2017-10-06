Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFDCF20373
	for <e@80x24.org>; Fri,  6 Oct 2017 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdJFTAM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:00:12 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:47894 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFTAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:00:11 -0400
Received: by mail-pf0-f171.google.com with SMTP id z11so31490pfk.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AebHWA3mED5uwl7e2Ny/80SUOF2yoM4o5Fa8o3yuymw=;
        b=FCUlXsrDrfN01EQX2CxChWShPDzaSUMJjJK1jTKKUJKT55VDfGb0DVwy3+NOvoKRzl
         zA5P9zsxC+tfA5kO4ZuhbHx+UUMerOe6hkJK418EnIPhF1gaR0nf2go6NtiGhxRt1caK
         8YZDkzQuir5gGAx/bvzPKB+oWK9N4S3T2LziWYMpjL29gvjIE84G2yk8UXJdO6kueHO6
         A07E77qgj9Rsq/YNcB4jQQvaha/Fke9jFSbNPSlYBj9yO5IlP3LkJTMCq7bW4ixfx4pj
         YQCfaqPRSyGWl7qVlrG0OXcOt+ae+zhwiytdnjgN4hMDM7z45f7LsK/tfr/77BH8rzL3
         zD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AebHWA3mED5uwl7e2Ny/80SUOF2yoM4o5Fa8o3yuymw=;
        b=hKLSf4SdRo4bHGEtxqgvthm+a5PWcfqhCbYIPPjMnsIoel+WxjKhK5rHTaBX1trT2g
         nByovmwBang2fcXgD4R3V4EIFL+f6NI+hHwyU13Kytwufr3Z8tYisOvQQ277nnTRcOv8
         gLARR+91Utz+b0+igbFHfgjwMXnwklkEpJDssr4nlVwQYgdG4X3bw9h3bZ+H/rwp+QeD
         sfunt3RE8pUElXc6zPf3TFIhUtaKnXW37Gzs8t5jtA/0rOtnTpjMmFI/PALz9OgXa6ny
         j8NxM8gnL0vG6ALvCDbMeO4Nsb5kYFbEEz+XtNlp3VpWP8jq0Uip1mWsibGNx7QxkR6o
         pxuw==
X-Gm-Message-State: AMCzsaWLsm4C8wALLO+e9O5Aimq0Dl9RnOTnQPHXIruVJ7beKvzUcQfm
        cFT2j5odx+XO3kB3SQlGLGcLsicU6A8=
X-Google-Smtp-Source: AOwi7QBRyaWE8fU9Znl8NCC9JRrvjglc1S2bWRP3WGKIf1G+U2xu+AnEqAx8BYN3nJOeiZXZaYyMOg==
X-Received: by 10.99.3.21 with SMTP id 21mr2730091pgd.77.1507316410454;
        Fri, 06 Oct 2017 12:00:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:fd93:ec9c:aa89:eb86])
        by smtp.gmail.com with ESMTPSA id i84sm4724070pfj.105.2017.10.06.12.00.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 12:00:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] tests: use shell negation instead of test_must_fail for test_cmp
Date:   Fri,  6 Oct 2017 12:00:05 -0700
Message-Id: <20171006190006.19623-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `test_must_fail` should only be used to indicate a git command is
failing. `test_cmp` is not a git command, such that it doesn't need the
special treatment of `test_must_fail` (which e.g. includes checking for
segfault)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3504-cherry-pick-rerere.sh         | 2 +-
 t/t5512-ls-remote.sh                  | 2 +-
 t/t5612-clone-refspec.sh              | 2 +-
 t/t7508-status.sh                     | 2 +-
 t/t9164-git-svn-dcommit-concurrent.sh | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index a267b2d144..c31141c471 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -95,7 +95,7 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
 	test_must_fail git cherry-pick master &&
-	test_must_fail test_cmp expect foo
+	! test_cmp expect foo
 '
 
 test_done
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 02106c9226..7178b917ce 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -56,7 +56,7 @@ test_expect_success 'use "origin" when no remote specified' '
 
 test_expect_success 'suppress "From <url>" with -q' '
 	git ls-remote -q 2>actual_err &&
-	test_must_fail test_cmp exp_err actual_err
+	! test_cmp exp_err actual_err
 '
 
 test_expect_success 'use branch.<name>.remote if possible' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index fac5a73851..5f9ad51929 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -87,7 +87,7 @@ test_expect_success 'by default no tags will be kept updated' '
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-	test_must_fail test_cmp expect actual &&
+	! test_cmp expect actual &&
 	test_line_count = 2 actual
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 93f162a4f7..1644866571 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1532,7 +1532,7 @@ test_expect_success '"status.branch=true" same as "-b"' '
 test_expect_success '"status.branch=true" different from "--no-branch"' '
 	git status -s --no-branch  >expected_nobranch &&
 	git -c status.branch=true status -s >actual &&
-	test_must_fail test_cmp expected_nobranch actual
+	! test_cmp expected_nobranch actual
 '
 
 test_expect_success '"status.branch=true" weaker than "--no-branch"' '
diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
index d8464d4218..5cd6b40432 100755
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
 
-- 
2.14.0.rc0.3.g6c2e499285

