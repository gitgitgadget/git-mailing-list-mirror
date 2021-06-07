Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABBC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524EB60FDA
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFGLGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:06:41 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33670 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhFGLGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:06:39 -0400
Received: by mail-wm1-f53.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so3764089wme.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WLFlAoWX5DnehMjif+1dJmB0MG3/InglUgDCi/3xyo=;
        b=n43YcWmFA4CD4H6A+1HXuy8YBPB+WJgl+FHQ5LYAUNHuEsgA2CPOyWQVLBDQk9v5I+
         NxM2QsK0ID6/r0t7VKcA9Or2YjTRWzizLkdtDaZmKobqyh8xF0PGtg82R0Bpf9ikwClg
         qm26THmdKdF+efgEXl7M+Idtzq2r+Z5ofgiRwNCA1UITc4JSamwZTjtOAy3Pe6PhVpOW
         ow75WsjSyWWuHKDgMH0XgzTF8ac2J9ItUC9iRDBlFdFErhf2RS1wMVhldQw0hAVmsxJ7
         91s8KC/BCuwpj0mAZAwaPza0NuFhHq7PURoqB+nogUlVQPKFBASvvPLW7xcVc+vW81bm
         jfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WLFlAoWX5DnehMjif+1dJmB0MG3/InglUgDCi/3xyo=;
        b=nLUmJUHxR8kUN6Sv9IBsQo5v6U5IHcPT0FXr6OWDgLs/Vk/470A3Gf09jeH2RBd0jM
         sEOVeafRjH23XP9psRnfs0Aa+9X2rV0MMxtE8WeA2isbu2AuCkbFqBd+m+LkWa0ZpZeD
         fApxh06oh4H4cS2LljoOo52IAsmMdMluirNgCCpNOnKGskgDoAKKX7xUUouP6gtCiSWU
         NK8ldei42r0aL8L0KfKpjwJAJrlvGrSCDKbH13oRR26nDa935j3iiKt4K0ElYP93Z4k/
         0r89Q1Iz/Sf6nTOI9tjq3UDTTF6kaV4g6h5m6gj8fDeeOJ3dlGv3OrqWUKT7UAe4lqLF
         qMJw==
X-Gm-Message-State: AOAM530aRsPtzc3/QOBgvUd5fDP3A83GkIQdBvYU7sRmmD0sU23ynf6v
        z9QbDxEhfOkQvId37HsUTkmNWMhpLN1bDA==
X-Google-Smtp-Source: ABdhPJyDofltYY4K9htxQCGlcja7JETHw+RSz9YtoprvZICGSzsaD1IB1n44WpdHkxKey8NSNhcabA==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr17084199wmh.48.1623063827914;
        Mon, 07 Jun 2021 04:03:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c64sm17230575wma.15.2021.06.07.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:03:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] SubmittingPatches: replace discussion of Travis with GitHub Actions
Date:   Mon,  7 Jun 2021 13:03:42 +0200
Message-Id: <patch-2.3-7d5d2854e3-20210607T110044Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com> <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
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
index 2643062624..e372d17673 100644
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
+GitHub CI section for details.
 
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
+With an account at GitHub, you can use GitHub CI to test your changes
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
+Then fix the problem and push your fix to your GitHub fork. This will
+trigger a new CI build to ensure all tests pass.
 
 [[mua]]
 == MUA specific hints
-- 
2.32.0.rc3.434.gd8aed1f08a7

