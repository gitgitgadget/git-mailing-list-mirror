Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E979EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbjFPLGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjFPLFr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 07:05:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70D49DF
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 04:00:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30fc50d843aso365269f8f.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686913212; x=1689505212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MVYIXPXEmjvMkdrOwKjPVfcnzGB3N0xsd9AoSoLJMN8=;
        b=cL/r3A+5b8AuYVR3eP8N605Rw+7eC2nE+tnDwuHnHstBfSrFDbW7PEqwSJVHHovohd
         lpXFJhq89kC9CoaO557vV92V+DCeb6dp8VJluYp6DcHpUdfZROj6ra3jqhni8lEU/EPw
         nYKszP9NSrm9xVjUOntLjtAiJBCJIlBbEL4MzM7pwYV/CMj1Sp5y13FUOc0jVYqconoM
         mMjVWj+KeyjomiJe/zJGbrSz0PyDzZwHP3ef31UL9dMIENayocPwvVT4sCKdQxcES2ew
         YgKPHZ5zYAfMun0xHtwvSsCOtDpfHgUpzoNxeXnau4kiv7DmASHUxF1rUJwhWmcXE8zn
         im7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686913212; x=1689505212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVYIXPXEmjvMkdrOwKjPVfcnzGB3N0xsd9AoSoLJMN8=;
        b=A33JIE3K0lf6JC7gBIElRoPE+Ed5GqlOSbauQ2YEEC6nOiddb9/CbfJJh+RJr/U3Dt
         LLFV2jJVj3atkPp+m2yS372x2LdESFrNTXeOkJbsrthe8Yxe0TxU64wFh7nwgfZE9OLd
         tpxBGX1cnIq2gnyaEdLOu6/hH0V5gD1idX8ppLt7yMyC62kyw0TP/ExoLB/eNt/fjCWC
         bdSSmxv6IZ05+tF1odwEkUtsLpnGxQ1539/Th4blj9ph8vNxKdvlxLCAy209pQRQoBv5
         /hOQLByaOXjqPmQg9F06vtHNOo1q5n0IvPh+zlSbQTnENJ3lVEFcdWHRSWMUwZmDJvIr
         krGg==
X-Gm-Message-State: AC+VfDxafQ94R9f7tEbopTjcNOJyNk7cssMcZBkgqauHZJGhvHPH2iSA
        DyNUb8qd1YBmvpNIXhulQKid2RTBXGU=
X-Google-Smtp-Source: ACHHUZ7XHCmzr9III6WmNdT9WaQXxGDKRUoiezfI6MVd/9/gQSvqLAeW0OThzpxIQuxZtxvIJQYc2A==
X-Received: by 2002:adf:ea04:0:b0:30f:b76f:4980 with SMTP id q4-20020adfea04000000b0030fb76f4980mr1022030wrm.6.1686913211681;
        Fri, 16 Jun 2023 04:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d4d4a000000b0030fc079b7f3sm14530686wru.73.2023.06.16.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:00:11 -0700 (PDT)
Message-Id: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jun 2023 11:00:09 +0000
Subject: [PATCH] Add 'preserve' subcommand to 'git stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein@blazepod.co>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nadav Goldstein <nadav.goldstein@blazepod.co>

In this patch, we introduce a new subcommand preserve to
git stash. The purpose of this subcommand is to save the
current changes into the stash and then immediately re-apply
those changes to the working directory.

Implementation-wise, this is achieved by adding a new branch
to the conditional in the cmd_stash function, where we check
if argv[0] is "preserve". If it is, we push_stash with the
new argument that we added to it preserve=1.
In all other cases we call push_stack/do_push_stack preserve=0

Signed-off-by: Nadav Goldstein <nadav.goldstein96@gmail.com>
---
    Add 'preserve' subcommand to 'git stash'
    
    In this patch, we introduce a new subcommand preserve to git stash. The
    purpose of this subcommand is to save the current changes into the stash
    and then immediately re-apply those changes to the working directory.
    
    Implementation-wise, this is achieved by adding a new branch to the
    conditional in the cmd_stash function, where we check if argv[0] is
    "preserve". If it is, we push_stash with the new argument that we added
    to it preserve=1. In all other cases we call push_stack/do_push_stack
    preserve=0
    
    If the community will approve, I will modify the patch to include help
    messages for the new subcommand

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1528%2Fnadav96%2Fstash_preserve-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1528/nadav96/stash_preserve-v1
Pull-Request: https://github.com/git/git/pull/1528

 builtin/stash.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe384..88abf4cc19c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1498,7 +1498,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED)
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked, int only_staged)
+			 int keep_index, int patch_mode, int include_untracked, int only_staged, int preserve)
 {
 	int ret = 0;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1643,7 +1643,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 				ret = -1;
 				goto done;
 			}
-		} else {
+		} else if (!preserve) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
 			/* BUG: this nukes untracked files in the way */
@@ -1709,7 +1709,7 @@ done:
 }
 
 static int push_stash(int argc, const char **argv, const char *prefix,
-		      int push_assumed)
+		      int push_assumed, int preserve)
 {
 	int force_assume = 0;
 	int keep_index = -1;
@@ -1780,14 +1780,19 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			    include_untracked, only_staged);
+			    include_untracked, only_staged, preserve);
 	clear_pathspec(&ps);
 	return ret;
 }
 
 static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
 {
-	return push_stash(argc, argv, prefix, 0);
+	return push_stash(argc, argv, prefix, 0, 0);
+}
+
+static int preserve_stash(int argc, const char **argv, const char *prefix)
+{
+	return push_stash(argc, argv, prefix, 0, 1);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix)
@@ -1827,7 +1832,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, include_untracked, only_staged);
+			    patch_mode, include_untracked, only_staged, 0);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
@@ -1850,6 +1855,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("store", &fn, store_stash),
 		OPT_SUBCOMMAND("create", &fn, create_stash),
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
+		OPT_SUBCOMMAND("preserve", &fn, preserve_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
@@ -1876,5 +1882,5 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.v, prefix, 1);
+	return !!push_stash(args.nr, args.v, prefix, 1, 0);
 }

base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
-- 
gitgitgadget
