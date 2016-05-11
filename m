From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 18/94] builtin/apply: move 'cached' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:29 +0200
Message-ID: <20160511131745.2914-19-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2k-0002Di-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbcEKNTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35462 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbcEKNTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9402053wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3qeKecfwvCRnF3tMiaNVUMuzPjvpkah0/t8iAXxj00=;
        b=tHLi8QfXfTMoSVmKvijSv2z3Ccu8CoRcRccd30lh9HnjPmI7s11EqE2OYMV3sm04xp
         jIUdFqxkvrgmwa9cA5DbL3+LjFy4DX1MMuRgE0uh64KaDhi1xE4iZ8xT4ORZWL3wc/kC
         kHkD/Gz34kUyblDPVUK6EFtncBOwMXSA494Cc+CxnOxjw5l9xtlOKvK7l0QZBb/XXKke
         ZdwimBbCVhuP9qcag1fl5vU5a0Me9gToFS35L3cBKFdz8gyoKGcZ0aD4hGcK89ZpzAjq
         CDzXLjoRN0iyjCkA6RJQdnQ52CcrlmEX4goGKer6BWERqPAfO+Ru19G2jZALgxFxOgfO
         5Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3qeKecfwvCRnF3tMiaNVUMuzPjvpkah0/t8iAXxj00=;
        b=B/MHNpkxq/Av5qW034L7EJ13u48V1MczO5H3L4qzrlOJhvCHRVM9hEzwPOaBCnzLVU
         aE2B9OKLSoDwZBLupG+fx2/yUFx26zuWNmEM6xxDYxaKQAAQGmPlvPb1XG/4c8wmOEOP
         7AYf2AIzIsF4j3MkaSo4CIl29FYuKNfmIAPtHVAeHgiFZRIqqNnKNWtH86du/w3EdIb8
         ZKw1P6On9HeSb9DVVf+9AoFZr1GG1W0TgG0x+atevsmoVsI6rzO8CYXT5rX9JGdqhZ23
         J5KQ0FMxWVZvwZNQLAniwDW1aAFE9EX6CV8WQ9oZZsrPssXBQyOqvAkcE1hZZu+0UK4U
         6aVw==
X-Gm-Message-State: AOPr4FUMq14mHxr7HLB6YmCFjfbmo1Z1EdbQ73Bc12OaGxfRWUa61RN3jUt/8Q1yzyVHUw==
X-Received: by 10.194.87.72 with SMTP id v8mr4245434wjz.68.1462972742794;
        Wed, 11 May 2016 06:19:02 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:01 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294260>

To libify the apply functionality the 'cached' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8791b28..09af5dc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -30,6 +30,9 @@ struct apply_state {
 	int apply_with_reject;
 	int apply_verbosely;
 
+	/* --cached updates only the cache without ever touching the working tree. */
+	int cached;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -47,13 +50,11 @@ struct apply_state {
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
- *  --cached updates only the cache without ever touching the working tree.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
@@ -3269,7 +3270,7 @@ static int load_patch_target(struct apply_state *state,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached || state->check_index) {
+	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
@@ -3542,7 +3543,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("path %s has been renamed/deleted"), old_name);
 	if (previous) {
 		st_mode = previous->new_mode;
-	} else if (!cached) {
+	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
@@ -3560,9 +3561,9 @@ static int check_preimage(struct apply_state *state,
 			if (checkout_target(&the_index, *ce, st))
 				return -1;
 		}
-		if (!cached && verify_index_match(*ce, st))
+		if (!state->cached && verify_index_match(*ce, st))
 			return error(_("%s: does not match index"), old_name);
-		if (cached)
+		if (state->cached)
 			st_mode = (*ce)->ce_mode;
 	} else if (stat_ret < 0) {
 		if (patch->is_new < 0)
@@ -3570,7 +3571,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (!cached && !previous)
+	if (!state->cached && !previous)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
@@ -3608,7 +3609,7 @@ static int check_to_create(struct apply_state *state,
 	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
-	if (cached)
+	if (state->cached)
 		return 0;
 
 	if (!lstat(new_name, &nst)) {
@@ -4102,7 +4103,7 @@ static void remove_file(struct apply_state *state, struct patch *patch, int rmdi
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die(_("unable to remove %s from index"), patch->old_name);
 	}
-	if (!cached) {
+	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
@@ -4135,7 +4136,7 @@ static void add_index_file(struct apply_state *state,
 		    get_sha1_hex(s, ce->sha1))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
-		if (!cached) {
+		if (!state->cached) {
 			if (lstat(path, &st) < 0)
 				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
@@ -4187,9 +4188,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
  */
-static void create_one_file(char *path, unsigned mode, const char *buf, unsigned long size)
+static void create_one_file(struct apply_state *state,
+			    char *path,
+			    unsigned mode,
+			    const char *buf,
+			    unsigned long size)
 {
-	if (cached)
+	if (state->cached)
 		return;
 	if (!try_create_file(path, mode, buf, size))
 		return;
@@ -4267,7 +4272,7 @@ static void create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(path, mode, buf, size);
+	create_one_file(state, path, mode, buf, size);
 
 	if (patch->conflicted_threeway)
 		add_conflicted_stages_file(state, patch);
@@ -4611,7 +4616,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOL(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
@@ -4663,7 +4668,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
-	if (cached && threeway)
+	if (state.cached && threeway)
 		die("--cached and --3way cannot be used together.");
 	if (threeway) {
 		if (is_not_gitdir)
@@ -4676,7 +4681,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-	if (cached) {
+	if (state.cached) {
 		if (is_not_gitdir)
 			die(_("--cached outside a repository"));
 		state.check_index = 1;
-- 
2.8.2.490.g3dabe57
