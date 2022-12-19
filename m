Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiLSPxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiLSPx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:53:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3698D12087
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:51:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h10so9103269wrx.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtDAz+FYEeL+Kqq1tRnLGXIEnscCZTjc+zSHtJSGhs0=;
        b=gsIbYaLSJw2NdfFg0MRzLF6zqlttco0/6j1hCgqRLKj8rcxdnt6Lj7O7fd9UUQoHaX
         I3QUZK7yE7Ftp6lwrmy1wWqLvzAqHlpcxxxbu3+aR8KVdxCmh9v14uZ6Fl+pqF3Bi67T
         BV0Fy/L0nhB/bFUO518u2zGQ6u25BBOS1aJz/Zm14B9Vm04hruzjCtJIRUUrEXeCCZyh
         lDm+/P1Q9Bq9CcBUIEqK8F4aJzp1Uw1IcpcCUrN/GYWu5DWN2MPiuCC5OcPCbyxmbGTp
         Hu/zpfZgZm0UofvWRFRixF0P6Od0v7M1V1ylWsR7/IxxsWCVe6PN2CJvpPGKIN4mUPdi
         VcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtDAz+FYEeL+Kqq1tRnLGXIEnscCZTjc+zSHtJSGhs0=;
        b=5+Gyg8aKCixPre/2RQ30rXxJBoKY96UpfmyzZxmzam145TQO1uV+B48n3YCJa3VdcB
         Qej7BlfmqUJX84VbLrP1oEenEe9npxCXLcbR8CKfherpkMqIrZBoX5Oiuun2o40FNTAq
         9nl1ns3LlEolR82v0pifTQdqftg5SkYaz5Ls/3l8NEzhPlusQ3zc57BtVUIBUlUbpSEd
         0ph4lhddp3PBmZtF05/rC0/yTIsFo2AiRrCeE/vK50InmoGFbz9xX4kDKr0n7GC6xWQh
         8Q7fyjFpJbcAhfr0ZyNB51suY2RBSkgngEMxfxCtJAFfkz3jOQnwGwyu5ffsi0KsZOzl
         xWng==
X-Gm-Message-State: ANoB5pnK+aqoijnu3w9md3Sp0HzvsqyNeA8GC86ReLikRWEWEIU6AFYb
        LKMsfHkBh8tyWuQZTtMoSU2Cs/EGQy8=
X-Google-Smtp-Source: AA0mqf4sEAoWCOvWZC3kXuyHRk4BhXcAZqpwOLX0/LsdTMJ+bkeTS0uLsUdE67+Bd47dhJk2Wl38wQ==
X-Received: by 2002:a5d:410c:0:b0:242:1c5f:9bf5 with SMTP id l12-20020a5d410c000000b002421c5f9bf5mr24106785wrp.8.1671465109489;
        Mon, 19 Dec 2022 07:51:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020adfe6c6000000b00241e8d00b79sm11978215wrm.54.2022.12.19.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:51:49 -0800 (PST)
Message-Id: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 15:51:48 +0000
Subject: [PATCH] Explicitly set errno to ENOENT if err is not ERROR_DIRECTORY
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

At this point, the only two possible errors are
ERROR_DIRECTORY or ERROR_BAD_PATHNAME.

This code clarifies this and also saves a call to
err_win_to_posix.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    Explicitly set errno to ENOENT if err is not ERROR_DIRECTORY
    
    At this point, the only two possible errors are ERROR_DIRECTORY or
    ERROR_BAD_PATHNAME.
    
    This code clarifies this and also saves a call to err_win_to_posix.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1402%2FAtariDreams%2Fopendir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1402/AtariDreams/opendir-v1
Pull-Request: https://github.com/git/git/pull/1402

 compat/win32/dirent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4d..8f94a5ab6db 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -34,13 +34,13 @@ DIR *opendir(const char *name)
 	if (len && !is_dir_sep(pattern[len - 1]))
 		pattern[len++] = '/';
 	pattern[len++] = '*';
-	pattern[len] = 0;
+	pattern[len] = '\0';
 
 	/* open find handle */
 	h = FindFirstFileW(pattern, &fdata);
 	if (h == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
-		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : err_win_to_posix(err);
+		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : ENOENT;
 		return NULL;
 	}
 

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
