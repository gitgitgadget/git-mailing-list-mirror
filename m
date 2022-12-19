Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9E8C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiLSSiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLSShc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:37:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63813F34
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:34:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id co23so9594830wrb.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8q70x0q/h/3KRURt0JizQYnaRjKxactmoygBWFeLBx0=;
        b=omGQdiubKJzIW+EO8aSs4LfxJGGDIyI90kxtzbLKGs7Ue2UZS9Pbgk8gP9GtStVHMu
         4OyQzuq1bqi4XlNna9RvToOBzFLzg9hHxOHWB86FE25EJexsY4jHAQObxltLpt/1jh3w
         5KLwMuZoH8W057pHlc1Er2vMuOA0F0xPQK6dG+XsVLFsw3u17QNWL7aUH8KpDaB03C4T
         m0vr98n5+t7nWwj95iQ0XmbUkRKvArhEFqJe6escccDHYvgrKukCKV3U5gb9+GnSkHaP
         9881cn000S5THALpMEzJDsTXiBLOc7pLF5D8XL4Oz/9phTfQ2ZxagO9bf9sLBVOaravZ
         8Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q70x0q/h/3KRURt0JizQYnaRjKxactmoygBWFeLBx0=;
        b=GIpFg7AgIKT0VSkxMF/MbGvmQKFU/IFdAIhGTe/nWn2WMvOp/XXBsBIGjlNkZ0huZ5
         yYvym8G1fL/e9Cb/Rgas+qxNSrNw+kdZF2UN5EY+/DJuzyfiwCFWABuCQkP/iCkv66DU
         eBE2NcdZo7j1OwLdXcVzQPTGveR/Wl0a/TmeboxCBNVU9AniMc86L3g7FafTxUM6Oawo
         Cxt/WFrI6Z8I1hD3uO1wZghk+kiah6W91l0+RSUoctbmeQdxNEep4MuYbD2n8T0Q+ec2
         lO8E3MJjzAmpjrwuNuKfc7Z75jTY6mVNrFqN9noliEN2kFSXzLvGgitK4TD5pa264o4B
         bDxg==
X-Gm-Message-State: AFqh2ko1BdSa9gDuxBYe/Up+5C2i2IfL1ScWvGYQkoAqQywhUFqZEdTL
        tdda31SCM+7EJm/vQFB7a4HjNF8ex6o=
X-Google-Smtp-Source: AMrXdXtqH49SkOQqWilA8YS24DpaGzdO9UqhzXI1vI/+5Rf6Lk1DpCdajEI6y8ltd670gm5meRV3/Q==
X-Received: by 2002:a05:6000:68e:b0:25a:f8a1:f138 with SMTP id bo14-20020a056000068e00b0025af8a1f138mr9602539wrb.65.1671474877490;
        Mon, 19 Dec 2022 10:34:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq19-20020a5d5a13000000b002421db5f279sm10723313wrb.78.2022.12.19.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:34:37 -0800 (PST)
Message-Id: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 18:34:36 +0000
Subject: [PATCH] win32: close handles of threads that have been joined
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

After joining threads, the handle to the original thread
should be closed as it no longer needs to be open.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: close handles of threads that have been joined
    
    After joining threads, the handle to the original thread should be
    closed as it no longer needs to be open.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v1
Pull-Request: https://github.com/git/git/pull/1406

 compat/win32/pthread.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..de89667ef70 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -39,14 +39,20 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
 	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
 	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		/* detach the thread once the join succeeds */
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		/* either thread is not joinable or another thread is waiting on
+		 * this, so we do not detatch */
+		return EINVAL;
+	default:
+	case WAIT_FAILED:
+		/* the function failed so we do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
