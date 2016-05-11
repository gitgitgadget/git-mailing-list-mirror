From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 71/94] builtin/apply: make add_index_file() return -1 on error
Date: Wed, 11 May 2016 15:17:22 +0200
Message-ID: <20160511131745.2914-72-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4X-0004Lj-S0
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbcEKNVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33825 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285AbcEKNUx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so9421854wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=guJHRwoab+PFlwqFKm2kqjynKXzuh/GPL9El55LPVlE=;
        b=IGiwMJuSxBwlSUyZaqRTXNW9GQyLsqg2QPZRQsAe9t6Q6M+3ZskgK3ZVfDUTVEKocN
         hBydNpWIKUo8LOn1LG/HcvQsNqcnzeR2j1esAOzAhcgFHiybfLjW0M0+exq0vqxALpO9
         sd8O2bpxMup4q0OA8wgVS25ZE3SWmOum4m8FrnKgqnF8D86GvzH/NlG5z6vAc6uqlzGj
         +8SqdfeHo2xHFAhf/8JyI1rwtauIPVPyKCQz7WobqFLhmM1wkc6cL3ivqCH/ni3zoiZ5
         hsNQODvPEImCHkzwAvsMYLqe77u3ZkadvNkBXBckX/WyhnoaBIfb+pDLyn+fUGUHdTZr
         V7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=guJHRwoab+PFlwqFKm2kqjynKXzuh/GPL9El55LPVlE=;
        b=QOlLoApr+YNCekoRBIbi2hPxitU6v20DGWlnjT+b50h5cvXNpjEDN5HFDSNabJPDvw
         jPItCdbUX8C0coVQP2es/UoJblcxXW4owCM4N0ybWQpHa26E0+zsomMHRx3KH1FLponl
         CRiBzB8KrHgYsUXl8VZ7K/KIsp+3HJP4GxkS/xB1hizWJNCtxlzJAk0edim8MiZIeHk1
         F+tA459bK+kVy5SG1v6CpRaLkcFpRk3hypM5LjjkAHc6PutZvUyZ6rQh81zWsUwcstj+
         bWkmvyNtjYExS0RpY3c/vZWpnjmN/rwttyXTxLYD+GqLOnrx3psNvZ++1bzk5p8sKB3u
         emNQ==
X-Gm-Message-State: AOPr4FWaaTdYqI4GsRGB0ucDA+1AvJig/IVIdovfEOuPZBeQMaJpOXLXgZVhnqq364iJhA==
X-Received: by 10.28.223.86 with SMTP id w83mr4386897wmg.95.1462972852523;
        Wed, 11 May 2016 06:20:52 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294291>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_index_file() should return -1 using error()
instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ca3502f..0e20467 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4089,11 +4089,11 @@ static int remove_file(struct apply_state *state, struct patch *patch, int rmdir
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
@@ -4101,7 +4101,7 @@ static void add_index_file(struct apply_state *state,
 	unsigned ce_size = cache_entry_size(namelen);
 
 	if (!state->update_index)
-		return;
+		return 0;
 
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
@@ -4112,20 +4112,32 @@ static void add_index_file(struct apply_state *state,
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
@@ -4261,8 +4273,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
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
2.8.2.490.g3dabe57
