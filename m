From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 18/44] builtin/apply: make build_fake_ancestor() return -1 on error
Date: Fri, 10 Jun 2016 22:10:52 +0200
Message-ID: <20160610201118.13813-19-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmz-0003PH-4O
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbcFJUMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33407 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbcFJUMG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so1068687wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ofadee7G1w+sPe4M/5c9FVKhTUrXdRvg1xheTGNbR2U=;
        b=H91z0+hhmO+o5WEY9U0QyyOLg1VWncK/i2OuttiR5Lc5e83cQwwx9K9JnTUxaPZf7z
         ymHvrJFqdk6sBqjL8n5Qhnc+6BwlrpxAI+xxOBwlkM+q1se1PjxzCrBmA5gCIkxilrRY
         L2Dmb5VnjYyXYHawVadnSEfTeKsw01XO6tR85nFTtFukz45P+rI0BWSnYE6CKwW2WsxM
         ERtLaYng9RK8yHt1/5NF9ALLsdrP/WQT5OlhqWRGtZuMH/jeksQ4AvaWCHMNxiCsGiDB
         bPiR0nVWqFz5F+fXHgYrrZnIJnrXN8daluGhYb8JPcITnvPEhv6AR39q3XWM/Ui0J5tR
         b2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ofadee7G1w+sPe4M/5c9FVKhTUrXdRvg1xheTGNbR2U=;
        b=eeeAB1Nq7JkxPnoE/gIhW39/MT/xlMbkt+ZCo5nWfYESB9CVpfJ3mb94IhbU35cJIo
         UT+4lDa1O/8f7pTv91L5rwwgedp9Td9OtM+rYqt4brZtH8E87UihViV+ZZllV91/ML2w
         3vDrSTj8kS0nNcZ/r6oaXx9kQwYUtFfB4Ap4H2BdL2nSgYdUXA1B/n2qiSYJZlDRA8yr
         4B2IQYQOyM1WAwfpoJfzSeHLGQ6NyGosxVauPCT7lA+BLB1M4x8+Kc+ITt7Ryi89qOFS
         p/C3QCSqHa4eZYt4s2XPNWkT5JVtDxCxD7Pyrkjygq0JNs1NpKusojYoFoDFMukrFd3h
         JpWA==
X-Gm-Message-State: ALyK8tI5J0pdq7PinjuleUoRZavRZ5tLPdwAm2aJnzJffZiwh0AGEQFNbs0ZCi7xDhDrFA==
X-Received: by 10.28.170.21 with SMTP id t21mr723902wme.0.1465589524629;
        Fri, 10 Jun 2016 13:12:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297035>

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
2.9.0.rc2.362.g3cd93d0
