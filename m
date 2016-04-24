From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 10/83] builtin/apply: move 'check_index' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:10 +0200
Message-ID: <1461504863-15946-11-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBq-0007l6-Da
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbcDXNfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:02 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37496 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbcDXNfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:00 -0400
Received: by mail-wm0-f47.google.com with SMTP id n3so90197010wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aIDCTK4CRP1/7gaZ8eDwk3LFqRHPAkVZNs1BIpJATIU=;
        b=lx9i1Y7vEglHz2fWx+Wjle+fJIPcjPbb6F5EeyE2RDog2Lp/hsf1Pt5il0sBe5uKkJ
         /4nJtGTnI1Vlp/YDqJBJhHxYgAFNllnTZ+YUZTEU3NOqhxtPbePiuPT1FBiCvvNR9EWP
         CSHc4604LC01Sd8NK8ltydof8WxBk42Dn+zx0/vWrKmobbm/XzkoQj8MIFTkcjAzlYn8
         FamnEz9t0HVa89f1jhCw0rnya6cFwmYRFqX9LP6kfImFldMaAchab0rtvmwXG7PREdyH
         RhqC6cKvcSZApJ0+8eh7YJ+8usVilX8xWCgTdaVa1NwU+o8i5jsNPNkekWd7toTJWvgV
         kVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aIDCTK4CRP1/7gaZ8eDwk3LFqRHPAkVZNs1BIpJATIU=;
        b=N2KXV0Se9PPaQiC2nmlY/qnaMsAitOi3/IiTfa2ZfihZtnijRHo0fMsGEi/5lfdnB7
         FHAyF04tir5kz/kYWtfQJ7vA+5tLBcqJlN9JltPNqliSs5KCrWxJDOxpDzxUD8eHH4ns
         86x4TmdBk3WOw+72XCZZOZNK/hJ/9ScedQ+3eTBQ/zYbRhLsmx0SyvNSkk1zSSRp4stD
         rrh/6a0LLDcox+hrDqcYsbDYRVCzKqYfXa3bpidiAIRvPXpeYjWBrSwsnfI6M1/x5G28
         4eYtJ6jKWLkRG0K/DpIiRR6DMc0R3o9mj1KdLyQ8CCMeF2KHJukTiXlaDCuPAFK0ng4u
         PN9g==
X-Gm-Message-State: AOPr4FXGyj/fKINPfYmNpxLljeUv4GID17/GWvwRzFE6lF5LfzoWvODMnbV8EOEtnXrZYQ==
X-Received: by 10.194.10.162 with SMTP id j2mr10819415wjb.72.1461504898771;
        Sun, 24 Apr 2016 06:34:58 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292329>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 69 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6c628f6..3f8671c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -30,6 +30,10 @@ struct apply_state {
 	 *    files that are being modified, but doesn't apply the patch
 	 */
 	int check;
+
+	/* --index updates the cache as well. */
+	int check_index;
+
 	int unidiff_zero;
 };
 
