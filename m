Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E737B2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 11:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935564AbdCXLhy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 07:37:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35805 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbdCXLhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 07:37:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so2716898wmb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FcQyjHn1IxSDJ12O13Q353M35OOYu00+ZjDAH+aXIvQ=;
        b=OvtxiCAAcJCDN655mWdTXMthrUSaKhBPktx+I6cVptK7ZIY4fESh8TZF6Yr79CGoXg
         9U5a+Jxk8AkR2rP3nGeSxtbmi8aB/cUc6ec0RAmuMzRWwucde32wkHDg+vm9KYhR+7q8
         4+ZZtonyhXiGhy92/DiaqknKNf+5jHDzLzUrKV/csnQj2HtQAaN3g8BpSbUoAH7VS6CM
         kdEsYo5NX+QgCtP5Dwn/rjWjVmUGRpTsg/d0WBFUyHzoXYsDZJRyYRvwVx3+ue4Fhism
         jauswQElPKhlordnthQKaTPBIywJFtYd92ODCaAAQz+iiawAyA6wnx2gRisPBAv+Vfaw
         xRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FcQyjHn1IxSDJ12O13Q353M35OOYu00+ZjDAH+aXIvQ=;
        b=S74NxriCNOhagT3VzjWPpKtqV+q76ku12MOa+H2qmxFDK0bRwwHcHRFZ4DlsvF0wgD
         pu/cxetej+Yycik/ivPfKe2/bPpMce7RZk3L5cPApwUiMzgeF/8QP440rrQVV4uop+BX
         7uFta5XoiojOXzREVQnY/2vIReaCoTCJr460n+IYwv79i9sl5ghmgM6D3tdpcZghSF0Q
         HZ1ebwuUB2ayJkU3vvYOtVIbw/yG4cceLnSlH6d+FUcbBlWrZjTmcqtx3fmBGda8oUi1
         ZLrlmqpbxSnF0lsQKWNOvzBuFwWsYU7QF31jtuCY6qe3s7vWmLzZovixGTZDMgaFhkEg
         S5Cw==
X-Gm-Message-State: AFeK/H2485t08ZyiimS3i20x2i9Ey+E2yiqsgDbA0mzIVMcDUEm3y6xA2C3JKwggFCUsKw==
X-Received: by 10.28.97.69 with SMTP id v66mr2594144wmb.113.1490355470302;
        Fri, 24 Mar 2017 04:37:50 -0700 (PDT)
Received: from ban4wcb152r.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k128sm2102958wmf.16.2017.03.24.04.37.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 04:37:49 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, gitster@pobox.com,
        sxlijin@gmail.com
Subject: [PATCH v2] travis-ci: build and test Git on Windows
Date:   Fri, 24 Mar 2017 12:37:47 +0100
Message-Id: <20170324113747.44991-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.1
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

Hi,

I think I addressed all issues from the v1 review (see interdiff below)
with one exception. The script still uses bash instead of sh. Something
about this does not work in sh:
    --output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3)

Does anyone know how to make this sh compatible?

