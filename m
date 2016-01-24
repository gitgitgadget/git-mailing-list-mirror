From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 02/11] update-index: use enum for untracked cache options
Date: Sun, 24 Jan 2016 16:28:15 +0100
Message-ID: <1453649304-18121-3-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbX-0000vY-Oq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbcAXP3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34967 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcAXP2o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so6789613wmz.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nfBnuifeDsK7CeHnY8RRpFmVHBcsEAEHmsM3mdZ1Dcc=;
        b=j97i6xZwm0bVg5vzuF/pAP8TsTRflnn4urD0tYbCiVmzAsE/gjgCBenQwOIuBeesYM
         uTTCsFsYTuioJT/ch5blqMBB0yGcYzSd6gLXfZZb+f0dB9eHQKI8xdu2KgOngidoFSRJ
         N1Gf5HtMneJT5g6QCJ2ArezP4NJvHQ16rFfzKlMf+EFaNixit6fUmx3CccYkpwNT7bUj
         kA4quthyNN4lXnHJDBCH/OSVLGDCwJotKDDClkq8er3Foy+vDzChmDGMxokz/QVgMZJM
         CyHbpB6X8aCuPKkzImgW10Szr0hS8G3qlNEjikL0dwftGhgUH9Dr6zFFfIrg0VeyMOo/
         UCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfBnuifeDsK7CeHnY8RRpFmVHBcsEAEHmsM3mdZ1Dcc=;
        b=dpDjKxHUVHeEnK2L4SpDKm+9Kugoz3KBAtP+d/TW9aCPXJsjOOpR7Ld7UVqSG+/Wrq
         TUe4h7TjxLLh5LYfZl/RCQheTfY5dSOuQMTNkzVrHl1nVXI/Mnloxzmb6CuYEz1UiYUA
         uG7uLVYCf4vAVsj5yVXIGzG8vb7zQKJMxsMWULpgpsX2udkBuizY3NWo6gFGPEJI4Bbg
         uhBoS3PzCzL1VY4FNdg6tI8CtaTtbFo/YstzBM7ys8mbDp6g6g2t7U4I677oSl2FfWOC
         SC9u4MVnWgtJlKIN67T5WbCqTSBtkmAY07H3QdJ7HsdjFvRsGvwhQ0JxD/dL2WDYOh34
         8hlA==
X-Gm-Message-State: AG10YOS1bee3pzKMXJk/5n3uauT3z9RPfavNAGUgS4Vo8UnNhW14EnPagvcjd5Zs0nCuiQ==
X-Received: by 10.194.91.180 with SMTP id cf20mr12986817wjb.121.1453649323364;
        Sun, 24 Jan 2016 07:28:43 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:41 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284652>

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6fff87..1e546a3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UC_UNSPECIFIED = -1,
+	UC_DISABLE = 0,
+	UC_ENABLE,
+	UC_FORCE
+};
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
-	int untracked_cache = -1;
+	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > UC_DISABLE) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1122,7 +1130,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-- 
2.7.0.181.gd7ef666.dirty
