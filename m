From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 4/8] dir: add add_untracked_cache()
Date: Tue,  1 Dec 2015 21:31:35 +0100
Message-ID: <1449001899-18956-5-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbS-0008BN-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbbLAUck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35008 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbLAUci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:38 -0500
Received: by wmeo63 with SMTP id o63so5067783wme.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pE9vi4DRGiIilCVuhPs58UAuczgMQj6RaPMKEHO2VpI=;
        b=BmIx7H8X2DgUBmJne0r3dis5ehrX1a13ad7Be4XJ4F/5/VJSHEXj0griPfWCXOLDBt
         9zlvtBhPKhL7Rn4MGU9415u2JHNnp98jauDtgYTAIVR3VpTV5rVIiS94ZOGW53+gz1Tk
         DBBhH9/F9L3mXblVsqv3mfNwkRXT91S5fjIBZWgUeXvhiVn9iCqXvlZWQypAQRSVAHs6
         jcKC4GGoeP3j3mOe8GTlOToYYHEEVqOrz/0HnWP/V0N9GcFrvsLSiwaQLPidsh6TDsKc
         XGS0sLtac9ZLokLvC+Oc3OvqDj/LrR68HQXip8Er2myiZnMDKUhAYl5LpSvzthtCHhUW
         1n/Q==
X-Received: by 10.28.35.66 with SMTP id j63mr157843wmj.10.1449001956994;
        Tue, 01 Dec 2015 12:32:36 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:36 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281847>

This new function will be used in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 +----------
 dir.c                  | 14 ++++++++++++++
 dir.h                  |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b54ddc3..ec67d14 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1114,16 +1114,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			if (untracked_cache == 2)
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
 	} else if (!untracked_cache && the_index.untracked) {
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
2.6.3.391.g95a3a5c
