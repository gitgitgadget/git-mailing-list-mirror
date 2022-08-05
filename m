Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECBC19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiHEDGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHEDF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:05:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E59FF7
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g12so1163008pfb.3
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKXhmBlxvN2IiplKFduGf7i9Fru3vQ/QSJaeUXYsMto=;
        b=A+WFIKbCUTBoWgXMftEyEY6z76Go64vsvfDw2LKWQQcHJtQVBbR6o4wXzNDb6C97Eg
         sy4ZOGdaMqRJQfIC1yAkcIU3KeYtGLiIq8C0DV13ui5PvkdUWsl+cEGeZSfp5cvBgVcp
         1qtL/rB+Y+I7eAUD/Z9G1D5u+xAz2E9CVJ80izcXgWxzjcilOk/B5VQ+zHPNQ4wQMYYk
         nwPWmUXhp6TjjbEg78Kl5X/FLNRMDakb1Smr0sqORDnMreYgPuB7OyUoUlDBUcpX3yTi
         Oo4z2JRUNzR2sjw9YbVZb0XS9BC1KivzWleALIliXmZo6mwTYUYGH/HJ4ebaMyh2AB3x
         lCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKXhmBlxvN2IiplKFduGf7i9Fru3vQ/QSJaeUXYsMto=;
        b=aXT3B8OqDJ/z8UwPmNTn+lOrNiHXkU7i5pzl8bvTILd4FHw0zFnSeP2xQaEwhyBEt5
         dh+1bPWjrkpckazP67BhAP3nhlg87sOLrFqOOzf+ZDViAbJEmV7F3wSqtdy1Z6Q+orww
         8T0ugHlR/Kp0nrDt0hqCcG9ZDN985gWlw0ymLfO3DGg9kuehr1XwKz+Wb3fLWlE5Qys7
         itbGXb3F7lL064ra9jCThp4Zre3wT8/sxMeZl2jqbS5KOU4t7qBUoub+mC9FME3CLs6q
         xQgfjDF84p+Y7+r84JVvUfllT7OjbOAna9Lu0lrLj+b14J/5nXfKnCch/UGVtNMzqAaF
         4GSw==
X-Gm-Message-State: ACgBeo33Q5FMaf0xafGj89br6o6l7qKPONFJUzowFb4fahAKdfOjyTGF
        YzkvkemhZdH4Ch2GzWcQTj2BhWhZHEOYkIF5
X-Google-Smtp-Source: AA6agR7Bd7IKIFmwNVQkEOEQ28+4Zwvq6HhunOLqAbaYD29vDqEfLVVnr4uL0DyC25a8YOMC54q4Pg==
X-Received: by 2002:a05:6a00:cc1:b0:52d:a29d:fb1 with SMTP id b1-20020a056a000cc100b0052da29d0fb1mr4906117pfv.56.1659668755723;
        Thu, 04 Aug 2022 20:05:55 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:55 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 4/9] mv: check if <destination> is a SKIP_WORKTREE_DIR
Date:   Fri,  5 Aug 2022 11:05:23 +0800
Message-Id: <20220805030528.1535376-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
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

