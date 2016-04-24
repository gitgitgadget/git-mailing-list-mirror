From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 16/83] builtin/apply: move 'cached' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:16 +0200
Message-ID: <1461504863-15946-17-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFa-0001Ig-2N
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbcDXNi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:56 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38251 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbcDXNfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:09 -0400
Received: by mail-wm0-f54.google.com with SMTP id u206so89925804wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5GrJN38QODExWKPsFmpJFOtxuZnd2yYFSqAILjlKAM=;
        b=MWCtYKVU7soG0W5jUqv4O3SVmxwWixRN4lqvzu5JHI8J0YEIyTUa/JlideXoYtCjgC
         Y9CqlIhDL9v5BBeGCMfvxtn0FdAwWSA1T5dQ+2uDhY6l4gGUwLohN/gv7DpYmi3jH9lc
         ADa78Ez6iPGQSp4q/t+QIbecgz5HA1nN4NXHiFP10/rrKy1xAJtx62zd6siKpxWZkd0g
         L3hCCsL3bzJDf2x0uG/437dDGL7wskXcqGW/Vb6oxslOqZQrNE5RoMEXkzEBSCREVwnh
         FAFjk/D9+bkR8ZKMcvTa9+3m5jFVbNA/PV2G0I0XiUpISNFnBHhwgazwL6ypS8vPOKUP
         h0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5GrJN38QODExWKPsFmpJFOtxuZnd2yYFSqAILjlKAM=;
        b=B8fYMuNtMGkNIx3I+HVSSqauwSIQW76XvY1QXpnNCZ7Yl6ibq8vtqdCBDGTmDzyLUW
         +GYku7GoN39TWjo4N/3NcNzhk6SbN4Y+ZWNGH4C14F9jblReLNMTRhtTMcQKDQGhGTz/
         xj6hNVi+QyAk07DplyFdAjdDfLzZm7zIBWLPSZFEtywdsI/HWGz+rDzzdZOMXcM7Nal2
         mmoyX3s6wgEHVJLaQy0vzYA6atwM/LMENuwPpa23vzSQM5iNXO+UDjtynbsS0DAFCwgU
         Z+kNj6t1b468xQ2vXaMs4Yj/zwfgKlUi6mgZX+fICaosLhIqPiEj7MEpE0Q4KrOiBZiS
         gRmw==
X-Gm-Message-State: AOPr4FU8G99vDmj9BellhuZ+u5l3Nb7siGrwX9XZjSv3RMVIsT5zA6A7acIJwGbcelZ9GA==
X-Received: by 10.28.22.65 with SMTP id 62mr7213052wmw.32.1461504908000;
        Sun, 24 Apr 2016 06:35:08 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:07 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292395>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a5dff99..ba828df 100644
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
@@ -48,13 +51,11 @@ struct apply_state {
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
@@ -3272,7 +3273,7 @@ static int load_patch_target(struct apply_state *state,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached || state->check_index) {
+	if (state->cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
@@ -3545,7 +3546,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("path %s has been renamed/deleted"), old_name);
 	if (previous) {
 		st_mode = previous->new_mode;
-	} else if (!cached) {
+	} else if (!state->cached) {
 		stat_ret = lstat(old_name, st);
 		if (stat_ret && errno != ENOENT)
 			return error(_("%s: %s"), old_name, strerror(errno));
@@ -3563,9 +3564,9 @@ static int check_preimage(struct apply_state *state,
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
@@ -3573,7 +3574,7 @@ static int check_preimage(struct apply_state *state,
 		return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (!cached && !previous)
+	if (!state->cached && !previous)
 		st_mode = ce_mode_from_stat(*ce, st->st_mode);
 
 	if (patch->is_new < 0)
@@ -3611,7 +3612,7 @@ static int check_to_create(struct apply_state *state,
 	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
-	if (cached)
+	if (state->cached)
 		return 0;
 
 	if (!lstat(new_name, &nst)) {
@@ -4105,7 +4106,7 @@ static void remove_file(struct apply_state *state, struct patch *patch, int rmdi
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die(_("unable to remove %s from index"), patch->old_name);
 	}
-	if (!cached) {
+	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
@@ -4138,7 +4139,7 @@ static void add_index_file(struct apply_state *state,
 		    get_sha1_hex(s, ce->sha1))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
-		if (!cached) {
+		if (!state->cached) {
 			if (lstat(path, &st) < 0)
 				die_errno(_("unable to stat newly created file '%s'"),
 					  path);
@@ -4190,9 +4191,13 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
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
@@ -4270,7 +4275,7 @@ static void create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	create_one_file(path, mode, buf, size);
+	create_one_file(state, path, mode, buf, size);
 
 	if (patch->conflicted_threeway)
 		add_conflicted_stages_file(state, patch);
@@ -4600,7 +4605,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOL(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
@@ -4660,7 +4665,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
-	if (cached && threeway)
+	if (state.cached && threeway)
 		die("--cached and --3way cannot be used together.");
 	if (threeway) {
 		if (is_not_gitdir)
@@ -4673,7 +4678,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-	if (cached) {
+	if (state.cached) {
 		if (is_not_gitdir)
 			die(_("--cached outside a repository"));
 		state.check_index = 1;
-- 
2.8.1.300.g5fed0c0
