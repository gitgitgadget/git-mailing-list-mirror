From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 12/94] builtin/apply: move 'check_index' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:23 +0200
Message-ID: <20160511131745.2914-13-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2g-0002CT-58
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbcEKNTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34345 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbcEKNSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so9410303wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJ4nkUzwcrWXjzQPNxjDqQMo+kQ+7aI8Lo5zjEkablg=;
        b=A36cSwqNxzUFvXDkeuz4D8oJvurC/YoUzXcIIUNCQuhYoNeBoMEsKXw7sHIpRqJgaU
         m6SRU5VIa+oi/MQffihAS1kCqGslDH5XVnEjT9B5SGxerKdQyCnGcYwI/Fp2WYj52tBB
         2NGnmfoQbuk5iPZYIVn7qj3Wf/5nlGdKxmjp0P8I/LYVSfTMH/IBtz5DPV+vhwo4sHt8
         iM65RKAZDsU0UTaNSVhqVVGmK9ixwI8RnTGd7G1mrQQXhiWjnoob8yyrUqkdqL8MQvw4
         br3WrvCo7PXFs2wOvDtPWn+O5+Q1OceuaIJIMUTk6O9hDZPleDXzNof+mHr16C8HLt8i
         zmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJ4nkUzwcrWXjzQPNxjDqQMo+kQ+7aI8Lo5zjEkablg=;
        b=jHd3TKqlcOvGHdhmVOvbqdR4Ky3Jz4wfVYbnpWlP/cQHCKfXx9pBVSgu8OhUjSJVqp
         Rc8hl9pU+ocnZxr6XaHnZiPDpG242SZ3m6bAUOG3Bdd6aaISSLweZVdB++fo5CWvIigJ
         dxn4KBLjkPKS82Z1OpiDlxCLRN8F661uaA0/VNw9dL/ideVzPrGa5xKEPkbdUaf59GxU
         9KYQeoWWqoOKGbvcMpsTqkWCtvCowVWNR9phVRMBWYG51KXWkvmH9/stTClm2yYS3zx1
         JjeyqFtESnYm199NPihZoJqfTigPMVX5Q+YgEf4HajvkvJFE4Rm7jqRGWVGPeHiGjcXF
         OMOg==
X-Gm-Message-State: AOPr4FX9UiTgevVpbYlCl0u4qtdcZ+jxG9TsCm1lNoftzs46nPw+5z3WNKHZixh6rdf9uA==
X-Received: by 10.28.229.68 with SMTP id c65mr15463wmh.77.1462972730486;
        Wed, 11 May 2016 06:18:50 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:49 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294258>

To libify the apply functionality the 'check_index' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 69 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6bf103a..5d8f410 100644
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
@@ -3246,13 +3248,14 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 
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
@@ -3278,7 +3281,8 @@ static int load_patch_target(struct strbuf *buf,
  * applying a non-git patch that incrementally updates the tree,
  * we read from the result of a previous diff.
  */
-static int load_preimage(struct image *image,
+static int load_preimage(struct apply_state *state,
+			 struct image *image,
 			 struct patch *patch, struct stat *st,
 			 const struct cache_entry *ce)
 {
@@ -3296,7 +3300,7 @@ static int load_preimage(struct image *image,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(&buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3355,7 +3359,9 @@ static int three_way_merge(struct image *image,
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
@@ -3382,7 +3388,7 @@ static int load_current(struct image *image, struct patch *patch)
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(&buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
@@ -3432,11 +3438,11 @@ static int try_threeway(struct apply_state *state,
 
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
@@ -3471,7 +3477,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 {
 	struct image image;
 
-	if (load_preimage(&image, patch, st, ce) < 0)
+	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
 	if (patch->direct_to_threeway ||
@@ -3502,7 +3508,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
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
@@ -3525,7 +3534,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (check_index && !previous) {
+	if (state->check_index && !previous) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
@@ -3575,11 +3584,13 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
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
@@ -3655,7 +3666,7 @@ static void prepare_symlink_changes(struct patch *patch)
 	}
 }
 
-static int path_is_beyond_symlink_1(struct strbuf *name)
+static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *name)
 {
 	do {
 		unsigned int change;
@@ -3676,7 +3687,7 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
 			continue;
 
 		/* otherwise, check the preimage */
-		if (check_index) {
+		if (state->check_index) {
 			struct cache_entry *ce;
 
 			ce = cache_file_exists(name->buf, name->len, ignore_case);
@@ -3691,14 +3702,14 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
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
@@ -3738,7 +3749,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	patch->rejected = 1; /* we will drop this after we succeed */
 
-	status = check_preimage(patch, &ce, &st);
+	status = check_preimage(state, patch, &ce, &st);
 	if (status)
 		return status;
 	old_name = patch->old_name;
@@ -3765,7 +3776,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	if (new_name &&
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
-		int err = check_to_create(new_name, ok_if_exists);
+		int err = check_to_create(state, new_name, ok_if_exists);
 
 		if (err && threeway) {
 			patch->direct_to_threeway = 1;
@@ -3820,7 +3831,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * is not deposited to a path that is beyond a symbolic link
 	 * here.
 	 */
-	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+	if (!patch->is_delete && path_is_beyond_symlink(state, patch->new_name))
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
 
@@ -4432,11 +4443,11 @@ static int apply_patch(struct apply_state *state,
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
@@ -4577,7 +4588,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
-		OPT_BOOL(0, "index", &check_index,
+		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
@@ -4636,20 +4647,20 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.2.490.g3dabe57
