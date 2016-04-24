From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 70/83] builtin/apply: make add_index_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:10 +0200
Message-ID: <1461504863-15946-71-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDE-0008WM-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbcDXNg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:28 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36741 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbcDXNgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so69578387wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPkTL7k94EsO1FhwvZ0ZxhKh2pbMYannf5fSbUyr6d8=;
        b=pnsx3dTUrKU/DxKeJGw2h2ezu3TBLDimJjDfsrjJ9PrvoX/gLdBhkaEmypZYGPlO1y
         Ng39f5+UYyP/i4ziKce4b2E6w867QN6fKEpdh9zjsGNE7NgzKBy0qwJSxo9lQgsGv1jb
         7kVQC9ynhCBG80aFgl8uf2ZwA/ttD5fhoSnOTOmFmdomu/pUTi9747wl3oLA8X7VCbu7
         0YzxLup4m8xzUpl6aCQkpu7t2SGGq4OaUUmU6nJZOR7ms5k6VAglj9gfQhUyWowMOGF0
         5qNOrFp8vqFrmR8/zJKswImVIqXC/oF5mAw6uHBYZy2g5+/FnePjYfADWiwGrym5Txtl
         ksuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPkTL7k94EsO1FhwvZ0ZxhKh2pbMYannf5fSbUyr6d8=;
        b=cFPVNcWcgUJ0WP+4yKNAi9zuGxoA+Fb6b28lvWW0g+Ttt7W6PcOMu4+6QUVXZjenAR
         EFzyYfv1p+mVPm+Qhp7UIdSFHA3USFLpRj3wh7W84mQhcGfzipa1itjI0MT1qgGmvWHI
         OSEkPMMdtbicCyvMqH3wUol6z3ez1OIqwe9NHTJgpeR3Z0cr6v7rIKBbQ+e4NY0tABbR
         TIgqhVnu7XYOuR2zCrftP4VpEHe/Dtbtm0TVAPlGkHr5NkfWnITLGGwoprvRDY3GwtAH
         3Cn6lJEHgNE4Epna9CTvAtltFzvuTNYq58HF16CGmyZGzBtIM1YSB/dpvD3xGZmLc9Dj
         EPNQ==
X-Gm-Message-State: AOPr4FVdB3R0O0rzjDTQOhTIjmkgCYLO+ZShV3/iQZKZcaNzQZqIU2TrxxGsCSsEWi0EMA==
X-Received: by 10.28.154.2 with SMTP id c2mr3392224wme.9.1461504983867;
        Sun, 24 Apr 2016 06:36:23 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292357>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5a5be49..e021fad 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4085,11 +4085,11 @@ static int remove_file(struct apply_state *state, struct patch *patch, int rmdir
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
@@ -4097,7 +4097,7 @@ static void add_index_file(struct apply_state *state,
 	unsigned ce_size = cache_entry_size(namelen);
 
 	if (!state->update_index)
-		return;
+		return 0;
 
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
@@ -4108,20 +4108,32 @@ static void add_index_file(struct apply_state *state,
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
+	}
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+		free(ce);
+		return error(_("unable to add cache entry for %s"), path);
 	}
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-		die(_("unable to add cache entry for %s"), path);
+
+	return 0;
 }
 
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
@@ -4255,8 +4267,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
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
2.8.1.300.g5fed0c0
