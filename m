Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17482C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 11:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiBIL60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiBIL5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A222E00FEC6
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 02:59:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so3249561wrc.13
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+7zGhFiGdhL/eHr/1nzwaaUo2iooJ/gzY8byscpxzG0=;
        b=CFKnHh+VL6FcQd5BjU9hKOyyjzqqSRRw3G3fuus2t/b1QFgzzEUIuqJ/1chiSt8dZj
         KdzIaNwPXrSQ33r1i8H/xZHITRgvtj2k1HpNSkdTgBRy1KZK6jrzOQOk1P/4dVw5+gMy
         KXMlgw4sx8vcrAq8kkB0w39Sd53S3wYPfIWUTJ6pzLELMzUszy3NI0misMbiAMRuwVbm
         F3LHCYX6IvFaDxNPOxVz3ps0nNognIH7aOOfq2rNFkz/0TnydgYUrnD9C4Kc2mWcCdgG
         0cpjPT1HEqFimPpaRckRFrBWzu4yrpVLHZ2Yc/L1cA0GXqC/nrJ3MrlnF9FVBLbJfBMP
         2Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+7zGhFiGdhL/eHr/1nzwaaUo2iooJ/gzY8byscpxzG0=;
        b=MvhVqk1/wXCnnLHBWsGzN8U+eR/7lAHL0GkqGsE/x+vYzKWLu1oci3tAz8zAjNIF0w
         z67Di6alsINy0zbFC4gnVltuY0elC3VYtio5kPzMci4ABA0Eu9meAURM3Go7pGM+LKjX
         9Ve8ry7vd51KxjNj8i5EpY4vFlk0oFWwkOiWiikIQdc7DY/pN56IKH23qd8YxcRXUCKK
         zKJPymR6H53ypZ70a9sR94tzxgO95SSmHDwk8xwnouhXgsQAfzdZvqadiAUA1uG6QRM2
         F21B2q6k33lQZMJ6oAuPiEDX62t11uGJlwy3B+KCgQkcbx7ZgSihPvjiEsVQ3Xj+t0LY
         gYuw==
X-Gm-Message-State: AOAM532a9J8sZTHQOZXb708MjULSJdBTcbgWCb7nvjx2ZG3A16edcsJe
        p2U1W1XEeRFA8W9hVbr1H6+AbqxNHUM=
X-Google-Smtp-Source: ABdhPJzGeXXbbRC2FdC6VGVMws430KnYibMxjsk6k6HKTM16sLc0dXolQD4plo/nx1PBD5MYuMZltA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr1666145wro.373.1644404358729;
        Wed, 09 Feb 2022 02:59:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm4187199wmm.15.2022.02.09.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:59:18 -0800 (PST)
Message-Id: <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 10:59:14 +0000
Subject: [PATCH 2/3] xdiff: refactor a function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rather than having to remember exactly what to free after an
allocation failure use the standard "goto out" pattern. This will
simplify the next commit that starts handling currently unhandled
failures.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmerge.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fff0b594f9a..48c5e9e3f35 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -684,35 +684,30 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		xmparam_t const *xmp, mmbuffer_t *result)
 {
-	xdchange_t *xscr1, *xscr2;
-	xdfenv_t xe1, xe2;
-	int status;
+	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
+	xdfenv_t xe1 = { 0 }, xe2 = { 0 };
+	int status = -1;
 	xpparam_t const *xpp = &xmp->xpp;
 
 	result->ptr = NULL;
 	result->size = 0;
 
-	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
-		return -1;
-	}
-	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
-	}
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0)
+		goto out;
+
+	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0)
+		goto out;
+
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe1, &xscr1) < 0) {
-		xdl_free_env(&xe1);
-		return -1;
-	}
+	    xdl_build_script(&xe1, &xscr1) < 0)
+		goto out;
+
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
-	    xdl_build_script(&xe2, &xscr2) < 0) {
-		xdl_free_script(xscr1);
-		xdl_free_env(&xe1);
-		xdl_free_env(&xe2);
-		return -1;
-	}
+	    xdl_build_script(&xe2, &xscr2) < 0)
+		goto out;
+
 	status = 0;
 	if (!xscr1) {
 		result->ptr = xdl_malloc(mf2->size);
@@ -727,6 +722,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 				      &xe2, xscr2,
 				      xmp, result);
 	}
+ out:
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
 
-- 
gitgitgadget

