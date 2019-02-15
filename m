Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0867F1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfBOPt3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 10:49:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34088 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBOPt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 10:49:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so5974381qkc.1
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yov/dNM3pt+9nYJHrPxxu1ONryOl4ApLkhBhrnkGLO4=;
        b=COzmX80bwFWOZ65C87AdB4F/acCeVUlP/LMmaZtfXQQScEc54dCmJltAHrpa99NtJC
         fgVJnXRR/WM5O32xWkbXvhmWwAF7KGAn7snEZMMtPY1/4urOLkFaxR3ta47K5vbR/TG1
         Lxs+DcVhMZ4ABQ/4NI8lPBDLNHG7m57ivSGx1qypT1pFoJnhd1Ir+rzBgG2kYFxooreq
         Z7oP1OoW1tjo5lhxPdu74k/mDQ4jG7tWF6LOrudScBVYuDxIRo0QIbADyfGxRwGx6CNi
         orM3PXHC629K4OC9ksSBn40LewDeqCh7IPx0Njg7b79+uWTHu7MWrtG3AVldJ5s3wP8z
         RK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yov/dNM3pt+9nYJHrPxxu1ONryOl4ApLkhBhrnkGLO4=;
        b=bYEsyvfFoL98o63pepN+8Me/adYmBPzVuSd3C4JNKFY0l+JLIxF3vY+t6QD1+HwWqS
         D6SWsKD/kau7Br8k6jGVk08zU9VamSbjK9C3X5b/dI12SgPnBdSKV56VfQow7OmsHaiv
         294h5UbYzKWIpbwfXzXcwMFel8CgLrFza1h2xtuq9G+btjivVAI4rZmXklCq+MNZhB2v
         4PGT/94OVAzmp4BVkhlx35f+bUL3OKeeJ17xtQ1BKHykLHcdhc2LsGmCVofFrWEGVPW1
         wh2WkMAOGPAE/AYynh5qR0SSw6reOlXL5t6z3wb4AHx8jjezptl1MzbUjzfvbkknLG/u
         qACw==
X-Gm-Message-State: AHQUAubW8FrLY4p+ZQjwYszh6HpgBVbhhpXegS+DIQJDwsRaPAGgMqYp
        EBCVTV7lVfvUn56OmN1opFnp0EyHaQY=
X-Google-Smtp-Source: AHgI3Ib/02geeqvCkTrHWvnhuf3mIuDkAIiYEGXSzk3tbTcWE8Im8M4XrDXNSofHV4iJEOG+UPwnYA==
X-Received: by 2002:a37:4244:: with SMTP id p65mr7087550qka.185.1550245765644;
        Fri, 15 Feb 2019 07:49:25 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id j6sm2909593qte.29.2019.02.15.07.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:49:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
Date:   Fri, 15 Feb 2019 13:49:13 -0200
Message-Id: <20190215154913.18800-3-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215154913.18800-1-matheus.bernardino@usp.br>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2a1cc4dab9..66ae347f79 100644
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
@@ -413,40 +415,33 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
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
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	iter = dir_iterator_begin(src->buf);
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
-			if (de->d_name[0] != '.')
-				copy_or_link_directory(src, dest,
-						       src_repo, src_baselen);
+		strbuf_addstr(dest, iter->relative_path);
+
+		if (S_ISDIR(iter->st.st_mode)) {
+			if (iter->basename[0] != '.')
+				mkdir_if_missing(dest->buf, 0777);
 			continue;
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
+		if (!strcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
@@ -463,7 +458,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
-- 
2.20.1

