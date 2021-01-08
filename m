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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4DC43381
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E24E238A1
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbhAHOh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbhAHOh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:37:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CEDC06129E
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:36:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so9249079wrt.2
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CExMPGt4R59wKj4DHc15d0hNgAEd8il/FaYm8Jgf0Ns=;
        b=osrRYN8xFrp/aLzpTlG0kWODRHrHJa+vhx85nsVJji0vWIipBa37KGVblaumtC7QPD
         XHOBl5UyP75FyBaJrhGQNDux993QNJK3mbP7JApLq1orFponaq3hVPGmi2+vaP/uwzpZ
         48M2JA4OKG5mHCWmDqh6sx2IuBdpnU5cEclt4qBjVANWWI6EJ0GFbHHDunN9pqpsiGqg
         TOc/YrJGCeQbOqEZFCdTccphuWDG9CBReGfwSt53YvMdOKjYIXQrFN70HGmV5H0HAD9C
         dw0AFrVlR79RRjTUloFXpXbhvMsA1HRApxN+tfOV0r07TKY0oxqpx5H1Ipj7xBzO+mtY
         zgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CExMPGt4R59wKj4DHc15d0hNgAEd8il/FaYm8Jgf0Ns=;
        b=lIkPMJdcnAtT4IXPr7FvzG0cz0yZWj/4YFEamPV7+I3SHvW2UqRoI8jQOepkoYi/1r
         sfS90KJsBoqd/EBNSVFjBXE4gDayEZQiE+VNNwA04LNptXKtIdL7PGTqEEYCUNszRymD
         FIa9JE8lphK8has1Ig9B3cutgXaFMOJeFGcIMRMenhF7k6KP57w1BoUY7a8P0GfxJpk/
         y1WvQU3jN5es2GYe3pO6g5/vcq7fxyNy2CFwb2o9jN78xA4oVi2bahRM54kHcmKS36iU
         uuNQPXHzndZ87RV+ExTzrQtURfFtRfr5vI3iLak4o0yQisMXTT8mssXDuTzQOI1ks/Ew
         /akA==
X-Gm-Message-State: AOAM532ey81uyhiqdKLxC2KXHz1rBkGxYTz338ZRQlHZsDA81xONGcLp
        /aArOnjUWSp1P8oFAESijmYEql9eZDs=
X-Google-Smtp-Source: ABdhPJxQldpfLUJ9MBbbRFl1mw9OuU/crD1Q7UFUBKqIe4naS0njViHx2eq5SUIASe4pgXkWnN0GSg==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr4077005wru.413.1610116602179;
        Fri, 08 Jan 2021 06:36:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm13827447wrn.83.2021.01.08.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:41 -0800 (PST)
Message-Id: <0261e5d245ef0a5b9a717be1bc03492d7bc06c5e.1610116600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
        <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 14:36:38 +0000
Subject: [PATCH v2 1/2] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

1.When we use git ls-files with both -m -d,
we would find that repeated path,sometimes
it is confusing.
2.When we are performing a branch merge,
 the default git ls-files will also output
 multiple repeated file names.
Therefore, I added the --dedup option to git ls-files.
1. It can be achieved that only the deleted file name
is displayed when using -m, -d, and --dedup at the same time.
2. Add --dedup when merging branches to remove duplicate file
 names. (unless -s, -u are used)

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/ls-files.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..66a7e251a46 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
+static int delete_dup;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -301,6 +302,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 {
 	int i;
 	struct strbuf fullname = STRBUF_INIT;
+	const struct cache_entry *last_stage=NULL;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -315,7 +317,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	if (show_cached || show_stage) {
 		for (i = 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce = repo->index->cache[i];
-
+			if(show_cached && delete_dup){
+				switch (ce_stage(ce)) {
+				case 0:
+				default:
+					break;
+				case 1:
+				case 2:
+				case 3:
+					if (last_stage &&
+					!strcmp(last_stage->name, ce->name))
+						continue;
+					last_stage=ce;
+				}
+			}
 			construct_fullname(&fullname, repo, ce);
 
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -336,7 +351,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			const struct cache_entry *ce = repo->index->cache[i];
 			struct stat st;
 			int err;
-
+			if(delete_dup){
+				switch (ce_stage(ce)) {
+				case 0:
+				default:
+					break;
+				case 1:
+				case 2:
+				case 3:
+					if (last_stage &&
+					!strcmp(last_stage->name, ce->name))
+						continue;
+					last_stage=ce;
+				}
+			}
 			construct_fullname(&fullname, repo, ce);
 
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -347,10 +375,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			if (ce_skip_worktree(ce))
 				continue;
 			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
+			if(delete_dup && show_deleted && show_modified && err)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			else{
+				if (show_deleted && err)/* you can't find it,so it's actually removed at all! */
+					show_ce(repo, dir, ce, fullname.buf, tag_removed);
+				if (show_modified && ie_modified(repo->index, ce, &st, 0))
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			}
 		}
 	}
 
@@ -578,6 +610,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "dedup", &delete_dup, N_("delete duplicate entry in index")),
 		OPT_END()
 	};
 
-- 
gitgitgadget

