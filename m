Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E613DC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiKGWo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKGWoy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 17:44:54 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99C2C132
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 14:44:53 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e19so6640022ili.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 14:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pC6nUfbdPEVrRHGoADxyu+hXtoPEQB0N/kLnJru9HMI=;
        b=MODiqrjJ1WY4iBlo5xua23O+90ITgv6E6Grh8Q/37GJ2055viPYceBoMujJlhPFSCi
         Ywa2B/3awAvjVIW9LTB0VF6EuomRPRcvGqAgXWZvcETBQF/12p0oUX/JfWQQ7IyH/XyD
         yljfk9ksS8KuLSyPHz1gAMhs4aOrTizf0m1rSFjdp5nJPQLu6Km7qiu9bcM7qsBMBOd+
         qWWS4sZJ9rZV04fxNIuGYZ+MgURgFBaF36A+BWTws0yvj/YK+udYLyznCrhf85XxXZYI
         6E9Ods12dXX98gv8uQ1GZvoav3ofMZVH35+5461A/lVFT7fa+tg4yzoStL/A1we+E7UW
         TNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC6nUfbdPEVrRHGoADxyu+hXtoPEQB0N/kLnJru9HMI=;
        b=s3quw9n+O7kpnaCUvcGcSXkCZX7G4CNood/kdyXp86YjL8HtxSUyDqNZk8Jvm50rDL
         DS1bK43MZYV6W4+W7orO/MYY8kw9qA3EBJmi8lC8jNyJtcANdketaIYRl7X2Xyn7F8+n
         EbBJmMPCP3OoqHZ3aDRqNPrvCFkboKwU3qmlZeOWYoHBDwxeUiG5xvXuSOC1+NlvPeQW
         N8MeGBqojru93gZX+bNtWnbt/L90KmWAqm1+UkCrXQANzPeSsqTBEhMnW2XnQICNIu6L
         0vBUZrSqMS5rBQoeOYAr7QV8vuEWhBLctk60NhyCOo1ntVHsva7/VEXSfn3JlOcL5Rwa
         99sg==
X-Gm-Message-State: ANoB5pmPyamLF+BIRczln81B8hga3CQEJAZ/Y7nO9DAYmqKCB8zNqadc
        Ep/QiQg1ADzynpiREv6LndI1cQ==
X-Google-Smtp-Source: AA0mqf4ld1OGYPIEO4U0bcAEpTJ/o3e0Vr2p9AwJKAcgojMh5UCNP+yJgnD0stOdIcnoGPX+VMqRIQ==
X-Received: by 2002:a92:d412:0:b0:302:1bdf:d1bf with SMTP id q18-20020a92d412000000b003021bdfd1bfmr1079142ilm.266.1667861092740;
        Mon, 07 Nov 2022 14:44:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w26-20020a02b0da000000b003635a42d653sm3043723jah.134.2022.11.07.14.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 14:44:52 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:44:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2mKY+rE6X/Lu4pb@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
 <Y2liOzOFLyz4uzd0@nand.local>
 <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
 <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
 <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 04:59:12PM -0500, Derrick Stolee wrote:
> On 11/7/22 4:03 PM, Ævar Arnfjörð Bjarmason wrote:
> >
> > On Mon, Nov 07 2022, Derrick Stolee wrote:
> >
> >> On 11/7/22 2:53 PM, Taylor Blau wrote:
>
> >>> I wonder how we should treat Ævar's concerns in this thread. I suspect
> >>> that the vast majority of workflows wouldn't be affected, but I don't
> >>> want to completely break Ævar's workflow, either ;-).
> >>>
> >>> Some kind of configuration mechanism like I proposed might be nice.
> >>> Thoughts?
> >>
> >> Taking a look at that sub-thread, I have two thoughts:
> >>
> >> 1. I don't think supporting a "multiple pushes of WIP work"
> >>    scenario is a good use of "free" resources. If you want to
> >>    test multiple versions of something, then use multiple
> >>    branches (and I think Johannes's patch allows concurrent
> >>    builds for distinct branch names).
> >
> > The setting Taylor proposed in
> > https://lore.kernel.org/git/Y2R3vJf1A2KOZwA7@nand.local/ is off by
> > default, i.e. it would behave the same way as what Johannes is
> > proposing, just give you (well, me) an opt-out from the default, without
> > patching main.yml on every branch.
> >
> > So it seems like a win-win, why force others to change their workflow?
> > Sure, I could push multiple branches, but you could also manually cancel
> > your outstanding jobs before re-pushing...
> >
> > I agree that cancelling the outstanding job is a better default, and if
> > we had to pick one or the other I'd say "sure", but if we can have
> > both...
>
> >> Either of these points may have an incorrect assumption, so
> >> I'm prepared to be wrong.
> >
> > I *think* you're wrong about #2, but I'm not sure either.
>
> At the very least, the configurable option requires fetching the
> repo and checking out at least one file. I don't know how much it
> actually saves one way or another.

To be clear, I think the savings here are minimal from a pure CPU-usage
perspective. I'm more concerned with the expense of running a job which
counts double-digit minutes against your available Actions runtime.

I played around with the following, but I can't quite get Actions to
like it. The error message I get (ref[1]) is something like:

    The workflow is not valid. .github/workflows/main.yml (Line: 96, Col:
    27): Unexpected value 'needs.ci-config.outputs.skip_concurrent == 'yes''
    .github/workflows/main.yml (Line: 123, Col: 27): Unexpected value
    'needs.ci-config.outputs.skip_concurrent == 'yes''

But I think the patch below should more-or-less be what we're looking
for:

--- >8 ---
Subject: [PATCH] ci: avoid unnecessary builds

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
index bd6f75b8e0..87b5b369e1 100644
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
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
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
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     steps:
     - name: download tracked files and build artifacts
       uses: actions/download-artifact@v2
@@ -137,6 +152,9 @@ jobs:
       NO_PERL: 1
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
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
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
@@ -218,6 +239,9 @@ jobs:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     strategy:
       fail-fast: false
       matrix:
@@ -281,6 +305,9 @@ jobs:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     strategy:
       fail-fast: false
       matrix:
@@ -316,6 +343,9 @@ jobs:
     env:
       jobname: StaticAnalysis
     runs-on: ubuntu-22.04
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
@@ -327,6 +357,9 @@ jobs:
     env:
       jobname: sparse
     runs-on: ubuntu-20.04
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     steps:
     - name: Download a current `sparse` package
       # Ubuntu's `sparse` version is too old for us
@@ -345,6 +378,9 @@ jobs:
     name: documentation
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
+    concurrency:
+      group: ${{ github.job.name }}-${{ github.ref }}
+      cancel-in-progress: needs.ci-config.outputs.skip_concurrent == 'yes'
     env:
       jobname: Documentation
     runs-on: ubuntu-latest
--
2.38.0.16.g393fd4c6db

--- 8< ---

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/actions/runs/3414594555
