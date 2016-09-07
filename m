Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B122070F
	for <e@80x24.org>; Wed,  7 Sep 2016 14:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757492AbcIGOuc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 10:50:32 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:35746 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756560AbcIGOuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 10:50:25 -0400
Received: (qmail 6538 invoked from network); 7 Sep 2016 14:50:22 -0000
Received: (qmail 29219 invoked from network); 7 Sep 2016 14:50:20 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Sep 2016 14:50:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/13] i18n: apply: mark error messages for translation
Date:   Wed,  7 Sep 2016 14:49:06 +0000
Message-Id: <1473259758-11836-2-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark error messages for translation passed to error() and die()
functions.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/apply.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ef03c74..ef2c084 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3065,8 +3065,8 @@ static int apply_binary_fragment(struct apply_state *state,
 	/* Binary patch is irreversible without the optional second hunk */
 	if (state->apply_in_reverse) {
 		if (!fragment->next)
-			return error("cannot reverse-apply a binary patch "
-				     "without the reverse hunk to '%s'",
+			return error(_("cannot reverse-apply a binary patch "
+				       "without the reverse hunk to '%s'"),
 				     patch->new_name
 				     ? patch->new_name : patch->old_name);
 		fragment = fragment->next;
@@ -3111,8 +3111,8 @@ static int apply_binary(struct apply_state *state,
 	    strlen(patch->new_sha1_prefix) != 40 ||
 	    get_sha1_hex(patch->old_sha1_prefix, sha1) ||
 	    get_sha1_hex(patch->new_sha1_prefix, sha1))
-		return error("cannot apply binary patch to '%s' "
-			     "without full index line", name);
+		return error(_("cannot apply binary patch to '%s' "
+			       "without full index line"), name);
 
 	if (patch->old_name) {
 		/*
@@ -3121,16 +3121,16 @@ static int apply_binary(struct apply_state *state,
 		 */
 		hash_sha1_file(img->buf, img->len, blob_type, sha1);
 		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
-			return error("the patch applies to '%s' (%s), "
-				     "which does not match the "
-				     "current contents.",
+			return error(_("the patch applies to '%s' (%s), "
+				       "which does not match the "
+				       "current contents."),
 				     name, sha1_to_hex(sha1));
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
 		if (img->len)
-			return error("the patch applies to an empty "
-				     "'%s' but it is not empty", name);
+			return error(_("the patch applies to an empty "
+				       "'%s' but it is not empty"), name);
 	}
 
 	get_sha1_hex(patch->new_sha1_prefix, sha1);
@@ -3147,8 +3147,8 @@ static int apply_binary(struct apply_state *state,
 
 		result = read_sha1_file(sha1, &type, &size);
 		if (!result)
-			return error("the necessary postimage %s for "
-				     "'%s' cannot be read",
+			return error(_("the necessary postimage %s for "
+				       "'%s' cannot be read"),
 				     patch->new_sha1_prefix, name);
 		clear_image(img);
 		img->buf = result;
@@ -3523,7 +3523,7 @@ static int try_threeway(struct apply_state *state,
 		write_sha1_file("", 0, blob_type, pre_sha1);
 	else if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
 		 read_blob_object(&buf, pre_sha1, patch->old_mode))
-		return error("repository lacks the necessary blob to fall back on 3-way merge.");
+		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
 
 	fprintf(stderr, "Falling back to three-way merge...\n");
 
@@ -3541,11 +3541,11 @@ static int try_threeway(struct apply_state *state,
 	/* our_sha1[] is ours */
 	if (patch->is_new) {
 		if (load_current(state, &tmp_image, patch))
-			return error("cannot read the current contents of '%s'",
+			return error(_("cannot read the current contents of '%s'"),
 				     patch->new_name);
 	} else {
 		if (load_preimage(state, &tmp_image, patch, st, ce))
-			return error("cannot read the current contents of '%s'",
+			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
 	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_sha1);
@@ -4020,29 +4020,29 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
 				; /* ok, the textual part looks sane */
 			else
-				die("sha1 information is lacking or useless for submodule %s",
+				die(_("sha1 information is lacking or useless for submodule %s"),
 				    name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_sha1(patch->old_name, sha1))
-				die("mode change for %s, which is not "
-				    "in current HEAD", name);
+				die(_("mode change for %s, which is not "
+				    "in current HEAD"), name);
 		} else
-			die("sha1 information is lacking or useless "
-			    "(%s).", name);
+			die(_("sha1 information is lacking or useless "
+			    "(%s)."), name);
 
 		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
-			die ("Could not add %s to temporary index", name);
+			die(_("Could not add %s to temporary index"), name);
 	}
 
 	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
 	if (write_locked_index(&result, &lock, COMMIT_LOCK))
-		die ("Could not write temporary index to %s", filename);
+		die(_("Could not write temporary index to %s"), filename);
 
 	discard_index(&result);
 }
@@ -4693,9 +4693,9 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		die(_("--reject and --3way cannot be used together."));
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		die(_("--cached and --3way cannot be used together."));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			die(_("--3way outside a repository"));
-- 
2.7.4

