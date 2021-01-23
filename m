Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D6C433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9847A22D75
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhAWKVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 05:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbhAWKUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 05:20:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D00C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so6484361wmq.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TyjZf0mT96/fEWF46OoQRjjJ1wDleRc+cRTYSJJH/UU=;
        b=LlhOKAu4kS+DD1lE3b66xzu2wkz2zPBn1osk/NdoMaka49E2y9vAFRaiwoCJxzBqd7
         U0f69GCC9vK0Qp7XLnFAN4aaOHefwimvMQJZq+uTbQZWeEsD1RG93z+LEcmNIuoSdnL2
         45f6BcXDGt9Ng50/ahtmBUm60Hed0ujsFrkhJjFX7lmKG8e9+yEeBkRiUrNsNh3jf10H
         Z0VDywz1npkvpdAC0KxpE8KMi8GZjWb8OFYgUIO2b0UV05VAuZgGJtMsGxf2deiJ4caa
         6wm00850hCyC9cdeEar/4OkWbFsIrMviu8cEgu0uF0xvx5YDIU9tgPEcMfbLY3qKahew
         o9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TyjZf0mT96/fEWF46OoQRjjJ1wDleRc+cRTYSJJH/UU=;
        b=ZdOPgSSpkfqydjYsnH/aWzJYQ/JkZA+kGXOK5fHOydtACLCGnD3sTgT8nv9f+I8fKE
         +OSL1zR0LMzYMWJol7ZSsjYvC1jEyfTMcWVR/dADt8KFPHgXRofRsBSdSOODj1md/ADj
         TN/+HB+Dg1iNBb1m0mp+P4wXnDpOKMVkKnBqCk0C4x+zkBNuQj61fkf/DXU6ImL3wwgs
         6RzmBUB8zIK7ZvtjUzScVyqG8//gTKF+kk7irEvjVM0+uziz54lndbRmq54dMwm06INd
         GOtxRU/relman9Of/ykTw69Ryctu2yyaA+VwUp5zCBZlrZF4RQg1vHKnQHoNUSH5i0e7
         zBYw==
X-Gm-Message-State: AOAM530nUgBp9G+bo3YhiIWyJwGK8T+vr9qzY4XUnhfKWIhzt1Wsdf0v
        Ek9rXiEUrQOGbT5oTudIMY2U9uNrED8=
X-Google-Smtp-Source: ABdhPJzyxyBDEXgZVgZDaeSX01jmqUpqys5fPnc9pz1ynvkIZcFDfWnuze/6LgYZIm/CENfvcOsj0A==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr7732082wma.118.1611397214090;
        Sat, 23 Jan 2021 02:20:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d30sm17430757wrc.92.2021.01.23.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 02:20:13 -0800 (PST)
Message-Id: <3997d390883e0ee13d343ad56cb535cd99d1af4e.1611397210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 10:20:09 +0000
Subject: [PATCH v6 2/3] ls_files.c: consolidate two for loops into one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Refactor the two for loops into one,skip showing the ce if it
has the same name as the previously shown one, only when doing so
won't lose information.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/ls-files.c | 70 ++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1e264bd1329..966c0ab0296 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -312,49 +312,39 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(repo->index, dir);
 	}
-	if (show_cached || show_stage) {
-		for (i = 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce = repo->index->cache[i];
-
-			construct_fullname(&fullname, repo, ce);
-
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (show_unmerged && !ce_stage(ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			show_ce(repo, dir, ce, fullname.buf,
-				ce_stage(ce) ? tag_unmerged :
-				(ce_skip_worktree(ce) ? tag_skip_worktree :
-				 tag_cached));
-		}
-	}
-	if (show_deleted || show_modified) {
-		for (i = 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce = repo->index->cache[i];
-			struct stat st;
-			int stat_err;
+	if (! (show_cached || show_stage || show_deleted || show_modified))
+		return;
+	for (i = 0; i < repo->index->cache_nr; i++) {
+		const struct cache_entry *ce = repo->index->cache[i];
+		struct stat st;
+		int stat_err;
 
-			construct_fullname(&fullname, repo, ce);
+		construct_fullname(&fullname, repo, ce);
 
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			if (ce_skip_worktree(ce))
-				continue;
-			stat_err = lstat(fullname.buf, &st);
-			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
-				error_errno("cannot lstat '%s'", fullname.buf);
-			if (stat_err && show_deleted)
-				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified &&
-				(stat_err || ie_modified(repo->index, ce, &st, 0)))
-					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+		if ((dir->flags & DIR_SHOW_IGNORED) &&
+			!ce_excluded(dir, repo->index, fullname.buf, ce))
+			continue;
+		if (ce->ce_flags & CE_UPDATE)
+			continue;
+		if (show_cached || show_stage) {
+			if (!show_unmerged || ce_stage(ce))
+				show_ce(repo, dir, ce, fullname.buf,
+					ce_stage(ce) ? tag_unmerged :
+					(ce_skip_worktree(ce) ? tag_skip_worktree :
+						tag_cached));
 		}
+		if (!show_deleted && !show_modified)
+			continue;
+		if (ce_skip_worktree(ce))
+			continue;
+		stat_err = lstat(fullname.buf, &st);
+		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
+			error_errno("cannot lstat '%s'", fullname.buf);
+		if (stat_err && show_deleted)
+			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+		if (show_modified &&
+			(stat_err || ie_modified(repo->index, ce, &st, 0)))
+				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 	}
 
 	strbuf_release(&fullname);
-- 
gitgitgadget

