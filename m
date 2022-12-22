Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A21C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiLVU7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 15:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVU7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 15:59:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3C62D2
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 12:59:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z10so2822826wrh.10
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SHuXzOqtWzTpy9VMcv4jbFw+pLkz5cn05Igrt/lQyAk=;
        b=P5+Hr4c5ExYbeEBmPlkYB9Q0u57Z9uQOFjrb3iJpZUsQEIr9vrUda+62I+5EPW6cGh
         a19oFW9JyTVEMiZU/OF3QBh/LE5rW16hdr2GDIwoLVLYDr+ovZanulYD0mWQVVa1vZ2G
         rlvVuB9gZE+PMahKz3SjOciHqmkHgymIZw+OaFk9lBkj/Jg3+XFtJGpZovMyqTanCHlE
         072PQGDEBPkEXQg06tXBZzgy6fx5A77xeKvKhW2KzIBDk7HppkMXtEX79lABCigdzImL
         ZRxMVe1UwnUICfc8i27LrkXUxq98DAX8jaEREEaAQdiv76xNZxNu8tJe7vnBc3+R75h6
         xTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHuXzOqtWzTpy9VMcv4jbFw+pLkz5cn05Igrt/lQyAk=;
        b=jfZJzZPG2o/DgObs+xwjZ5X18nt9ZmIgcpoFdLIEwl7yo+JDsTyXhmr3W6fNc6q7nH
         TwRx/ZANsoaoHk9+4ZhKwPlzbyTh1/r8Y5gSu9HzF0FuNF3MQzspf9gqRrNIHbyJq6wx
         ZGpK6KkW1fz1YoKmY+0XRN7FP4U/BsLjqijHEph0xaXpq+ByO6+2kGa4GOdJ2GfXplak
         LV8lRnQ8lziKP/JWA4vKjUhgQGT3q0PLhqdANlFFcRHmq/t/Rw5h8iQknuiF6b0Dymrh
         FcLLOUz+q8z8f1ypP6oRkkPxlD8jMv8Jmv2Fh9Cg43A2W0X7NPqFd6oxpv14R7qBnD+e
         /btg==
X-Gm-Message-State: AFqh2koUPUo1kA7Xu+hM6fCOxB721awEWeM2J2n5xxhbZvA+D2kUklNy
        8LmjoqFRf7bPYB6IrNl2rB/hMpjLzs8=
X-Google-Smtp-Source: AMrXdXuy5wEcSYN+hq8FNq0YsULmyteKp7gbyYSCJbl5oxEKUIIaKpWO0Bu8xPhx2rOCrlZPI3/jgw==
X-Received: by 2002:adf:e283:0:b0:242:324e:b3d with SMTP id v3-20020adfe283000000b00242324e0b3dmr4381700wri.1.1671742751476;
        Thu, 22 Dec 2022 12:59:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d4b43000000b00241f029e672sm1328701wrs.107.2022.12.22.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 12:59:11 -0800 (PST)
Message-Id: <pull.1414.git.git.1671742750504.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 20:59:10 +0000
Subject: [PATCH] win32: use _endthreadex to terminate threads, not ExitThread
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

This is a pretty serious bug actually:
Because we use the C runtime and
use _beginthreadex to create pthreads,
pthread_exit MUST use _endthreadex.

Otherwise, according to Microsoft:
"Failure to do so results in small
memory leaks when the thread
calls ExitThread."

Simply put, this is not the same as ExitThread.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: use _endthreadex to terminate threads, not ExitThread
    
    This is a pretty serious bug actually: Because we use the C runtime and
    use _beginthread to create pthreads, pthread_exit MUST use _endthread.
    
    Otherwise, according to Microsoft: "Failure to do so results in small
    memory leaks when the thread calls ExitThread."
    
    Simply put, this is not the same as ExitThread.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1414%2FAtariDreams%2Fsevere-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1414/AtariDreams/severe-bug-v1
Pull-Request: https://github.com/git/git/pull/1414

 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 737983d00ba..cc3221cb2c8 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -66,7 +66,7 @@ pthread_t pthread_self(void);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
-	ExitThread((DWORD)(intptr_t)ret);
+	_endthreadex((unsigned)(uintptr_t)ret);
 }
 
 typedef DWORD pthread_key_t;

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
