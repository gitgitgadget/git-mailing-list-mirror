Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BAC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 19:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjASTeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjASTek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 14:34:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F554FC20
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:34:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t5so2897768wrq.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoKy8LlyuR966Nh5t32z8WXtLsQcw86mjWBEGjZxvCE=;
        b=p5FdB/SIlkb3CF2PgKpK7Rgv8pEvp9pRgPbCoK2dZFFJhyC5rZcQhHh0/4WkxYte1M
         Gp+vUuKTWVhhKnoYlpIW6lFgICDS36WGNPZ99gZxPPzcNvSWgja17603E8JyZOwPaSit
         EahfxQGKyGi/w88YFwNMIn9YdcfyMjuQDZtsW3nRrZYoQ8Z1rbV+mWSrONPdVCjWkrvB
         BRWUyVCmS6RErOWRRwhVid2zsnQvS5uXIfbqLcRggPxu0rJBPkmbVlBKDKKQNpJtrGtB
         BcApC447SWw6szUhKQY7l01VbOq71W6a4delCGWe62mrpdHr1flBPhN/I0vFYstLtTxr
         E/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoKy8LlyuR966Nh5t32z8WXtLsQcw86mjWBEGjZxvCE=;
        b=Z4qnmQJJimVgp7rZ4DK0vsPeDflfOWvViRkIEJSdCw5jnqUTpnPcY8SJwyoJpYZLu1
         tOw3WnCZ4XEWAvOBrFngChmK97TLZTZkv4x9j5cdZqL2bc+hTQWQwh38ds7Csn0AR4KV
         5/b1s6lEz48MCaGolUn+9/MFSCHnwcEO0MS+Eng/sehpGWPnry4vkTRjGa2MFlTppbDZ
         gJ5Vud0Wu1RqCeImjBFyYmdFfYPCJR/f845fWsPO28q6IczivXfoCLXWCb0uXh7lL/Gh
         IS7HaYqNH7SQLxIrpAmzygDGPkmp4e7dm5M6V8wwnsAKKbTYikb8h7BAOP2kfA6WMOZn
         oiRw==
X-Gm-Message-State: AFqh2krlP71IrMtwstK/04WQAvZGQrJI3ULLUUnZYa0xPDbBfMkhf5uf
        3b4savhgbzZOiA9jsgaFure8W18RLEE=
X-Google-Smtp-Source: AMrXdXuRYRUwOl/4GdDwrOGIMsL23s2xUr6T3UlYZxLfMGx4v6YW63QKe+J6c+KDNKTD8kncniae/g==
X-Received: by 2002:adf:de10:0:b0:297:811e:9a72 with SMTP id b16-20020adfde10000000b00297811e9a72mr10703476wrm.54.1674156876525;
        Thu, 19 Jan 2023 11:34:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm16684154wrc.17.2023.01.19.11.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:34:36 -0800 (PST)
Message-Id: <pull.1439.git.git.1674156875354.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 19:34:35 +0000
Subject: [PATCH] die: fix inconsistencies with header
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

The headers for the die and usage functions
have different parameter names or are missing
the "NORETURN" attribute

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    die: fix inconsistencies with header
    
    The headers for the die and usage functions have different parameter
    names or are missing the "NORETURN" attribute
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1439%2FAtariDreams%2Fperror-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1439/AtariDreams/perror-v1
Pull-Request: https://github.com/git/git/pull/1439

 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 contrib/credential/wincred/git-credential-wincred.c         | 2 +-
 usage.c                                                     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index e29cc28779d..fa88d621865 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -11,7 +11,7 @@ static char *password;
 static UInt16 port;
 
 __attribute__((format (printf, 1, 2)))
-static void die(const char *err, ...)
+static void NORETURN die(const char *err, ...)
 {
 	char msg[4096];
 	va_list params;
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c78..c0610d7648c 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,7 +12,7 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
 __attribute__((format (printf, 1, 2)))
-static void die(const char *err, ...)
+static void NORETURN die(const char *err, ...)
 {
 	char msg[4096];
 	va_list params;
diff --git a/usage.c b/usage.c
index 5a7c6c346c1..5f5510ceeeb 100644
--- a/usage.c
+++ b/usage.c
@@ -206,7 +206,7 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
-void NORETURN die_errno(const char *fmt, ...)
+void NORETURN die_errno(const char *err, ...)
 {
 	char buf[1024];
 	va_list params;
@@ -217,8 +217,8 @@ void NORETURN die_errno(const char *fmt, ...)
 		exit(128);
 	}
 
-	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_start(params, err);
+	die_routine(fmt_with_err(buf, sizeof(buf), err), params);
 	va_end(params);
 }
 

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
