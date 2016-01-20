From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 06/11] dir: add {new,add}_untracked_cache()
Date: Wed, 20 Jan 2016 10:59:39 +0100
Message-ID: <1453283984-8979-7-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpev-0007wT-LA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393AbcATKG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:26 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32900 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245AbcATKGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:16 -0500
Received: by mail-wm0-f49.google.com with SMTP id 123so125782732wmz.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEnQSRpQSXE+5ZpAqH7tsJAI72hGHzcZJYDC3PpjqLs=;
        b=OhVMJ7D8e03dFSEURoRnBlrdF/KjIfUwZriE+abwMFz9rNzeQkqcorPssFH2vcJW55
         sraIsB7EBc1lsWB+pMsVPwcbprvbaiEqfuKXFIrFaFwbT8Dfs2WgtFrvNTDzoagqCor7
         4QviKTZwrMO1l6vmkyriYvjLR8CjOX+7v98DFL3Kl17EbVBBpwRZ1Al/JLzSLzURiNUv
         jQnJPB2oNJvKQasdUXGdctRnIZrWRPhedWnA47yWO2a/v4fS3AN+onQZX3zv2Z3bYsu4
         aOiSOHcjmH9wwTbwXzYEaM1oGXkQUCF11dhCVGOliV/8loHudImEyabdWx41bRzoJBnX
         INTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEnQSRpQSXE+5ZpAqH7tsJAI72hGHzcZJYDC3PpjqLs=;
        b=APyOZD178TQvJHYHEEBmA//Dnwh5MCB+Fwhw0/xg4G7LDTcwmsyuq+5ijVYG65xyAw
         cD9fH4obnt8VQUp8eouxapZYzJivqUp6dzSeNPsE8xj7YSBA0AbiJfifmBaFgvdHoGcL
         VrqA2HfxCd3lHfFHBfi3WwqmftjIk0x7uQ0Ex0Ri9H6GZZK0fNVhfo4dLN/HrqQ+BaSw
         dSvr3nn5dSmoP7CoUd76W6LdjgnbK615VbpV1LJIwn8e5pu41yvcyfuY9em8fhzSvL3M
         XwmRDXzi8XV8+FNTeQhr6l11BkrKpFddyYxjSP88BYvYJYGbEBi44tHQEkW4Kbtd9XlJ
         agmg==
X-Gm-Message-State: ALoCoQkQVCvc7kx+EzyN11TYYZtX2epSLPUPSHVVzWDfZjIKFQnDsV0fml0Hn35cOA71ES6XZskT3t9r8DonG2xRnpCO4BNgxA==
X-Received: by 10.194.79.227 with SMTP id m3mr34223359wjx.5.1453284375078;
        Wed, 20 Jan 2016 02:06:15 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:14 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284440>

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
2.7.0.36.g6be5eef
