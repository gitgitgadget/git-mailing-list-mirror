Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C603C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbiDRQb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDRQbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789DE2FFE6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so19102843wrh.11
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XfnbSGIpG/XYVtdnuTNfnz2u/kuY63QGk7wI7td+JA=;
        b=m1p+WU+3JEOGzd+od76Vv7XzqJ0QU3jIEiKOPDKWPP4AJCI+U1jRCfyZcIuZWjllc9
         WBoj9VidDB+5WKZtwTId7/lCBCk/VdQq8aKAEhELn2NHVUb4R24NRQQdTmzwH+0T44ac
         RuKlScABDfPJ40JEpEfFW+1TGjPulF/p7foN7IyvYtL3vUgwlaQ5hMgAp3a9nWe1tT1o
         H5/p/V1J/HkNqmSDgJzQQiOA971u28DgHbg0M0XPN8OyDhYPmsAx5bKcw2nqT05DXcFu
         YpRGXHGq5unxz46odH11w8qTwLKa3auO4yFG7cbUA2OWGwS3sKnOnCyOvEbmlfkz5Ph/
         Pvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XfnbSGIpG/XYVtdnuTNfnz2u/kuY63QGk7wI7td+JA=;
        b=5yCcQf6teVbIxt1wgzpONYuyaZ3jD9mw9rlyCnxEmPbwV8xLiB4+/W6jTE0oaSJIXn
         8rVGb5Q2Mznp370MDGrqbyXDAHn7E0v2pY0n1FjE6ISCsn5zu+rSMbCbiXyCi0P9vFe8
         smf0OG+8TQTCwR6E453c9TItYrbpNkYNYkt3lil5Kz3mHLkw3jWDYx2Nr9tvGbdONlgA
         Bz6xXNgFAoFDJ/Fa1VKFkGyHV+Ps2z3jVtjVe2I39sb+dT3yAP4wZJGqRtYDAkECuORy
         cI57D4MTUT3IUBlknv97Jrmu0THTFviglq8oPYRMVV98vPr90fLWbpR30LlmK+Out65T
         XOqg==
X-Gm-Message-State: AOAM533SfZyNeLUFGfJ4aWoYv5QOkNwEe2i86E0bhEBSPw9kTXMzrGzv
        YuZ9uyvTCsQADb7IwHy1aej98gOSJRk=
X-Google-Smtp-Source: ABdhPJyVE9354fuW/fuhqYok/mcwWTZdJsc1WKNfcUF7xCraNN3Xv1uvOYgpmH+mt3ZWzc1BLgKjsg==
X-Received: by 2002:a5d:64c7:0:b0:20a:8785:eb43 with SMTP id f7-20020a5d64c7000000b0020a8785eb43mr8156828wri.210.1650299353684;
        Mon, 18 Apr 2022 09:29:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/31] CI: make "$jobname" explicit, remove fallback
Date:   Mon, 18 Apr 2022 18:28:39 +0200
Message-Id: <patch-v4-02.31-737fe1e2c4c-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $jobname fallback last adjusted in b011fabd6e0 (ci/lib.sh:
encapsulate Travis-specific things, 2019-01-27).

This makes all of our CI jobs have an explicit $jobname, and removes
the special-case of the Windows jobs implicitly setting one (that they
don't currently use). In subsequent commits we'll use this new
$jobname explicitly.

This is a follow-up to my 25715419bf4 (CI: don't run "make test" twice
in one job, 2021-11-23), since then all the jobs except the Windows
jobs have had an explicit $jobname.

In the case of the Windows jobs we were using a jobname of windows-gcc
for both, due to picking "gcc" as a default fallback for "$CC" in
ci/lib.sh.

Since we'll need this to run ci/lib.sh it makes sense to move the
check to the top of the file. Subsequent commits will add more such
assertions to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  8 ++++++++
 ci/lib.sh                  | 12 +++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..309b9141249 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -79,6 +79,8 @@ jobs:
 
   windows-build:
     name: win build
+    env:
+      jobname: windows-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
@@ -100,6 +102,8 @@ jobs:
         path: artifacts
   windows-test:
     name: win test
+    env:
+      jobname: windows-test
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -131,6 +135,8 @@ jobs:
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
     name: win+VS build
+    env:
+      jobname: vs-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
@@ -183,6 +189,8 @@ jobs:
         path: artifacts
   vs-test:
     name: win+VS test
+    env:
+      jobname: vs-test
     runs-on: windows-latest
     needs: vs-build
     strategy:
diff --git a/ci/lib.sh b/ci/lib.sh
index 57141d38a85..5fda166ad47 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -6,6 +6,13 @@
 # and installing dependencies.
 set -ex
 
+# Starting assertions
+if test -z "$jobname"
+then
+	echo "must set a CI jobname in the environment" >&2
+	exit 1
+fi
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -146,11 +153,6 @@ test -n "${DONT_SKIP_TAGS-}" ||
 skip_branch_tip_with_tag
 skip_good_tree
 
-if test -z "$jobname"
-then
-	jobname="$CI_OS_NAME-$CC"
-fi
-
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
-- 
2.36.0.rc2.898.gdf6bbac50ff

