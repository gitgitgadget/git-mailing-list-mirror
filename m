From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 44/44] apply: use error_errno() where possible
Date: Fri, 10 Jun 2016 22:11:18 +0200
Message-ID: <20160610201118.13813-45-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnd-0003vF-9y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbcFJUM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32784 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730AbcFJUMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1071990wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1w7zFZgf4NFBvlrS9RboAq5p2/cPzprG6UFqd4sVsE=;
        b=Ewjylw3uM59N3yZVcWvC0lxHYk5e1MPmDQhKrg8nbMAlNp6zJyTsZs6XWosVIiYLRG
         qNtYGn7xS4HA5imGsvaNeJbqv8Pfz3xJvSXrc33giAemVkvmsqUNyLCMjOYVeKK+rp7o
         oR9D+MPUFtTwnGGNXrcdUGFpW9lwChij7vasfR+JVpROq4XDA+YjYt1QHF3q/6PZXwrx
         hS3wuZhwNH0KTB8nOw7ZiJdQUeGQUOrw3tE1Jxv+CCnNuxMhLP+XPFvDoVf5AmF7kmyF
         /4ov0iuO0EyKNf2oS24/iKHmysotluGIDTR1ikFEQyKRftRMCkJ2PbqNAy+EFsmUnFNI
         a+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1w7zFZgf4NFBvlrS9RboAq5p2/cPzprG6UFqd4sVsE=;
        b=NOqY9OuSn8axJYosh4scmI88DD8MVKLToug4MrZHPRY1Ep9VMC+7uQFyCl8VTDJVNs
         YNf9DJHVQgXhHPSnScRb6F0tqfeCZKEV06haJ+EbNt5s+bXiTxYzAOJVnXv/j13gGGwK
         MTAQss6l+b9gUd/GuYeF3zixZOgaBFwu3rupECpaStRq+ilNq+Pc+QCZuctnej33dLXw
         DdlIO6XKmmjt+kwyEFrqz97CeTIqtFn+BJclJrTZRIziRzfqlwS0CESgmh9idNf+tT/H
         jdhysRuefD5xs2kQ71VyHVAq4qda29Cmpa9YlW7mwAWdmAK22SZ7J9ndTjWPd+fj2em9
         eFfw==
X-Gm-Message-State: ALyK8tII8e3TDyaBx0qYSpx99WJHmg/FW1x3qI+MtFbyAUvSNMBiP236SU/cZXmzQBPJbA==
X-Received: by 10.28.1.151 with SMTP id 145mr596405wmb.25.1465589570693;
        Fri, 10 Jun 2016 13:12:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297048>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index ef49709..cd4cd01 100644
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
+	return error_errno(_("unable to write file '%s' mode %o: %s"),
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
2.9.0.rc2.362.g3cd93d0
