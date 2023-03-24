Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5743FC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 17:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjCXRPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjCXRPY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 13:15:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1946B9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:14:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so1556593wmr.4
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DdHr+QroQTujK3tThL677/4Sj4iMqBz64f7ZMSWmIc=;
        b=pHIyLNtlxs9cLoZj+T5AemNAjOTosDdN4uuVsHhHlY3S05a/B2TFkCi2vgRCS1HwIE
         mBSf3TyESNdSL25398Ura/OF0ZAzNvM/KPuymnE+zylvFxtH1ww2VoWfACJyD2umfnDu
         DRKFPvLxB1e2Ne6Q8NRKM7J3qokDmxXmceZO+m4rv0Jxz7Ly3kW6kETfK6Ce2psiw1/K
         k7r1O1ZNr1nJdYSIaesj8I02REwC7ZeGrHzN6XpK4nh1CUw2Su0tm+WDIJI8W0LDBVRi
         7JPWrQlPJeiwn9pn7HKgSlDdrFXKB2mB6FJde/ubOePzbTRHXK52pF+ZM94txpmRSA8S
         mAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DdHr+QroQTujK3tThL677/4Sj4iMqBz64f7ZMSWmIc=;
        b=LaNGkUxHM1nH+nSKATz31WcTbvgNph09CTwlY4POYfcgmOSLlmV9EfboMmKlYC/rNB
         lf4ApV0y87Ar3wpkT0QWMJRBb3+IeApOMheBsus7oi9Qb80iVrDZwskB29UpHRtIApEX
         dIvcpEvYVnLEQQ57+WhqYwYcy+tIrfMTbc8n/IC7iokI2Ur5v3nsskJtGVFBV98T+07r
         W/Acs+1VrxUmRdlWXGbIM/R2lI7+U5jRKQQrGEB0Tm6StFkUl7PsrPJZjyiQqQJLwwSz
         MS9JjyqYXyzXtu8tiyJcs/FksX74/PxE5XVSr40wZJlnG/0fOKLYfjmVI63CVuGqAlsa
         tKWg==
X-Gm-Message-State: AO0yUKUl3hb68CmXV/Qabd3dmNsGTuH8cT7GAyPBGjKoeHyy+UU26f4Q
        +qIBaBmYNGCHVYAXBYmKAuWpjApzxFo=
X-Google-Smtp-Source: AK7set8tPbFI9JNMIkjNLNjKcwjk3q7gIRq9VKDLYo9z5wyjTM5iHyGXjL9Zmy3DFSjtNqcO4GLu2Q==
X-Received: by 2002:a05:600c:2214:b0:3ee:289a:43a7 with SMTP id z20-20020a05600c221400b003ee289a43a7mr3724999wml.22.1679678091069;
        Fri, 24 Mar 2023 10:14:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c451400b003ee443bf0c7sm374637wmo.16.2023.03.24.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:14:50 -0700 (PDT)
Message-Id: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Mar 2023 17:14:50 +0000
Subject: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

CreateNamedPipeW is perfectly happy accepting pipe names with seemingly
embedded escape charcters (e.g. \b), WaitNamedPipeW is not and incorrectly
returns ERROR_FILE_NOT_FOUND when clearly a named pipe, succesfully created
with CreateNamedPipeW, exists.

For example, this network path is problemmatic:
\\batfs-sb29-cifs\vmgr\sbs29\my_git_repo

In order to work around this issue, rather than using the path to the
worktree directly as the name of the pipe, instead use the hash of the
worktree path.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
    fsmonitor: handle differences between Windows named pipe functions
    
    CreateNamedPipeW is perfectly happy accepting pipe names with embedded
    escape charcters (e.g. \b), WaitNamedPipeW is not and incorrectly
    returns ERROR_FILE_NOT_FOUND when clearly a named pipe with the given
    name exists.
    
    For example, this path is problemmatic:
    \batfs-sb29-cifs\vmgr\sbs29\my_git_repo
    
    In order to work around this issue, rather than using the path to the
    worktree directly as the name of the pipe, instead use the hash of the
    worktree path.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1503%2Fedecosta-mw%2Ffsmonitor_windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1503/edecosta-mw/fsmonitor_windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1503

 compat/simple-ipc/ipc-win32.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 20ea7b65e0b..867590abd10 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "hex.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
 #include "pkt-line.h"
@@ -17,27 +18,27 @@
 static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
 {
 	int off = 0;
-	struct strbuf realpath = STRBUF_INIT;
-
-	if (!strbuf_realpath(&realpath, path, 0))
-		return -1;
+	int ret = 0;
+	git_SHA_CTX sha1ctx;
+	struct strbuf real_path = STRBUF_INIT;
+	struct strbuf pipe_name = STRBUF_INIT;
+	unsigned char hash[GIT_MAX_RAWSZ];
 
-	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
-	if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
+	if (!strbuf_realpath(&real_path, path, 0))
 		return -1;
 
-	/* Handle drive prefix */
-	if (wpath[off] && wpath[off + 1] == L':') {
-		wpath[off + 1] = L'_';
-		off += 2;
-	}
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, real_path.buf, real_path.len);
+	git_SHA1_Final(hash, &sha1ctx);
+	strbuf_release(&real_path);
 
-	for (; wpath[off]; off++)
-		if (wpath[off] == L'/')
-			wpath[off] = L'\\';
+	strbuf_addf(&pipe_name, "git-fsmonitor-%s", hash_to_hex(hash));
+	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
+	if (xutftowcs(wpath + off, pipe_name.buf, alloc - off) < 0)
+		ret = -1;
 
-	strbuf_release(&realpath);
-	return 0;
+	strbuf_release(&pipe_name);
+	return ret;
 }
 
 static enum ipc_active_state get_active_state(wchar_t *pipe_path)

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
