Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238BDC4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKYKAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 05:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKYKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 05:00:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884918389
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:59:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so7247647pjs.4
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7K81kW03eDSulANpnDOLXsfz64/iyG/IJ7djr0bSoQ=;
        b=NgeCRQb/ST8IdR9tXi3LZuDgA+T8t9ZwZkds85ceXsamzKgIk0ydrHyRUKpnBr5+lJ
         JTJBCBMjaEtGpy8sKxx8zCWJJ7V584sSljCj0pQQu3evBln96ezHNjS32C4yZqYEqoSS
         mANkUArhQm+CsQ32Kvd5TCArQTbRnCHN8XD+ATHVlWt5Q6yR0kcbD+PFENa8QypjA+Y9
         T9iDjEG69r7MWt90cxrM7MH0junigujpCF0VYd6dDQ9REk42tSbSS5gfYRqMTcz60f2T
         /Kq9MRbs+i1CNNSsbzCWt7yZRp1QH/CcHy72egrszkRDR87SugYC5f/pREQsrCQ1YIIt
         57RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7K81kW03eDSulANpnDOLXsfz64/iyG/IJ7djr0bSoQ=;
        b=y+lQ8v+bqedtpKXXcFPR5d4+E+2Fp0NJ/lV7H6mgUOMlapcTo55mYc4PUXwAj++nUM
         DGFYe+QxHwnciv6j9XAPAN8oJ//P67jdtjT3WruxDkJ5h8uIfH2byfkUMpni07EWCDA/
         j6Y+jz713LtC71el0CZcaKj7JnaklXO1F/oMmSg/EVfOo4qsV9RMenGzG2T+Jrje8QaY
         u2iQXFpV8c2YI9E6K3qPP/wvpp23i+qRSRIJXsbgJHPYdz6XBVZKubQP157wBWmzPjWj
         LJNtUAyMvRM4SmbHfsPyibrXGeHuc6KGIlxRWssSeaQr4yKoFKwOd5Zw0g+A8a+kuk2o
         qnrw==
X-Gm-Message-State: ANoB5pl6AK8TS7BP82MmukOVZc9/K3BWlGJpEVGT/vWbJ1yM0GlRsPKg
        4Xr7GZLMJT/Kd2J8pRisc2DPg4j+CfU=
X-Google-Smtp-Source: AA0mqf5JxV2XK+ogN2RC1tFCQULHIoTRbUdmcJakfp43A3bgRclGZ9cl4d4WcqRzaaOeghFAOFdGjA==
X-Received: by 2002:a17:90b:3444:b0:213:519d:fe51 with SMTP id lj4-20020a17090b344400b00213519dfe51mr45558183pjb.239.1669370397410;
        Fri, 25 Nov 2022 01:59:57 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b00186b0ac12c5sm2904514plb.172.2022.11.25.01.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:59:56 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/4] Fix broken CI on newer github-actions runner image
Date:   Fri, 25 Nov 2022 17:59:50 +0800
Message-Id: <20221125095954.4826-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124153934.12470-1-worldhello.net@gmail.com>
References: <20221124153934.12470-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

GitHub CI runner image "ubuntu-latest" will upgrade to "ubuntu-22.04"
soon. Our CI will break on the new runner image because there is not
"gcc-8" package in ubuntu-22.04. See log of CI#10:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3546701459/jobs/5956020103#step:3:106

Another issue in CI#10 is "pd4 -V” failed without an error output. See:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3546701459/jobs/5956019973#step:3:315

This first issue is fixed in patch 1/4 by downgrading the version of
the runner image for jobs which need "gcc-8". The second issue is
fixed in patch 2/4 by removing the pipe from "p4d -V".  Then, we can
see there was a sigfault when running "p4d -V". See log of CI#11:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3546723251/jobs/5956063536#step:3:311

This issue is fixed in patch 3/4 by upgrading version of p4 on Linux
to the same version as on macOS. But all p4 related test cases failed
becasue python was missing on ubuntu-22.04.  See the log of CI#12:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3546734918/jobs/5956087614#step:4:22733

This issue is fixed in patch 4/4 by installing python2/python3 on
Linux.  All test cases passed. See log of CI#13:

 * https://github.com/jiangxin/git-ci-test/actions/runs/3546744257

# range-diff v3..v4

