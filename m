Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B73320248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBZM3C (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:29:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45575 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBZM3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:29:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so13714098wrn.12
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oghJqaynPEgjf3o7hWdnzPASnjGvBBwyCoemAS8PKKs=;
        b=PTOFYJaf1d9i997+467aqtJc4+JeFHx9czjh0dc5wSKncBOaeb6jbMTzxlfwMT7Egq
         GyOtPLC575z/qEzYa0iY2t8xX12UfzGM1G7GKqnhP6jUbg0kGAkshZTfONeYvsisgI99
         RKxi2wFDatMgDCIMtJsvvyCrgwTtq9C/ZqEqtAwweQFo7lF5Qz9uaeTYA4oCnP1W/vNq
         g/Vrol2iMkP8+hxTr/IMb4IJPiCsUZzJ95N/IJoOuKg/LiCvA9DZpMwcUTjNt3moN0u8
         obQABhUfCHRLGv4UvjyTqs095CZeFEtNgrWA1HPiSS2ir/cOxlnP/30cO3a/fBezuaow
         LFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oghJqaynPEgjf3o7hWdnzPASnjGvBBwyCoemAS8PKKs=;
        b=s/gqbnJWg2EZ0kbyJt01v3NGsfyoPu7hneJpTwWjGbPdLrge5IUvWReN53xtKhtrAc
         B9ae5kDGEKL80ZjoKOTaHCMhOMsNNbudCCkP2scNyJJVNePuQDuwscwJZEigovg96aVo
         kcGRsattYE+Uhk2XIg3XyIKtni6mAyMjQgJ+zey4Ljd/LDvLqMsCqfRDiIpldB7oyHvh
         KFW6Ju7b/5XxBCw/AAqBDlacQI7ZaV7le7cc2JXItPu20ugTJN2A6vGeZorwON62Per2
         uvGafhzJ6a6tNvby50krWHT7ml35k1p2i558e7F0sZzobBAJJC1HifKrHqym3Z5vtvht
         8NmQ==
X-Gm-Message-State: AHQUAubs3rt10PGH0UL2lqKXNntwpGslEUGu/sXVX3pex2k7qQFwtf2x
        1Dtx8RizAVC+MFq1d/w675XgBAPvZvU=
X-Google-Smtp-Source: AHgI3IbNCE1sYq0GBgSdctW/g27KIft7rlxnk6WfDU9viyL+fobBjg2+jBmb0rfNCTqGnMANYFKV9A==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr15526739wrv.73.1551184138657;
        Tue, 26 Feb 2019 04:28:58 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm2733165wme.24.2019.02.26.04.28.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Feb 2019 04:28:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH v3 5/5] clone: use dir-iterator to avoid explicit dir traversal
Date:   Tue, 26 Feb 2019 13:28:29 +0100
Message-Id: <20190226122829.19178-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API. This simplifies the code and avoid recursive calls to
copy_or_link_directory.

This process also makes copy_or_link_directory call die() in case of an
error on readdir or stat, inside dir_iterator_advance. Previously it
would just print a warning for errors on stat and ignore errors on
readdir, which isn't nice because a local git clone would end up
successfully even though the .git/objects copy didn't fully succeeded.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fd580fa98d..6c07648e49 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,8 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "dir-iterator.h"
+#include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
 #include "remote.h"
@@ -411,42 +413,36 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
 }
 
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
-				   const char *src_repo, int src_baselen)
+				   const char *src_repo)
 {
-	struct dirent *de;
-	struct stat buf;
 	int src_len, dest_len;
-	DIR *dir;
-
-	dir = opendir(src->buf);
-	if (!dir)
-		die_errno(_("failed to open '%s'"), src->buf);
+	struct dir_iterator *iter;
+	int iter_status;
+	unsigned flags;
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
+	iter = dir_iterator_begin(src->buf, flags);
+
 	strbuf_addch(src, '/');
 	src_len = src->len;
 	strbuf_addch(dest, '/');
 	dest_len = dest->len;
 
-	while ((de = readdir(dir)) != NULL) {
+	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
 		strbuf_setlen(src, src_len);
-		strbuf_addstr(src, de->d_name);
+		strbuf_addstr(src, iter->relative_path);
 		strbuf_setlen(dest, dest_len);
-		strbuf_addstr(dest, de->d_name);
-		if (stat(src->buf, &buf)) {
-			warning (_("failed to stat %s\n"), src->buf);
-			continue;
-		}
-		if (S_ISDIR(buf.st_mode)) {
-			if (!is_dot_or_dotdot(de->d_name))
-				copy_or_link_directory(src, dest,
-						       src_repo, src_baselen);
+		strbuf_addstr(dest, iter->relative_path);
+
+		if (S_ISDIR(iter->st.st_mode)) {
+			mkdir_if_missing(dest->buf, 0777);
 			continue;
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
+		if (!strcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
@@ -463,7 +459,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (copy_file_with_time(dest->buf, src->buf, 0666))
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
-	closedir(dir);
+
+	if (iter_status != ITER_DONE) {
+		strbuf_setlen(src, src_len);
+		die(_("failed to iterate over '%s'"), src->buf);
+	}
 }
 
 static void clone_local(const char *src_repo, const char *dest_repo)
@@ -481,7 +481,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
 		strbuf_addstr(&dest, "/objects");
-		copy_or_link_directory(&src, &dest, src_repo, src.len);
+		copy_or_link_directory(&src, &dest, src_repo);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-- 
2.21.0.rc2.261.ga7da99ff1b

