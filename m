Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13FBC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644422231B
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0DMK2IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgJSVfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733223AbgJSVfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:35:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED5C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so1353023wre.4
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=Z0DMK2IT+H8kgk6vx5yycdB0J68JdW8J0ixuUY1WsKXN67k6adA/NgKLXYOQ17sYvL
         FytoF3ecKRz6CHKmi8O9w1ROYY6cseQlThm6XADuZKekLGV8ul1UuUFC7fnbcoao9Fhs
         //D4RMcMAtzckEYMapKd99bAd9kAiP3+J9wke7A2yHHhBhyEBJ/tOqTWqDJfT1+xLNpd
         NRcvY26VMQWlXtBS2fcqbIpY25L5A+H/DZtXvtHCdCwl9x/3FkTNtCqcTHS7voQqyiQ4
         H8QhzadkDQjeSzkWjFwPlcTyTdjypEmCSb2QUCnoIhLjJjPJBoYgXcqji/kKkSxtiE1j
         aOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=YTJeUb+oy4d2jRukQTVl/cDxka8DordtVB2z295+4cmvDjWIKz5es+gG1bWCPEKpoh
         5XNp2WTc38sXNfGjYS0XEh0j77eMpZ66t7slgX/i3hTF0t8QDWqdEuxyw62sWfOt7xj9
         omjtD4nfsvk9d09l9tDJ5zwsebwTQ/9XI5SZZt5rz1KVnRhWtLw82H2Zwj6QOQZbuxhz
         GVnZZxFTULpwBP/L8RuUW6bwPVtSLSimArr3eH+2RwJ0z0qIyiDfZm2k0bLK6PYL/N4L
         Z1AFAIKIGCdTL3SbWvmuOLREA0oGEOpXKX7d2si+Nv7BWrNGuaASmx3n/HYGvhl9LnWF
         PxRA==
X-Gm-Message-State: AOAM531xoa2TAPlY3mC3zsCxN8oqLS5VcQPPK1UqsdZw4F66RqkjNPN5
        TgIqZzXdsLK7fZrzNiroWYXvUkNdOCQ=
X-Google-Smtp-Source: ABdhPJz5qYz2dsvBEFJl3tTEqESdaXsyWZEC0vmiFJCaXXZzCN3xBzA5pbxu3T5AgpOLnuNZHBd8NQ==
X-Received: by 2002:adf:e88c:: with SMTP id d12mr1323760wrm.21.1603143318601;
        Mon, 19 Oct 2020 14:35:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm1026424wmh.16.2020.10.19.14.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:35:17 -0700 (PDT)
Message-Id: <cba03dd40bc6af965eb33eba87ea490588dc6bcc.1603143316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 21:35:12 +0000
Subject: [PATCH v2 1/4] fsmonitor: use fsmonitor data in `git diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

With fsmonitor enabled, the first call to match_stat_with_submodule
calls refresh_fsmonitor, incurring the overhead of reading the list of
updated files -- but run_diff_files does not respect the
CE_FSMONITOR_VALID flag.

Make use of the fsmonitor extension to skip lstat() calls on files
that fsmonitor judged as unmodified.

Notably, this change improves performance of the git shell prompt when
GIT_PS1_SHOWDIRTYSTATE is set.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 diff-lib.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f95c6de75f..d2d31b9f82 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,6 +97,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
+	refresh_fsmonitor(istate);
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
@@ -197,8 +199,17 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
-		/* If CE_VALID is set, don't look at workdir for file removal */
-		if (ce->ce_flags & CE_VALID) {
+		/*
+		 * When CE_VALID is set (via "update-index --assume-unchanged"
+		 * or via adding paths while core.ignorestat is set to true),
+		 * the user has promised that the working tree file for that
+		 * path will not be modified.  When CE_FSMONITOR_VALID is true,
+		 * the fsmonitor knows that the path hasn't been modified since
+		 * we refreshed the cached stat information.  In either case,
+		 * we do not have to stat to see if the path has been removed
+		 * or modified.
+		 */
+		if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {
 			changed = 0;
 			newmode = ce->ce_mode;
 		} else {
-- 
gitgitgadget

