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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2664C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC1822597
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 05:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAEFjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 00:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbhAEFju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 00:39:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DDC061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 21:39:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e2so15754909plt.12
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 21:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGqmNgZxRRjYRFf83FGFMocIIUNqTAu4Dza9uspIDDI=;
        b=ZjvsJ7XhaVMoRWoZGJyHNwS5sZEhoOrNOYd2Rgu2eacjk1mUtcYqeQmhkr3k7s7el8
         ykHBNEoSzmZ0iqal+GKI+QvAnbNZfHfvyno1V/mVc0T6mLhUt8TpgIhGmr4igGe2t+kU
         XVY5+ld44uFfcEWrVtRErmaELuy+Hfj6Tu1ozjowxbqvi/OU28r/8m2YjbTde0X5BgpK
         vOY3jE9M2iURkLW0vGuYm9LEZCFc+FlS2h+0/g9NSQEQf6ce/tzOwanOKv8Ts8gaBKzP
         4245oJ6hyVDEzTU4uS8ih9sq/SsR5EdMJVI72QlQWilFOLO67jYxXekI3YbLrDCjaC18
         fr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGqmNgZxRRjYRFf83FGFMocIIUNqTAu4Dza9uspIDDI=;
        b=L1RcAvZvEJAOb8SkWQPjTAZzmyRoMwRCQZGWTZsBy9PPtP9eVo5V2yQMajYofqeQ/Q
         iFz8Y2lTMLR7Yq3//je44bjqDMkNETdn03pSdcoV/DpLHHF65lF/Id7aSvpWVLjF4mhK
         bMB9d6dzx8EC50Rv8y50R5JcsLmCmnCeaPNBJYAqGx5KA+HtC1XVSEkubw4/IF7eJu2+
         c3KVY0zKD2PZOa5MEM4a7NDdWtS/Nf/kNpadd07DtrfSvMbl3VdtputDtI0e7Fwb0NBb
         ad5IGJ8Zt0O255n67nfOqcQYUi7ajsPOYkFFx0zaEZdVdKZoguj5YeraxFPLZqpJQjJ0
         yF0Q==
X-Gm-Message-State: AOAM533xw2VSU8PqbWV5rZQz7+oZJopYR/ojcBzgDAaF1pZCJ0Fr2MSe
        CsmjRM2pJZaG+1ON1IMaMupvXdw6iNdT0w==
X-Google-Smtp-Source: ABdhPJy9lH5fPHQ06Zbxk7BjRjp4jQvABfGU1/ZAz82mlC+oXkfZ8g4RORaLIcMLaGjMnUlLtcxPWg==
X-Received: by 2002:a17:90a:3e05:: with SMTP id j5mr2442021pjc.91.1609825149825;
        Mon, 04 Jan 2021 21:39:09 -0800 (PST)
Received: from ADLADL.lan ([103.135.249.72])
        by smtp.gmail.com with ESMTPSA id x10sm55642303pff.214.2021.01.04.21.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 21:39:09 -0800 (PST)
From:   ZheNing Hu <adlternative@gmail.com>
To:     git@vger.kernel.org
Cc:     felipe.contreras@gmail.com, ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH v1 1/1] builtin/ls-files.c:add git ls-file --dedup option
Date:   Tue,  5 Jan 2021 13:39:45 +0800
Message-Id: <20210105053946.710743-1-adlternative@gmail.com>
X-Mailer: git-send-email 2.30.0
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

