From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 10/48] builtin/apply: move 'check_index' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:38 +0100
Message-ID: <1457545756-20616-11-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHn-0007er-0B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933694AbcCIRwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:31 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35611 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933669AbcCIRw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:28 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so190199308wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIxzLs9S4hgKh0g05ENfC57OAUVmpMpc43FgrHbhAB0=;
        b=r4RJX7/3p0uuNY5TwD3nVAGsjbgUqU8R8XYRNQKwd6WKZmNwI+kUl/wxQjqh2NthHQ
         6NoWpxi6RFNtqJrf89GLmKFELsWXGt1O24CxVEp/jh2tjRAHFdXRZo16xULxfikelSen
         rO7OitWJdhHQncsLNlThcRPA0+dhvbPA30Rbj31rZ0PWrqw0G9HsK7dDjFW98MBkslzY
         BPD04Lg6TFJxoO1ocLqsNYpv95Ivm6I/K8Wg+5d52CQQmfG7J8mK4vktT84yFzlb5kOu
         K4TigCZTDtG1CaHmcjQzKMU98fNmVwxLx9AR6fF/0Z3mLn/tRGReOPww7nyi28rk6Ub0
         /laA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIxzLs9S4hgKh0g05ENfC57OAUVmpMpc43FgrHbhAB0=;
        b=ciFyCO7/QETI/jSGPyFPQkr0GmAKVm+v908W+LmAQtcRl352rXeY9f15AciOS/n6MJ
         kzJmwFjMuaBLWbAD00v6mzhrHTAu5uHmiYS52jMzLPUYO849x1UfGogx7eQ5TkUOh0XC
         HJrbcS7G+rlk71gtybvqCcYdRAI15YaiXce+KqUMDV5xyGdSu2pD4b5MY1u02LHveBhy
         /fWsrlgCyvQe1n5mPUS13vH5Mw63ibkr8MaARI8r87TIg5bQFK0q4JiQV6FzvOShYuYx
         84kv3nZe921zZFPHya0KsFiTrZ/kdKvUEeBKf2WsiR9CRtOZtZACUo99FfH6VQtoUUls
         UlvQ==
X-Gm-Message-State: AD7BkJL+nVqOy5NrYoG1a1go0wlCycmSt6x/Rg2WmXKOB6bYXPElP8l3G1Z9BE4V28bloQ==
X-Received: by 10.194.23.37 with SMTP id j5mr35321450wjf.171.1457545946107;
        Wed, 09 Mar 2016 09:52:26 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:25 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288501>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 69 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 37879de..9bc01a8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -31,6 +31,10 @@ struct apply_state {
 	 *    files that are being modified, but doesn't apply the patch
 	 */
 	int check;
+
+	/* --index updates the cache as well. */
+	int check_index;
+
 	int unidiff_zero;
 };
 
@@ -38,13 +42,11 @@ struct apply_state {
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
- *  --index updates the cache as well.
  *  --cached updates only the cache without ever touching the working tree.
  */
 
 static int p_value = 1;
 static int p_value_known;
-static int check_index;
 static int update_index;
 static int cached;
 static int diffstat;
@@ -3250,13 +3252,14 @@ static int verify_index_match(const struct cache_entry *ce, struct stat *st)
 
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
@@ -3282,7 +3285,8 @@ static int load_patch_target(struct strbuf *buf,
  * applying a non-git patch that incrementally updates the tree,
  * we read from the result of a previous diff.
  */
-static int load_preimage(struct image *image,
+static int load_preimage(struct apply_state *state,
+			 struct image *image,
 			 struct patch *patch, struct stat *st,
 			 const struct cache_entry *ce)
 {
@@ -3300,7 +3304,7 @@ static int load_preimage(struct image *image,
 		/* We have a patched copy in memory; use that. */
 		strbuf_add(&buf, previous->result, previous->resultsize);
 	} else {
-		status = load_patch_target(&buf, ce, st,
+		status = load_patch_target(state, &buf, ce, st,
 					   patch->old_name, patch->old_mode);
 		if (status < 0)
 			return status;
@@ -3359,7 +3363,9 @@ static int three_way_merge(struct image *image,
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
@@ -3386,7 +3392,7 @@ static int load_current(struct image *image, struct patch *patch)
 	if (verify_index_match(ce, &st))
 		return error(_("%s: does not match index"), name);
 
-	status = load_patch_target(&buf, ce, &st, name, mode);
+	status = load_patch_target(state, &buf, ce, &st, name, mode);
 	if (status < 0)
 		return status;
 	else if (status)
@@ -3436,11 +3442,11 @@ static int try_threeway(struct apply_state *state,
 
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
@@ -3475,7 +3481,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 {
 	struct image image;
 
-	if (load_preimage(&image, patch, st, ce) < 0)
+	if (load_preimage(state, &image, patch, st, ce) < 0)
 		return -1;
 
 	if (patch->direct_to_threeway ||
@@ -3506,7 +3512,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
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
@@ -3529,7 +3538,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 			return error(_("%s: %s"), old_name, strerror(errno));
 	}
 
-	if (check_index && !previous) {
+	if (state->check_index && !previous) {
 		int pos = cache_name_pos(old_name, strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
@@ -3579,11 +3588,13 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
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
@@ -3659,7 +3670,7 @@ static void prepare_symlink_changes(struct patch *patch)
 	}
 }
 
-static int path_is_beyond_symlink_1(struct strbuf *name)
+static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *name)
 {
 	do {
 		unsigned int change;
@@ -3680,7 +3691,7 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
 			continue;
 
 		/* otherwise, check the preimage */
-		if (check_index) {
+		if (state->check_index) {
 			struct cache_entry *ce;
 
 			ce = cache_file_exists(name->buf, name->len, ignore_case);
@@ -3695,14 +3706,14 @@ static int path_is_beyond_symlink_1(struct strbuf *name)
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
@@ -3742,7 +3753,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	patch->rejected = 1; /* we will drop this after we succeed */
 
-	status = check_preimage(patch, &ce, &st);
+	status = check_preimage(state, patch, &ce, &st);
 	if (status)
 		return status;
 	old_name = patch->old_name;
@@ -3769,7 +3780,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 
 	if (new_name &&
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
-		int err = check_to_create(new_name, ok_if_exists);
+		int err = check_to_create(state, new_name, ok_if_exists);
 
 		if (err && threeway) {
 			patch->direct_to_threeway = 1;
@@ -3824,7 +3835,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
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
 	if (update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(&lock_file, 1);
 
-	if (check_index) {
+	if (state->check_index) {
 		if (read_cache() < 0)
 			die(_("unable to read index file"));
 	}
@@ -4563,7 +4574,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
-		OPT_BOOL(0, "index", &check_index,
+		OPT_BOOL(0, "index", &state.check_index,
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
@@ -4631,20 +4642,20 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
