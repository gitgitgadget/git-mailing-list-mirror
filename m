Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F21C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKHSZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKHSZs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:25:48 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E285288B
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:25:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id h206so12105847iof.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxcZPjdL5HGOcYCO5n0TCtRt7bdPis3EeS48/0WoNiQ=;
        b=gExIY4PWvC/xfgsN8vcTtr8IcONStGAPGlcOTtpfTwcLKV0d6OQ76xhT81CyJUKcv3
         1xIk/FEM/oz0MC9VkQr3/OciUZ/E7SQI5TPDvxk9HU0DhGJrXr99ePYp1BpLawENmSlx
         K3F+9QEIEGPPgGpq5ugQxxI4SsD2tsw6ewMuW+99ndhRy+yhI4CrAncznX+KO8CRL0Jz
         q3zTxTTuGhgn5g83XCLjvW2GNzvG+qZlMMhUAClVR3zkUQbTKUyfKArx8ZJ44lmKRVWE
         q6Ak63oI/+/+/7M/dSHBLHzA3fQLsWytIL8kV6K4cQdK5hpWhMhQdjgBf8S2eS07hvb5
         7fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxcZPjdL5HGOcYCO5n0TCtRt7bdPis3EeS48/0WoNiQ=;
        b=Km+eR9j7OaVIWF2ezioWlGSGeObG/5vWQYKocr/xk4yVtdO4dpXF39LOBKk4OQZNs0
         MBAcIWEOEPDi0zcqIBYIfIdKskQvDLIxFwHvAezGnKIitni8wZ+qlP/GhOhtauGoNb8H
         3JFVs6wPHyHTAGnZ5e26HSv6peYdp/Q6fuiPMlZUDhZqTBDxyiDwqra0OKQUWm6VuIVW
         lJ8bJ18Wndw4QPFe+5bXEaco+6Vex7AfVvuLBT09GvrN+Im6oWTVsA29Z5IJ3oGW7rhz
         hNmPW5HRtRtFu5fPYZ3UwOLe5tYj6FogYKvWK/Q2epKXQUb6PRABc+tR863An4fFeIMT
         tKIg==
X-Gm-Message-State: ACrzQf0xz/I6CXQG+hC8TTCQfLo2uaf6U9R1/mrZbq7DTRKkKIyPtzgx
        0mRFsCrSpi4H3OR6efNQQpOGbgUOA7v4wA==
X-Google-Smtp-Source: AMsMyM5kwY4Bk+TO5QGGa6MEFG53ppz8ZtTSMMbtwdgLBeg1qwg/dN4JY+pS1Z+GHZjgxK1yHsAoCQ==
X-Received: by 2002:a05:6602:2c8e:b0:6a3:886a:30fb with SMTP id i14-20020a0566022c8e00b006a3886a30fbmr34868466iow.75.1667931946963;
        Tue, 08 Nov 2022 10:25:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s16-20020a056602169000b006c3fc7101fbsm4544002iow.3.2022.11.08.10.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:25:46 -0800 (PST)
Date:   Tue, 8 Nov 2022 13:25:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] ci: avoid unnecessary builds
Message-ID: <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>
References: <cover.1667931937.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667931937.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a branch is pushed to a repository which has GitHub Actions
enabled, a bunch of new workflow runs are started.

We sometimes see contributors push multiple branch updates in rapid
succession, which in conjunction with the impressive time swallowed by
even just a single CI build frequently leads to many queued-up runs.

This is particularly problematic in the case of Pull Requests where a
single contributor can easily (inadvertently) prevent timely builds for
other contributors when using a shared repository.

To help with this situation, let's use the `concurrency` feature of
GitHub workflows, essentially canceling GitHub workflow runs that are
obsoleted by more recent runs:

  https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency

For workflows that *do* want the behavior in the pre-image of this
patch, they can use the ci-config feature to disable the new behavior by
adding an executable script on the ci-config branch called
'skip-concurrent' which terminates with a non-zero exit code.

Original-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .github/workflows/check-whitespace.yml |  6 ++++
 .github/workflows/l10n.yml             |  6 ++++
 .github/workflows/main.yml             | 40 ++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index ad3466ad16..0bcc9cffbd 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -9,6 +9,12 @@ on:
   pull_request:
     types: [opened, synchronize]
 
+# Avoid unnecessary builds. Unlike the main CI jobs, these are not
+# ci-configurable (but could be).
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
 jobs:
   check-whitespace:
     runs-on: ubuntu-latest
diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 27f72f0ff3..51fd46e6af 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -2,6 +2,12 @@ name: git-l10n
 
 on: [push, pull_request_target]
 
+# Avoid unnecessary builds. Unlike the main CI jobs, these are not
+# ci-configurable (but could be).
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
 jobs:
   git-po-helper:
     if: >-
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index bd6f75b8e0..d27cd44584 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,6 +11,7 @@ jobs:
     runs-on: ubuntu-latest
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
+      skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
     steps:
       - name: try to clone ci-config branch
         run: |
@@ -34,7 +35,15 @@ jobs:
           then
             enabled=no
           fi
+
+          skip_concurrent=yes
+          if test -x config-repo/ci/config/skip-concurrent &&
+             ! config-repo/ci/config/skip-concurrent '${{ github.ref }}'
+          then
+            skip_concurrent=no
+          fi
           echo "::set-output name=enabled::$enabled"
+          echo "::set-output name=skip_concurrent::$skip_concurrent"
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
         uses: actions/github-script@v3
@@ -82,6 +91,9 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
+    concurrency:
+      group: windows-build-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
@@ -101,11 +113,14 @@ jobs:
   windows-test:
     name: win test
     runs-on: windows-latest
-    needs: [windows-build]
+    needs: [ci-config, windows-build]
     strategy:
       fail-fast: false
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+    concurrency:
+      group: windows-test-${{ matrix.nr }}-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
       uses: actions/download-artifact@v2
@@ -137,6 +152,9 @@ jobs:
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
+    concurrency:
+      group: vs-build-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
@@ -184,11 +202,14 @@ jobs:
   vs-test:
     name: win+VS test
     runs-on: windows-latest
-    needs: vs-build
+    needs: [ci-config, vs-build]
     strategy:
       fail-fast: false
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+    concurrency:
+      group: vs-test-${{ matrix.nr }}-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
@@ -218,6 +239,9 @@ jobs:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: ${{ matrix.vector.jobname }}-${{ matrix.vector.pool }}-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     strategy:
       fail-fast: false
       matrix:
@@ -281,6 +305,9 @@ jobs:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: dockerized-${{ matrix.vector.jobname }}-${{ matrix.vector.image }}-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     strategy:
       fail-fast: false
       matrix:
@@ -316,6 +343,9 @@ jobs:
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-22.04
+    concurrency:
+      group: static-analysis-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
@@ -327,6 +357,9 @@ jobs:
     env:
       jobname: sparse
     runs-on: ubuntu-20.04
+    concurrency:
+      group: sparse-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: Download a current `sparse` package
       # Ubuntu's `sparse` version is too old for us
@@ -345,6 +378,9 @@ jobs:
     name: documentation
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: documentation-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     env:
       jobname: Documentation
     runs-on: ubuntu-latest
-- 
2.38.0.16.g393fd4c6db
