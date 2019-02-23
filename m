Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72D620248
	for <e@80x24.org>; Sat, 23 Feb 2019 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfBWTDa (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 14:03:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32958 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfBWTDa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 14:03:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so6323112qtz.0
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 11:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFJNMLJ1S8chAJ9zMk+hdn6F9IPmbMWIhTTMygRfn7U=;
        b=IOokQs1HeYGMqNkF76+crmHxtpfsXfSGer/q+RWi+0vIubrN/ZhOJ1Xq+uVhuSmuXu
         Y414umK6FCGPFB6HzX1SQiENrTFNFTvDcvPXw2cHMotNeH9rGwFdRgu2pryTiFiaDX77
         aoo5nRl7tSJqc6UTr0iXuH4Y49IBBRhHP6/njMkdvqvwkPvq1qgHRO6uvdVeeNlxR6rq
         7Bt+emtKDLZoWNTV8kNv6iQat8rkmBPvuSGbTfMdpMkWyOx5nV02r01fcMVfFwg5FZnY
         xNoeDAqyDSqVKB9GXQ1wFTsBFyVnEwdWNwSQqyHempaqhS3JsuQ6kuXXocvzY2/FN+KW
         ztTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFJNMLJ1S8chAJ9zMk+hdn6F9IPmbMWIhTTMygRfn7U=;
        b=fxQrvAUy2YknJk0wkJ8Ct/MgAdzrnKLHC0297AyEFfNShmdZRbfVD59DFab8vcKgV+
         SEIXVCM9Bdy2G2Pnpn8KBaS7je0A7U6tyivqYfY9boH9HhnV5g2HOrbXCYgw5kx6Jrgz
         4g2hAUW8tEuCYUx3Lp0C2VUjOkXHLnkmR2ZqMrcblUEZMty1gUGkFUWRINBqfAWFMDto
         23i4TdHtAt8mXiPyZ24rz351YlFjKBH91j0oOQqI2uedQCGjTWM2WEfd/nOxxLsd5oKD
         IAEy3Jk7dmwbXMgHTIzokJYKL6iyKrynZXzw3vdLX7lP4vTZb6gsCZoG3kz1t4xKqGOm
         QczA==
X-Gm-Message-State: AHQUAubv6MkfjPqDSXh4Onf2Ym7kb2nz9enV+NIPmaqDDBFlVZ4EZ2ra
        auqNBN548up1g0MyOW1hEla5iGnzeb0=
X-Google-Smtp-Source: AHgI3IaccEODUupK1+60i4lt1wPxUF3+N6gewdOb2fKIddBirsQ9hvOvLDY3vB0fIOgg8yz/1MVYUw==
X-Received: by 2002:aed:3ae4:: with SMTP id o91mr8184120qte.251.1550948608457;
        Sat, 23 Feb 2019 11:03:28 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id j9sm1028064qtb.30.2019.02.23.11.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 11:03:27 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
Date:   Sat, 23 Feb 2019 16:03:09 -0300
Message-Id: <20190223190309.6728-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190223190309.6728-1-matheus.bernardino@usp.br>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API. This simplifies the code and avoid recursive calls to
copy_or_link_directory.

This process also brings some safe behaviour changes to
copy_or_link_directory:
 - It will no longer follows symbolic links. This is not a problem,
   since the function is only used to copy .git/objects directory, and
   symbolic links are not expected there.
 - Hidden directories won't be skipped anymore. In fact, it is odd that
   the function currently skip hidden directories but not hidden files.
   The reason for that could be unintentional: probably the intention
   was to skip '.' and '..' only, but it ended up accidentally skipping
   all directories starting with '.'. Again, it must not be a problem
   not to skip hidden dirs since hidden dirs/files are not expected at
   .git/objects.
 - Now, copy_or_link_directory will call die() in case of an error on
   openddir, readdir or lstat, inside dir_iterator_advance. That means
   it will abort in case of an error trying to fetch any iteration
   entry.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Improved patch message
 - Removed a now unused variable
 - Put warning on stat error back
 - Added pedantic option to dir-iterator initialization
 - Modified copy_or_link_directory not to skip hidden paths

 builtin/clone.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 862d2ea69c..515dc91d63 100644
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
@@ -411,42 +413,45 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
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
+	struct stat st;
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	iter = dir_iterator_begin(src->buf, 1);
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
+		strbuf_addstr(dest, iter->relative_path);
+
+		/*
+		 * dir_iterator_advance already calls lstat to populate iter->st
+		 * but, unlike stat, lstat does not checks for permissions on
+		 * the given path.
+		 */
+		if (stat(src->buf, &st)) {
 			warning (_("failed to stat %s\n"), src->buf);
 			continue;
 		}
-		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
-				copy_or_link_directory(src, dest,
-						       src_repo, src_baselen);
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
@@ -463,7 +468,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
@@ -481,7 +490,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
 		strbuf_addstr(&dest, "/objects");
-		copy_or_link_directory(&src, &dest, src_repo, src.len);
+		copy_or_link_directory(&src, &dest, src_repo);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-- 
2.20.1

