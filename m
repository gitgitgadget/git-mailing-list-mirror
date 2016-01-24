From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 06/11] dir: add {new,add}_untracked_cache()
Date: Sun, 24 Jan 2016 16:28:19 +0100
Message-ID: <1453649304-18121-7-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbg-0000zo-L4
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbcAXP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33003 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbcAXP2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so6828537wmu.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krr5lcFN4+efBOtNEQ8rLRGP3LPZKFqWSua3lpUmw48=;
        b=RvPq/F8U5V7v1CXkgvxjfNMpprajgd0L7iWPh31yTRWOfU02pDovu418WlbtIlfkHA
         9ehZaGp/x2jSQP+1QTEZDATWvbkEyiLAttVqDlaa2RXr8HdFMkrwGzHzT3qaar1SU8qf
         C7VvfE3FagYY/4L2RO2WkxjrpTpRidkN0pnF2unD6Oskbc8DBW9/GFGNfb9JVlEFIbyj
         YK9Ggnt/Ph9OOy7rwAvx7gO3/+3v84ZD6Dmfx3EbAflARs+wChYLbCtfIPXtE52F4Jeh
         BSWLz89IsXcOMx8iqP2Zw1BG5/enKWjdVSqZtR2U8GMSEJXuhKx2vjE4+6a+6A72Em5l
         /43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krr5lcFN4+efBOtNEQ8rLRGP3LPZKFqWSua3lpUmw48=;
        b=edSn4YvNiNaGkx0tn9xyRWbrouEDA91s42s7BvayaOB9Ad/2uMKfnTnnVnUFCCX0/I
         RBGRiBa4Vg9Sk5K/nHl1++MaZY5MvKdA0v6MdlwBsx0PRoNAX8JpV3aclP+zIw+57nzW
         o2iJDI/nNdBvK4PTsCXc5aW8NC9laZq4iXnpuvDN3Yh6swJNOICsbmxh4gq39Yp91AZQ
         8/x5/skGz6Ok+LtmwFY477bv+kapEVE7umE3phfJChxiCSWX6Bx6YenoJG9Luvmxx0jn
         3PdJhHFtvfDGezTR+r+pH4PJgF/VxzdxxCyPeMGFpnz4n+BIa/Wk0hjLCoQ76Tc+cYxX
         JH4A==
X-Gm-Message-State: AG10YORGUzYR9VdPZBJKCOm/S2jE7jOi/Fxx/q/9UC50P8fMD9oQ0pevRP7E4hae2fltAA==
X-Received: by 10.28.3.131 with SMTP id 125mr14470974wmd.14.1453649330112;
        Sun, 24 Jan 2016 07:28:50 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:48 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284657>

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
2.7.0.181.gd7ef666.dirty
