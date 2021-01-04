Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8743BC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0E322473
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbhADQYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbhADQXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159C6C0617A0
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g20so37592912ejb.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkudzzghxuCldF99LMBvd7ZeIXMfW7S+vV2oM3Z7GZU=;
        b=GED/8U/niyC+bZI4kdvOE5q0dPGSWcGOLX/Lb4IQwEg/YRtB01eoblYijMQOZpSxxF
         feJoiCmBtcHhlOQpA/Xlc4DBQBsgvmj3kF42N1efc0KhF2+bBAHqLfgnfxDqZRvNQlno
         +LaA7ZiujQL2lJXKKy5jXK9FtgkfNYB38La6uEroRy2MVTtsIt7RQwADsNw+edU6XPdF
         6ALMpB2tpI9WMpNX2k8g7Px+5blpijyQW7DcR6Co9RneAWDrGg3OwMJitSIIYWJHOaG0
         A57so09Spr/gm/yT7QFt2IzbvKd/Y54wPrUmuWBu/tzLpwNoqaA+bXkYxJqvKaM3kdQH
         8dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkudzzghxuCldF99LMBvd7ZeIXMfW7S+vV2oM3Z7GZU=;
        b=EHY9VK1ZF51uUE4Plea2fqExnnkxxOvqV2e4j761/oxS6KSrAH6jeoYNb/hk9FPQYa
         KL0tHmecGfd9iZVd8FsXK62kCv3Ir8EwhfzErlPPFmVrSwEMWwzfYsqKQC61sjxh9H3L
         QD2MBrNRpuhTImWDwxZmckXYv62w0ekWg7JV+Z8mRcBeUycqse9rSgflC8poD1lgxytE
         HPIQ9xMRDapj1hq5c8xt9ULsnBjw+8uncBMQLtmutXJZ28Xphu8FUS3z0/3SCsxH++j6
         jejpFxIe1eIddwBVTBRHiqpy5LCPv+YsOJPMnKj7VLdIjDjFGqZOsRqI70yK/3qT2RkB
         RHcg==
X-Gm-Message-State: AOAM533w9U97mOPalMippKYycRDqEKu3s+06WZVd6N9Bro+rPOU9mtnG
        33WOaw7Gw54Vr+srxVWBxAMk91Je9KA=
X-Google-Smtp-Source: ABdhPJzYHGM87b3mGJoUjWyS7VXaDSvWADxTP63xTV0mAuWMTJb6hmztEwW3Ssci9KQbPkEYDpPo8Q==
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr65686682ejx.113.1609777341535;
        Mon, 04 Jan 2021 08:22:21 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:20 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 5/7] worktree: `list` escape lock reason in --porcelain
Date:   Mon,  4 Jan 2021 17:21:26 +0100
Message-Id: <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree list" porcelain format shows one attribute per line, each
attribute is listed with a label and value separated by a single space.
If any worktree is locked, a "locked" attribute is listed followed by the
reason, if available, otherwise only "locked" is shown.

In case the lock reason contains newline characters (i.e: LF or CRLF)
this will cause the format to break as each line should correspond to
one attribute. This leads to unwanted behavior, specially as the
porcelain is intended to be machine-readable. To address this shortcoming
let's teach "git worktree list" to escape any newline character before
outputting the locked reason for porcelain format.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index dedd4089e5..9156ccd67e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -567,6 +567,24 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
+static char *worktree_escape_reason(char *reason)
+{
+	struct strbuf escaped = STRBUF_INIT;
+	char *r;
+
+	for (r = reason; *r; r++) {
+		if (*r == '\r' && *(r + 1) && *(r + 1) == '\n') {
+			strbuf_addstr(&escaped, "\\r\\n");
+			r++;
+		} else if (*r == '\n')
+			strbuf_addstr(&escaped, "\\n");
+		else
+			strbuf_addch(&escaped, *r);
+	}
+
+	return strbuf_detach(&escaped, NULL);
+}
+
 static void show_worktree_porcelain(struct worktree *wt)
 {
 	printf("worktree %s\n", wt->path);
@@ -580,9 +598,11 @@ static void show_worktree_porcelain(struct worktree *wt)
 			printf("branch %s\n", wt->head_ref);
 
 		if (worktree_lock_reason(wt)) {
-			if (*wt->lock_reason)
-				printf("locked %s\n", wt->lock_reason);
-			else
+			if (*wt->lock_reason) {
+				char *reason = worktree_escape_reason(wt->lock_reason);
+				printf("locked %s\n", reason);
+				free(reason);
+			} else
 				printf("locked\n");
 		}
 
-- 
2.30.0.391.g469bf2a980

