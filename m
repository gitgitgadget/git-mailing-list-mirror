Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CCEC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 05:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiKHFZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHFZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 00:25:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268318E3E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 21:25:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k8so19221072wrh.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 21:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+YnAkThO9HzhTn+HqRMWrcaH4Dn/OMl80XZMsz4NCA=;
        b=jW8GyFevz5iTb6HHxYGG+um2iORzBeUXQPtP2+YtwAXp51//IV4RMe3STg4K7rAlPd
         eiKY2Bd+p2wCptsxZq1rjL8dy3T8FMmmEPnymKBPPTPWoAjdfETHY5NcxrHHAvPWWl1P
         eybpB5EZrLIIbAQZnHBekf1J5EiFPateimuAPPhlOVm5WltKvH0k/Ul5xvZJqwiE82qd
         TwjAYATv+ZJAbSu/4r2/JFhq6kr6h4YRbWCuIyjtd2ZIhE6YMgw5CO17nlTonw+gZx2Y
         UADOs/bCJdrEJWytPm0KCLCMirhoBAxp/2Slva50XfKlRzk05niIVNf+2CYJfp0KJEVY
         AHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+YnAkThO9HzhTn+HqRMWrcaH4Dn/OMl80XZMsz4NCA=;
        b=Bj52hm93ohf+oeLxj6PiTncivvhZ5u3131IDVNr32KqqVR1Z/mE2o12OSaZZe3bdBH
         ZbWmWdc+xrRafrc+1BPBZ0GZUkHxXSK9+niUNmjhH5YtesDM00YabwxBWlRwP+YWiAeD
         GdfbxavhmjisheEZksmRKcS3jLOb0geNvKQ/xXodtIIL0rRySukYoqmLBpUaph3AEGGn
         HmOoR5vj+MN+GzuuEpRbE/m2+gmHbw64HN5lFIWUPLdsWA3GpMI1fCMscNJfeFCYXXAh
         BCJVgsWDWfjXIHmzN91zT3JTim4rBpVJ/EPgCwCmUgxFGDldAXNnlDnwQrzmsl8TFE8e
         JgWQ==
X-Gm-Message-State: ACrzQf06jo68YRi6HinUuJ5bNMg29zqm9rQ1smOxHPg0CQNtUaoVFBRt
        +5MCSRySkQ74qx7ESXamfRTKKrsXSOc=
X-Google-Smtp-Source: AMsMyM548PGAldsmHkKJVQAoksPW434n6CnIUv9Cu/aPojxExe9WOq5K63q1xPWVeeJT5cfHH5Bnrw==
X-Received: by 2002:a5d:6ac7:0:b0:236:b281:150 with SMTP id u7-20020a5d6ac7000000b00236b2810150mr33440888wrw.29.1667885120964;
        Mon, 07 Nov 2022 21:25:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a056000104300b0022584c82c80sm9035982wrx.19.2022.11.07.21.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 21:25:20 -0800 (PST)
Message-Id: <pull.1406.git.1667885119570.gitgitgadget@gmail.com>
From:   "srz_zumix via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 05:25:19 +0000
Subject: [PATCH] fsmonitor--daemon: on macOS support symlink
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     srz_zumix <zumix.cpp@gmail.com>, srz_zumix <zumix.cpp@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: srz_zumix <zumix.cpp@gmail.com>

Resolves a problem where symbolic links were not showing up in diff when
created or modified.

kFSEventStreamEventFlagItemIsSymlink is also treated as a file update.
This is because kFSEventStreamEventFlagItemIsFile is not included in
FSEvents when creating or deleting symbolic links. For example:

$ ln -snf t test
  fsevent: '/path/to/dir/test', flags=0x40100 ItemCreated|ItemIsSymlink|
$ ln -snf ci test
  fsevent: '/path/to/dir/test', flags=0x40200 ItemIsSymlink|ItemRemoved|
  fsevent: '/path/to/dir/test', flags=0x40100 ItemCreated|ItemIsSymlink|

Signed-off-by: srz_zumix <zumix.cpp@gmail.com>
---
    fsmonitor--daemon: on macOS support symlink
    
    Resolves a problem where symbolic links were not showing up in diff when
    created or modified. (on macOS with git config core.fsmonitor=true)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1406%2Fsrz-zumix%2Ffeature%2Fdarwin_symlink-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1406/srz-zumix/feature/darwin_symlink-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1406

 compat/fsmonitor/fsm-listen-darwin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index daeee4e465c..cc9af1e3cb3 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -336,7 +336,7 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			 * know how much to invalidate/refresh.
 			 */
 
-			if (event_flags[k] & kFSEventStreamEventFlagItemIsFile) {
+			if (event_flags[k] & (kFSEventStreamEventFlagItemIsFile | kFSEventStreamEventFlagItemIsSymlink)) {
 				const char *rel = path_k +
 					state->path_worktree_watch.len + 1;
 

base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
-- 
gitgitgadget
