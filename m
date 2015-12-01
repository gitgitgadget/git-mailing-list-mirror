From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 5/8] dir: add remove_untracked_cache()
Date: Tue,  1 Dec 2015 21:31:36 +0100
Message-ID: <1449001899-18956-6-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbS-0008BN-TF
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbbLAUcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36195 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182AbbLAUck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:40 -0500
Received: by wmec201 with SMTP id c201so5028621wme.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvoxBSaXtSL1Pjg0r0fMBr7dn/DnuzehDLRoPkXcXXA=;
        b=YtMCY4Mt7+bEWx+ep9UJ828Hy/147hwUkAZE6JsajnR+Flso92Lb4awDTlmH9fmzxU
         pm4edRe77OGcMxGxS2usCVpqUP2qP6ZqwlfszNRCaGPUbGbwzspJNkgNn3Pjwfh/EMNP
         +ce1uLLjVovtz6pmpnB1Kx+U56xiVOeGYdPzTHF/3rhfFsX0j9SbpHxLGWqI8K9I6pKW
         gvSALEvOGlSIxH+OlCncy9A8TU/tGv9bBBU3UIOf7cd5F/PazxZ1VNC/HcX8iAcdo/hj
         aRSywM1GEgMvbBMTliEVug5DbrofqY+YPbdxmhIJq00UdoHGL0fbQO2LCH5XAjimhQJy
         Ya4w==
X-Received: by 10.194.90.50 with SMTP id bt18mr82249434wjb.118.1449001959355;
        Tue, 01 Dec 2015 12:32:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:38 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281849>

This new function will be used in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 3 +--
 dir.c                  | 6 ++++++
 dir.h                  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ec67d14..2cbaee0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1117,8 +1117,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (!untracked_cache && the_index.untracked) {
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		remove_untracked_cache();
 		fprintf(stderr, _("Untracked disabled\n"));
 	}
 
diff --git a/dir.c b/dir.c
index 0f7e293..ffc0286 100644
--- a/dir.c
+++ b/dir.c
@@ -1952,6 +1952,12 @@ void add_untracked_cache(void)
 	the_index.cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(void)
+{
+	the_index.untracked = NULL;
+	the_index.cache_changed |= UNTRACKED_CHANGED;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index ee94c76..3e5114d 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(void);
+void remove_untracked_cache(void);
 #endif
-- 
2.6.3.391.g95a3a5c
