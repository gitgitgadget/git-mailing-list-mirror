Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB537C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 00:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLPAn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 19:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLPAn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 19:43:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA432BA9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 16:43:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u12so1021600wrr.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 16:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwaNqMKgH1pWD606B9qBrtR/UWuBXj9K6Je2p5gTQbE=;
        b=SAxKq5jQ6Gpu1PuowPhczwCWfbZq+lBB50PpdgdfGNOMRYRlkkFeQaz2nuhlV4F+og
         D7qPk7FWPfDPD4t2JJEDHZtlDW/gZVyS+9rSxSD1kufwtdTUmaMSCNAR858nx5eYKRkr
         k7fwvG5bR7pLuxiv02BLzd1IjMXgeosflLF/MNWxTR/tJsCG+5LGAy+tUO0DGl8+v3DV
         CldHE6LY1RiCm9ziM5/pscULxCPkilX8LREscaxSaFCIo8ool93Dn3SjJPzsGmX04iCp
         dxxj1Uz0DRUQutGF+iEJwU+Vn17nUNsSFi/x0PGPzGaNoHTFDWCFcX2LTk8OokCLE57c
         Buvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwaNqMKgH1pWD606B9qBrtR/UWuBXj9K6Je2p5gTQbE=;
        b=jJ5lunX0WyKTHv/4Hp0poZ0h+jYoANMB2upGVpPveZeWOsRibwOA8Hde60iXSedFET
         sYLh38GZj0KF5ezVUROSnu3OVVHNXKlRavm7+MGYi2Yao97vsEObPqqkIqU3XylHVD9n
         Hgf0zWr3vaCbYojZMXfPetvgC3ioVoBQq+X4jwCShPyssX/O2PD26yZlQFmCUjNzHGWa
         q09SmdWmcYDBN5qpD79LefDahLsCUGexPiwxDKbxzHOobq6QK3RioXiNDvhLx7KCzrF4
         F5CXnDIN+xqyrDrBwWZZuoQHjPv9fJVq1VQKfMYLLDkNAlDZJ2nidRgMgot9D1fDxN57
         MMsg==
X-Gm-Message-State: ANoB5pnM9h6JJWGmqrTGs7ExB6uFiZvffjgi+8ywu8m1eKDXlma6U94I
        fNyMcDgf3fH3yqUjFc2jIfgPxHaVsqw=
X-Google-Smtp-Source: AA0mqf4PtdBIhdnibPdEdQkizGrlrYpz6yO+ZvTHoKBBnhQrO35jKlZL8g54+grWKLO1SzMm2ggeNA==
X-Received: by 2002:adf:f14c:0:b0:24f:dbcd:7726 with SMTP id y12-20020adff14c000000b0024fdbcd7726mr12724938wro.5.1671151403631;
        Thu, 15 Dec 2022 16:43:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfe602000000b002368f6b56desm893393wrm.18.2022.12.15.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 16:43:23 -0800 (PST)
Message-Id: <pull.1397.git.git.1671151402532.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 00:43:22 +0000
Subject: [PATCH] bisect: remove check for fp and move the goto label after the
 fclose
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

The fp check in these function are only relevant if goto has been taken.

Because of this, we should move the label so that fclose is not called.

This is because the goto is taken when fp is 0 anyway.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    bisect: remove check for fp and move the goto label after the fclose
    
    The fp check in these function are only relevant if goto has been taken.
    
    Because of this, we should move the label so that fclose is not called.
    
    This is because the goto is taken when fp is 0 anyway.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1397%2FAtariDreams%2Ffclose-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1397/AtariDreams/fclose-v1
Pull-Request: https://github.com/git/git/pull/1397

 builtin/bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index cc9483e8515..2e5dbc8be3b 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -316,9 +316,9 @@ static int bisect_write(const char *state, const char *rev,
 	if (!nolog)
 		fprintf(fp, "git bisect %s %s\n", state, rev);
 
+	fclose(fp);
+
 finish:
-	if (fp)
-		fclose(fp);
 	strbuf_release(&tag);
 	return res;
 }
@@ -484,9 +484,9 @@ static int get_terms(struct bisect_terms *terms)
 	strbuf_getline_lf(&str, fp);
 	terms->term_good = strbuf_detach(&str, NULL);
 
+	fclose(fp);
+
 finish:
-	if (fp)
-		fclose(fp);
 	strbuf_release(&str);
 	return res;
 }

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
