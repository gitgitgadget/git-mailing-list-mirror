Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10BC43217
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiBOQAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiBOQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5657C087C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j26so22058189wrb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bVQOuNDx/E8BIA67X3H7/Oi34m9u80FBN5XoTePZszA=;
        b=SoUkOs0YOari/H9tPk2p3RtCyu/V2RakzgYl8UU5M4bPSW/pfrP8WNDGH9rYSd2dA8
         eXincdf69izbIn1wrmhrxK/I1eYQbWEOk66+MAqsTxocbvEUwhciS0mGX7khpvLK+DwB
         fhzGLaKqwI1H8niWaMa/9r5ymDiMPEnsXGzYY7Y+0zHy9Wz3zkXz/aITtttxSR+FnLlr
         0rnOscnZ3VAXnUT9Q4XSZZISKtxr4Ty1KiKRTcuoZ3vwT/HihiyHWqj4jX5FndSjLugh
         YRsbCcMenJyPoUF+85XDgLxx5dwAKeL3q6w2FcspWaJTS0q3EOGkF7b4P0+n2d+05O5g
         Dinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bVQOuNDx/E8BIA67X3H7/Oi34m9u80FBN5XoTePZszA=;
        b=WPxQkciAcfsGx6+uNcIGw2lpPzM4ySaqq6MN8WE9PeJY1rXTKmunfs9jGfb5p7Hjku
         vvMiKbTTkqXVs5l7E/H3FywHcG5lG/3eRpy6B4wN2sITLeESr9MM9ExqiW/C3ZkssyFu
         k3INBNCD7ehF0C9s7YDo11xwV0OUH8oSGNUu3Di6jo8TQyw5+ABAW5ZOayTJ6AJM7gCF
         QDHr0sX7ORgBJ/OWF5xLRZ+qFSADpY0/5tgAEm9Yi6tAAGkx+hb7jXGpFvshGo1Ju4lu
         GVx30BZOTvol78YPSKgqjACJpp2cUfqLQ/QLEzayMDfd+EC6RjA7e4jCVFkodH6wXzh4
         dksQ==
X-Gm-Message-State: AOAM532S3KPfRHOudoEOgJvLcQyDUPtjAq0G3BNz3uBCcRubT/JWWlR0
        YpFtJ0MmFQ2lUfoMADCJfD/3wcHmf6I=
X-Google-Smtp-Source: ABdhPJyC15If1TSbIFmkDNdX2GZ2TFzbJ1MemMY1AFSMC/aykzkOedo2M7pJuXyEcpyPqrfxljiYPQ==
X-Received: by 2002:adf:cd0f:: with SMTP id w15mr3655447wrm.335.1644940795325;
        Tue, 15 Feb 2022 07:59:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm10854977wmq.33.2022.02.15.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:54 -0800 (PST)
Message-Id: <496b3da35d0f9b8c68c6bc6c2bf2ca93ffe224b9.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:30 +0000
Subject: [PATCH 20/23] fsm-listen-darwin: shutdown daemon if worktree root is
 moved/renamed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the listener thread to shutdown the daemon if the spelling of the
worktree root directory changes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 87a8476b09f..d3afbbc53d6 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -178,6 +178,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	strbuf_release(&msg);
 }
 
+static int ef_is_root_changed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagRootChanged);
+}
+
 static int ef_is_root_delete(const FSEventStreamEventFlags ef)
 {
 	return (ef & kFSEventStreamEventFlagItemIsDir &&
@@ -287,6 +292,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_is_root_changed(event_flags[k])) {
+			/*
+			 * The spelling of the pathname of the root directory
+			 * has changed.  This includes the name of the root
+			 * directory itself of of any parent directory in the
+			 * path.
+			 *
+			 * (There may be other conditions that throw this,
+			 * but I couldn't find any information on it.)
+			 *
+			 * Force a shutdown now and avoid things getting
+			 * out of sync.  The Unix domain socket is inside
+			 * the .git directory and a spelling change will make
+			 * it hard for clients to rendezvous with us.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "event: root changed");
+			goto force_shutdown;
+		}
+
 		if (ef_ignore_xattr(event_flags[k])) {
 			trace_printf_key(&trace_fsmonitor,
 					 "ignore-xattr: '%s', flags=0x%x",
-- 
gitgitgadget

