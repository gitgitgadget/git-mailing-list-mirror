From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 06/11] dir: add {new,add}_untracked_cache()
Date: Fri, 15 Jan 2016 07:59:47 +0100
Message-ID: <1452841192-620-7-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNM-00050u-H8
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbcAOHAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:42 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36054 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcAOHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:39 -0500
Received: by mail-wm0-f42.google.com with SMTP id l65so8279381wmf.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/TkrSI1AmSaDtrzasr5iTKMf0LwgFRVEOv70zTVVd7o=;
        b=Km403h8iVwhImkSFC6TMcnXB5Y8lfFKDA6AT0gRUlryZyRMQj7Dhr91qOcgRV0Dcbv
         fiDNekiTrP1YdAG9RiZUmZpFXNkfY05Jl2Xsp523rRwa2LCbIWnJb3pc4PSPvC/C5jVq
         LtCPhJxR8mDk2xtompNwOkxcb6lda/MDygweo9BApMEkBjxPOP2AC09tSRIUK0UhqQNh
         sKQzMIi3fbcq/4wPBILgXsNRQKZo1525CEtOyf6mDRSq0XTy8gQKsvizGG8AhVnkCm+p
         lYBWJXYXoiHTdq+gkVYT4WmpPKv9Z53sD4hRYCJpJoh3CnOrO/QurycBR4JmBeFKThJJ
         lR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/TkrSI1AmSaDtrzasr5iTKMf0LwgFRVEOv70zTVVd7o=;
        b=S2n6lNrVfrxVhrtnJRgnfbhOvllhk2SyKDYIBkOi5vdMQuO9X97bYAxXdJEYDlRb7R
         EoelFbiuw8ptluEKoYNKO5UEuDshNcxTaYNkhSS6QKvf7Z3+NDzaVNof1cpCtQUxZ2zW
         GJLlYjIijJlIqjQEXG4DIu8F+1OWs4ROLI3dO55DLmEHFiySmGSqEpK1d12CGdsog6Gh
         c5Q5YoZAIqkDCbdImjQdCBdcI9sPnZ9kdvjhMJvauyeAUJqyLpxqCYTfdKvTylPYOXLk
         SRrtg1ubw43mnXuTOY6PvcbRh8YM+jblrqtuzX9PYCo3/lrI/hIvyZry4cpqUAK8o4bu
         ToRg==
X-Gm-Message-State: AG10YORqoP7m2yxRa93uCJKP5lg1yijz/R50Ee6A5MMyJKMOvaj9PD/D49LCLD8xRsLYoA==
X-Received: by 10.28.46.87 with SMTP id u84mr1603907wmu.102.1452841237897;
        Thu, 14 Jan 2016 23:00:37 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:36 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284144>

Factor out code into new_untracked_cache() and
add_untracked_cache(), which will be used
in later commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 18 ++++++++++++++++++
 dir.h                  |  1 +
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fe7aaa3..5f8630c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,16 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (untracked_cache == UC_TEST)
 				return 0;
 		}
-		if (!the_index.untracked) {
-			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
-			strbuf_init(&uc->ident, 100);
-			uc->exclude_per_dir = ".gitignore";
-			/* should be the same flags used by git-status */
-			uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-			the_index.untracked = uc;
-		}
-		add_untracked_ident(the_index.untracked);
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
 		if (the_index.untracked) {
diff --git a/dir.c b/dir.c
index d2a8f06..31eae37 100644
--- a/dir.c
+++ b/dir.c
@@ -1938,6 +1938,24 @@ void add_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
+static void new_untracked_cache(struct index_state *istate)
+{
+	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
+	strbuf_init(&uc->ident, 100);
+	uc->exclude_per_dir = ".gitignore";
+	/* should be the same flags used by git-status */
+	uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	istate->untracked = uc;
+}
+
+void add_untracked_cache(struct index_state *istate)
+{
+	if (!istate->untracked) {
+		new_untracked_cache(istate);
+	add_untracked_ident(istate->untracked);
+	istate->cache_changed |= UNTRACKED_CHANGED;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index 7b5855d..cfd3636 100644
--- a/dir.h
+++ b/dir.h
@@ -308,4 +308,5 @@ void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
+void add_untracked_cache(struct index_state *istate);
 #endif
-- 
2.7.0.36.g20612a7
