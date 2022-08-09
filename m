Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06ACC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiHIMKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbiHIMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:56 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F20024BD4
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:51 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10cf9f5b500so13711193fac.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKXhmBlxvN2IiplKFduGf7i9Fru3vQ/QSJaeUXYsMto=;
        b=VZJRni/gfXweCN2W56+GUOwfi1OopRV5flQozvLsCn6o9A/WdKqs4pbja4Nb+Ngfbq
         lg1JhG/poUYIBPLYmpg4ozPY4PBbGhpnvGhRAQyc3u45GF00hfkpL8YQ+bEwRz+mIXHn
         56N2fjZukrv1js+TSuqSBXrURDDKCRF6TZISqjrOfli4DZ1A875e8k21p68qyO4OdzmV
         h37mWOPBWhD9Q22X+ksQR1Yg77T3FnxCcZD4q7oRwRt89MTRaBIXIoIofusPO50H9O6l
         1CegVwKZEIRRownC4E9TjcqZXXeVml0seguF3g6yqp2hQgkIdD5XRcTCNgDMGFAtCzUq
         f5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKXhmBlxvN2IiplKFduGf7i9Fru3vQ/QSJaeUXYsMto=;
        b=wR3uXi1BN/8FaZ3sy1PAibJCXLVlKHkrioMinbYYY7j1pL7lx6IMvGfdmKEZE0+wvN
         mFDTffPK9GJ93FIHiJUzXbRG2DiuzTnCyIGMxB8GVuaIKSzTQZbbj6zofeJMa4xkzQXn
         r14KsFH30gDTjs+5B7Cg9aZid+8kNO+j3emyHnbtrQOaFvWaGQoyQ4RjSX7tCx/34F6h
         zEdV8r/u0H12lFUwbZ7SZpZ2Yj+gfeuKRVcUnyziDTZoTm/x5AFPKZAS4fi5Ls3mxK3t
         hHTCGLvnPYfm+zA1EIzDArLQu8Oe6TJRHmrQpZ1jCKRrYiyl4VYV8oPYiNz0C/wVqjd0
         ZNgg==
X-Gm-Message-State: ACgBeo3TGAVZCRE5zATxNSVyv2xJo4IytQFJknjIYk4JrDM0xHeA6pOc
        ELSDYeHG6WzhDzBiGns760ujxc0cgteYEA==
X-Google-Smtp-Source: AA6agR7DFeY0waO+DB1BW8kkPboewNGc6x/1CiyKno2j0Q5PywYnSgf94YA0/7rweCQROnfy1DxDtA==
X-Received: by 2002:a17:90b:815:b0:1f5:22ee:2e22 with SMTP id bk21-20020a17090b081500b001f522ee2e22mr33650770pjb.141.1660046979792;
        Tue, 09 Aug 2022 05:09:39 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:39 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 4/9] mv: check if <destination> is a SKIP_WORKTREE_DIR
Date:   Tue,  9 Aug 2022 20:09:05 +0800
Message-Id: <20220809120910.2021413-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, <destination> is assumed to be in the working tree. If it is
not found as a directory, then it is determined to be either a regular file
path, or error out if used under the second form (move into a directory)
of 'git-mv'. Such behavior is not ideal, mainly because Git does not
look into the index for <destination>, which could potentially be a
SKIP_WORKTREE_DIR, which we need to determine for the later "moving from
in-cone to out-of-cone" patch.

Change the logic so that Git first check if <destination> is a directory
with all its contents sparsified (a SKIP_WORKTREE_DIR).

If <destination> is such a sparse directory, then we should modify the
index the same way as we would if this were a non-sparse directory. We
must be careful to ensure that the <destination> is marked with
SKIP_WORKTREE_DIR.

Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
was everywhere and can be simplified.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 0a999640c9..f213a92bf6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -171,6 +171,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
+	const char *dst_w_slash;
 	enum update_mode *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
@@ -201,6 +202,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
 		flags = 0;
 	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
+	dst_w_slash = add_slash(dest_path[0]);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
@@ -208,12 +210,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
-		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
 	} else {
-		if (argc != 1)
+		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
+		    empty_dir_has_sparse_contents(dst_w_slash)) {
+			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
+		} else if (argc != 1) {
 			die(_("destination '%s' is not a directory"), dest_path[0]);
-		destination = dest_path;
+		} else {
+			destination = dest_path;
+		}
+	}
+	if (dst_w_slash != dest_path[0]) {
+		free((char *)dst_w_slash);
+		dst_w_slash = NULL;
 	}
 
 	/* Checking */
-- 
2.37.0

