Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82335C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 17:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiLSRRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiLSRRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 12:17:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8963646A
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 09:17:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso7027052wmb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 09:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=76iW3mDnqSjAVhB2a43w1yWRCDg2+y4HpMJh2iFPvFs=;
        b=Pq7lKfGXD76X/B2tRkSUsvXmn/aD//BeRHYttvXRRQJoBjRrrX2d1ceklxjwiIX0mx
         C84t1l848B6ffYFwU2O34lVMUllkMBFNARqD9HXoXxIUkPEXu0RAw1GcPtXZXaJfsrn8
         S+GWicdGb9eLiGAad2C4gtUvu3RspIRbNvXmACCS/DC6zC7haONxbe1AkWwQMV6MV1o4
         dCr2iqZ9PbFP9WPegaBg6dsv0Ruta4RlkAtfchkTL4/fLf+KW6jqfKYtVGKkYPn4DUKw
         kKMn5pYjyWfuP7xioeg+y6Od+xb48rvIQXf/Vjjq0h/Ldq5jWsHUTqdCqu1ldK4Ph3vy
         +sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76iW3mDnqSjAVhB2a43w1yWRCDg2+y4HpMJh2iFPvFs=;
        b=AMXmvW6NPyD3xsJI+pUWRqhb06Y/XRQoD3zHx2xcCUNpeqfPemo09boWEWsVOOUH+A
         +RlOEEZAEcw9kBD0ir3z7vl4lznNmpnkxt7gSb7Frlizr6Jqnsvqp4idU/Cvq9LPgOja
         kFTPlYN2ZxI5koIsBEca3NMc6hIQHza31/ThruLhZisRg+FAC/XAXbtWDm8k/MkI21aw
         jRxfniRHjibLx4v2CuMlBJg+YIl1dchuPSR58/HttYBR6Auezb3t3WaNIQEwjWu6X1ZP
         tIVr9z+pW94I3V/bGt85LmtIupikFb2oE4DG4l/AvPtz1yeIVN1Z7Bd2d6dxKWk6artW
         NeFw==
X-Gm-Message-State: ANoB5pkmhN4a5HQ10Y/pCF6hY0n8SfjVkaMD7q3+qo2y7Ov3NQjZd7Tl
        47PEiR7AUVgaRKKnl15x4VDJStDxqoQ=
X-Google-Smtp-Source: AA0mqf7DBSFsUU/e9ru6a8N7QOWh1Y2Rsdk9aJoL0JDXVhOB4y8/E0+K94O9EA3Xf0dmZEn1ahjP/Q==
X-Received: by 2002:a05:600c:1d02:b0:3cf:d365:1ea3 with SMTP id l2-20020a05600c1d0200b003cfd3651ea3mr33223057wms.12.1671470223312;
        Mon, 19 Dec 2022 09:17:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020a1c7710000000b003c6f3f6675bsm19502777wmi.26.2022.12.19.09.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:17:03 -0800 (PST)
Message-Id: <pull.1404.git.git.1671470222521.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 17:17:02 +0000
Subject: [PATCH] win32: ensure len does not cause any overreads
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

Check to make sure len is always less than MAX_PATH,
otherwise an overread will occur, which is
undefined behavior.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: ensure len does not cause any overreads
    
    Check to make sure len is always less than MAX_PATH, otherwise an
    overread will occur, which is undefined behavior.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1404%2FAtariDreams%2Foverread-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1404/AtariDreams/overread-v1
Pull-Request: https://github.com/git/git/pull/1404

 compat/win32/dirent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4d..0c1bdccdd58 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -27,7 +27,7 @@ DIR *opendir(const char *name)
 	DIR *dir;
 
 	/* convert name to UTF-16 and check length < MAX_PATH */
-	if ((len = xutftowcs_path(pattern, name)) < 0)
+	if ((len = xutftowcs_path(pattern, name)) < 0 || len > MAX_PATH)
 		return NULL;
 
 	/* append optional '/' and wildcard '*' */

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
