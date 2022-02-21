Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641CDC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378302AbiBUOrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbiBUOrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D851D5596
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m27so15711421wrb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV2MR96BaXSEm8tHvq8YfW66x01Lto0/DfOwR/D0QSE=;
        b=kxsaZ8nB919JsmmfhJhKgWMe52F3mdDLk2UOSIJOCE84pApYbFd37l4Wzg8LGnTPgC
         L+8BSrO4GUuXcybEtnti3S6x/U9gCX9DSRUNEXPVVsgRLldZkDKG3VTFsEKFbGZjMtBp
         QGaBjfZIl1PHw9CwVWhZlRsF8vZ5aad+y4IHv4nVWe4uQ2SwmYmYv8DYkOKnYQwzoyyi
         Wnfl/cbwvU8vkX7eTheCZBO4SGLMEQoZRFAJjvb0voZSF2PIjkmA77g9MGHBu4Pxbq1j
         I3eCQhU7B6K7Mnde14KoG2oH9z8nVsDquCcg/t8H/qjRnPUagAGY70d89uzZvxdd87LK
         mEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sV2MR96BaXSEm8tHvq8YfW66x01Lto0/DfOwR/D0QSE=;
        b=ijXgV1jcsSRrRAz2TAZKTuP16uUBIsrjZYcfj0Ts/xGLtZSDB96P1RcF62OQovl+Sm
         P2gE0pC0QjqTDtfG1exNkzPFZSMKjJ4EQ4+ESZnTsmVwSbFnct4EnnYuzLNkFoZJOjcs
         KcZpUgIUfw99DsjXnVSfo78ZL+bn0ViR3fgCTIvBE20k7sHt+389Za6Ih39282zuyzGc
         PLEAmcfrXD0PURbiRGg6uJzNzLNTjPWyGHW8yt80YXIuDgGVbwYDD7xdEo9z+vWZSVn7
         PfsTSZRV+SSdBe0tuSi3Y7YgeJcHwPNaH5cUbsDnFf9WCbjFXXDv/5RnHYsO+IqYqR3T
         Xprw==
X-Gm-Message-State: AOAM532SQKgAavEpTWE8XToDUFkLgzTLcjDHQcInALbjg6oEzZ63wQpq
        GMwyG3nlmAugCLEi0qjJePyrMwyRPtMMyA==
X-Google-Smtp-Source: ABdhPJzr6KWmhJ+uToVgv49+YHAXVq9Nh5LJ1TcZ8KXtgSImgx/sROBwy3f7W7OC17udZzJDll7/Ig==
X-Received: by 2002:a5d:4292:0:b0:1e4:b7fd:eb84 with SMTP id k18-20020a5d4292000000b001e4b7fdeb84mr16216328wrq.657.1645454809161;
        Mon, 21 Feb 2022 06:46:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:48 -0800 (PST)
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
Subject: [PATCH 02/25] CI: make "$jobname" explicit, remove fallback
Date:   Mon, 21 Feb 2022 15:46:14 +0100
Message-Id: <patch-02.25-eda7fb18064-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
2.35.1.1132.ga1fe46f8690

