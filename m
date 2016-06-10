From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 21/44] builtin/apply: make add_index_file() return -1 on error
Date: Fri, 10 Jun 2016 22:10:55 +0200
Message-ID: <20160610201118.13813-22-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnF-0003cB-HM
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbcFJUMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35049 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbcFJUMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so1048992wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r03EKjqPOXHcs2V8+Sfrz8Jj3RbnlRJjhCCHWomFh6o=;
        b=Wz9QPRGSt4oGsGX8m9ZP+s1MhTpuRQTi4FfRljlqAOx2qWBSH6Z9SnrFvZSL+B1RZ8
         +KJ1ZjDEsnC+bakmHCHyy41FkVZSVKNOZ3U9t8Y+m8ZoXe0xQfPDdQAKCF/8ug2ezQW3
         e8S5dmdjUbKvSABSUTFhqhcX2YPOH3cHdIRrpGeknCdKN1nslVwM9U+9mOgbzHnGpiJQ
         2VDjAG/kbCZzBJGwcolW5qeVNB7nRlcTch2nckJQlmBInz49p8dDt0TQoyxnafb8Rji0
         mdXnPpbFHdbo+Pi3ANBb2okH+WfeGLisGSYWC/RnFk2sRYeL1JCtT0gbEMMa0LKQQuhP
         BCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r03EKjqPOXHcs2V8+Sfrz8Jj3RbnlRJjhCCHWomFh6o=;
        b=NWTZJ2k5NNguectDFFKhQxTMOmpfBJsreaNgTjQgv4TqjbeA0YbhMiQzgyUjWF+nN4
         8ibFUh+eUUIIOKzv71VHezNHa/X4ifKp3zV+VJDtGvhCeotVgk7AVNQN733nKG31UFLt
         KuUXtm5ZEBI6wISZ/Xk74w65tleuIczM0JMPjWKVD9GnMOxfghtOpvO4iT1QaCd2Fmyn
         VSnRnUtFg0lSMKSdUcdrhJRxOr5jTtvQWXlxagjBk2ltJGepHkmQnrBikywCiq/S9AAH
         bInbLjvf7F25MEkEkkOhBVOJBPJCNQxRYvimghrNTbAqWYlpWdI83aN8DNnS7O8RrYWb
         JtMA==
X-Gm-Message-State: ALyK8tITT2cCMovvmhbW8VVnu84Ad+qfVRtb2331j6q7AkGvbYLkbEo5zAjOaUfR2QwUUQ==
X-Received: by 10.28.1.151 with SMTP id 145mr594648wmb.25.1465589528737;
        Fri, 10 Jun 2016 13:12:08 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297039>

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
2.9.0.rc2.362.g3cd93d0
