Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68ADC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE5F61925
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYVcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 17:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFYVcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 17:32:01 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CEC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:29:40 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u11so12923733oiv.1
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVEX/pnMFSADStdRMpGkmT7VJWdVpnQHNatyqrNV4UA=;
        b=h7715B2h4pG84UdhhozmcZmS//4LofKcLzNyRudJAn7uwwOISTjfY3la1zp7aP54z6
         2NBfj43YepcIclel1WxJtBvHmeDKzWIgWR1NnxUN5vyLFnjLGIpaXmHVWPtl64fXppy3
         voVX4bSSLGBQqeF3elB1STTYQq/FSmPVYvX/XzvicTUb0vNvdCZpFEY9JXgKgchOUWF8
         wz2g/rqmsH6zv7Wc1muXwBdVB52ydKWPv94LDUrooEHLy+jd9MHjKtkgXU4NlbW0pHPB
         +FDynyrvjjGRd9CsTlM7L5J89q/D5k+2Vik88Zghs0lqVHD5y2fPytXWX/iIYvC8M2pC
         oadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVEX/pnMFSADStdRMpGkmT7VJWdVpnQHNatyqrNV4UA=;
        b=Fcq81RIiXRwL9LZxuO2fmsrv8WmTz18JOeeBCLmJDqJgYTtiXbGwJIzVIL31HLfJ8p
         +guizzxMvN5ZBL2iyYCvNyLQK83pNkCQj0Tn5PZsx9LIdfBVYr/7NNuwWoQvPsOEsbCF
         gKACRtxEXZUqFwJWEPHvVQ/ODmGQRJ53z+6Z23vbWwoMu6aPbajo/MBksEItWupmzzGf
         PYTD3/2mBuR4IQ3PPV/SZgXn5Mgjl40ZAQ9nzIp+WV2WCFhZPI7VNJyV2WuKY0Oi+lpg
         8TElfbaj1SaENXq7TOXOkVJmv9QOG38PgPBGJmTP2VbRsH8KhF7SfOj3lkC8g56IZll0
         srPw==
X-Gm-Message-State: AOAM530c9PAv+sTVyC2Xk/ZTNFOeT6GPM2YKpxFIgsUGiZdzr+jBdxms
        wTFMQ+qIjH2jUKZK5YaUn2rBOkmEvVe0DA==
X-Google-Smtp-Source: ABdhPJydehK7H5ry3Ya0KV7+3/Bb2o6d0kxtdeS6Hzrcw5Tx3ts1WnEADSNUpkYvau8ynemuA+omDA==
X-Received: by 2002:a05:6808:20a0:: with SMTP id s32mr12757099oiw.94.1624656579318;
        Fri, 25 Jun 2021 14:29:39 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id s12sm1321250otd.73.2021.06.25.14.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:29:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] version-gen: cleanup
Date:   Fri, 25 Jun 2021 16:29:33 -0500
Message-Id: <20210625212933.71607-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I sent this patch a long time ago and nobody saw any problem with it
other than a minor nit of using an if instead of an early exit.

https://lore.kernel.org/git/1381561628-20665-2-git-send-email-felipe.contreras@gmail.com/

 GIT-VERSION-GEN | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9c125f298a..60e0f8c6d2 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,22 +6,29 @@ DEF_VER=v2.32.0
 LF='
 '
 
-# First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
-if test -f version
-then
-	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
+describe () {
+	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) || return 1
 	case "$VN" in
-	*$LF*) (exit 1) ;;
+	*$LF*)
+		return 1
+		;;
 	v[0-9]*)
 		git update-index -q --refresh
 		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty" ;;
+		VN="$VN-dirty"
+		return 0
+		;;
 	esac
+}
+
+# First see if there is a version file (included in release tarballs),
+# then try 'git describe', then default.
+if test -f version
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(cat version) || VN="$DEF_VER"
+elif test -d ${GIT_DIR:-.git} -o -f .git && describe
+then
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
@@ -34,7 +41,6 @@ then
 else
 	VC=unset
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
+test "$VN" = "$VC" && exit
+echo >&2 "GIT_VERSION = $VN"
+echo "GIT_VERSION = $VN" >$GVF
-- 
2.32.0

