Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34FC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1560D20735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5CYR5OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgEEQ07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgEEQ0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:26:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7AC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:26:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so844604plt.5
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETYopeI48Fh/Ezq2vKjx51hu3dX5j7POpPAXPv1OpTA=;
        b=u5CYR5OVahD7ycvMccOdzqNJA1ow5511QsestRP5rmrFAvL9Su89kEis29NFvZEef/
         Sad7KxIguJfGhuIWTq5nDuvfghKhKFw1b5s3JUWxILsvTvnPuBqD7pfBuhDyeFvSrsQ5
         /MnymBFY1WuiAALFQGMDTxns3siV8fEsI3sbD2P6n4K+XpgrI+dNAMEq7U3ILUBtbott
         ySovzhU6k91/O75CbJ3bx3T8Gg/FymvoCYXoUst9TCPCoASyK1OQnb/J9OQbSbdH/5E6
         zyYCIV2zlw7752EulY8ALyFhCKCimf85bOsGo3L2MEYi2T1mUzumb1wngKkoE9kMsFnS
         89aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETYopeI48Fh/Ezq2vKjx51hu3dX5j7POpPAXPv1OpTA=;
        b=shVcD58agDSTsMQ6IoAzDusMAzSMa51b5evGh2rLmaJM1Q/4cK0/1IcUeed1pg+5xp
         5cEkGsR9izYTHequrVHyluaoMs3cIyIb/10fALYMMNbO9Ya8Eh5U3wtD7hREvAjkKkMj
         Kl5vwbLtGN2zlfNN2FSl02l2uNnbSWweeM2LjUGJEF0YPWmiPCJqkgV3qo+EEMOPSe4R
         NBvVUHnUqm67Cm9LDTbmuymLCexYE6MQzzhbdHYRSBfIjZRgMNFSMjlCvvgx3iuBbkGQ
         BqN6pUZP26STNHV/YPS+vgxDBoJv7OHOBlC/uw/Y2m1XO0KKtVBx3auC2ZPXibav4pEC
         GKhQ==
X-Gm-Message-State: AGi0PubwCON0mh4iI9fodAVElyb7k/r4iM72phjcqIhjip2SLBip1r+3
        A28olKGgvzYthMxMsQi1OqauG2Md
X-Google-Smtp-Source: APiQypIDcMnp31NrAdABjkEl0snXajMc5uYZsVR9KzraewhrShuzJtuDTDDkDGMqp5Oq4l6sWGdmag==
X-Received: by 2002:a17:90a:db0a:: with SMTP id g10mr3996861pjv.54.1588696014863;
        Tue, 05 May 2020 09:26:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id l37sm2508996pje.12.2020.05.05.09.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 09:26:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] fixup! CI: limit GitHub Actions to designated branches
Date:   Tue,  5 May 2020 23:26:41 +0700
Message-Id: <a2e548b683cd584fd686a44e1d7f3473943fc73f.1588695295.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588695295.git.congdanhqx@gmail.com>
References: <cover.1588607262.git.congdanhqx@gmail.com> <cover.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the patch to for discussion.

Should we want to enable GitHub Action for all repo-s, except git/git
and gitster/git. We'll want to have this patch fix-up to the previous
one.

With this patch merged, contributors will need to opt-out by push to
a branch/tag with "wip" anywhere in the refname.

Note that, integration branches (maint, master, next, jch, pu) will
always be built, regardless of repo.
Since the current condition is ugly enough, and I find it's very hard to
wrap my head around those condition.

Should this patch get fixing up into previous one, please remove the second
paragraph in the body of previous patch.

Thanks.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml      | 80 ++++++++++++++++++++++++++++++---
 Documentation/SubmittingPatches |  4 +-
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9bba0ce068..81dfa3d228 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -4,12 +4,8 @@ on:
   pull_request:
   push:
     branches:
-      - maint
-      - master
-      - next
-      - jch
-      - pu
-      - 'for-ci**'
+      - '**'
+      - '!**wip**'
     tags:
       - '**'
       - '!**wip**'
@@ -19,6 +15,15 @@ env:
 
 jobs:
   windows-build:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v1
@@ -43,6 +48,15 @@ jobs:
         name: windows-artifacts
         path: artifacts
   windows-test:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -82,6 +96,15 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     env:
       MSYSTEM: MINGW64
       NO_PERL: 1
@@ -130,6 +153,15 @@ jobs:
         name: vs-artifacts
         path: artifacts
   vs-test:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     runs-on: windows-latest
     needs: [vs-build]
     strategy:
@@ -166,6 +198,15 @@ jobs:
                           ${{matrix.nr}} 10 t[0-9]*.sh)
         "@
   regular:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     strategy:
       matrix:
         vector:
@@ -201,6 +242,15 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     strategy:
       matrix:
         vector:
@@ -225,6 +275,15 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   static-analysis:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-latest
@@ -233,6 +292,15 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
+    if: >-
+      ${{
+      (github.repository_owner != 'git' && github.repository_owner != 'gitster') ||
+      github.ref == 'refs/heads/maint' ||
+      github.ref == 'refs/heads/master' ||
+      github.ref == 'refs/heads/next' ||
+      github.ref == 'refs/heads/jch' ||
+      github.ref == 'refs/heads/pu'
+      }}
     env:
       jobname: Documentation
     runs-on: ubuntu-latest
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e516b080df..a2e6a3d2ca 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -79,8 +79,8 @@ test your changes on Linux, Mac (and hopefully soon Windows).  See
 GitHub-Travis CI hints section for details.
 
 Alternately, you can use GitHub Actions (which supports testing your changes
-on Linux, macOS, and Windows) by pushing into a branch whose name starts
-with "for-ci", or a tag whose name doesn't have `wip`,
+on Linux, macOS, and Windows) by pushing into a branch or tag
+whose name doesn't have `wip`,
 or opening a GitHub's Pull Request against
 https://github.com/git/git.git or a fork of that repository.
 
-- 
2.26.2.672.g232c24e857

