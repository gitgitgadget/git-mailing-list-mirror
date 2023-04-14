Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB1C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDNMTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDNMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:02 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA869A26A
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:54 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w19-20020a9d6393000000b006a43ff0f57cso1010976otk.5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474734; x=1684066734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sTu8DDDcKxqs8OHsyqf7ijd1kHrvKVRJsUQq6XeabE=;
        b=eVo7o5QRXNMBU5JOKvtkZa4v9uGZ8tdE2YNb+0CV3/p5JtZ2ywWYzXBHYFlX/wJwIv
         tqePiV9foKDGavRcDW7+ev+Go2chNqilTT7hoNjOhrRfkBQtsbPkmBKtB1ZNAPytEzwv
         W3PdFW7P1QJ6U92L5PIrjhWx/2E3CvJ/CjF9zmDnJPGh7N6LqTvGLUVQTts9Kom2Kkcd
         tHXqt77yBP9Pi3DP5FXGlr7k20D+W5YwWDMDsLbLYlcrW4029uubJvdIyFlciaFTvRSI
         2x9Qi+PVHiNgnEoV4TemAi/1f/AX6AhTdKTtPkTPq2phneDAdv0R3jh9AkumWods9N0L
         iGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474734; x=1684066734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sTu8DDDcKxqs8OHsyqf7ijd1kHrvKVRJsUQq6XeabE=;
        b=T1VfvYTvZpMKvgK0uHQyHT12C8ULgkjyciDHxwtEUsVTThvHVD/HuQaSzhss+AvO1H
         jlfbk1oCz/rKtpYz5KCkT9zxRufYKEI9tNN/aV0yHvaO0VjRke00ixl9za++oKLSV/tC
         vO+zBjC2D+KZmAADF4SktLuA0qa1MOkzBU0gVBmj3cBHShNykDkk9qF6zW2wUUF1stzr
         k6BV4iyS0JKtkEZJ1PU+7kwMrS2Znlpds5v2XGZlm9/fFPVIzoNHEmeOr9A+YTBbFR/P
         cdjY8/MHT6jTzvaYhKiOU2wl3n4hGe3RyptEa0HamGYAGY51S0TXS+dbDPvIwPvIfnTM
         1sCQ==
X-Gm-Message-State: AAQBX9chHTIE0wCy29qYBfbVMZkabQgIArZePHW+qnirLBhqz9vdeVKX
        WgP1pzBTCY06KNifAR7ba807ah0u4Zg=
X-Google-Smtp-Source: AKy350Yrwxev/6nzMIAV5TT58j1MDaSyBoziZiiYyELcoXQcSs620NaGIFV9t4eVAHKUiM8lSSVL1A==
X-Received: by 2002:a05:6830:18c5:b0:6a1:3dfc:4e44 with SMTP id v5-20020a05683018c500b006a13dfc4e44mr3037087ote.27.1681474734011;
        Fri, 14 Apr 2023 05:18:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d7484000000b006a249e69aebsm1574627otk.81.2023.04.14.05.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/18] version-gen: simplify `git describe` checks
Date:   Fri, 14 Apr 2023 06:18:30 -0600
Message-Id: <20230414121841.373980-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How can `git describe --match 'foo*'` return something that doesn't
contain 'foo' and without error?

It can't, so no need for check for the impossible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index cd94a7902e..0021e88cdc 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,22 +3,11 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
-LF='
-'
-
 describe () {
 	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
-	case "$VN" in
-	*$LF*)
-		return 1
-		;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty"
-		return 0
-		;;
-	esac
+	git update-index -q --refresh
+	test -z "$(git diff-index --name-only HEAD --)" ||
+	VN="$VN-dirty"
 }
 
 # First see if there is a version file (included in release tarballs),
-- 
2.40.0+fc1

