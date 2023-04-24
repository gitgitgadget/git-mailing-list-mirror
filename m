Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E5C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjDXQuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDXQut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:49 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B26580
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:44 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187df75c906so3508974fac.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355043; x=1684947043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmDSSAOitudY51HngA7WBHjy884CnNNTWDg/qlQvQ3E=;
        b=HCPIVLGnbr/PPhQPsqXtGPl4YTX+VSwseyBSqdH42dxfMVeuu6PY9hiT0Zg6l/kdTj
         ny6C9tEFM12d/10hTzRE32fyN/fJT150VofSFa2eSYfL1n9+zJD5bxBq5sny5pgbB5vB
         r959SmKICuvUXLHptD/PfBr0HrmgKdoE96Ybo+eKhK8QnEOJbsjqQFLCiKQO26ifttGV
         hPfc9VgOq5bG3Xf3u4PzQ7Ng1g3DlF/lCgity9q7ZjsGMjs6I/SdmbeJA9AGh8gX9/Rk
         3UhAoZGmEZxHumLlw8nU0eNqYoMbMkNcEiafyHhdCITZJ7yMLxld08qH20xTObDjOqJM
         turg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355043; x=1684947043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmDSSAOitudY51HngA7WBHjy884CnNNTWDg/qlQvQ3E=;
        b=VdKoi0/plMtEWPcIkHM3yAYG6CSfoNVRedQmDXEbB6Z/Wj/ou6MIashE5Cvc0lQYzS
         dhdTllVUNpegR3q9MlTqh9NUJz+/odYwKd4FGbIFf8XAA3ntKftDt9648vNMq4/ffQXg
         WF/pb7eYJ5OFkqzxi+wOZGVGQktR9J53cX7NkVNYBpk1Maotpk32ocAMIj4a/P1cXxrE
         DUpVXC+y2BNrXEVwO7XLlE0DsWIMrWeJUrg55wvyGM+KPNvUHDL3ijMQF5pwdo4Ub/lD
         0rvOJlXD1aS05C933xM8BRAHRRmtL8Hzlpr3XyREklgHMMUjjLAQByCZhyHiW0S8qgqQ
         k2fQ==
X-Gm-Message-State: AAQBX9c4eG1X/SsfXehV5O1jGjShhwuOMgGLczxHUOCpc0ZTodSpymwS
        LGNvQafQm3a/nqfe0Hp+paa4zKeTNrY=
X-Google-Smtp-Source: AKy350amSXc4S6rgU7KaKHZloArCZfkm2f5GIwpfIW9lTrYtlqAALUk4V4Hiwp2Tzsqwv2fegd3b0w==
X-Received: by 2002:a05:6870:c694:b0:187:bacd:2937 with SMTP id cv20-20020a056870c69400b00187bacd2937mr10854945oab.51.1682355042878;
        Mon, 24 Apr 2023 09:50:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870131a00b00177ba198612sm4639136oab.53.2023.04.24.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/15] version-gen: complete revamp/rewrite
Date:   Mon, 24 Apr 2023 10:50:26 -0600
Message-Id: <20230424165041.25180-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version generation script needs some love, as the last true change was done in 2008.

This series step by step revamps the whole script ending in only a few lines of code.

There should be no functional changes.

