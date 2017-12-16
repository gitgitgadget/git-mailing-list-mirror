Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BC71F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756506AbdLPMzm (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:55:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36404 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756321AbdLPMzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:55:41 -0500
Received: by mail-wr0-f194.google.com with SMTP id u19so3864469wrc.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajG8Yol+bys67Ybnn3CnPw984DV2QDYIyoWMk5ZJGqk=;
        b=GUjfT6ukkIbi2QXKrko0sh1dKlMX63+gpphMUQceu+7MhoYODzwkmXvzAVBCpDgXf/
         eksiyU27OBqUX16gSavHv9Vdei59ekckxcv7X8hFSroGiVBZGzKEghQH/8XsUKyqKVpR
         mI0Tgrw+LLqnDk+eqRQycbj0djA2aX9/f6jFfS6ZrEVu/1nEA4GF/rQ7xQK/pBytAomj
         ztkBBkJZZDpRGBw/IB9pbJEQFFEAjLEGjAlAjeJlWj7t1kkhT2b3qwaZtj9HOV/AcoO3
         olJLP5mwOoKC29cuAdP/4dH/5ih3nBTSlkPycjpTjPoQEEJRf2yNgv+TP3q42HigcRG2
         E6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajG8Yol+bys67Ybnn3CnPw984DV2QDYIyoWMk5ZJGqk=;
        b=Sh7SxTj1Qm5Hzm6PvQA1mrwChXBRpd9DSo+tbZNqqWNqYLBxIZRnFAjIHSJqFrJKMV
         wk9QpLcJ4V+UWi8ZBHaRSfS3IL8Krvsd8BXhWOWCvn5W620ah82pp1fGmPu80724n9fH
         1PBRuw2NSMfhJk7KES2cqGdrwMOQU328MYSJJT/SWRUpV4w7vu8wu7Dc2+wuaJ/8wGzd
         OeJxswkG8f8OidY287E3d60ubmFWeLUkH3n84KqaPgv9suMXwapUqF4gqk+u6r/E6jZ4
         tQxKix23+AwVp10RpuRhjwV6Dms1/4ynnGL2vYGF/fjR67KhVehdrVl7p3KFEKMVPSgS
         7bUg==
X-Gm-Message-State: AKGB3mLxYdxGSb4M4WwhgaQP7ZhfRSbEwk1GvH2hWG6649Jl9tpLi2GS
        R0CLTw1SBZQevPBeXyK0v60=
X-Google-Smtp-Source: ACJfBotXZS//5odPIjcUAB1HAg+skbg9kmOSHB+fGaqmvCcROKCWsx+tln+XHHk83fHtSG6e7kLsQA==
X-Received: by 10.223.176.242 with SMTP id j47mr1428398wra.178.1513428940144;
        Sat, 16 Dec 2017 04:55:40 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id x52sm9790912wrb.25.2017.12.16.04.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:55:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/8] travis-ci: introduce a $jobname variable for 'ci/*' scripts
Date:   Sat, 16 Dec 2017 13:55:32 +0100
Message-Id: <20171216125532.10826-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of 'ci/*' scripts are shared between different build jobs:
'ci/lib-travisci.sh', being a common library, is sourced from almost
every script, while 'ci/install-dependencies.sh', 'ci/run-build.sh'
and 'ci/run-tests.sh' are shared between the "regular" GCC and Clang
Linux and OSX build jobs, and the latter two scripts are used in the
GETTEXT_POISON Linux build job as well.

Our builds could benefit from these shared scripts being able to
easily tell which build job they are taking part in.  Now, it's
already quite easy to tell apart Linux vs OSX and GCC vs Clang build
jobs, but it gets trickier with all the additional Linux-based build
jobs included explicitly in the build matrix.

Unfortunately, Travis CI doesn't provide much help in this regard.
The closest we've got is the $TRAVIS_JOB_NUMBER variable, the value of
which is two dot-separated integers, where the second integer
indicates a particular build job.  While it would be possible to use
that second number to identify the build job in our shared scripts, it
doesn't seem like a good idea to rely on that:

  - Though the build job numbering sequence seems to be stable so far,
    Travis CI's documentation doesn't explicitly states that it is
    indeed stable and will remain so in the future.  And even if it
    were stable,

  - if we were to remove or insert a build job in the middle, then the
    job numbers of all subsequent build jobs would change accordingly.

So roll our own means of simple build job identification and introduce
the $jobname environment variable in our builds, setting it in the
environments of the explicitly included jobs in '.travis.yml', while
constructing one in 'ci/lib-travisci.sh' as the combination of the OS
and compiler name for the GCC and Clang Linux and OSX build jobs.  Use
$jobname instead of $TRAVIS_OS_NAME in scripts taking different
actions based on the OS and build job (when installing P4 and Git LFS
dependencies and including them in $PATH).  The following two patches
will also rely on $jobname.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml                | 10 +++++-----
 ci/install-dependencies.sh |  6 +++---
 ci/lib-travisci.sh         |  9 +++++++--
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 281f101f3..88435e11c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,12 +39,12 @@ env:
 
 matrix:
   include:
-    - env: GETTEXT_POISON=YesPlease
+    - env: jobname=GETTEXT_POISON GETTEXT_POSION=YesPlease
       os: linux
       compiler:
       addons:
       before_install:
-    - env: Windows
+    - env: jobname=Windows
       os: linux
       compiler:
       addons:
@@ -55,7 +55,7 @@ matrix:
           test "$TRAVIS_REPO_SLUG" != "git/git" ||
           ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
       after_failure:
-    - env: Linux32
+    - env: jobname=Linux32
       os: linux
       compiler:
       services:
@@ -63,7 +63,7 @@ matrix:
       before_install:
       before_script:
       script: ci/run-linux32-docker.sh
-    - env: Static Analysis
+    - env: jobname=StaticAnalysis
       os: linux
       compiler:
       addons:
@@ -74,7 +74,7 @@ matrix:
       before_script:
       script: ci/run-static-analysis.sh
       after_failure:
-    - env: Documentation
+    - env: jobname=Documentation
       os: linux
       compiler:
       addons:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5bd06fe90..468788566 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -8,8 +8,8 @@
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 
-case "${TRAVIS_OS_NAME:-linux}" in
-linux)
+case "$jobname" in
+linux-clang|linux-gcc)
 	export GIT_TEST_HTTPD=YesPlease
 
 	mkdir --parents "$P4_PATH"
@@ -26,7 +26,7 @@ linux)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx)
+osx-clang|osx-gcc)
 	brew update --quiet
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 2d0d1d613..4b3c5fdd0 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -29,8 +29,13 @@ set -ex
 
 skip_branch_tip_with_tag
 
-case "${TRAVIS_OS_NAME:-linux}" in
-linux)
+if test -z "$jobname"
+then
+	jobname="$TRAVIS_OS_NAME-$CC"
+fi
+
+case "$jobname" in
+linux-clang|linux-gcc)
 	P4_PATH="$(pwd)/custom/p4"
 	GIT_LFS_PATH="$(pwd)/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
-- 
2.15.1.429.ga000dd9c7

