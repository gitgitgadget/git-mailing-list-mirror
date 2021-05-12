Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF09C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36D6613C9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhELIqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhELIqS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:46:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6CFC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so22765328wrx.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wh7P7AR4jRhgPXq0zC3n8dfYSAFiMdgcPiNVoXXDKus=;
        b=mqFI2M5WYUPrUsqaXqfL7PxrYnW/3AUL3bHOU7TD0aGLmNFQM9dHS/sq6PhgDwKXfM
         gFcbte1W1XSIWoBmyWLb6+ZsP/YxlBC56BtZEgZdOmssyrBPf7nyo5n1N8HuZUsmQaQG
         4GR9J84uu7YShdaCLqTIXjNeosAgd5VZ4kLCr4muGYrYp1Pspy7IIoYqWqrCm3rnOVyl
         mdnT19m06KJ3d/QmFDRVmhqdsMQBKP5qXNHW6O4B2TJfixtTcLvdoFbgZJqTD2BDqWEI
         p3KxuWzdMeD5hl5nujLGz19cI4KVBq/M7uWXvTcMqIhrnwfM0Mlm0vhDD+iA3etMuEJs
         FYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wh7P7AR4jRhgPXq0zC3n8dfYSAFiMdgcPiNVoXXDKus=;
        b=Bu9Stgx/RoCgYTcHtdGZT0C0u39uSrXSTTWAr07qbciUTm/BLwlVgnB3dpwxxIV+Eb
         ptQ51WWwRbssMEe96WQw+JpN2wJ+BqBg4r7NMXec+vOJUvKUGLE+2SZUnkGLRyihSqH2
         MWJ+cHNLkCh5gATWyNcs2100M7YUB6ojuXM0SlMj8WU0iGmGUCC0Vs8aanMwMbPkWXpy
         lSgBMpUpDIALhfyT5SOtmUVAZhuonxIE5ewRnDGWhWmvKwNL1dnCQbjwvySYH/cRQwjF
         eGhuvBpy7wQRFknhQhkVfdjoHYX/fc/50JQE1efjvFn5u5gcWspBYyn0xMhWSsoviOjG
         HoNg==
X-Gm-Message-State: AOAM532SlXOgoTtNg5IujwEojbgCvTTdCxtAepHCjnwNuaN+NIZe478F
        XfDhtqfrXxnocn/slRkCxOhCpUZnWFRzRQ==
X-Google-Smtp-Source: ABdhPJyvNgvt0kB2GlPGegjWXOX7XMNN0wfYKd+Ex+IaImXRxmEdXTr/yKamE/SrvDflar1zwu1H4A==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr43839628wrn.132.1620809109508;
        Wed, 12 May 2021 01:45:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p17sm30284051wru.1.2021.05.12.01.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:45:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] SubmittingPatches: replace discussion of Travis with GitHub Actions
Date:   Wed, 12 May 2021 10:45:01 +0200
Message-Id: <patch-2.3-7add00cc87-20210512T084137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
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
 Documentation/SubmittingPatches | 44 ++++++++++++---------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2643062624..2aa217da9c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -74,10 +74,9 @@ the feature triggers the new behavior when it should, and to show the
 feature does not trigger when it shouldn't.  After any code change, make
 sure that the entire test suite passes.
 
-If you have an account at GitHub (and you can get one for free to work
-on open source projects), you can use their Travis CI integration to
-test your changes on Linux, Mac (and hopefully soon Windows).  See
-GitHub-Travis CI hints section for details.
+If you have an account at GitHub pushing to a fork of
+https://github.com/git/git will use their CI integration to test your
+changes on Linux, Mac and Windows. See the GitHub CI section for details.
 
 Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
@@ -451,12 +450,12 @@ their trees themselves.
   the status of various proposed changes.
 
 [[travis]]
-== GitHub-Travis CI hints
+== GitHub CI
 
-With an account at GitHub (you can get one for free to work on open
-source projects), you can use Travis CI to test your changes on Linux,
-Mac (and hopefully soon Windows).  You can find a successful example
-test build here: https://travis-ci.org/git/git/builds/120473209
+With an account at GitHub you can use GitHub CI to test your changes
+on Linux, Mac and Windows. See
+https://github.com/git/git/actions/workflows/main.yml for examples of
+recent CI runs.
 
 Follow these steps for the initial setup:
 
@@ -464,31 +463,20 @@ Follow these steps for the initial setup:
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
 . Enable Travis CI builds for your Git fork.
 
 After the initial setup, Travis CI will run whenever you push new changes
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
+Then fix the problem and push your fix to your Github fork. This will
+trigger a new CI build to ensure all tests pass.
 
 [[mua]]
 == MUA specific hints
-- 
2.31.1.909.g789bb6d90e

