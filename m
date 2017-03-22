Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E100B20958
	for <e@80x24.org>; Wed, 22 Mar 2017 06:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758611AbdCVG5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 02:57:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34663 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758360AbdCVG5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 02:57:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so6986870wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 23:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8FoJbC9TsAD54EOXpMe2ohYdgIL7nTHbeIzDNuanHmM=;
        b=fyrW3ZvxkySKPrcIsAMhpok4p9GC32MPdugv9im+rK2Ywa+ny6I2kFrJokolwMKDuE
         kDNJ0apRq/a4geHffiJDryoNY49/mGLT3oKqaZidWtDF6IT7ze6xeYZgprqWid+NGRFl
         yInGGyGDcstHJOH3t1IYlmdc6Af/rBAKQ3Wrn3w8bhbdn74lH6/gGnlvHV1A64AYuxPA
         lzJWXg0LiaCfjn4m/2i7lAssOx1kfGGwyjsqpnLTsKMWIx35kY/i2G8Tqwhx7iro4kgc
         BV1Ch2cCcgOtNFmlGwApjEYkF2i0GBYrJHSLj+LVFC3q7cd78PUpkvXwFupwMQVUQfVN
         iSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8FoJbC9TsAD54EOXpMe2ohYdgIL7nTHbeIzDNuanHmM=;
        b=ScXFGmIAXFi7+HAxrVihBbYKBNp49vU7VN9GNwr6nz6t9VUizdE6B4cUu8sEKe+yKJ
         tUPzs8h2/ek5e442kjroWRhCs2vd8SyIM4ZxVw0WU1ZZv5tAQSW7/Eo8PZA+OZO+xT+D
         E+T6QHZh0E8PD5jHx7DlpBaNYtXYIJ6PTXI8SCe1gstYxAGM0GhcwViKojjs37bGyMI0
         HN3H8uzH834Q2JvOG2rEXP802MkqH+0kO5vDu/SjnFIGEp22rWNszkyuJKe67/MPdlic
         2XsmdBBlErZox8iZnaU1xy7iHNK5DNlqt6/vNSYgIXNlJB9rB6zX9rBRDVf8YGlARB14
         maog==
X-Gm-Message-State: AFeK/H0CbRNv/TRUePdqIVWNPpLMWg2xZZR3CdtBQTJUwJlUbW+e9os82T4HDs1AREIb+g==
X-Received: by 10.28.216.141 with SMTP id p135mr6296842wmg.71.1490165773285;
        Tue, 21 Mar 2017 23:56:13 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4341.dip0.t-ipconnect.de. [93.219.67.65])
        by smtp.gmail.com with ESMTPSA id c76sm20415265wme.23.2017.03.21.23.56.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 23:56:12 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net
Subject: [PATCH v1] travis-ci: build and test Git on Windows
Date:   Wed, 22 Mar 2017 07:56:12 +0100
Message-Id: <20170322065612.18797-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most Git developers work on Linux and they have no way to know if their
changes would break the Git for Windows build. Let's fix that by adding
a job to TravisCI that builds and tests Git on Windows. Unfortunately,
TravisCI does not support Windows.

Therefore, we did the following:
* Johannes Schindelin set up a Visual Studio Team Services build
  sponsored by Microsoft and made it accessible via an Azure Function
  that speaks a super-simple API. We made TravisCI use this API to
  trigger a build, wait until its completion, and print the build and
  test results.
* A Windows build and test run takes up to 3h and TravisCI has a timeout
  after 50min for Open Source projects. Since the TravisCI job does not
  use heavy CPU/memory/etc. resources, the friendly TravisCI folks
  extended the job timeout for git/git to 3h.

Things, that would need to be done:
* Someone with write access to https://travis-ci.org/git/git would need
  to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
  repository setting [1]. Afterwards the build should just work.

Things, that might need to be done:
* The Windows box can only process a single build at a time. A second
  Windows build would need to wait until the first finishes. This
  waiting time and the build time after the wait could exceed the 3h
  threshold. If this is a problem, then it is likely to happen every day
  as usually multiple branches are pushed at the same time (pu/next/
  master/maint). I cannot test this as my TravisCI account has the 50min
  timeout. One solution could be to limit the number of concurrent
  TravisCI jobs [2].

[1] https://docs.travis-ci.com/user/environment-variables#Defining-Variables-in-Repository-Settings
[2] https://docs.travis-ci.com/user/customizing-the-build#Limiting-Concurrent-Builds

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/322094c0a2
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-v1 && git checkout 322094c0a2

 .travis.yml             | 11 ++++++++++
 ci/run-windows-build.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100755 ci/run-windows-build.sh

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..a7e98ae519 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,17 @@ env:
 
 matrix:
   include:
+    - env: Windows
+      os: linux
+      compiler:
+      addons:
+      before_install:
+      before_script:
+      script:
+        - >
+          test "$TRAVIS_REPO_SLUG" != "git/git" ||
+          ci/run-windows-build.sh $GFW_CI_TOKEN $TRAVIS_BRANCH $(git rev-parse HEAD)
+      after_failure:
     - env: Linux32
       os: linux
       services:
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
new file mode 100755
index 0000000000..324a9ea4e6
--- /dev/null
+++ b/ci/run-windows-build.sh
@@ -0,0 +1,55 @@
+#!/usr/bin/env bash
+#
+# Script to trigger the a Git for Windows build and test run.
+# Pass a token, the branch (only branches on https://github.com/git/git)
+# are supported), and a commit hash.
+#
+
+[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)
+
+TOKEN=$1
+BRANCH=$2
+COMMIT=$3
+
+gfwci () {
+	curl \
+		-H "Authentication: Bearer $TOKEN" \
+		--silent --retry 5 \
+		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" |
+	sed "$(printf '1s/^\xef\xbb\xbf//')"  # Remove the Byte Order Mark
+}
+
+# Trigger build job
+BUILD_ID=$(gfwci "action=trigger&branch=$BRANCH&commit=$COMMIT&skipTests=false")
+
+# Check if the $BUILD_ID contains a number
+case $BUILD_ID in
+	''|*[!0-9]*) echo $BUILD_ID && exit 1
+esac
+
+echo "Visual Studio Team Services Build #${BUILD_ID}"
+
+# Wait until build job finished
+STATUS=
+RESULT=
+while true
+do
+	LAST_STATUS=$STATUS
+	STATUS=$(gfwci "action=status&buildId=$BUILD_ID")
+	[ "$STATUS" == "$LAST_STATUS" ] || printf "\nStatus: $STATUS "
+	printf "."
+
+	case $STATUS in
+		inProgress|postponed|notStarted) sleep 10                      ;; # continue
+		         "completed: succeeded") RESULT="success";        break;; # success
+		                              *) echo "Unknown: $STATUS"; break;; # failure
+	esac
+done
+
+# Print log
+echo ""
+echo ""
+gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
+
+# Set exit code for TravisCI
+[ "$RESULT" == "success" ]

base-commit: afd6726309f57f532b4b989a75c1392359c611cc
-- 
2.11.1

