Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484DC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E706128D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhGVLbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhGVLa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:30:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097EBC061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f17so5684591wrt.6
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBkwGxUBFXi0fdj7/tUasfhzg4iY87ZsmWY71cU2HE8=;
        b=JClTYwVWmJM0hQbG2gfpLO2y26yVCGZ3aTSdTltY+h1BnOHWo40cCA5aVpHfDXvfl6
         zgIKygVmnfujmdyqmbbow0Rb4HC4cmDblLpaEJ5bqTY/nUaMh6ILcTsV/cN1+CodWCVc
         Cqzg0kw5sgCFeKqbxmqWpuCQN82XtvHDH1hA39DmpGSWfA7Z3wKmTziXayauQJ9s7Tpg
         DrE3t6Pp7Jgb/v8ir5Z2n23NpJbYkUpUqhK/QRhPYzkTor4RQdjBnpZ6YHETWbIBHWmF
         dgYYclxmnpHRCyzJcUOVikycYW57rR/BziCmByNe/m24LHOf7slABLd9snrz3bC03Jfp
         JhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBkwGxUBFXi0fdj7/tUasfhzg4iY87ZsmWY71cU2HE8=;
        b=fBeb1xGkbDAXFrZMXJbhXVgTElyDYT7XUb04Y0RfNpNctU0ko0bWE1OvOB73e8/roK
         NRER9U6pFwlL3DnyWNoUaZSZNy3600iqU++3Mui0Zc4dzghHrtr+GL/LoMUEn+m1sn0W
         T7W5H4mhECSmtKH/hPKER9SRfieCpP6W49iL7i9X3jJXfXU/3PlbLnMGti/UpctSR8RH
         cQcSesfbu4guvlzgYveG64dPBZ7BLhpV6SJkrYy1fQuJ65nw+Hqcydrd5zNoIyGIhzFD
         iOUTBDrv7F6/95wKFWbbjEzQCuhM3ACj+EHgiYhFJZmXzLeK1SaCmNAAPi94Y1zwZuXw
         Sweg==
X-Gm-Message-State: AOAM531HHr9q1KGLga1Yns3/fSTfuvaM8yH+l5jCFNl8UNctF2VEQSDn
        Fa1r7wvlIQkhHQo8y2Q122BO50Xgv6rZcg==
X-Google-Smtp-Source: ABdhPJwmH9QPsQlKAfbqQqz5rGnZ50K0xtunLiGsF8iru/xgURb0M3aVyo//Dj8fyT5oB03NQsoouw==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr47945020wrq.350.1626955888315;
        Thu, 22 Jul 2021 05:11:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k24sm30964130wrh.30.2021.07.22.05.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:11:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] SubmittingPatches: replace discussion of Travis with GitHub Actions
Date:   Thu, 22 Jul 2021 14:11:24 +0200
Message-Id: <patch-2.2-ecb9924a6a-20210722T120746Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com> <cover-0.2-0000000000-20210722T120746Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the discussion of Travis CI added in
0e5d028a7a0 (Documentation: add setup instructions for Travis CI,
2016-05-02) with something that covers the GitHub Actions added in
889cacb6897 (ci: configure GitHub Actions for CI/PR, 2020-04-11).

The setup is trivial compared to using Travis, and it even works on
Windows (that "hopefully soon" comment was probably out-of-date on
Travis as well).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 49 ++++++++++++---------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 07e2073155..e409022d93 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -74,10 +74,9 @@ the feature triggers the new behavior when it should, and to show the
 feature does not trigger when it shouldn't.  After any code change, make
 sure that the entire test suite passes.
 
-If you have an account at GitHub (and you can get one for free to work
-on open source projects), you can use their Travis CI integration to
-test your changes on Linux, Mac (and hopefully soon Windows).  See
-GitHub-Travis CI hints section for details.
+Pushing to a fork of https://github.com/git/git will use their CI
+integration to test your changes on Linux, Mac and Windows. See the
+<<GHCI,GitHub CI>> section for details.
 
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
@@ -449,13 +448,12 @@ their trees themselves.
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
-[[travis]]
-== GitHub-Travis CI hints
+== GitHub CI[[GHCI]]]
 
-With an account at GitHub (you can get one for free to work on open
-source projects), you can use Travis CI to test your changes on Linux,
-Mac (and hopefully soon Windows).  You can find a successful example
-test build here: https://travis-ci.org/git/git/builds/120473209
+With an account at GitHub, you can use GitHub CI to test your changes
+on Linux, Mac and Windows. See
+https://github.com/git/git/actions/workflows/main.yml for examples of
+recent CI runs.
 
 Follow these steps for the initial setup:
 
@@ -463,31 +461,18 @@ Follow these steps for the initial setup:
   You can find detailed instructions how to fork here:
   https://help.github.com/articles/fork-a-repo/
 
-. Open the Travis CI website: https://travis-ci.org
-
-. Press the "Sign in with GitHub" button.
-
-. Grant Travis CI permissions to access your GitHub account.
-  You can find more information about the required permissions here:
-  https://docs.travis-ci.com/user/github-oauth-scopes
-
-. Open your Travis CI profile page: https://travis-ci.org/profile
-
-. Enable Travis CI builds for your Git fork.
-
-After the initial setup, Travis CI will run whenever you push new changes
+After the initial setup, CI will run whenever you push new changes
 to your fork of Git on GitHub.  You can monitor the test state of all your
-branches here: https://travis-ci.org/__<Your GitHub handle>__/git/branches
+branches here: https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml
 
 If a branch did not pass all test cases then it is marked with a red
-cross.  In that case you can click on the failing Travis CI job and
-scroll all the way down in the log.  Find the line "<-- Click here to see
-detailed test output!" and click on the triangle next to the log line
-number to expand the detailed test output.  Here is such a failing
-example: https://travis-ci.org/git/git/jobs/122676187
-
-Fix the problem and push your fix to your Git fork.  This will trigger
-a new Travis CI build to ensure all tests pass.
+cross. In that case you can click on the failing job and navigate to
+"ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
+can also download "Artifacts" which are tarred (or zipped) archives
+with test data relevant for debugging.
+
+Then fix the problem and push your fix to your GitHub fork. This will
+trigger a new CI build to ensure all tests pass.
 
 [[mua]]
 == MUA specific hints
-- 
2.32.0.957.gd9e39d72fe6

