Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEDC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDNMSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDNMSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF704ED5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:44 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k22-20020a9d7016000000b006a43382e5b9so2067572otj.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474723; x=1684066723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu3dtNsOSPkRUjaovDWpJSrpjXg452dEqTCsKNpXO2A=;
        b=pdzmFzE9BJJaoUISsmLqzX6AmUW7alZr8yDuFYaPLro11HbOVC2fWViVyKkS6FNwP3
         EUFKC2d61F3KBoRSlzk5HWJp+8WUN2/U/YMt11LlFbehOVZwsNps8FJj/4/hI/ZUSaoP
         rcJRzNs2+tpBJ/6Xvz2gUNVRIrbTK3obH9gA4hPYTE8mJ/49Ai+DPv92Lgs+lp65s7/R
         GSlcyMd5d9ZQZTWYm5O7v9REt/F4rH5jw2RlWb/fJeyRIH2H6+ObDUWfWfb50hAF/1UO
         KDBwWy4vl9DlEMo19Gqgi/0Ns0NHnNkIXFYwWiUYDL9/J5Ls811MzGmYmDG3mv1qUHeK
         NAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474723; x=1684066723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pu3dtNsOSPkRUjaovDWpJSrpjXg452dEqTCsKNpXO2A=;
        b=h51d7iZuOgKv4BoObpmURCSciHZMnmKNH4vU2YH6Cu1HlKeRRIMSQjQL3hBHsVktpE
         2M3x0GgqXY7r1mpQe0zn5AfDFrhEYubJ3qQJOAuzG8rq3Fr6PFjR9sxZcT7psbELZHXt
         8Pi9UTjHFI2nyUzI7hkNCR4GAQTg+lOa98iKQdSyPQTrjHokoS2TCCgL8iat99EHzlll
         4w2aL4OKUhvUjni+7re/RtoPCmlWQhoiut+xeEeDTFdXNzA5xkUh8AE+ugA29v77i8X3
         vHYnAYNAgcUxIoXkWCNqoeOCKvaWTUdmNwOZ2To166a1n6a8VDSSoq0B8JlewqQpJCcu
         dYJw==
X-Gm-Message-State: AAQBX9c3CR6SjI0ju/6WJiNrGKXU09QJo+VuGW12JJNE1l13B/6BZUwG
        MIRGhuMCxzcMnltAJUIWFLN+IFQdYhw=
X-Google-Smtp-Source: AKy350aBCXr+YG4AgiOM4n5Af1RaFCaWs7gE+lmlWDpgdYBGfe3SePHV38++/AFmL+/ehT69lENWSA==
X-Received: by 2002:a05:6830:124c:b0:6a4:3e49:9eb2 with SMTP id s12-20020a056830124c00b006a43e499eb2mr1088769otp.19.1681474723381;
        Fri, 14 Apr 2023 05:18:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m18-20020a9d7ad2000000b00690e21a46e1sm1595403otn.56.2023.04.14.05.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/18] version-gen: complete revamp/rewrite
Date:   Fri, 14 Apr 2023 06:18:23 -0600
Message-Id: <20230414121841.373980-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version generation script needs some love, as the last true change was done in 2008.

This series step by step revamps the whole script ending in only a few lines of code:

    get_version () {
        test -f version && cat version && return
        git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/+/' -e 's/^v//'
    }

    NEW="GIT_VERSION = $(get_version)"

    test -r GIT-VERSION-FILE && test "$NEW" = "$(cat GIT-VERSION-FILE)" && exit
    echo "$NEW" | tee GIT-VERSION-FILE >&2

There should be no functional changes except for the last patch that changes
interim version from `2.40.0.$n.g${oid}` to `2.40.0+$n-g${oid}` as that causes
the proper sorting.

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

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9a1111af9b..99584bf86d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,40 +1,11 @@
 #!/bin/sh
 
-GVF=GIT-VERSION-FILE
-DEF_VER=v2.40.GIT
-
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
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/+/' -e 's/^v//'
 }
+
+NEW="GIT_VERSION = $(get_version)"
+
+test -r GIT-VERSION-FILE && test "$NEW" = "$(cat GIT-VERSION-FILE)" && exit
+echo "$NEW" | tee GIT-VERSION-FILE >&2

Felipe Contreras (18):
  version-gen: reorganize
  version-gen: trivial cleanup
  version-gen: refactor default version
  version-gen: simplify v prefix removal
  version-gen: simplify update check
  version-gen: remove redundant check
  version-gen: simplify `git describe` checks
  version-gen: simplify dirty check
  version-gen: move describe fix into function
  version-gen: describe and sed in one go
  version-gen: refactor describe function
  version-gen: do v fix only when necessary
  version-gen: move v fix into sed
  version-gen: refactor main functionality
  version-gen: remove default version
  version-gen: refactor GIT_VERSION string
  version-gen: get rid of GVF variable
  version-gen: generate proper interim versions

 GIT-VERSION-GEN | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

-- 
2.40.0+fc1

