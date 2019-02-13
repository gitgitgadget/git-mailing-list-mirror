Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5931F453
	for <e@80x24.org>; Wed, 13 Feb 2019 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbfBMU4G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 15:56:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41843 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbfBMU4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 15:56:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id v10so4334197qtp.8
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Swkf9KlDJKbP/t5wkesGzq+2XcDxjXxCUKP38bA1Ws=;
        b=sHZmhUaw/ReWd0ie8GcAHuHe/bOadDY1KghsAGud25f5b18XvvLGgC8jZyqQGxDo0N
         6elqeqvL/e7+JqRRSr937Ic3b1mZySa/x6MmYLlz4FZ2Wn+u8FC0IBU2qL0UEPOJ4wJq
         BiYaFXDm5oeKsmgFRHR7PnKI48edHN58EsE5hlyGBKgFLPwPVWry9oAVey9LZxKKhk0F
         jb+ljUB/EDmcKkaHR0sNEf1cJVt03aFQFN86iX5IdLhbpcfPDMNzh9+0pF/hp5TJK9R8
         zS0BYlwWyVq0fumLlYpHyimfGSoaeAe85qxSAMKXy8p/wgw2cfj/LH0uhdFcRvc5KgcS
         Dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Swkf9KlDJKbP/t5wkesGzq+2XcDxjXxCUKP38bA1Ws=;
        b=D3qmQWygdAXleect8Efwu8Lnp+xvW8gh5m1m9fXKnutp8/K+iR+w6vqaM8/fVA341H
         msDe7YbO5jyCwiKe7b0Yfs4RjNI17C2Bjs1o2FWbm0rEUOxoK9L3I9xb21sgirI3Kpgc
         k0QLAUe/LWYn9J7aoh2y2PWH5ulkC36vCcQmB0229MdbUyRWolBDgFSgxlqVNaiROVK/
         BRXgJhFbw5d4NxZQQpukCKuG1QOb5YP3IzzPDKKcuODWolJxQTpXw2dSv8fa2XsuCG4J
         j30sFLOVXRrpQl6NnQldH0ab9SAfr+nIOCajJDQASjhWHAN18k4NLAt0pTjE1xNI32oq
         RWwQ==
X-Gm-Message-State: AHQUAubghM90VvraEr3tAk5ZkKIameGDK7wpxhsvAr7ISGwulpHdZ3jk
        JuaugEKfVzSSqONT4Kkz23+RfbIsHvs=
X-Google-Smtp-Source: AHgI3IZ9tq7aEwKVVqdhCCSDlB3wgKqx64AwL6UX5eksLMfyQFvaMR/OcJsluZFr9sAt8bVKhSrHsw==
X-Received: by 2002:ac8:35f8:: with SMTP id l53mr87840qtb.15.1550091364608;
        Wed, 13 Feb 2019 12:56:04 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id 10sm234040qtx.40.2019.02.13.12.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 12:56:03 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][RFC PATCH] clone: use dir-iterator to avoid explicit dir traversal
Date:   Wed, 13 Feb 2019 18:55:54 -0200
Message-Id: <20190213205554.4086-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
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
This is my microproject for GSoC 2019. It's still a RFC because I have  
some questions. Any help will be much appreciated.                      
                                                                        
There're three places inside copy_or_link_directory's loop where        
die_errno() is called. Should I call dir_iterator_abort, at these       
places, before die_errno() is called (to free resources)?               
                                                                        
And if so, should I check dir_iterator_abort's return code? It's said at
dir-iterator.h that dir_iterator_abort returns ITER_ERROR on error, but 
by the code, we can see that it only possibly returns ITER_DONE.        
                                                                        
Finally, if this call and check both needs to be done, there'll be code 
replication in this three places. Should I add a goto and do all this    
stuff at the function end? (But then, I would have to store die_errno's 
error messages and errno code in temporary variables. Is this approach  
good?) 

 builtin/clone.c | 65 +++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..f5208ad9ca 100644
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
@@ -392,50 +394,55 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	fclose(in);
 }
 
-static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
-				   const char *src_repo, int src_baselen)
+static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
-	struct dirent *de;
+	/*
+	 * Tries to create a dir at pathname. If pathname already exists and
+	 * is a dir, do nothing.
+	 */
 	struct stat buf;
-	int src_len, dest_len;
-	DIR *dir;
 
-	dir = opendir(src->buf);
-	if (!dir)
-		die_errno(_("failed to open '%s'"), src->buf);
-
-	if (mkdir(dest->buf, 0777)) {
+	if (mkdir(pathname, mode)) {
 		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
+			die_errno(_("failed to create directory '%s'"),
+				  pathname);
+		else if (stat(pathname, &buf))
+			die_errno(_("failed to stat '%s'"), pathname);
 		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
+			die(_("%s exists and is not a directory"), pathname);
 	}
+}
+
+static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
+				   const char *src_repo, int src_baselen)
+{
+	int src_len, dest_len;
+	struct dir_iterator *iter;
+	int iter_status;
+
+	mkdir_if_missing(dest->buf, 0777);
+
+	iter = dir_iterator_begin(src->buf);
 
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
@@ -452,7 +459,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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

