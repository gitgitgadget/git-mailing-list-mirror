From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 68/94] builtin/apply: make build_fake_ancestor() return -1 on error
Date: Wed, 11 May 2016 15:17:19 +0200
Message-ID: <20160511131745.2914-69-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6D-00069s-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbcEKNWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32806 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcEKNUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9416201wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LoQyyuwqBnCcRBkZ45f4YQlntolIl39Kn7QuQaH2wRA=;
        b=FX2O6HQY6S3fxZzCJcVxYv3JYRV5G4XeA1dAAsMuovhkQ1lG98xux0ZWl1tzDUjMw5
         +abdQwoX0sJlzqdgcuJJZ/PyWU0bQyLVrVxXNM8D5jy6h7B99MUP1weIsZCwbrkvAN3p
         pDHRZXmJ/PLuJQzKz9T+O/SrBRA1Dw7hYiTiSqesaj/HiHkEkeKfksfm8fom4XrLeEaw
         W2tR70csDgmnp3JktRhecRmmeWiJGPqvkUdRUKMUyWh0TRqdjFktiHqurDQH+dZaGOgX
         cxaJoHmzGZyEJYggTi8ncG1cFeNLnpXYYzfRjrYJTXMA0V6esXgxCy/7JJR9Ac7UwmC2
         NUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LoQyyuwqBnCcRBkZ45f4YQlntolIl39Kn7QuQaH2wRA=;
        b=STGV0m22eIaYzFZFQz/kNgeClchUDnGMGdzwZoSFmkemaQYC42mO+gHlzCWwV6toTa
         OwwA/xLLXE+M8A6lW6C6GBQ1BHi07xXJJ1NDgEBoic8f4l+VM9a9LW+1U1sIY4qQf+NF
         OKnT5W7Gika8twtt0iVWDR6wshZEEInuXoBJbT2uzhhpEmMN6UfLPUAz/uWgH/n+zQVP
         UOWQbCI1G2eqxGjQhofTPu+Py+qw99ATnHKlwksRzlf4EylcvnPLyXY4C3LYai3YQG2Y
         VbRep+hNMMBVvDG/pwr9jmsRy+i5xQXenzDKdMYOJumoHQGP8eDLiRfb0nqd8bEaunnY
         V9sg==
X-Gm-Message-State: AOPr4FV3j/NJZ7GEmRwyVtJ8UDL6XP6xPpNSNTjdUKkbIs+M2jEzSa4N38qhVRcAI2BA8Q==
X-Received: by 10.28.97.213 with SMTP id v204mr81713wmb.50.1462972847017;
        Wed, 11 May 2016 06:20:47 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:45 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294319>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", build_fake_ancestor() should return -1 using
error() instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 06c1c16..a2cc099 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3890,11 +3890,12 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
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
@@ -3912,31 +3913,38 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
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
@@ -4475,8 +4483,11 @@ static int apply_patch(struct apply_state *state,
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
2.8.2.490.g3dabe57