It's hard to see the actual changes to this script as 99% of the commits are
just to bump the default version (which I don't know why it even exists).

For reference, cleaning the history I came up with these actual changes in case
anyone is interested:

c48799e560 (Teach GIT-VERSION-GEN about the .git file, 2008-02-20)
1100ac81a9 (Change GIT-VERSION-GEN to call git commands with "git" not "git-"., 2006-05-22)
374dfaa2e3 (Make GIT-VERSION-GEN tolerate missing git describe command again, 2006-01-26)
5c7d3c9507 (Allow building of RPM from interim snapshot., 2006-01-16)
181129d24c (For release tarballs, include the proper version, 2006-01-09)
026351a035 (Make GIT-VERSION-GEN tolerate missing git describe command, 2005-12-30)
9b88fcef7d (Makefile: use git-describe to mark the git version., 2005-12-27)

Cheers.

Changes since v1:

I removed all the controverrsial functional changes (those will come in
a separate series) due to comments by Todd Zullinger.

The non-functional changes are already plenty, so let's focus on those
first.

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9a1111af9b..3d30ce74af 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,40 +1,18 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
-DEF_VER=v2.40.GIT
+DEF_VER=2.40.GIT
 
-LF='
-'
-
-# First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
-if test -f version
-then
-	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
-	case "$VN" in
-	*$LF*) (exit 1) ;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
-	esac
-then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
-else
-	VN="$DEF_VER"
-fi
-
-VN=$(expr "$VN" : v*'\(.*\)')
-
-if test -r $GVF
-then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-else
-	VC=unset
-fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
+get_version () {
+	test -f version && cat version && return
+	test -d "${GIT_DIR:-.git}" -o -f .git || return
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
+
+VN=$(get_version)
+
+: "${VN:=$DEF_VER}"
+
+NEW="GIT_VERSION = $VN"
+
+test -r GIT-VERSION-FILE && test "$NEW" = "$(cat GIT-VERSION-FILE)" && exit
+echo "$NEW" | tee GIT-VERSION-FILE >&2

Felipe Contreras (15):
  version-gen: reorganize
  version-gen: trivial cleanup
  version-gen: refactor default version
  version-gen: simplify v prefix removal
  version-gen: simplify update check
  version-gen: simplify `git describe` checks
  version-gen: simplify dirty check
  version-gen: move describe fix into function
  version-gen: describe and sed in one go
  version-gen: refactor describe function
  version-gen: do v fix only when necessary
  version-gen: move v fix into sed
  version-gen: refactor main functionality
  version-gen: refactor GIT_VERSION string
  version-gen: get rid of GVF variable

 GIT-VERSION-GEN | 50 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

Range-diff against v1:
 1:  18ac0e3784 =  1:  dbe102186a version-gen: reorganize
 2:  280efc616f =  2:  9a1a46481b version-gen: trivial cleanup
 3:  af67bdb106 =  3:  04d6741689 version-gen: refactor default version
 4:  798fd082f3 =  4:  770eeb9abc version-gen: simplify v prefix removal
 5:  adbad7eab8 =  5:  2234d37305 version-gen: simplify update check
 6:  2742189cc7 <  -:  ---------- version-gen: remove redundant check
 7:  414e2efddd =  6:  0784430fe6 version-gen: simplify `git describe` checks
 8:  04b755dcc1 =  7:  aa0ac9d10c version-gen: simplify dirty check
 9:  05519e8ece !  8:  51272021d9 version-gen: move describe fix into function
    @@ GIT-VERSION-GEN: describe () {
      if test -f version
      then
      	VN=$(cat version)
    --elif describe
    --then
    +-elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
    ++elif test -d "${GIT_DIR:-.git}" -o -f .git
    + then
     -	VN=$(echo "$VN" | sed -e 's/-/./g')
    -+else
     +	describe
      fi
      
10:  f9b0092966 =  9:  06eb36044f version-gen: describe and sed in one go
11:  2a5167e4f0 ! 10:  4c0785fb5d version-gen: refactor describe function
    @@ GIT-VERSION-GEN: GVF=GIT-VERSION-FILE
      }
      
      # First see if there is a version file (included in release tarballs),
    -@@ GIT-VERSION-GEN: if test -f version
    - then
    +@@ GIT-VERSION-GEN: then
      	VN=$(cat version)
    - else
    + elif test -d "${GIT_DIR:-.git}" -o -f .git
    + then
     -	describe
     +	VN=$(describe)
      fi
12:  a71fe9229b ! 11:  7bd0e69a1b version-gen: do v fix only when necessary
    @@ GIT-VERSION-GEN
      describe () {
      	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
     @@ GIT-VERSION-GEN: then
    - 	VN=$(cat version)
    - else
    + elif test -d "${GIT_DIR:-.git}" -o -f .git
    + then
      	VN=$(describe)
     +	VN=${VN#v}
      fi
13:  5462474c52 ! 12:  3834398857 version-gen: move v fix into sed
    @@ GIT-VERSION-GEN: GVF=GIT-VERSION-FILE
      
      # First see if there is a version file (included in release tarballs),
     @@ GIT-VERSION-GEN: then
    - 	VN=$(cat version)
    - else
    + elif test -d "${GIT_DIR:-.git}" -o -f .git
    + then
      	VN=$(describe)
     -	VN=${VN#v}
      fi
14:  64cb12343a ! 13:  18c2cbaf9c version-gen: refactor main functionality
    @@ GIT-VERSION-GEN
     -describe () {
     +get_version () {
     +	test -f version && cat version && return
    ++	test -d "${GIT_DIR:-.git}" -o -f .git || return
      	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
      }
      
    @@ GIT-VERSION-GEN
     -if test -f version
     -then
     -	VN=$(cat version)
    --else
    +-elif test -d "${GIT_DIR:-.git}" -o -f .git
    +-then
     -	VN=$(describe)
     -fi
     +VN=$(get_version)
15:  16b6e38ace <  -:  ---------- version-gen: remove default version
16:  7bb1206f00 <  -:  ---------- version-gen: refactor GIT_VERSION string
 -:  ---------- > 14:  6c594361df version-gen: refactor GIT_VERSION string
17:  e0cd32d548 ! 15:  edf380d2fa version-gen: get rid of GVF variable
    @@ GIT-VERSION-GEN
      #!/bin/sh
      
     -GVF=GIT-VERSION-FILE
    --
    - get_version () {
    - 	test -f version && cat version && return
    - 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
    -@@ GIT-VERSION-GEN: get_version () {
    + DEF_VER=2.40.GIT
      
    - NEW="GIT_VERSION = $(get_version)"
    + get_version () {
    +@@ GIT-VERSION-GEN: VN=$(get_version)
    + 
    + NEW="GIT_VERSION = $VN"
      
     -test -r $GVF && test "$NEW" = "$(cat $GVF)" && exit
     -echo "$NEW" | tee $GVF >&2
18:  43a59f630a <  -:  ---------- version-gen: generate proper interim versions
-- 
2.40.0+fc1

