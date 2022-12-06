Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0EDC3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLFT6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLFT6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:58:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063295A2
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:58:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so9018127ejc.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfNZnKqBW4tt3SWCIV8mvHUsyrYxmDuk2Mx0LO9KNaA=;
        b=hkHb4Vv1au74QhAXWNPdJqY4GSKFYSIcfy7o0qc41kndeFPUZ4+2Bmohk+bSv9oYCG
         K3UkKB7yF+MVjlGW2euirrx27yVZ/UXs10wxQrpTUSliMq7iA5At+sRNYZlChF6xKOOM
         7fbN0aNr3cbv9JTSBfQvhttWEWuQvSPD1O0me43i7qLsCBiajUGo6uXkD8Y2nL5Jq6xA
         cNigees9Lnh4/SUqHSim0DeoBQJtSjV+iOmUHKOAR1pA7yq21pSDDwN9EVdbznpOqnL7
         +lzd2qAaTmSrRqHuRRKIibfssJki54g+nrken7+zZY+e8hESl4Oj5Dt5c8etE5uE5Y26
         Bn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfNZnKqBW4tt3SWCIV8mvHUsyrYxmDuk2Mx0LO9KNaA=;
        b=3y6+nKe9jQeuuyturW8GWQUc4PLPXVT1FoM8VhaRrlvUAOn65O66s88tarWqW3tDad
         +V4hRt7fzmbdGCNrkQwhRlDT6io4ElrCCfAlo/yXeWbGAvGOljD8XzMc+vkIt5wtidX7
         s+cxQMCh5qsXtcEeagqH5zBooMBckqtvGxOwopgvD5PQExaz2GGcXPixxxkKpNRUY9nR
         KLTjRro5r3GP1osaS9A2erxbRH2U7w7qm+Gxkt/YvDLy+CYufBdRB5ncCtQjgo+pePv8
         1FGGI5NncJeypqyqzJvtGGliCzBR6JG/zdnUBfnGiVAN5mKyLKLJ7rRVOA9OVS4SRPWd
         W/nA==
X-Gm-Message-State: ANoB5pmTXuT4Wu2jDFsrX2rc6N94C8BdvtFbnikdmUNUi5fDe9zIfBPF
        cenul11x9kjuMrrIxx4exMsRli3PaIWwJw==
X-Google-Smtp-Source: AA0mqf4Vi9GTorNXUUZ3HtCfC/D7VFYOuFVEwE0fI2T2EJzALcqa5zqXjJBN00b1fPqb1g6jOdbZ4g==
X-Received: by 2002:a17:906:6d8a:b0:7ad:69eb:923b with SMTP id h10-20020a1709066d8a00b007ad69eb923bmr12354022ejt.19.1670356679317;
        Tue, 06 Dec 2022 11:57:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b007c0d41736c0sm4562676ejb.39.2022.12.06.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:57:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: upgrade to macos-12, and pin OSX version
Date:   Tue,  6 Dec 2022 20:57:56 +0100
Message-Id: <patch-1.1-4c1dcc89e7a-20221206T195552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1017.g5f0c708352f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per [1] and the warnings our CI is emitting GitHub is phasing in
"macos-12" as their "macos-latest".

As with [2], let's pin our image to a specific version so that we're
not having it swept from under us, and our upgrade cycle can be more
predictable than whenever GitHub changes their images.

1. https://github.com/actions/runner-images/issues/6384
2. 0178420b9ca (github-actions: run gcc-8 on ubuntu-20.04 image,
   2022-11-25)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This is intended as a sibling to
https://lore.kernel.org/git/xmqq1qpd9bys.fsf@gitster.g/, and along
with another change I'm about to submit should make the CI warning
free.

 .github/workflows/main.yml | 4 ++--
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..1ac11648854 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -238,11 +238,11 @@ jobs:
             pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
-            pool: macos-latest
+            pool: macos-12
           - jobname: osx-gcc
             cc: gcc
             cc_package: gcc-9
-            pool: macos-latest
+            pool: macos-12
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d8fafc8ed2d..4f407530d30 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -30,7 +30,7 @@ ubuntu-*)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-macos-latest)
+macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib.sh b/ci/lib.sh
index cb30699f34d..706e3ba7e93 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -252,7 +252,7 @@ ubuntu-*)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-macos-latest)
+macos-*)
 	if [ "$jobname" = osx-gcc ]
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-- 
2.39.0.rc2.1017.g5f0c708352f

