Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820DC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391316AbiDUS0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391284AbiDUS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7B4AE38
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso6432991wml.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGt5pX+/GfUy7JCUft/YvumTDhqV2Fqma6AGQu5mwYw=;
        b=EtT8kdFTqTe5wp2If+oYJ60Lb5/91QI/BSlDoz/NAm2vGILFjlhwfLL9/PWO4By8qR
         I3gad2pRm8VF6hW/NaitHbb9fo15WSjAF2T+vpt+I+alhidbfKRTjNoqAQYvHZjF0Y3j
         /KF9d6zy5Di5U3dbdlRAi+nS8GV/A2jRNYSxi9RmhGbg0h4gUWHqNuxCDwymirgwPanz
         fdikAKPVrmpUeW962BcHGA+XhWKzABODPGuZuepIekRl9IyXX3UWRTM5gSd4cxdLYAw1
         gFRTkFVCMWdehWEq2C9GvgY8piB5W2wk6YiNjyuNVS5LweIyyD2XpP/5c/LIBFIYkdWl
         g23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGt5pX+/GfUy7JCUft/YvumTDhqV2Fqma6AGQu5mwYw=;
        b=kpJ4spOARmW7GK2gQyNfnx+J6eKpWRZT8wDLNnzkEJ651Bz+ZjXM/56gbAkG1NVDmt
         yCubi1iulvFpkexnt+JaScnF0HsajvppA5YBJvSmMci4arGywqPCmxHmR7H89SioI0Ha
         y4EAwFOEO4OnSdFnEyvKA8GA2tYH4y0aG3UsCvRR2t/Yi0oXhuy8mW7BZvaF/kMl5Jnh
         Zq1a4podbr9oXw6GJ6kmdRlb//GCCI65BxrBbXm+Ab7z2Q7CbY7pDUdWXUujMRMqCymu
         LBKOjgWNX2IDSCuUi0HeYFEp8WMBxiZSXC9emoHX9r2VNWhBNnITacmFvo8+RfxjTx2v
         gjdA==
X-Gm-Message-State: AOAM53030BDu0FZNBvdSTxFLiyYly+CHCAqLo+oXoduVtyYagI8dBStU
        k2PN7QIGufYoSOEQJxGSykewZmAgQrgo+w==
X-Google-Smtp-Source: ABdhPJxFHMHC0ga77I1ktLwWTTnbiQ2t6r7GlRl36Fc4MUFZBOFGSuSeyyNFhtxmlmwqSgf15TNQkg==
X-Received: by 2002:a05:600c:1c15:b0:392:8c46:4fd4 with SMTP id j21-20020a05600c1c1500b003928c464fd4mr9520523wms.205.1650565416371;
        Thu, 21 Apr 2022 11:23:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:35 -0700 (PDT)
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
Subject: [PATCH v5 02/29] CI: make "$jobname" explicit, remove fallback
Date:   Thu, 21 Apr 2022 20:22:57 +0200
Message-Id: <patch-v5-02.29-3f5c071b0f6-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index 57141d38a85..6d76c2d406b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -6,6 +6,13 @@
 # and installing dependencies.
 set -ex
 
+# Starting assertions
+if test -z "$jobname"
+then
+	echo "error: must set a CI jobname in the environment" >&2
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
2.36.0.879.g3659959fcca