@@ -37,14 +41,12 @@ struct apply_state {
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
- *  --index updates the cache as well.
  *  --cached updates only the cache without ever touching the working tree.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int check_index;
 static int update_index;
 static int cached;
 static int diffstat;
@@ -3248,13 +3250,14 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
 
-static int load_patch_target(struct strbuf *buf,
+static int load_patch_target(struct apply_state *state,
+			     struct strbuf *buf,
 			     const struct cache_entry *ce,
 			     struct stat *st,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached || check_index) {
+	if (cached || state->check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
@@ -3280,7 +3283,8 @@ static int load_patch_target(struct strbuf *buf,
  * applying a non-git patch that incrementally updates the tree,
  * we read from the result of a previous diff.
  */
-static int load_preimage(struct image *image,
+static int load_preimage(struct apply_state *state,
+			 struct image *image,
 			 struct patch *patch, struct stat *st,
 			 const struct cache_entry *ce)
 {
@@ -3298,7 +3302,7 @@ static int load_preimage(struct image *image,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(&buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3357,7 +3361,9 @@ static int three_way_merge(struct image *image,
  * the current contents of the new_name.  In no cases other than that
  * this function will be called.
  */
-static int load_current(struct image *image, struct patch *patch)
+static int load_current(struct apply_state *state,
+			struct image *image,
+			struct patch *patch)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status, pos;
@@ -3384,7 +3390,7 @@ static int load_current(struct image *image, struct patch *patch)
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(&buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
@@ -3434,11 +3440,11 @@ static int try_threeway(struct apply_state *state,
 
 	/* our_sha1[] is ours */
 	if (patch->is_new) {
-		if (load_current(&tmp_image, patch))
+		if (load_current(state, &tmp_image, patch))
 			return error("cannot read the current contents of '%s'",
 				     patch->new_name);
 	} else {
-		if (load_preimage(&tmp_image, patch, st, ce))
+		if (load_preimage(state, &tmp_image, patch, st, ce))
 			return error("cannot read the current contents of '%s'",
 				     patch->old_name);
 	}
@@ -3473,7 +3479,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 {
 	struct image image;
 
-	if (load_preimage(&image, patch, st, ce) < 0)
+	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
 	if (patch->direct_to_threeway ||
@@ -3504,7 +3510,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
  * check_patch() separately makes sure (and errors out otherwise) that
  * the path the patch creates does not exist in the current tree.
  */
-static int check_preimage(struct patch *patch, struct cache_entry **ce, struct stat *st)
+static int check_preimage(struct apply_state *state,
+			  struct patch *patch,
+			  struct cache_entry **ce,
+			  struct stat *st)
 {
 	const char *old_name = patch->old_name;
 	struct patch *previous = NULL;
@@ -3527,7 +3536,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (check_index && !previous) {
+	if (state->check_index && !previous) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
@@ -3577,11 +3586,13 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 #define EXISTS_IN_INDEX 1
 #define EXISTS_IN_WORKTREE 2
 
-static int check_to_create(const char *new_name, int ok_if_exists)
+static int check_to_create(struct apply_state *state,
+			   const char *new_name,
+			   int ok_if_exists)
 {
 	struct stat nst;
 
-	if (check_index &&
+	if (state->check_index &&
 	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
@@ -3657,7 +3668,7 @@ static void prepare_symlink_changes(struct patch *patch)
 	}
 }
 
-static int path_is_beyond_symlink_1(struct strbuf *name)
+static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *name)
 {
 	do {
 		unsigned int change;
@@ -3678,7 +3689,7 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
 			continue;
 
 		/* otherwise, check the preimage */
-		if (check_index) {
+		if (state->check_index) {
 			struct cache_entry *ce;
 
 			ce = cache_file_exists(name->buf, name->len, ignore_case);
@@ -3693,14 +3704,14 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
 	return 0;
 }
 
-static int path_is_beyond_symlink(const char *name_)
+static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 {
 	int ret;
 	struct strbuf name = STRBUF_INIT;
 
 	assert(*name_ != '\0');
 	strbuf_addstr(&name, name_);
-	ret = path_is_beyond_symlink_1(&name);
+	ret = path_is_beyond_symlink_1(state, &name);
 	strbuf_release(&name);
 
 	return ret;
@@ -3740,7 +3751,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	patch->rejected = 1; /* we will drop this after we succeed */
 
-	status = check_preimage(patch, &ce, &st);
+	status = check_preimage(state, patch, &ce, &st);
 	if (status)
 		return status;
 	old_name = patch->old_name;
@@ -3767,7 +3778,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	if (new_name &&
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
-		int err = check_to_create(new_name, ok_if_exists);
+		int err = check_to_create(state, new_name, ok_if_exists);
 
 		if (err && threeway) {
 			patch->direct_to_threeway = 1;
@@ -3822,7 +3833,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * is not deposited to a path that is beyond a symbolic link
 	 * here.
 	 */
-	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+	if (!patch->is_delete && path_is_beyond_symlink(state, patch->new_name))
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
 
@@ -4434,11 +4445,11 @@ static int apply_patch(struct apply_state *state,
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
 		apply = 0;
 
-	update_index = check_index && apply;
+	update_index = state->check_index && apply;
 	if (update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
-	if (check_index) {
+	if (state->check_index) {
 		if (read_cache() < 0)
 			die(_("unable to read index file"));
 	}
@@ -4565,7 +4576,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
-		OPT_BOOL(0, "index", &check_index,
+		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
@@ -4632,20 +4643,20 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	if (threeway) {
 		if (is_not_gitdir)
 			die(_("--3way outside a repository"));
-		check_index = 1;
+		state.check_index = 1;
 	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
-	if (check_index && is_not_gitdir)
+	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
 	if (cached) {
 		if (is_not_gitdir)
 			die(_("--cached outside a repository"));
-		check_index = 1;
+		state.check_index = 1;
 	}
-	if (check_index)
+	if (state.check_index)
 		unsafe_paths = 0;
 
 	for (i = 0; i < argc; i++) {
-- 
2.8.1.300.g5fed0c0
