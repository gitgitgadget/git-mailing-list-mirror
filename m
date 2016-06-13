From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 21/40] builtin/apply: make add_index_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:23 +0200
Message-ID: <20160613160942.1806-22-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSe-0004W9-TA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424971AbcFMQLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35980 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424925AbcFMQK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so15999288wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEPxb1EDU6tLXsnbrYCvfJHjPZGyinb66wLNDFgPclo=;
        b=pJb6RY/xVafpmxGolAlG20wmpG/PUSENix8kQ5yEuhBA2wQfBUaSo1GiSpuWMn8oEt
         YyP8G83m1FFyjo0raYE+NkFJqdFdZsl+Z0O2BFJ6B3/cJ6TajW8asDriVljqrTQ15zCq
         EPCrrd8bljQ+4Qcb0UY7RgSH0uQHZ2s/kWdugauiTvL4NBe3boS2YLOgj9Q2EvfcumYe
         SxE6VQ36wt3IlqwqguY/zPsrVwazFd7aUgnmyUQMwvShHT5SAifVn7u2iNU2vtP/pZZG
         5+UcdzQc4b9SK4jLNX17068I+qeZH3D5geD/lqd3N97NcDHELenrJi9fkiwyut4C4DyB
         om6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEPxb1EDU6tLXsnbrYCvfJHjPZGyinb66wLNDFgPclo=;
        b=jtw8cAFihV1vh4LNwNojAd1lyTlfqpm6yhY1VJ4VD1XkOjxO2RSBckK2M5d58s2DAf
         7kvio62cNPhrWAX7j/BtyPA1k18kUZeGb7ZRDH3e/6UhU51OJFWIJAYgs/zGnheu6xE8
         fuElvP7x7zISQYlDco2lDYK8ytYgq5kgQMAxBNiM0JnkEgAF6uAmaN9XlxZpaAGMVdOV
         BJ91JUxBWFO/07t71NiigCdt9zX+9uxAcNGsLgNVEfZ00sZCvVFNYc+gCTE7jE0vrLSG
         uxespm8eYfX059fOX2UzyFDAPYHNxe39zIQe5LkG4P3SUjpz1MC5wBoqLkvlm9jE7C07
         iqyw==
X-Gm-Message-State: ALyK8tIeaHNdVC2VMcfZhnc6zTXUM+72bng9wGNHAWHbMey/1KtnB82vIr2tEiWxn1fBrg==
X-Received: by 10.28.194.87 with SMTP id s84mr1404201wmf.59.1465834225263;
        Mon, 13 Jun 2016 09:10:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:24 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297219>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_index_file() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0997384..005ba78 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4088,11 +4088,11 @@ static int remove_file(struct apply_state *state, struct patch *patch, int rmdir
 	return 0;
 }
 
-static void add_index_file(struct apply_state *state,
-			   const char *path,
-			   unsigned mode,
-			   void *buf,
-			   unsigned long size)
+static int add_index_file(struct apply_state *state,
+			  const char *path,
+			  unsigned mode,
+			  void *buf,
+			  unsigned long size)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4100,7 +4100,7 @@ static void add_index_file(struct apply_state *state,
 	unsigned ce_size = cache_entry_size(namelen);
 
 	if (!state->update_index)
-		return;
+		return 0;
 
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
@@ -4111,20 +4111,32 @@ static void add_index_file(struct apply_state *state,
 		const char *s;
 
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		    get_sha1_hex(s, ce->sha1))
-			die(_("corrupt patch for submodule %s"), path);
+		    get_sha1_hex(s, ce->sha1)) {
+			free(ce);
+			return error(_("corrupt patch for submodule %s"), path);
+		}
 	} else {
 		if (!state->cached) {
-			if (lstat(path, &st) < 0)
-				die_errno(_("unable to stat newly created file '%s'"),
-					  path);
+			if (lstat(path, &st) < 0) {
+				free(ce);
+				return error(_("unable to stat newly "
+					       "created file '%s': %s"),
+					     path, strerror(errno));
+			}
 			fill_stat_cache_info(ce, &st);
 		}
-		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
-			die(_("unable to create backing store for newly created file %s"), path);
+		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0) {
+			free(ce);
+			return error(_("unable to create backing store "
+				       "for newly created file %s"), path);
+		}
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-		die(_("unable to add cache entry for %s"), path);
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		free(ce);
+		return error(_("unable to add cache entry for %s"), path);
+	}
+
+	return 0;
 }
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
@@ -4260,8 +4272,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 	if (patch->conflicted_threeway) {
 		if (add_conflicted_stages_file(state, patch))
 			exit(1);
-	} else
-		add_index_file(state, path, mode, buf, size);
+	} else {
+		if (add_index_file(state, path, mode, buf, size))
+			exit(1);
+	}
 }
 
 /* phase zero is to remove, phase one is to create */
-- 
2.9.0.rc2.411.g3e2ca28
