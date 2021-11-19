Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F5C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9C561A8A
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKSN7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhKSN7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 08:59:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F239C06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso7619228wmf.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YLsHHM9ZZuZgf6ohh+nICqd6PNQktxtkyxdOvXOlpo=;
        b=ZXi3ijpj/3vboilGH+AGBxGjR2PSCz1oxlofpb5Paw/QfS3gHgRxXfMsGYMadLBkLb
         Vbt4xwMNYZvp1IXUrlaa9GZEH23pye9xaj1oGW/8a3rI74B7Qhw4KQreH1DO/rjMeb/v
         unoXnhjXv/jIXwIJMYISJEdF29QV5O6aA3NZyKysp4linhJQ+mfjXGC+duZZDFwXMubi
         oc1Qz9c2rNy50xNSQ9vlxnAg2sYRF9mcqiwj1P4EzDtkFliH1JAyxTXDKHhU1tQuRCom
         R3iZZf7JFnkRlUvq0ulEF3kviLdAefJ5JeFbMo3SzIZfVT+962d7Ls4jLb3VqsaaH/CM
         V3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YLsHHM9ZZuZgf6ohh+nICqd6PNQktxtkyxdOvXOlpo=;
        b=D1F4Cr736xZd01osdjFTKb0qqQNUMy1kWRXyWZHME/5MoRURAsj8KpG8N9EYkxpwzN
         dJ+Spr21nfikvzNgs+cy2kOGMD3FrM5oc6goFwDzyCfePPITMeJFTZfxDzLm12u6CdaT
         ZlsZ7/ScS7UFk4Th1QTn490j0nHGjdVVvTDoNlmPnTfhqKXcOKeGS5EGOj0pHecQ1laF
         JrKR1q7oSa6uJ0BwgdTruJ1Jl9TtcM061ZyY8tRFF9H6MTU7XGB+JdPQVVobHtM/+E7d
         t+o4fOoqVbqm5NEH+co3sA9jwnrUxnx5cpb+qADGHnxkNk0fmLElxnOlEyDZikOOC4QK
         iPlw==
X-Gm-Message-State: AOAM530Q84RP42Ov2Q6ubhc7tL6/TbY5VBwpwzhRojK450fhIaHbQnS9
        RfzMuNb5b7XjImfj85x4Kjm8Yv54CnbXeQ==
X-Google-Smtp-Source: ABdhPJzwOQy6w0z1aVdcjtOjoor8YXzNcuU06/oBGcz3Pj0igiUwqjI2YXYTOfYgf21MjKZt+/0jIA==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr6946282wmq.148.1637330175321;
        Fri, 19 Nov 2021 05:56:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15sm4488823wri.50.2021.11.19.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:56:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Date:   Fri, 19 Nov 2021 14:56:06 +0100
Message-Id: <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.g5753b56b5c1
In-Reply-To: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the names used for the GitHub CI workflows to be short enough
to (mostly) fit in the pop-up tool-tips that GitHub shows in the
commit view. I.e. when mouse-clicking on the passing or failing
check-mark next to the commit subject.

That description is truncated to 24 characters, with the 3 at the end
being placed by "...".

E.g. the full job name (visible at [1]):

    "regular (linux-gcc-default, gcc, ubuntu-latest)"

Will, when shown in the tool-tip be truncated to:

    "CI/PR / regular (linu..."

There's then a further limit in the expanded view where the job names
are observably truncated to 44 characters (including "..."). I.e.:

    "regular (linux-gcc-default, gcc, ubuntu-l..."

With this change we shorten both the job names, and change the
top-level "name" from "CI/PR" to "CI", since it will be used as a
prefix in the tooltips. We also remove redundant or superfluous
information from the name, e.g. "ubuntu-latest" isn't really needed
for "linux-leaks", it'll suffice to say linux. For discovering what
image runs that specifically we can consult main.yml itself.

The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
then becomes a 1=1 match to the "$jobname" used in
"ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
added implicitly as before (from the top-level "on" parameter in
"main.yml"). In the tooltip we'll now show:

    "CI / linux-leaks (pu..."

We then have no truncation in the expanded view. See [2] for a
currently visible CI run using this commit, and [3] for the GitHub
workflow syntax involved being changed here.

We could avoid even more truncation with more compact names,
e.g. changing "linux" to "lin" or "lnx", but I didn't do that since
any additional shortening seemed counterproductive, i.e. "w32" is a
well-known way of referring to "Windows", but "lin" isn't). We could
also shorten e.g. "::build" and "::test" to "+bld" and "+tst", but
those seem similarly to be overly obtuse.

1. https://github.com/git/git/tree/master/
2. https://github.com/avar/git/tree/avar/ci-shorter-names
3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 ++++++++++++-
 README.md                  |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..8f4caa8f040 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,4 +1,4 @@
-name: CI/PR
+name: CI
 
 on: [push, pull_request]
 
@@ -7,6 +7,7 @@ env:
 
 jobs:
   ci-config:
+    name: config
     runs-on: ubuntu-latest
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
@@ -77,6 +78,7 @@ jobs:
             }
 
   windows-build:
+    name: w32::build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
@@ -97,6 +99,7 @@ jobs:
         name: windows-artifacts
         path: artifacts
   windows-test:
+    name: w32::test
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -127,6 +130,7 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
+    name: w32/VS::build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
@@ -178,6 +182,7 @@ jobs:
         name: vs-artifacts
         path: artifacts
   vs-test:
+    name: w32/VS::test
     runs-on: windows-latest
     needs: vs-build
     strategy:
@@ -210,6 +215,7 @@ jobs:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   regular:
+    name: ${{matrix.vector.jobname}}
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -251,6 +257,7 @@ jobs:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   dockerized:
+    name: ${{matrix.vector.jobname}} (docker)
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
@@ -258,10 +265,13 @@ jobs:
       matrix:
         vector:
         - jobname: linux-musl
+          os: alpine
           image: alpine
         - jobname: Linux32
+          os: ubuntu32
           image: daald/ubuntu32:xenial
         - jobname: pedantic
+          os: fedora
           image: fedora
     env:
       jobname: ${{matrix.vector.jobname}}
@@ -310,6 +320,7 @@ jobs:
       run: ci/install-dependencies.sh
     - run: make sparse
   documentation:
+    name: documentation
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
diff --git a/README.md b/README.md
index eb8115e6b04..f6f43e78deb 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
-- 
2.34.0.823.g5753b56b5c1

