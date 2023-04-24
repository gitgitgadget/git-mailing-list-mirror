Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCFC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjDXQu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjDXQuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F12B6E80
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6a604259983so3720411a34.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355045; x=1684947045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoxuHttwGlHpw0iLHk9kbmg5mFYOxafVOewfrSGopK8=;
        b=kws+ZNzWb4MAI4sZBfbW0KjKYBdHA6jEeO8xoVcZMXHxMnN/WqjaVh7k0TxDKZM2E+
         6PobSuNT1iHD51eIt0+xsrJQIDvYfFQ1NYIOMY5T63oT4rXOJ2M16HNtG6z1/ZOiDkCf
         jbAGfGRtzY1oIbKs48PDuI53iscVTXv7CvcnjqTFRgCcEbQ+C/OWH0ke/RAPrYFrWaVm
         4/n0N35va7Aam0cJG8vYWIC0PHYZcfpnzzliF3VXoHgk50liBjaa0Mqx8kLynV/fD4d3
         r/u6nErm1KLkp+NlAy2w707oQ2EGfR5iSHEsx36NIQOgoCa3DMUFabPAwOqw/46OJmo0
         IVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355045; x=1684947045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoxuHttwGlHpw0iLHk9kbmg5mFYOxafVOewfrSGopK8=;
        b=Ki5UzXD/ZQ7oRrExxVwCUiSL7E+E4YwXIVIlgB4Vo+V59k/7wXuHVhs43fBAGz3Jm4
         VwUqNnMg7A8JO8aDexDqmF6uSrZJBl7ieLtRcD8ioQMKJenXQZIwfnVIN27drcgVyuv/
         I8iZX1otP50crcietvy/EkXoXQRlREuNRtcy2Csbpr2oxQo30muYBmCoD709YtxlNwBh
         JDxZE3gpcDnKlOjHFHaca2lGADd6XNgb0pccWqpfEzAe2y1cNQkD6XXLmzv9HjmOdCML
         NuNkeljXQozjK/zdiLRUVi7LGaLsgckXtYc3Ozzvuck5q3hUaZtIflZMGd5ArVLRXRo9
         zD6Q==
X-Gm-Message-State: AAQBX9c044zFxPt9Kx0Z+s+RPi8zcns43O3U/X9/kPsCDIKz4HdnAtvb
        OLU53laflKHm6TtvwpiNEJYNdU5iVAY=
X-Google-Smtp-Source: AKy350b8xB+pS08P/RTE+vtsT+OYHx8D56EEHJ1NNYE1pAQ/9JIuA+ApY5YPxoL+3a+b0ezuo36u6Q==
X-Received: by 2002:a05:6870:4150:b0:187:cebb:ce1 with SMTP id r16-20020a056870415000b00187cebb0ce1mr9183221oad.33.1682355045330;
        Mon, 24 Apr 2023 09:50:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i4-20020a056870864400b0018e996a507esm1438684oal.31.2023.04.24.09.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/15] version-gen: trivial cleanup
Date:   Mon, 24 Apr 2023 10:50:28 -0600
Message-Id: <20230424165041.25180-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use `git-foo` since git 1.6.

HEAD is the default of `git describe`.

Also, deal with a bunch of shellcheck warnings.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 29d634a30b..6dd7683ee7 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -7,7 +7,7 @@ LF='
 '
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) || return 1
+	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
 	case "$VN" in
 	*$LF*)
 		return 1
@@ -22,26 +22,24 @@ describe () {
 }
 
 # First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
+# then try `git describe`, then default.
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git && describe
+elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=$(expr "$VN" : 'v*\(.*\)')
 
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
 else
-	VC=unset
+	VC='unset'
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
+test "$VN" = "$VC" && exit
+echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

