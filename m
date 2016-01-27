From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 06/11] dir: add {new,add}_untracked_cache()
Date: Wed, 27 Jan 2016 07:58:02 +0100
Message-ID: <1453877887-11586-7-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9H-0002r4-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbcA0HEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:10 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34324 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbcA0HDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:50 -0500
Received: by mail-wm0-f41.google.com with SMTP id n5so13137467wmn.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xD189z6l12ECEHTv1oUjadm8yfkgxKq3F1VMr9Y0qF0=;
        b=flmGnDtZuZB6IM5vt3moAY+hVeUxKBz5F5fznim5UAn1TyPGdd9JAnHOSbUInhugpZ
         JrgqX5rLbEQLwTlE15yCdK16lWQEswkj0FkaZf0Q3s3cI+95OC7BJPwXBMQa27djvJhd
         wZCQIdGx1n5RGSUgAyNgzDlqYYwPG8A7I9s3Rx+rBWNJr5QXkbyaTjNoa5O2oRW4Qrq6
         /oRCU0DwPGIoMKoEGqyiT5X8OeKmeeitj41J1/d6xIN3XlxJyik6wGN+1Hgg/WHcUGpN
         ARPKHoW0jWeJgCnwDxWq8lMHGzH0KYWpsYvJmhhJUz4NW/MiHxT5nB82LyXQS/uwXoEy
         dUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xD189z6l12ECEHTv1oUjadm8yfkgxKq3F1VMr9Y0qF0=;
        b=PWZ+zkFaseNd4uoVoMkx/nDz3QueWb0sUkRfKyvXR+BYJA4L6qgyYDaHzInQUwaSfD
         Vb/LYkmsTE9MkPb0nvJTpJt8B3toyezwQddezI9MTm5p4rkOereYQz9Z96DE+o6RXnVq
         YQNFjt2SgxCAtIkE9cE5skZgD/W6rKzeJlm6SOJl/c05+XTePRjeL5/yES04gjffZPok
         g6idwkIHl6tNmf/9c7IjE5mpqyuEqWJvtEFC/DSX5M/VjX6N2S6mIZjChO4bSS8XfIkP
         emdL8lQAbaHHXfqd6zdOlKhBvbMEWB+AX07cNr8qSoQN6DfNiEBbCdACbkPgKmbza8am
         qxAQ==
X-Gm-Message-State: AG10YOTtlZJPaxs57hsm8H6Blfz/4qSVUUq1377U0oS5DCMsoG+8zd/JWIIb2c/7zl8faA==
X-Received: by 10.28.23.5 with SMTP id 5mr29456728wmx.82.1453878229227;
        Tue, 26 Jan 2016 23:03:49 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:48 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284881>

Factor out code into new_untracked_cache() and
add_untracked_cache(), which will be used
in later commits.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
index 29aec12..8646b18 100644
--- a/dir.c
+++ b/dir.c
@@ -1864,6 +1864,24 @@ void add_untracked_ident(struct untracked_cache *uc)
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
2.7.0.181.g07d31f8
