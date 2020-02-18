Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70563C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 22:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422A0207FD
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 22:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOGaHR+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRWPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:15:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46731 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRWPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 17:15:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so25828584wrl.13
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nGTLmIRHKFRdGf1szSBOq2Q9NqK92BGoCEG86gmWc9Y=;
        b=qOGaHR+3LnNxSWHVpUA8FqSPGBOJRn1FVM+PlUhs0ctI02Ap4u7PrFRrez12OG4iF0
         +3gnFIqk8LlDG0ZSuYafzWFl1xZtqxY9bNAM1ndWF05RezmsRW9mchbBbaZApDsL6Oor
         hDaoW4/M1+VLTmiLFy4ecVuGmHiRo/6Jhc2w9UQrBtYLDGJRTySKmxz0B6SkXNQwoh5F
         P+OETXf4nyskzlUPkOibcfH4/+fB61hWjnLhpw1fRNrz3Yna3JoR0AQSD7y8XEe/oQ4f
         dV8+pTfmErTA6A/FRm/bRgGhfomNVOI18h01yyl+5PJ08zG1hmOB4WpqhnPalwFIrCC6
         QEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nGTLmIRHKFRdGf1szSBOq2Q9NqK92BGoCEG86gmWc9Y=;
        b=rLrTNXeXXOaMWULhhA+iyrv8n5whnAdmn8MSqeUzrzba4YKpO+pjr1Y0QxSUSyiZMf
         nLss1qIUn31VklS0gMm+oI2e3Db5W4m572xjTOfjlGjBk/PsLoGr9DafWeFji40ZbAJq
         sVpMlwLrxqnkFiFeUP4+gYtsMzj0ZqTreI52CmNcjMD4bgYufVDWHWS7dACWKQTQ5xD0
         z3UJqZalQRXYtD12B9Z4DDyFdtshPqEZEPKzCS3Wzd6+ZLmPgIyDrMho0aNyHS4jg4T/
         HJcI7MCbNvISW2wS2o5eun8UzjcS15u3uBEgSVZlZqTdesfmQ7kNAezkQa0cC1PGJhdr
         aNfQ==
X-Gm-Message-State: APjAAAXwenzwtd9MGGenC5rYc4yxe+lZNhc4ZujOvp1L+I7h6XlZ5CPr
        /CbqxMrYcTy9tRF0OexZAb39JRvz
X-Google-Smtp-Source: APXvYqxz3koZJqM2FoHhYscFgQ/tlFbo7RMlIWo0XaP6K53Z1VO7kL5p3qJwsrAOL+RtfuspQ0+D1g==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr30038638wrp.238.1582064106963;
        Tue, 18 Feb 2020 14:15:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm61298wra.83.2020.02.18.14.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:15:06 -0800 (PST)
Message-Id: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com>
References: <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 22:15:05 +0000
Subject: [PATCH v3] t3433: new rebase testcase documenting a stat-dirty-like
 failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A user discovered a case where they had a stack of 20 simple commits to
rebase, and the rebase would succeed in picking the first commit and
then error out with a pair of "Could not execute the todo command" and
"Your local changes to the following files would be overwritten by
merge" messages.

Their steps actually made use of the -i flag, but I switched it over to
-m to make it simpler to trigger the bug.  With that flag, it bisects
back to commit 68aa495b590d (rebase: implement --merge via the
interactive machinery, 2018-12-11), but that's misleading.  If you
change the -m flag to --keep-empty, then the problem persists and will
bisect back to 356ee4659bb5 (sequencer: try to commit without forking
'git commit', 2017-11-24)

After playing with the testcase for a bit, I discovered that added
--exec "sleep 1" to the command line makes the rebase succeed, making me
suspect there is some kind of discard and reloading of caches that lead
us to believe that something is stat dirty, but I didn't succeed in
digging any further than that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t3433: new rebase testcase documenting a stat-dirty-like failure
    
    Rename to t3433 to avoid having two t3424 tests.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v3
Pull-Request: https://github.com/git/git/pull/712

Range-diff vs v2:

 1:  09085292596 ! 1:  270591cd3be t3424: new rebase testcase documenting a stat-dirty-like failure
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    t3424: new rebase testcase documenting a stat-dirty-like failure
     +    t3433: new rebase testcase documenting a stat-dirty-like failure
      
          A user discovered a case where they had a stack of 20 simple commits to
          rebase, and the rebase would succeed in picking the first commit and
     @@ -24,10 +24,10 @@
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
     + diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
       new file mode 100755
       --- /dev/null
     - +++ b/t/t3424-rebase-across-mode-change.sh
     + +++ b/t/t3433-rebase-across-mode-change.sh
      @@
      +#!/bin/sh
      +


 t/t3433-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t3433-rebase-across-mode-change.sh

diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
new file mode 100755
index 00000000000..f11fc35c3ee
--- /dev/null
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='git rebase across mode change'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir DS &&
+	>DS/whatever &&
+	git add DS &&
+	git commit -m base &&
+
+	git branch side1 &&
+	git branch side2 &&
+
+	git checkout side1 &&
+	git rm -rf DS &&
+	test_ln_s_add unrelated DS &&
+	git commit -m side1 &&
+
+	git checkout side2 &&
+	>unrelated &&
+	git add unrelated &&
+	git commit -m commit1 &&
+
+	echo >>unrelated &&
+	git commit -am commit2
+'
+
+test_expect_success 'rebase changes with the apply backend' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b apply-backend side2 &&
+	git rebase side1
+'
+
+test_expect_failure 'rebase changes with the merge backend' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b merge-backend side2 &&
+	git rebase -m side1
+'
+
+test_expect_success 'rebase changes with the merge backend with a delay' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b merge-delay-backend side2 &&
+	git rebase -m --exec "sleep 1" side1
+'
+
+test_done

base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
-- 
gitgitgadget