1:  1c0d639487 ! 1:  28588dad56 github-actions: run gcc-8 on ubuntu-20.04 image
    @@ Commit message
         "ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
         install "gcc-8" package on the new runner image.
     
    -    Change the runner images from "ubuntu-latest" to "ubuntu-20.04" in order
    -    to run with "gcc-8" as a dependency.
    +    Change some of the runner images from "ubuntu-latest" to "ubuntu-20.04"
    +    in order to install "gcc-8" as a dependency.
     
    -    Instead of use the environment "$runs_on_pool" as below:
    +    The first revision of this patch tried to replace "$runs_on_pool" in
    +    "ci/*.sh" with a new "$runs_on_os" environment variable based on the
    +    "os" filed in the matrix strategy. But these "os" fields in matrix
    +    strategies are obsolete legacies from commit [1] and commit [2], and
    +    are no longer useful. So remove these unused "os" fields.
     
    -        case "$runs_on_pool" in
    -        ubuntu-20.04 | ubuntu-latest)
    -            ;;
    -
    -    we can reuse the os field in the matrix, and use a new environment
    -    "$runs_on_os" as below:
    -
    -        case "$runs_on_os" in
    -        ubuntu)
    -            ;;
    -
    -    In this way, we can change the "ubuntu-latest" runner image to any
    -    version such as "ubuntu-22.04" to test CI behavior in advance.
    +    [1]: c08bb26010 (CI: rename the "Linux32" job to lower-case "linux32",
    +                     2021-11-23)
    +    [2]: 25715419bf (CI: don't run "make test" twice in one job, 2021-11-23)
     
         Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    -         vector:
    -           - jobname: linux-clang
    -             cc: clang
    -+            os: ubuntu
                  pool: ubuntu-latest
                - jobname: linux-sha256
                  cc: clang
    -@@ .github/workflows/main.yml: jobs:
    +-            os: ubuntu
    +             pool: ubuntu-latest
                - jobname: linux-gcc
                  cc: gcc
                  cc_package: gcc-8
     -            pool: ubuntu-latest
    -+            os: ubuntu
     +            pool: ubuntu-20.04
                - jobname: linux-TEST-vars
                  cc: gcc
     -            os: ubuntu
                  cc_package: gcc-8
     -            pool: ubuntu-latest
    -+            os: ubuntu
     +            pool: ubuntu-20.04
                - jobname: osx-clang
                  cc: clang
    -+            os: macos
                  pool: macos-latest
    -           - jobname: osx-gcc
    -             cc: gcc
    -             cc_package: gcc-9
    -+            os: macos
    -             pool: macos-latest
    -           - jobname: linux-gcc-default
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: linux-leaks
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: linux-asan
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: linux-ubsan
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -     env:
    -       CC: ${{matrix.vector.cc}}
    -       CC_PACKAGE: ${{matrix.vector.cc_package}}
    -       jobname: ${{matrix.vector.jobname}}
    --      runs_on_pool: ${{matrix.vector.pool}}
    -+      runs_on_os: ${{matrix.vector.os}}
    -     runs-on: ${{matrix.vector.pool}}
    -     steps:
    -     - uses: actions/checkout@v2
    +@@ .github/workflows/main.yml: jobs:
    +         - jobname: linux-musl
    +           image: alpine
    +         - jobname: linux32
    +-          os: ubuntu32
    +           image: daald/ubuntu32:xenial
    +         - jobname: pedantic
    +           image: fedora
     
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
    -  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
       libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
      
    --case "$runs_on_pool" in
    + case "$runs_on_pool" in
     -ubuntu-latest)
    -+case "$runs_on_os" in
    -+ubuntu)
    ++ubuntu-*)
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
      		$UBUNTU_COMMON_PKGS $CC_PACKAGE
    -@@ ci/install-dependencies.sh: ubuntu-latest)
    - 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
    - 	popd
    - 	;;
    --macos-latest)
    -+macos)
    - 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
    - 	# Uncomment this if you want to run perf tests:
    - 	# brew install gnu-time
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: export DEFAULT_TEST_TARGET=prove
    - export GIT_TEST_CLONE_2GB=true
    +@@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
      export SKIP_DASHED_BUILT_INS=YesPlease
      
    --case "$runs_on_pool" in
    + case "$runs_on_pool" in
     -ubuntu-latest)
    -+case "$runs_on_os" in
    -+ubuntu)
    ++ubuntu-*)
      	if test "$jobname" = "linux-gcc-default"
      	then
      		break
    -@@ ci/lib.sh: ubuntu-latest)
    - 	GIT_LFS_PATH="$HOME/custom/git-lfs"
    - 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
    - 	;;
    --macos-latest)
    -+macos)
    - 	if [ "$jobname" = osx-gcc ]
    - 	then
    - 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
2:  fed880b8bd ! 2:  b914f1d2fc ci: show error message of "p4 -V"
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    ci: show error message of "p4 -V"
    +    ci: remove the pipe after "p4 -V" to cache errors
     
    -    When installing p4 as a dependency, we used to pipe output of "p4 -V" to
    -    validate the installation, but this would hide potential errors of p4.
    -    E.g.: A broken p4 installation fails to run.
    +    When installing p4 as a dependency, we used to pipe output of "p4 -V"
    +    and "p4d -V" to validate the installation and output a condensed version
    +    information. But this would hide potential errors of p4 and would stop
    +    with an empty output. E.g.: p4d version 16.2 running on ubuntu 22.04
    +    causes sigfaults.
     
    -    Add some instructions to show errors of command "p4 -V", so we can see
    -    why the command output doesn't match.
    +    By removing the pipe after "p4 -V" and "p4d -V", we may get a verbose
    +    output, and stop immediately on errors becuase we have "set -e" in
    +    "ci/lib.sh". Since we won't look at these trace logs unless something
    +    fails, so just including the raw output seems most sensible.
     
         Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## ci/install-dependencies.sh ##
    @@ ci/install-dependencies.sh: esac
      then
      	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
     -	p4d -V | grep Rev.
    -+	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
    ++	p4d -V
      	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
     -	p4 -V | grep Rev.
    -+	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
    ++	p4 -V
      else
      	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
      fi
3:  da2f516fc9 = 3:  4aa2b30c36 ci: p4 on Linux has the same version as on macOS
4:  bd1850cc93 = 4:  35909fd459 ci: install python on ubuntu
      
--

Jiang Xin (4):
  github-actions: run gcc-8 on ubuntu-20.04 image
  ci: remove the pipe after "p4 -V" to cache errors
  ci: p4 on Linux has the same version as on macOS
  ci: install python on ubuntu

 .github/workflows/main.yml |  7 ++-----
 ci/install-dependencies.sh | 12 ++++++------
 ci/lib.sh                  | 11 +++++------
 3 files changed, 13 insertions(+), 17 deletions(-)

-- 
2.39.0.rc0

