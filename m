Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D0AC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjDEPW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbjDEPWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:22:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0210C
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:22:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso1404327wmr.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680708138;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5lAsHxiPtzDOgRVdktANkgd3YPKlifh0fx5+z4WUY8w=;
        b=n0ToebiclT3FS3JUYNZkcc5jbU7AEEf2XnA56krwWmZj8ROr2RHRFp6mg0I4Benu7/
         TV6TRj/lSXuA8uzfcNbfT8eFHz3sAiOAxzkCT6ERbo6OOWhx/fDycFRXK50IOj/8jRni
         1cbZbo3zfODjSrmYnvFH4Uz4R5Pzrgwdyd3EnaPXaiZ7NitcGH6pOYq/HjrHTuxYE7bL
         vENt+8WiHEYAq5Ha7vc6JXBCDk/iUWlAUXuW7eDRCbootqdjr9JDtGAXapcxfIsHQ2xm
         tbEdkaNi3D3kXYGILz4TSVZGy9v2drD6GKgscI7buIU2lo16FpzUx8nuau5QRGwaRxOq
         m5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708138;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lAsHxiPtzDOgRVdktANkgd3YPKlifh0fx5+z4WUY8w=;
        b=q0iBjAwJGtWMksjylCub3dzJao9+6Kn7F8g9ElqRTVlbC09YPpDC2GS411I8NdR71x
         q8NFYp/QBqKUvG9KKBD6uBirNnvQdDWJknVCkiADY4VCX7P18EbuYhshfnsEcfV/EN+7
         eN2gy7nmWZ+I0U6af50CnXihfruLP4Jsv3AMUGdoS8RVCDDV9627GXWyn3n+MCCfClwD
         j8vOrxsyjSsUOZu0uJdcKffxOi0OhgBbpxb9+DqA77jd6dv8vSPiH36AT0IJ5Hk+TuX7
         MsQEy3w/S64CCK1pjwyYjIyhvclf4k1oUUuL7SKG2Mx/xp5FGcqvbHiJllMfU7B3oTwd
         7q0w==
X-Gm-Message-State: AAQBX9e/l6vOHq73t5PJwb9MjDuShRE8/cMUIYOMGKNcZVVHaRyYe+4q
        h+RnldDlHq6cR/H2EyeLrRvG12Te6Ro=
X-Google-Smtp-Source: AKy350a3Yqkc1jSXbg7tS4+sGfwe6G7Q+dusQ7xqMKgu76phCsMZo6+3+5aop8TfyEZQkTTB5vldvw==
X-Received: by 2002:a7b:ca54:0:b0:3f0:3c2:3fa4 with SMTP id m20-20020a7bca54000000b003f003c23fa4mr5080805wml.12.1680708137885;
        Wed, 05 Apr 2023 08:22:17 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm2515610wmj.4.2023.04.05.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:22:17 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 5/5] rebase: remove a couple of redundant strategy tests
Date:   Wed,  5 Apr 2023 16:21:48 +0100
Message-Id: <3515c31b40e171018e8288220765ca6f0725a17f.1680708043.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680708043.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove a test in t3402 that has been redundant ever since 80ff47957b
(rebase: remember strategy and strategy options, 2011-02-06).  That
commit added a new test, the first part of which (as noted in the old
commit message) duplicated an existing test.

Also remove a test t3418 that has been redundant since the merge backend
was removed in 68aa495b59 (rebase: implement --merge via the interactive
machinery, 2018-12-11), since it now tests the same code paths as the
preceding test.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3402-rebase-merge.sh    | 21 ---------------------
 t/t3418-rebase-continue.sh | 32 --------------------------------
 2 files changed, 53 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7e46f4ca85..79b0640c00 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
-test_expect_success 'rebase -s funny -Xopt' '
-	test_when_finished "rm -fr test-bin funny.was.run" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	git reset --hard &&
-	git checkout -b test-funny main^ &&
-	test_commit funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase -s funny -Xopt main
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git checkout second-side  &&
 	tr "[A-Z]" "[a-z]" <newfile >tmp &&
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 42c3954125..2d0789e554 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --continue handles merge strategy and options' '
-	rm -fr .git/rebase-* &&
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$@" >>funny.args
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	case "\$2" in --foo) ;; *) exit 2 ;; esac
-	case "\$4" in --) ;; *) exit 2 ;; esac
-	shift 2 &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
-	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
-	echo "Resolved" >F2 &&
-	git add F2 &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase --continue
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase -r passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.40.0.670.g64ef305212.dirty

