From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 07/11] dir: add remove_untracked_cache()
Date: Fri, 15 Jan 2016 07:59:48 +0100
Message-ID: <1452841192-620-8-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNl-0005LO-6R
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcAOHBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:01:07 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37050 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbcAOHAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:41 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so10168677wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OBfuLfBXuPBOxGDtssWbEVRAIwgK1w39F4IFoilxuo=;
        b=aSOi6UP8lwOKNReSsP5vvAxyo+NSS6kQe+MLCdav6o05BeX7I7IHlucBpvE4j4V0fQ
         2NR3VVvyiaqi17Z3fvhBL75hNoNabc8VXxSJt5kyOi7tlHErrpsdleDLe+anBysuXFy/
         H0/XESzy8UnvFPr6kMul2/cWmEAKczhH4z/CZEbMz2563bEonpR8JtaqNUm1TDgyyv9Q
         zEUtKbk8mdGi4YCoNRzH9WLQNr+q+tcfhEF0AS1pFI1NBpXAFRy5ssdNeJDR6hgr02Ni
         jdhRV2E97NWI1NW/bkYC1iPM3l0/NtyEOlCf6EhKKIALNSuBKRJptAmr4VS//KSDvHwG
         f3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OBfuLfBXuPBOxGDtssWbEVRAIwgK1w39F4IFoilxuo=;
        b=byvohb8XYWJKbJTX2c3yceRkN6DiXTYMETjVvmWlsmFw+D6WaYFhs6hP1cyCgXNB5B
         hk1yVn3LpViqGwwE0mfluUO6P4H3Kor+NBS4STyG33L2ymxXPluxv0GT1BQwgEUYM0Sl
         m/zqBxLEj9fRWMeTKfwCABeoKJR8h9ZaeW2LR44+hM8AVAJ/AoL8oX7gLKvDZbKRPeW4
         kjYA3rmI9ILtaPdljKFdTD56YOoYY5yq6QHbTJjT/+ggzygSfVCVlERynPEHdaP96YRk
         SYkVfNnKZm+WPpaKxlNHMJiTZmRUQz71bjoR1jWbgtLmMe6rca54vv5+ZUbTfOBbXWgb
         A2XQ==
X-Gm-Message-State: AG10YOR5D745waOJP3Cp6jwgXB2FLyCmJFKKBbj6GvUQXg8iOljReFSRgTY9rsEWNTXeNA==
X-Received: by 10.28.150.215 with SMTP id y206mr1468737wmd.8.1452841240569;
        Thu, 14 Jan 2016 23:00:40 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:39 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284151>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +-----
 dir.c                  | 9 +++++++++
 dir.h                  | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f8630c..d90154c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1126,11 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
-		if (the_index.untracked) {
-			free_untracked_cache(the_index.untracked);
-			the_index.untracked = NULL;
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		}
+		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
 	}
 
diff --git a/dir.c b/dir.c
index 31eae37..0d069c9 100644
--- a/dir.c
+++ b/dir.c
@@ -1956,6 +1956,15 @@ void add_untracked_cache(struct index_state *istate)
 	istate->cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(struct index_state *istate)
+{
+	if (istate->untracked) {
+		free_untracked_cache(istate->untracked);
+		istate->untracked = NULL;
+		istate->cache_changed |= UNTRACKED_CHANGED;
+	}
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index cfd3636..a3dacdb 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(struct index_state *istate);
+void remove_untracked_cache(struct index_state *istate);
 #endif
-- 
2.7.0.36.g20612a7
