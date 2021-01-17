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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC3CC433E9
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2A22DA9
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAQEDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbhAQEDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:03:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDCC061757
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w5so13179993wrm.11
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 20:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iebpkCS+CosQGGcqJCeaoOyETtTcGihIckpNXbtABE0=;
        b=ABjd1yhVOlLoaJHOq0/3VC5IaRNpb1d2GJHacGVHUlDR8uJlXTY6LK+wkDN35X/BEz
         Tdhz+VOXmS96Wpk7qFxvqSW5OhQ+p1PSly/smx4GwanwtcvW8agMUJo2hdrRT4miKsJt
         aNSUHleci+MzwR+rV3t1K4auEvIbhkak2N43CpWly2JgXlUHLVcgWf3uTCswewbbKrA9
         NpMs8dRmuqCjqWTtGUFRuQ9ZrsQG3wXgEnlwFdoFdhfPGIlC4NYSe1i9DDB9iR/31AV8
         2BW8ueYnL/fy2kSdSktOHKqfPhOYy2cfWLCy+Twn2sxa7li7wfWPX+zOxI9X2qnO0SNl
         Ditw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iebpkCS+CosQGGcqJCeaoOyETtTcGihIckpNXbtABE0=;
        b=mw9h95e+DApcjwh/r/NPeppepWC+MXFynZHN3xuvQq5nwVqims1Z6/IJaLhxJTZaiX
         fK6rYsEjekwW9tjH+0H0Vm15Eh4RTPYWTwUW2Legrdf/Uy4GpawISX3zWTgcqcyI8ARL
         XpXKE79cv3RtJMfqLNddBxyPEj8Gc68T+X3xX66vBAYRQxJbLmlKwuoSNyxQzTwsFist
         uWtU3GV2sdkhjxkLDN8Zt36/oKCCWmLGLAS8Q8lzdCxQV+QTjZcm3zIhKtwDIcNISYzO
         M8TxM2YSmbwwT2Pg0MOlq7Dc/jYE5qGRPDu/WRVuqiVFtRkLZz/Af2UDAtK4oA3OQlrR
         R5tg==
X-Gm-Message-State: AOAM5315KpSYmdUUcb2RAeqrJANikEbu+iiKc2U3vFklYf39nnVBeVAs
        afkK1TQDFTbn2jKaHeTzTIez3tCLIUY=
X-Google-Smtp-Source: ABdhPJygYotjUn0AH1ESwkU85DWURYJpLG+3SRnJc9k/sy6ujubPcw9jyJn3Yn+ggqTEJdYT9Qd/Ew==
X-Received: by 2002:adf:8503:: with SMTP id 3mr20256703wrh.56.1610856139105;
        Sat, 16 Jan 2021 20:02:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm20335986wrm.17.2021.01.16.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 20:02:18 -0800 (PST)
Message-Id: <50efd9b45b1f5ea09af5268a081e1f131e0f2da4.1610856136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Jan 2021 04:02:15 +0000
Subject: [PATCH v4 2/3] ls_files.c: consolidate two for loops into one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
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
 builtin/ls-files.c | 68 +++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6f97a23c2dc..49c242128d7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -312,49 +312,37 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
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
-			int err;
+	if (! (show_cached || show_stage || show_deleted || show_modified))
+		return;
+	for (i = 0; i < repo->index->cache_nr; i++) {
+		const struct cache_entry *ce = repo->index->cache[i];
+		struct stat st;
+		int err;
 
-			construct_fullname(&fullname, repo, ce);
+		construct_fullname(&fullname, repo, ce);
 
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			if (ce_skip_worktree(ce))
-				continue;
-			err = lstat(fullname.buf, &st);
-			if (err) {
-					if (show_deleted)
-						show_ce(repo, dir, ce, fullname.buf, tag_removed);
-					if (show_modified)
-						show_ce(repo, dir, ce, fullname.buf, tag_modified);
-			}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
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
+		if (ce_skip_worktree(ce))
+			continue;
+		err = lstat(fullname.buf, &st);
+		if (err) {
+				if (show_deleted)
+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
+				if (show_modified)
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			show_ce(repo, dir, ce, fullname.buf, tag_modified);
 	}
 
 	strbuf_release(&fullname);
-- 
gitgitgadget