Thanks,
Lars


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/7c527f3571
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-v2 && git checkout 7c527f3571

    Interdiff (v1..v2):

    diff --git a/.travis.yml b/.travis.yml
    index a7e98ae519..c757a111ce 100644
    --- a/.travis.yml
    +++ b/.travis.yml
    @@ -48,7 +48,7 @@ matrix:
           script:
             - >
               test "$TRAVIS_REPO_SLUG" != "git/git" ||
    -          ci/run-windows-build.sh $GFW_CI_TOKEN $TRAVIS_BRANCH $(git rev-parse HEAD)
    +          ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
           after_failure:
         - env: Linux32
           os: linux
    diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
    index 324a9ea4e6..234a235c77 100755
    --- a/ci/run-windows-build.sh
    +++ b/ci/run-windows-build.sh
    @@ -1,30 +1,49 @@
     #!/usr/bin/env bash
     #
     # Script to trigger the a Git for Windows build and test run.
    -# Pass a token, the branch (only branches on https://github.com/git/git)
    -# are supported), and a commit hash.
    +# Set the $GFW_CI_TOKEN as environment variable.
    +# Pass the branch (only branches on https://github.com/git/git are
    +# supported) and a commit hash.
     #

    -[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)
    +test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
    +test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit

    -TOKEN=$1
    -BRANCH=$2
    -COMMIT=$3
    +BRANCH=$1
    +COMMIT=$2

     gfwci () {
    -	curl \
    -		-H "Authentication: Bearer $TOKEN" \
    -		--silent --retry 5 \
    -		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" |
    -	sed "$(printf '1s/^\xef\xbb\xbf//')"  # Remove the Byte Order Mark
    +	local CURL_ERROR_CODE HTTP_CODE
    +	exec 3>&1
    +	HTTP_CODE=$(curl \
    +		-H "Authentication: Bearer $GFW_CI_TOKEN" \
    +		--silent --retry 5 --write-out '%{HTTP_CODE}' \
    +		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3) \
    +		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
    +	)
    +	CURL_ERROR_CODE=$?
    +	if test $CURL_ERROR_CODE -ne 0
    +	then
    +		return $CURL_ERROR_CODE
    +	fi
    +	if test "$HTTP_CODE" -ge 400 && test "$HTTP_CODE" -lt 600
    +	then
    +		return 127
    +	fi
     }

     # Trigger build job
     BUILD_ID=$(gfwci "action=trigger&branch=$BRANCH&commit=$COMMIT&skipTests=false")
    +if test $? -ne 0
    +then
    +	echo "Unable to trigger Visual Studio Team Services Build"
    +	echo "$BUILD_ID"
    +	exit 1
    +fi

     # Check if the $BUILD_ID contains a number
     case $BUILD_ID in
    -	''|*[!0-9]*) echo $BUILD_ID && exit 1
    +''|*[!0-9]*) echo "Unexpected build number: $BUILD_ID" && exit 1
     esac

     echo "Visual Studio Team Services Build #${BUILD_ID}"
    @@ -36,13 +55,13 @@ while true
     do
     	LAST_STATUS=$STATUS
     	STATUS=$(gfwci "action=status&buildId=$BUILD_ID")
    -	[ "$STATUS" == "$LAST_STATUS" ] || printf "\nStatus: $STATUS "
    +	test "$STATUS" = "$LAST_STATUS" || printf "\nStatus: $STATUS "
     	printf "."

    -	case $STATUS in
    +	case "$STATUS" in
     	inProgress|postponed|notStarted) sleep 10               ;; # continue
     	         "completed: succeeded") RESULT="success"; break;; # success
    -		                              *) echo "Unknown: $STATUS"; break;; # failure
    +	*) echo "Unhandled status: $STATUS";               break;; # failure
     	esac
     done

    @@ -52,4 +71,5 @@ echo ""
     gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-

     # Set exit code for TravisCI
    -[ "$RESULT" == "success" ]
    +test "$RESULT" = "success"
    +

    \0

 .travis.yml             | 11 ++++++++
 ci/run-windows-build.sh | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100755 ci/run-windows-build.sh

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..c757a111ce 100644
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
+          ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
+      after_failure:
     - env: Linux32
       os: linux
       services:
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
new file mode 100755
index 0000000000..234a235c77
--- /dev/null
+++ b/ci/run-windows-build.sh
@@ -0,0 +1,75 @@
+#!/usr/bin/env bash
+#
+# Script to trigger the a Git for Windows build and test run.
+# Set the $GFW_CI_TOKEN as environment variable.
+# Pass the branch (only branches on https://github.com/git/git are
+# supported) and a commit hash.
+#
+
+test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
+test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
+
+BRANCH=$1
+COMMIT=$2
+
+gfwci () {
+	local CURL_ERROR_CODE HTTP_CODE
+	exec 3>&1
+	HTTP_CODE=$(curl \
+		-H "Authentication: Bearer $GFW_CI_TOKEN" \
+		--silent --retry 5 --write-out '%{HTTP_CODE}' \
+		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3) \
+		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
+	)
+	CURL_ERROR_CODE=$?
+	if test $CURL_ERROR_CODE -ne 0
+	then
+		return $CURL_ERROR_CODE
+	fi
+	if test "$HTTP_CODE" -ge 400 && test "$HTTP_CODE" -lt 600
+	then
+		return 127
+	fi
+}
+
+# Trigger build job
+BUILD_ID=$(gfwci "action=trigger&branch=$BRANCH&commit=$COMMIT&skipTests=false")
+if test $? -ne 0
+then
+	echo "Unable to trigger Visual Studio Team Services Build"
+	echo "$BUILD_ID"
+	exit 1
+fi
+
+# Check if the $BUILD_ID contains a number
+case $BUILD_ID in
+''|*[!0-9]*) echo "Unexpected build number: $BUILD_ID" && exit 1
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
+	test "$STATUS" = "$LAST_STATUS" || printf "\nStatus: $STATUS "
+	printf "."
+
+	case "$STATUS" in
+	inProgress|postponed|notStarted) sleep 10               ;; # continue
+	         "completed: succeeded") RESULT="success"; break;; # success
+	*) echo "Unhandled status: $STATUS";               break;; # failure
+	esac
+done
+
+# Print log
+echo ""
+echo ""
+gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
+
+# Set exit code for TravisCI
+test "$RESULT" = "success"
+

base-commit: afd6726309f57f532b4b989a75c1392359c611cc
--
2.12.1

