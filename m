Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8697BC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiGSOKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbiGSOKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E28558CF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l124so13511359pfl.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYXym/+opy3nmKeEok8SGg0UamikXOVHzY0az9xgUMc=;
        b=as+KuAAhSkxy6HhrH06ElOpJx55nBjey8peL1jCveDaVukFve5Ga45L9Mx2cmHFIbh
         ilxqWmEVPEG53V/2Y0pskUlMXpeThBVEYlNcEyL4E286HYv6pTa4+l6jVEzBfHzT4mVB
         Bx1p9T76UPDuw8iJJRV5UwaK7488D+LbtN8jlLTFohiX57GrqAxTUMo39GaW+b5PNCB6
         vCLa2gneKMtVZXRRxUi25ZSDz41Co8DwweJqG5JzlqHsUaB+vNfCCYfa2EjMkXs1Mfc8
         i6+4lHpTIrpnnz6XvBKDI8JfZ986OHeXzcNDDFqx6D7aADDtXX9+IiHQ5QthL5wJkfIr
         kLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYXym/+opy3nmKeEok8SGg0UamikXOVHzY0az9xgUMc=;
        b=dnpPvKLvfx0mqsJQscvfVfX9imNCOn74HpBPOA2wqBickRUh3uG1Sq9JPU7Z0bfx55
         p9FKSTfpYa0ucDMZSW+aOOZowEVUCGIoNCUp/W+DONhvk8KAv2WF/DxEJX4KxSM4n0it
         TGOeo0xtkFTInr4+/XY3QttD6402FxVvpJ8XMkD1EhS2MuUjOAbhHffnkNdQG5LLqPi5
         Xb61BG6BYjkDedPIVxh4CF2F6xBDipuUZqy9WEAJGCoWSAvkUl7oxrmCKsVjJ3WrOHBc
         zOgIcWdbzLGddutBk2AyViu6/5CurzN6xfxN8JwvHUcgSnrQFJBRyZwC7eWWOacvgpug
         TfLw==
X-Gm-Message-State: AJIora+91vPCqdppUVu61xGL8iOA05vkVLkpPFMMZn5Ea2QVTdyjsXpw
        ht9goN/0uqcaZcVXehDqZBLSp2LpsNegWsdD
X-Google-Smtp-Source: AGRyM1tqHhy9mBRq50/dxfTLKZxqPapgHWYWc1XVfqHWxgoT9mmueNgOyC3CpoBx32AckHoXJnENCA==
X-Received: by 2002:a63:5f4e:0:b0:417:ba9d:c513 with SMTP id t75-20020a635f4e000000b00417ba9dc513mr29580467pgb.434.1658237341120;
        Tue, 19 Jul 2022 06:29:01 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:29:00 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 4/7] mv: check if <destination> is a SKIP_WORKTREE_DIR
Date:   Tue, 19 Jul 2022 21:28:06 +0800
Message-Id: <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
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
with all its contents sparsified (a SKIP_WORKTREE_DIR). If yes,
then treat <destination> as a directory exists in the working tree, and
thus using the second form of 'git-mv', i.e. move into this
<destination>, and mark <destination> as a SKIP_WORKTREE_DIR.
If no, continue the original checking logic.

Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
was everywhere and can be simplified.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 23a297d6b8..2e9d577227 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -178,7 +178,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode *modes;
+	const char *dst_w_slash;
+	enum update_mode *modes, dst_mode = 0;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -208,6 +209,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
 		flags = 0;
 	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
+	dst_w_slash = add_slash(dest_path[0]);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
@@ -215,13 +217,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
-		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
 	} else {
-		if (argc != 1)
+		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
+		    !check_dir_in_index(dst_w_slash)) {
+			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
+			dst_mode |= SKIP_WORKTREE_DIR;
+		} else if (argc != 1) {
 			die(_("destination '%s' is not a directory"), dest_path[0]);
-		destination = dest_path;
+		} else {
+			destination = dest_path;
+		}
 	}
+	if (dst_w_slash != dest_path[0])
+		free((char *)dst_w_slash);
 
 	/* Checking */
 	for (i = 0; i < argc; i++) {
-- 
2.37.0

