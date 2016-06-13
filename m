From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 40/40] apply: use error_errno() where possible
Date: Mon, 13 Jun 2016 18:09:42 +0200
Message-ID: <20160613160942.1806-41-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSF-0004Co-QD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424983AbcFMQLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34678 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424981AbcFMQLD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:11:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id n184so16056127wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSrKcdumb+3XxVltbHygsQtpL4HSHwvB0H4Is/ivcok=;
        b=AvS2wgz6zUYBqQblhuD0n6c6lXlF301zBkFh90oCStF+24JKrrTAlb6jzjJYUMtg7Q
         Bw3kOP9l05yy7pzHGq3MJll7fFhSgFTbGESBSTBdw6LaBspNnMf0sRal6QBmYOHIy3Gh
         qgjTdiBQvILIWCBs3QXOq6t6wLgc3/vXsis1As/mND5rNjRpFUr5l4Pf/a9aLpTrjI05
         9JhLNfwoGYnzT3An+1/laJpzobmwKoApjqcZIa4BsfEOWMPYNDOfv+2k3ijHgNiZEQlY
         qpdBhanN0yFid92cV3eSLlpO6uk6pHbLafOpETpI614YDgrC8iaxDApGsKVFOXEjmybL
         proQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WSrKcdumb+3XxVltbHygsQtpL4HSHwvB0H4Is/ivcok=;
        b=FA43ZDBMSFVxTYMOaEu/nC9B8LKsXWWOOBi2GN6Q2/agnCRWO1HyGItX264tb7hrcO
         N1Qu+cABw3FQwhtZD4agtoc/tcwB9i3/ukaJ6AugTUHXDGcqH0F4OZa4KV4kCXrPy+5J
         wSV8ah3UnBwfefaMizIpsJZte+/bEaIXXALAXFyWkhoAPfKJM2r/ubKjyjoN9tNWUG8w
         4ITDUU/otJbs5yy/Xk8lsRynSCfWuBmTiPkLb5ENOznkVlyMK2sf3pL239sygrhR8Ili
         VT9OXi6OiGWWaneciyjF/bR1bt6KIF83+bD71ZtgriWx/XOgFfTA8d+E4uuLIythtNJ1
         fcAg==
X-Gm-Message-State: ALyK8tKDxY7SQPotkmVZqKobb0QVYgaorcKJxv88NBxgahyMFcX0RwyH0hTIZdmaTSghiQ==
X-Received: by 10.28.21.202 with SMTP id 193mr1855235wmv.92.1465834262419;
        Mon, 13 Jun 2016 09:11:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:11:01 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297211>

To avoid possible mistakes and to uniformly show the errno
related messages, let's use error_errno() where possible.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index ef49709..777798a 100644
--- a/apply.c
+++ b/apply.c
@@ -3505,7 +3505,7 @@ static int load_current(struct apply_state *state,
 	ce = active_cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
-			return error(_("%s: %s"), name, strerror(errno));
+			return error_errno("%s", name);
 		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
@@ -3664,7 +3664,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
-			return error(_("%s: %s"), old_name, strerror(errno));
+			return error_errno("%s", old_name);
 	}
 
 	if (state->check_index && !previous) {
@@ -3686,7 +3686,7 @@ static int check_preimage(struct apply_state *state,
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
 			goto is_new;
-		return error(_("%s: %s"), old_name, strerror(errno));
+		return error_errno("%s", old_name);
 	}
 
 	if (!state->cached && !previous)
@@ -3745,7 +3745,7 @@ static int check_to_create(struct apply_state *state,
 
 		return EXISTS_IN_WORKTREE;
 	} else if ((errno != ENOENT) && (errno != ENOTDIR)) {
-		return error("%s: %s", new_name, strerror(errno));
+		return error_errno("%s", new_name);
 	}
 	return 0;
 }
@@ -4260,9 +4260,9 @@ static int add_index_file(struct apply_state *state,
 		if (!state->cached) {
 			if (lstat(path, &st) < 0) {
 				free(ce);
-				return error(_("unable to stat newly "
-					       "created file '%s': %s"),
-					     path, strerror(errno));
+				return error_errno(_("unable to stat newly "
+						     "created file '%s'"),
+						   path);
 			}
 			fill_stat_cache_info(ce, &st);
 		}
@@ -4316,7 +4316,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	strbuf_release(&nbuf);
 
 	if (close(fd) < 0 && !res)
-		return error(_("closing file '%s': %s"), path, strerror(errno));
+		return error_errno(_("closing file '%s'"), path);
 
 	return res ? -1 : 0;
 }
@@ -4386,8 +4386,8 @@ static int create_one_file(struct apply_state *state,
 			++nr;
 		}
 	}
-	return error(_("unable to write file '%s' mode %o: %s"),
-		     path, mode, strerror(errno));
+	return error_errno(_("unable to write file '%s' mode %o"),
+			   path, mode);
 }
 
 static int add_conflicted_stages_file(struct apply_state *state,
@@ -4514,7 +4514,7 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 
 	rej = fopen(namebuf, "w");
 	if (!rej)
-		return error(_("cannot open %s: %s"), namebuf, strerror(errno));
+		return error_errno(_("cannot open %s"), namebuf);
 
 	/* Normal git tools never deal with .rej, so do not pretend
 	 * this is a git patch by saying --git or giving extended
-- 
2.9.0.rc2.411.g3e2ca28
