From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 5/8] dir: add add_untracked_cache()
Date: Tue,  8 Dec 2015 18:15:13 +0100
Message-ID: <1449594916-21167-6-git-send-email-chriscool@tuxfamily.org>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lro-0006Ji-1U
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbbLHRPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:53 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38535 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbLHRPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:48 -0500
Received: by wmec201 with SMTP id c201so38601941wme.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5YxUyHQQEsuhaTwTm4azJTeR88fDBNIUATeMSXUixBo=;
        b=i13hhwggsmAf+K3M+I6ulmcYvB4fzGnFKC8wDO52XvoVUfcp8uNjN1H35CSs9vaOCj
         kRCPpM/jTTNDGdz4Nr4KK7nlr6lxyPdtsz7Z0tqhXNP1KcTKDSy1htYSHZnpy91clWJg
         AfHUazVwibmgWrvs/LUNVb3Qet6foeGCuJDb7bXZmD0u/y7Epbs3rnNYK8yZQ9kLj84n
         a5k3BNHtIGMr5acj+IU6TdeXhm8kBRbWyx84UmLB7nmm8FMFuc4DN/7tHgmPa0jECS2g
         mJdPA0aMork7ivyR1EPud0g/WIUDKP0os01Bjx5cKLnWM1iEvzxbO/i5L2mqgh+8jdOt
         u13g==
X-Received: by 10.194.87.170 with SMTP id az10mr713827wjb.144.1449594947018;
        Tue, 08 Dec 2015 09:15:47 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:46 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
In-Reply-To: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282163>

This new function will be used in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 14 ++++++++++++++
 dir.h                  |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 21f74b2..40530b0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,16 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (untracked_cache == TEST_UC)
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
+		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (untracked_cache == NO_UC && the_index.untracked) {
 		the_index.untracked = NULL;
diff --git a/dir.c b/dir.c
index d2a8f06..0f7e293 100644
--- a/dir.c
+++ b/dir.c
@@ -1938,6 +1938,20 @@ void add_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
+void add_untracked_cache(void)
+{
+	if (!the_index.untracked) {
+		struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
+		strbuf_init(&uc->ident, 100);
+		uc->exclude_per_dir = ".gitignore";
+		/* should be the same flags used by git-status */
+		uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+		the_index.untracked = uc;
+	}
+	add_untracked_ident(the_index.untracked);
+	the_index.cache_changed |= UNTRACKED_CHANGED;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index 7b5855d..ee94c76 100644
--- a/dir.h
+++ b/dir.h
@@ -308,4 +308,5 @@ void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
+void add_untracked_cache(void);
 #endif
-- 
2.6.3.478.g9f95483.dirty
