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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B08C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E322CAF
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbhAXKzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbhAXKzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:55:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9669C06174A
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so9357120wrc.7
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GP5PnqLYwbr09MZepCskm2EciyWOk0VFQMALvYuJKt8=;
        b=gnPR/vS1vHx2b52L9q+G1mBat4xMchMkeS0PNXUFw8LCDqTzpmikXI0D53uJBsNa/R
         RW3jSMqspvvNTlKCOVHLK2h4m+KMctXnLynAx7QTKIuUIegrDCQaSwlaU16W5Sepfg90
         of3yAZhEEENLxWvMK+ghJtkDdkQwwqSGOdmIvejDMi/17wKZ9vHMLZpp8rjN/i8xJH7o
         Swnut1alZJ3IR3aSkyS6bYTsfpxEepfWbZxhXMtprxmxSl7Ayyme7hrrBO+A58v2r8eb
         AV21bTpukIFLOjoQbj6oUHI302vhs3Ucsdvz8yHva+qt2MvGDAlqiptinaXv40FrZzGv
         HZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GP5PnqLYwbr09MZepCskm2EciyWOk0VFQMALvYuJKt8=;
        b=BIcgCHhSiPt2El1DfrCtedWc/H9xrigZ35MLbYNJn+U5IurHoiUdTp/r3SWJjKOURl
         zr9tS0q4Iv2qUD2puiRfUP21SwAcOteEhp7mK/8JuczzLFmMU1vFg+bRZIzpC1Y6i6Tp
         IluLTH6b5cpHlMywnn0lL9/T4h71tzi+EEcLDphT+1R7sEnVmeyCWTszmKRDLmBsQea2
         S31PsHWweQ5EdIXO72+mrTYdnvPN41K+caPyNWDIuhsHMGLg6jELWdLXnq1HW7aiWcab
         N6vfZtsxSPvXtpeZE/OHW5PGde5YDGnwt/Y4uhNtxg83LO1n0nF62wZhc1AJcgppLlkW
         WUZA==
X-Gm-Message-State: AOAM530TpPPEPM+3mNmlWzuWdrhPsEQ8/1itNCioHaW7KMWJvELm5dB8
        PcYLp515FtLtvjO+G6+YEg//UqciXv4=
X-Google-Smtp-Source: ABdhPJwF4DDuWStwclZ9h/40IIs2Vf/48jTSpBEvYOl21MHNmb6Ps1YXDdPuWocgeQLSNNWf8AcEDg==
X-Received: by 2002:adf:c106:: with SMTP id r6mr12046166wre.175.1611485670460;
        Sun, 24 Jan 2021 02:54:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm17985263wmh.3.2021.01.24.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:54:29 -0800 (PST)
Message-Id: <f9d5e44d2c08b9e3d05a73b0a6e520ef7bb889c9.1611485667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Jan 2021 10:54:26 +0000
Subject: [PATCH v7 2/3] ls_files.c: consolidate two for loops into one
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

This will make it easier to show only one entry per filename in the
next step.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: corrected the log message]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

