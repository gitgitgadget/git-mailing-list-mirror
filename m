Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1ABC77B73
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDXQux (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjDXQut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6976590
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-38e3a1a07c8so2877392b6e.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355044; x=1684947044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhyABzB19F127sXkh/fN/OWuVNaEINGwbxe9YoZbzNI=;
        b=BYi2ksaMQLfEyH0rj+mIRmODzsAerqCTJnYwuTHoKKQkOuR7Gbn5+Wy0V4DKol9QFy
         Z1gI6C8mV239q0vtWYmWy9ixrDGICKoCFIZDViSl9XXkFBi+mC+0ODK6ZnMWawRdQY1A
         6Fp4s3GAoHOfEJd4O5PzLlmSNakLqfjE88q7qZ1b0fTc8xorq8+H12XELKf75lxbp5uQ
         qMCV/I5KZSfesZF4MOGu+IsNGEUl/xCL0RfRMmMA97kZPGcU3737AofYxjEjHrBQ4zCU
         icfaFSzwPhyKWoK31GSVUAhUA9ZJ/dr7AkZMYn2RlHwI9CoUeVkrFpO+v3V39pO8kauJ
         lazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355044; x=1684947044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhyABzB19F127sXkh/fN/OWuVNaEINGwbxe9YoZbzNI=;
        b=d3351GwH6YWmLNCcunjv7BRli1cJNEQXVT4CKjTT1co8WHHGLfnXfg1fv7omBYmMtT
         APLh84Q3YNtTDkUyvup5lRq1cRNVx1zwH03/mJ7dxVtARjQLksoPTReniB1gNzdVfM0r
         yIpY0zV7SaRLQUn34sWK0nBY91W6zjxJmKmP8dkMCXO1xt1eSqJHeAX9QJD58z8ebhES
         T6qx2Bc4+4JFTO1c0wayq11ii5EiOv51pL3TWkNQQ3TryGSGDeTOqigGwgiaV5KXk+jA
         4AWXnedaOw8wRj/HSrBKC9afs/EUF7TxQrZbBQz/JPn8pntH4qVvlW4iMHBkrJWWALwY
         VE2A==
X-Gm-Message-State: AAQBX9dwk2wrT5QZ39CYowz7uvPq9uYTuLGbsw8oUeW0Ay7VJsJqgR8d
        n7V9RAqk350f8+ygdZPTqEchpDfafHU=
X-Google-Smtp-Source: AKy350a+vQSQplHHiXvMIgAb+LgeNRFn/C0kisBy+8Xop5nfmFXRstQDrhn07jvmIfB/OaA6B1VWRA==
X-Received: by 2002:a05:6808:a11:b0:38e:2804:4bfb with SMTP id n17-20020a0568080a1100b0038e28044bfbmr6748699oij.5.1682355044046;
        Mon, 24 Apr 2023 09:50:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z9-20020a4aae09000000b005421d52de9csm4944052oom.45.2023.04.24.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/15] version-gen: reorganize
Date:   Mon, 24 Apr 2023 10:50:27 -0600
Message-Id: <20230424165041.25180-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simply move some code into a `describe` function so it's clear what code
is related to dealing with `git describe`, and what code is the main
functionality.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9a1111af9b..29d634a30b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,20 +6,27 @@ DEF_VER=v2.40.GIT
 LF='
 '
 
+describe () {
+	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) || return 1
+	case "$VN" in
+	*$LF*)
+		return 1
+		;;
+	v[0-9]*)
+		git update-index -q --refresh
+		test -z "$(git diff-index --name-only HEAD --)" ||
+		VN="$VN-dirty"
+		return 0
+		;;
+	esac
+}
+
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
-	case "$VN" in
-	*$LF*) (exit 1) ;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
-	esac
+elif test -d ${GIT_DIR:-.git} -o -f .git && describe
 then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
 else
-- 
2.40.0+fc1

