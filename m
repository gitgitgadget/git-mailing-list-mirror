Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B918C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiDMTyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiDMTyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3134A31DCC
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t1so4140941wra.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GLiRbG6gjj0P6dug5ZgN0vQ/XREwjkyqnctAJTBsl4=;
        b=ZM/dJnxmolvRNvfmAS/V97ZqM/4W0C62Aaa2B6JYZRcx/Ux0dFVgiB+lz5zq4LdGjG
         Gj4YSv/Jb4v5YwwXQkx9xqf9P6L+6FSTk8yS26O6nNsDJIJFpUCAiSf0KeZhX7gf1boV
         mOzC226PGyeeTmzH5MSpxyeXw23xkaSlPYBKDdBPokLKz4fhqiknO37MrZtiogX2Wo+a
         8H8i4f2ul/F7Ld8opynaB/akRrEviKgKAwEZECLHXFlfgq2MO+dpphIkqFdQGRk1ePfH
         akYaOtgsBYGBzDViM3n4myrqAW5Fd4OhvRHCym4/WBz53tOZEhx2RSouGrnVyiYP8VFt
         541Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GLiRbG6gjj0P6dug5ZgN0vQ/XREwjkyqnctAJTBsl4=;
        b=bpgryrJ7Fx8VG70YNzCltXfZM69dLHG/5jp75hi0o2GXARHO5czOelyh/np9aMcO3/
         oHo9cq5Rus/dS7udDmLn2KBaXOpwm7X84MqL5XPAmI6XFIgMqVGTGHX0btCPUdqDTvMW
         PHmoCrtu6yQE5Yfr+m2A6NZ1qqPUxpcwSijbJvDffPAdtf4oF+WS7/6bN4KPfrthVRuo
         fASPF6sNsRSVoQnBXN5pUsxGqRWQG6SSWYh9vroTQpftDBGWqECGF8pMn0gTfrDt76Yi
         kDj/P3zRWNlQjSH1RxQhfwFgLzZEag35QQKyqjSwxiU2ycePgDt6CUI5OePvG9aXcrC2
         E4bA==
X-Gm-Message-State: AOAM531ynWg15ianecSMd4U/lV1pFCwMnO2wz60lMWO0QJtDSvJFKnLE
        mpyzMMkHY6IPLC/INAWTPRyG+KaRPZb5Lg==
X-Google-Smtp-Source: ABdhPJwALPoPuqzSPsRhX9svHNP0ZBeq4FNx/5Giwax7OnzSG1WAjdcovY/PFOojpFZRM+K41vsLeg==
X-Received: by 2002:a5d:5144:0:b0:207:9a13:ca73 with SMTP id u4-20020a5d5144000000b002079a13ca73mr348545wrt.268.1649879515366;
        Wed, 13 Apr 2022 12:51:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:54 -0700 (PDT)
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
Subject: [PATCH v3 02/29] CI: make "$jobname" explicit, remove fallback
Date:   Wed, 13 Apr 2022 21:51:15 +0200
Message-Id: <patch-v3-02.29-7de95ff437e-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

