From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 18/40] builtin/apply: make build_fake_ancestor() return -1 on error
Date: Mon, 13 Jun 2016 18:09:20 +0200
Message-ID: <20160613160942.1806-19-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURk-0003mr-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424941AbcFMQKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35118 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424929AbcFMQK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id k184so16027564wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3RdGCGhExdWirj3mxHG/IIIGvENjyukKOFiVC4H9MBw=;
        b=dzNvMub6tX7qJ6Zp18YUp0dvXqafMGjGVZao7HSS7R8JOA/uOXOXJxkRFkXV0G8Otc
         rpSmiOEsxG13TodIZidGF7RgHytTWfj8srXLmuvyv4lS5zxpHtwdPBX+lRZJ5Pla5b1I
         ZCdnlJRIuUtgZg/nlUua5ZY9cuTZMdTnp+OSyCudrJ84x2ZGFVDPh6XzkfPRvQZvm0Q+
         Zydz8gElLpE6vQsTSdhdyFHkOfPsK3R8rpCOD+Pb61ttx17K6YTOJ6ECFxyOjbUPEpbo
         ldmSbGMEOTQyHSw9AHSFaZcp4Nki1sYVa6nmLksJhHYMowvHu06VpFZLXSPmLDoM0jT1
         rGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3RdGCGhExdWirj3mxHG/IIIGvENjyukKOFiVC4H9MBw=;
        b=eGexaHDczCFDWrbitZTBrDkAF18ED9jFxn2uYDZxihTOnA3MmHdqkf+7L9nGpaCqtv
         qh15pJTor7uInhdVXx+b6H5q+YtVdyEbRox/ELoik1br5zt1CT/dja2Nea6kXDQjPiJ0
         MtPpQ2jv9fJEFD1qb0c+TAuHy1F97bn2jIOnzbc+XRESKX98bH21rDjUUv6AAAJhfFF7
         JuPEJZlyaN7Qnv8+2ltn752nxkZf2VvcD0i/z2I64kwyivVp7rYPURSsMDig4UM6RXPp
         l+3c4iLJ5HHMJm3o8V97cbiR4Oe2wocqpM2DHYkEJ4jyHJQX7LXiVQGCPTzQ2xhf3qAb
         8i9A==
X-Gm-Message-State: ALyK8tKyALDXZwW4IiHuIUzcjCyGyCNrzmtxhYpPlxVROK5CGs0h+GK7Et/N+WcppY2WKQ==
X-Received: by 10.194.179.199 with SMTP id di7mr1941893wjc.26.1465834221466;
        Mon, 13 Jun 2016 09:10:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297201>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", build_fake_ancestor() should return -1 instead
of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 429fddd..e74b068 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3889,11 +3889,12 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
-static void build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct patch *list, const char *filename)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
 	static struct lock_file lock;
+	int res;
 
 	/* Once we start supporting the reverse patch, it may be
 	 * worth showing the new sha1 prefix, but until then...
@@ -3911,31 +3912,38 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
 				; /* ok, the textual part looks sane */
 			else
-				die("sha1 information is lacking or useless for submodule %s",
-				    name);
+				return error("sha1 information is lacking or "
+					     "useless for submodule %s", name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_sha1(patch->old_name, sha1))
-				die("mode change for %s, which is not "
-				    "in current HEAD", name);
+				return error("mode change for %s, which is not "
+					     "in current HEAD", name);
 		} else
-			die("sha1 information is lacking or useless "
-			    "(%s).", name);
+			return error("sha1 information is lacking or useless "
+				     "(%s).", name);
 
 		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
 		if (!ce)
-			die(_("make_cache_entry failed for path '%s'"), name);
-		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
-			die ("Could not add %s to temporary index", name);
+			return error(_("make_cache_entry failed for path '%s'"),
+				     name);
+		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
+			free(ce);
+			return error("Could not add %s to temporary index",
+				     name);
+		}
 	}
 
 	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
-	if (write_locked_index(&result, &lock, COMMIT_LOCK))
-		die ("Could not write temporary index to %s", filename);
-
+	res = write_locked_index(&result, &lock, COMMIT_LOCK);
 	discard_index(&result);
+
+	if (res)
+		return error("Could not write temporary index to %s", filename);
+
+	return 0;
 }
 
 static void stat_patch_list(struct apply_state *state, struct patch *patch)
@@ -4476,8 +4484,11 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->fake_ancestor)
-		build_fake_ancestor(list, state->fake_ancestor);
+	if (state->fake_ancestor &&
+	    build_fake_ancestor(list, state->fake_ancestor)) {
+		res = -1;
+		goto end;
+	}
 
 	if (state->diffstat)
 		stat_patch_list(state, list);
-- 
2.9.0.rc2.411.g3e2ca28
