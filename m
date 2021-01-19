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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D98C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099DE22CB1
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbhASGcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbhASGbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 01:31:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A0C061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c124so15442667wma.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jJ9Qw1W+HvIO5qmF1W1X8JylABMQea6oallp6y0iDek=;
        b=q+F6qZ3zcB94YK9Sh8xytLe0YfwGt/VPU7lxvRioKIHJoHIA5tqIbYrbQSGvabdNZe
         NT8MaqnfUqO1uetYIZAnWdhv8x5nsLpS5MWLY78kWYKICiwZZ+cL/NNFoa6C90HGwe6L
         jrtwekgdbFn8h5k/f3ctdDWuWzxXTf1oF36X6cyOPMqgWDsLlWQNlFKsXGt0NnXBHTI5
         YitVxci49h6+5RclCqdFTbTXtAUzih21cZOZB9SoWPhIW3mPI2Kqs6bzT14KPmX6gHpo
         JdI7h2MVgSaUJnbfSoJRTIfISae/jWte67blzQJe0Ya31H/VHfRhlejWQeLCOJMFWNoV
         D+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jJ9Qw1W+HvIO5qmF1W1X8JylABMQea6oallp6y0iDek=;
        b=MiSL9F4ClYMT/Maz2j9ZaSmAD9XcWZ5TpygAlWCOhI3/Q6zo6RGuvbhZfEUz9VVR3F
         Cy/fT8bCFYsjkkVvQpTtXD3CWfKkqNeORCc7IOWnkrYgh6U002gvhZz/tyC9ZKYZww+a
         bemsbzkhCDRovPmHzO7EpVJbA74LsbH0khesexJhJi6cCDPS/8xpmQkiIQPV9JDM0zfO
         NJewnhixSr50GjQkH4nPF1dugXxcZgl6udrm/uBCbFyrC1/7LVpZ80Rkew2OoSnDeiFZ
         mstMQgYrtBJSHex2Mhi8KYwJQkXsooDDxiS9hDcwr0ShCmQ8gZij6Hh4EQ4T9XSWlbfR
         I5zg==
X-Gm-Message-State: AOAM531K5l5oBra7aaHBzrp+vkQ0+aF6syU8/PFJ2g4ZhEfilxtMIagu
        tdHS8F1XgOV4vIhd5FzQYvyHpmgSiFY=
X-Google-Smtp-Source: ABdhPJwk6K6CyjtqmsG2z5O40BWhHT5dkAJrFpJI0e4A26zPfmueIK//aSix2IIp7KxWPZHlf0cMoA==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr2532766wmg.66.1611037849370;
        Mon, 18 Jan 2021 22:30:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm2840335wme.18.2021.01.18.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 22:30:48 -0800 (PST)
Message-Id: <802ff802be884349b4a63c0ae6e4b783e6c7aedb.1611037846.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 06:30:45 +0000
Subject: [PATCH v5 2/3] ls_files.c: consolidate two for loops into one
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
 builtin/ls-files.c | 70 +++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f1617260064..1454ab1ae6f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -312,51 +312,39 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(repo->index, dir);
 	}
-	if (show_cached || show_stage) {
-		for (i = 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce = repo->index->cache[i];
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
-			if (show_unmerged && !ce_stage(ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			show_ce(repo, dir, ce, fullname.buf,
-				ce_stage(ce) ? tag_unmerged :
-				(ce_skip_worktree(ce) ? tag_skip_worktree :
-				 tag_cached));
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
-	}
-	if (show_deleted || show_modified) {
-		for (i = 0; i < repo->index->cache_nr; i++) {
-			const struct cache_entry *ce = repo->index->cache[i];
-			struct stat st;
-			int err;
-
-			construct_fullname(&fullname, repo, ce);
-
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, repo->index, fullname.buf, ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			if (ce_skip_worktree(ce))
-				continue;
-			err = lstat(fullname.buf, &st);
-			if (err) {
-				if (errno != ENOENT && errno != ENOTDIR)
-				    error_errno("cannot lstat '%s'", fullname.buf);
-				if (show_deleted)
-					show_ce(repo, dir, ce, fullname.buf, tag_removed);
-				if (show_modified)
-					show_ce(repo, dir, ce, fullname.buf, tag_modified);
-			} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
+		if (ce_skip_worktree(ce))
+			continue;
+		err = lstat(fullname.buf, &st);
+		if (err) {
+			if (errno != ENOENT && errno != ENOTDIR)
+				error_errno("cannot lstat '%s'", fullname.buf);
+			if (show_deleted)
+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (show_modified)
 				show_ce(repo, dir, ce, fullname.buf, tag_modified);
-		}
+		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
+			show_ce(repo, dir, ce, fullname.buf, tag_modified);
 	}
 
 	strbuf_release(&fullname);
-- 
gitgitgadget

