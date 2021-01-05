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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2424C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6522597
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAEFjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 00:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbhAEFjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 00:39:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6DC061793
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 21:39:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x126so17728373pfc.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 21:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGqmNgZxRRjYRFf83FGFMocIIUNqTAu4Dza9uspIDDI=;
        b=O1fSuL5JTPAwmhOXoa6haKl/hm/E5RU0Fqi6MSDdTKL4VoC0sYBh2QjcXSKmI0QnL7
         jcUGMz5Ircrmx19b/deFygjMwCfm5O/rysTT9s47dZutUAQrmnnppmOqHr/sbYgHw0BP
         fa6oqmZl24LJWZ8uP47mIlCC5l1zK1ubIEjZGKTqUnkBFoJPvtG5iGs3pGTES1/LpqBr
         t0O8MNKXsOHRn17lIyTs7pSxRsBL4aGlhsIWXz6HRhdWzGRsXUzCs0VlwejyHuPsNlFQ
         G9NTnyF+542mvps18Fk5CuPx5SVxA+tiWPLC6t2nQqpprDNNNWIpQor0EcP7R4CXQiJv
         nYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGqmNgZxRRjYRFf83FGFMocIIUNqTAu4Dza9uspIDDI=;
        b=HHHjjLjzC9olEtCsEQ9giOOa2RESmscwOuXNM+vzd1nKkHVxw/I2LtSwP5T24BJRuL
         JeQ4/UTRxPnJs68UUTU18NH1BRbKh8L7xIvkG5IdeXoTeiGNFCc1YWp4EjLnBp0TBISY
         dTKC3WXorEV3xmBGKX7W4hNrxuVAjkp4G+O2c//b8g86UJYAk6gC0Li7h/rf7sTsOlLT
         HbtG+Oa6e0CqtxWj6tjtpZMQYUsUSs5zqLyrIAaAGtvQh0drBFjJ3kYEjyBVfsAWUqfw
         DvTmuuDhKVvr2t729lEjBsu1xhXgH85ne2ADMwGjBIJITVyXsx2y2Kkw94/84ffH0jJJ
         W6GA==
X-Gm-Message-State: AOAM532Kt1vv8cpuCKxYjI6crlZKh8Xz29JtsO7swb6jUSqnDeWr6tX3
        SXIcHRlANau9NY8NIfOBQwCZRUcHTaUeXA==
X-Google-Smtp-Source: ABdhPJzJEzTGQtZv1lofZLUYw8fUfCFCuRjM9Jvx7EudXXWmSBqOPz2gn0vSSZ4T39F9G5l4YRtkGg==
X-Received: by 2002:aa7:85d8:0:b029:19e:610e:1974 with SMTP id z24-20020aa785d80000b029019e610e1974mr49408560pfn.21.1609825152141;
        Mon, 04 Jan 2021 21:39:12 -0800 (PST)
Received: from ADLADL.lan ([103.135.249.72])
        by smtp.gmail.com with ESMTPSA id x10sm55642303pff.214.2021.01.04.21.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 21:39:11 -0800 (PST)
From:   ZheNing Hu <adlternative@gmail.com>
To:     git@vger.kernel.org
Cc:     felipe.contreras@gmail.com, ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH] builtin/ls-files.c:add git ls-file --dedup option
Date:   Tue,  5 Jan 2021 13:39:46 +0800
Message-Id: <20210105053946.710743-2-adlternative@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105053946.710743-1-adlternative@gmail.com>
References: <20210105053946.710743-1-adlternative@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index c8eae899b8..66a7e251a4 100644
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
2.30.0

