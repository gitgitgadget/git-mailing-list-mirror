Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C05BC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286CF20684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK9bluQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK0QQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:16:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40340 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QQl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:16:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep1so10230576pjb.7
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o69Y/Neow3Wzzqy6EF4+lVIzm0UauoScoupof4lRaeM=;
        b=tK9bluQg+Pl+i5Vm/JHTMlI0mWYv2leagMbSkq4/Us3RdFM6PQz7HOpu9y1p7BxMxN
         jX/DUbdNpeoCptO8rctHzfvbzbejt+YtKVfQUYewtK1b7v6i3GHLuTo2x8IW1qKFvVjZ
         qHJFNSPkg+xP8oOmW+QdpGtpLaRbMbsWhioIfDyotWBADWj0zgNrHfslM/SZsDEm5Ds+
         y/S+eEWWV7EnvDQWuG1IwNCL7BsL9thqWV6tdEVewAT3KqngwTAdjbRMUG/t2OFyo7iW
         bRex+QYPhdczaEWwmf9goEgPHD6DANlxpFY6R7n8RLKdEnEBW+JRF/gj3wSvh0IZaFnW
         fIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o69Y/Neow3Wzzqy6EF4+lVIzm0UauoScoupof4lRaeM=;
        b=J7ut0v5TGWnHeFQnX4aIke1fRvC27Q7HsdYrIoAHG4ZdWBiKGXfohpv+NcEyE/sZjj
         Sys1zMmygdCWEybqK+beCajRh+9zADHPJAe4vc7eYXwTts7mjV1DKwDi/xgMJfcZ2gOh
         WzRmV8jKyaLLWbkzatSkvRB0/J/tpurkzH+1J1DBQbEgaXQhfYRBW1bWT6sJh7ohgMJ5
         qF9/XRc/jxVkVsGfpx1Os2aSzPLzEIxNPLELY69+cM9FfHVxtMBXNvlU4KMSj//JFoz4
         bBG3Wp0bGfFAaP3e0J6uIH7RhN6KU5LUYc+hddl7QfUYAwAW4suJ//FtC9+dxuahruCY
         0vTA==
X-Gm-Message-State: APjAAAVG0T64SK9r0QomCenSrIGT6/NfKVtGCqdsEtXvjhNnvEGzYS/f
        WyVtqQ6dvGHhyXXkchE6hJg29cqT
X-Google-Smtp-Source: APXvYqy4GoKshoaF0epAvVhhhMsSWSea6/juyYNVrAazO3pWmhBWNsEavm7ho0lS3UYI3MUFlVjiRQ==
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr5082737pll.55.1574871400075;
        Wed, 27 Nov 2019 08:16:40 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id i13sm16832019pfo.39.2019.11.27.08.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 08:16:39 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH] ci: detect installed gcc in Travis CI
Date:   Wed, 27 Nov 2019 23:15:55 +0700
Message-Id: <20191127161555.26131-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.161.g2616cd003f.dirty
In-Reply-To: <20191126011536.GA30006@generichostname>
References: <20191126011536.GA30006@generichostname>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI has continously updated their images, including updating gcc
installation.

Save us some headache by checking which version of gcc is installed in
the image, and use said version to run the build.

While gcc-10 hasn't been released, yet, add it to the list to save us
some headache in the future.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c8c2c38155..4040fc1a22 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -159,12 +159,21 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
-linux-clang|linux-gcc)
-	if [ "$jobname" = linux-gcc ]
-	then
-		export CC=gcc-8
-	fi
+*-gcc)
+	for gitcc in gcc-10 gcc-9 gcc-8
+	do
+		if command -v $gitcc >/dev/null 2>&1
+		then
+			export CC=$gitcc
+			break;
+		fi
+	done
+	unset gitcc
+	;;
+esac
 
+case "$jobname" in
+linux-clang|linux-gcc)
 	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
@@ -180,11 +189,6 @@ linux-clang|linux-gcc)
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 osx-clang|osx-gcc)
-	if [ "$jobname" = osx-gcc ]
-	then
-		export CC=gcc-8
-	fi
-
 	# t9810 occasionally fails on Travis CI OS X
 	# t9816 occasionally fails with "TAP out of sequence errors" on
 	# Travis CI OS X
-- 
2.24.0.161.g2616cd003f.dirty

