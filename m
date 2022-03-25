Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA1C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiCYTat (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCYTaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980221F379C
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h7so14935441lfl.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZVj/gO4l1lswu+vSRZjq027jIUX5L/y/IDPUEWoS08=;
        b=VNn1VTnON8f37WqEW4oja695nU2tOi/aPMzGlnpQpFbzIUCYY7erTMeG5rTepoC+hz
         Sw3FNk3sv4r6m1o9D0nWnA/rWUF3Sr3YALbcXqlW6z5mbxEMbZHmrjtdBrqB704aPUJ/
         72fmRbSAUzKtKEs804H/eDYydPk+2Ff/AVL7H9+G/LrsLSLHTtPxO9+wWfOGhcJTWkld
         LpiS2SR5rOdOuzijB4xInv2F6+1zrkdnepBZJVoH7q2Z8ZiocDJLnomxNWPOXqNsExZs
         CNsXpE73WqwwB3hQ3m0dk83Tg2/bujaR9nXqnVnPTF3uRMWomqXoLg3QOE3N97ym8dDB
         I1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZVj/gO4l1lswu+vSRZjq027jIUX5L/y/IDPUEWoS08=;
        b=D6XyNbAfbd2NfGT+psXLEGKpLyk0D/YN5uiDUeTBRup5k0RuGntw0VrcjYd2bpfmf/
         T7yLwFWUBy0OVYIHfDQAxF2TsFYVSuF+2/xHydq32fkn+BSGDB96WsTwwutjPHURZ19c
         QyqT8uE4uy38JM61FRGpncLxpND7/sjJyTIIMUqRZfeiQXTe+PzG2zl1nD6ybluGlb7c
         UdUQOPWyczrqXFKStwj/1Jg5RsjkxJ0SSdee4ajaUW/SEu19ySMs3YGEIvz6kFXcAguw
         z2AaRm2rrceeGCs7OaQJXZyQcNChIoKOYc2L4VzL6+XKstGgc0V2KeJJBjwkEtoe6QX7
         Xjig==
X-Gm-Message-State: AOAM532aHaawqn2Tp66iJqfATgi42K/rfmx3pwkPUIBqwPWXTWK9mem2
        W+F45W6g81J/WLdnMvt6ykJ5zeVQjhXudg==
X-Google-Smtp-Source: ABdhPJzIB1tUu4LefJU+2eAU4gXCv/X/0CjMGZHMhmwcrGqlp9Zn2R8LvAvaGjjflVv1DQ3XxSzmGg==
X-Received: by 2002:a5d:6b0b:0:b0:1ef:d826:723a with SMTP id v11-20020a5d6b0b000000b001efd826723amr10615435wrw.420.1648233500613;
        Fri, 25 Mar 2022 11:38:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:20 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/25] CI: make "$jobname" explicit, remove fallback
Date:   Fri, 25 Mar 2022 19:37:53 +0100
Message-Id: <patch-v2-02.25-b23aa99fd37-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
index 57141d38a85..d2a7c33f536 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -6,6 +6,13 @@
 # and installing dependencies.
 set -ex
 
+# Starting assertions
+if test -z "$jobname"
+then
+	echo "must set a CI jobname" >&2
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
2.35.1.1517.g20a06c426a7

