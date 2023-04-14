Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E833DC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjDNMSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNMSr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37B93F7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-18779252f7fso9409562fac.12
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474725; x=1684066725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhyABzB19F127sXkh/fN/OWuVNaEINGwbxe9YoZbzNI=;
        b=oDC9TCSQYOD/Rb4zqyb2eN9fQDRIazL5OxmCgQ3biWOTVtTn9Pf7zKVp14mjsaVr4b
         4xSFuhdRrgLgDGbUMMJJSqDSk8RavSTmlDlI/spzMCi4D5fd7YVYzgykci0izQ6370Cz
         m/DVeOxbof95bZthwQ5W5Im2NuK9bbhgl8ek9v14bnaHPMtAcEF2XP3pqXSIQdUhVbXP
         dgZk9Ew0GuFIxPMMYGT3bb38rSP1lbm9QVTf7zRB7FNJ/mnK5SqQ/PkXgTW1p/mnsJuB
         oHf8TYALapCWJzsFXA1At5s4109RYGZkqDF3RyxuyVKpyQ0d9yClow/jQfHpaAsQdLU2
         IK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474725; x=1684066725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhyABzB19F127sXkh/fN/OWuVNaEINGwbxe9YoZbzNI=;
        b=AT8MV/1ltZMBra7hprYoApcs6sYV7xK3AcfgMVHi6pZPlIpbzcqNiIuCBe6fZPCesr
         ykKUTcu+tt8lvUwthp34aXB6ea56LfrvjhvumkdsAYCnGUvOT8HdUBA+W0wx50hm5DNf
         3c1iSuinCtVF5FiTpeoEQJ/x7MnA+CDlqxN4v02GLj96sRW6wLM9IhdPmB5idFY2cb7G
         RbCtYZKrqgiUeVR1KEebNz7cDutcSOCmZkKktH3x7iSPSHRyRP3opzPF6MHeD11lAvHl
         M8DxRJKVUVb0rDAF3EVy1H4f9YjWv3gMhhz7rRnF6prQ5xuNZeNiiMelMaY07m9HcPFP
         Np+A==
X-Gm-Message-State: AAQBX9e3+f1YpX5s7iiEy8qgQLClEyqLtAtSB7JOZqjR4SmrZe2u899a
        4Ehnsz1idOqfJgRjMnwhrfH58zwCapE=
X-Google-Smtp-Source: AKy350bH/h9Yw2iPbFomTgGrYxTA6hW1OP6I4j/vGy2tHtXAFXiasl7ZiDEKgEcrR2/ZLqaRSBUcVQ==
X-Received: by 2002:a05:6870:65a4:b0:180:7b0d:2213 with SMTP id fp36-20020a05687065a400b001807b0d2213mr3663824oab.54.1681474724797;
        Fri, 14 Apr 2023 05:18:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dt22-20020a0568705a9600b0016e8726f0d4sm1753274oab.3.2023.04.14.05.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/18] version-gen: reorganize
Date:   Fri, 14 Apr 2023 06:18:24 -0600
Message-Id: <20230414121841.373980-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
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

