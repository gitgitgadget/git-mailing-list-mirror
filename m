Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0524C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF42310A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAFIxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhAFIxq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:53:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94587C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 00:53:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so1679996wrj.7
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 00:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ehXPLhhv+x6ddF3Y/ouw3+URsWiF4qO3xYC2rBimN84=;
        b=A0RZQdrKOtgo1JPGNIGdG/3/TeA2Kqt8jXjFDYABtuMwDQvFzSM7QHUh2S+Qzgt6e8
         PfdNQkAqabEwsKZ/OTty8UUGWCFTqJeQsgrL+ITzF1TJcraA/PQjaO1Fo6niZWW1UX8b
         43GJA5VQfFHtEOO+ZguJC1e/jSga9oiRZH4AsaRXo7JnTBpryaNenPXwxYm8bFaA00Yw
         1CkbsbSSTdaDniAp2G+UiyQrglAraeQMFOqpxt47I9bSFPRDgzSHg/R2Yr7m9A5Oh6Ts
         yxNSO3V+gdol3hNzUzF1DKPOavJVm6LNKV9hzrNSwN3UsTagJlJsRNhBm5JKnOFXDzdc
         S/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ehXPLhhv+x6ddF3Y/ouw3+URsWiF4qO3xYC2rBimN84=;
        b=eCRl/+YU+MZ4JCka9zqKsFU2bsVzA1OM9pbgjNADj4WOoWVvWbgSGJ2r9TyLdXqyUX
         9at/lp/My53yEoaTgugBpajD1A6th9rlx62201nhFEGehU2YD5ILuaff5iH+cfsQFsQp
         i1jzDZUM2u+0eqkSs1V+aOP3NLFEykRxil4FilTUzm/5BERkEM7xVPzzqRvmZaxWWXZM
         HtPsIJj3+rkrvJ2GLVnbXEaQuAxgmOZ8O90PBmT/ZQif/DbRLae8hZKiim/+s755JoKA
         G4LblnCYhapPc7bU5XSyt1hTYtBBKD0bukKRRSe41wL3xlGikxZLLmLgWSB5MHjT0L61
         /w4Q==
X-Gm-Message-State: AOAM5308M4vn0368PixH3QTO8R7g9JCnliKCmJc+33qarX+nPT8aizE4
        be/+5AWEzOZCLb7wSm+paSkB4mVawvo=
X-Google-Smtp-Source: ABdhPJwN+j+uD8yIb9fg5ylrp6Myi4l75BydsiIvu9+n2GlmVDg593VHynMdTXsQz2SdWMg0xbov3A==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr3206586wrt.176.1609923183912;
        Wed, 06 Jan 2021 00:53:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm2472495wrw.72.2021.01.06.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:53:03 -0800 (PST)
Message-Id: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 08:53:02 +0000
Subject: [PATCH] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
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
    builtin/ls-files.c:add git ls-file --dedup option
    
    I am reading the source code of git ls-files and learned that git ls
    -files may have duplicate entries when conflict occurs in a branch merge
    or when different options are used at the same time. Users may fell
    confuse when they see these duplicate entries.
    
    As Junio C Hamano said ,it have odd behaviour.
    
    Therefore, we can provide an additional option to git ls-files to delete
    those repeated information.
    
    This fixes https://github.com/gitgitgadget/git/issues/198
    
    Thanks!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/832

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
 

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
