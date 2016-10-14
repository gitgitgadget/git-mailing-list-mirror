Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33D4209AA
	for <e@80x24.org>; Fri, 14 Oct 2016 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbcJNLra (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 07:47:30 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:40894 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754684AbcJNLr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 07:47:27 -0400
Received: (qmail 18895 invoked from network); 14 Oct 2016 11:47:24 -0000
Received: (qmail 31620 invoked from network); 14 Oct 2016 11:47:24 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Oct 2016 11:47:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 3/3] i18n: apply: mark error messages for translation
Date:   Fri, 14 Oct 2016 11:43:37 +0000
Message-Id: <20161014114337.18684-3-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
In-Reply-To: <20161014114337.18684-1-vascomalmeida@sapo.pt>
References: <20161014114337.18684-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark error messages for translation passed to error() and die()
functions.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 apply.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/apply.c b/apply.c
index 13b2064..8215874 100644
--- a/apply.c
+++ b/apply.c
@@ -122,9 +122,9 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
+		return error(_("--reject and --3way cannot be used together."));
 	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
+		return error(_("--cached and --3way cannot be used together."));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
@@ -3095,8 +3095,8 @@ static int apply_binary_fragment(struct apply_state *state,
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
@@ -3141,8 +3141,8 @@ static int apply_binary(struct apply_state *state,
 	    strlen(patch->new_sha1_prefix) != 40 ||
 	    get_oid_hex(patch->old_sha1_prefix, &oid) ||
 	    get_oid_hex(patch->new_sha1_prefix, &oid))
-		return error("cannot apply binary patch to '%s' "
-			     "without full index line", name);
+		return error(_("cannot apply binary patch to '%s' "
+			       "without full index line"), name);
 
 	if (patch->old_name) {
 		/*
@@ -3151,16 +3151,16 @@ static int apply_binary(struct apply_state *state,
 		 */
 		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
 		if (strcmp(oid_to_hex(&oid), patch->old_sha1_prefix))
-			return error("the patch applies to '%s' (%s), "
-				     "which does not match the "
-				     "current contents.",
+			return error(_("the patch applies to '%s' (%s), "
+				       "which does not match the "
+				       "current contents."),
 				     name, oid_to_hex(&oid));
 	}
 	else {
 		/* Otherwise, the old one must be empty. */
 		if (img->len)
-			return error("the patch applies to an empty "
-				     "'%s' but it is not empty", name);
+			return error(_("the patch applies to an empty "
+				       "'%s' but it is not empty"), name);
 	}
 
 	get_oid_hex(patch->new_sha1_prefix, &oid);
@@ -3177,8 +3177,8 @@ static int apply_binary(struct apply_state *state,
 
 		result = read_sha1_file(oid.hash, &type, &size);
 		if (!result)
-			return error("the necessary postimage %s for "
-				     "'%s' cannot be read",
+			return error(_("the necessary postimage %s for "
+				       "'%s' cannot be read"),
 				     patch->new_sha1_prefix, name);
 		clear_image(img);
 		img->buf = result;
@@ -3551,7 +3551,7 @@ static int try_threeway(struct apply_state *state,
 		write_sha1_file("", 0, blob_type, pre_oid.hash);
 	else if (get_sha1(patch->old_sha1_prefix, pre_oid.hash) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
-		return error("repository lacks the necessary blob to fall back on 3-way merge.");
+		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
 
 	if (state->apply_verbosity > verbosity_silent)
 		fprintf(stderr, _("Falling back to three-way merge...\n"));
@@ -3570,11 +3570,11 @@ static int try_threeway(struct apply_state *state,
 	/* our_oid is ours */
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
 	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_oid.hash);
@@ -4072,18 +4072,18 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			if (!preimage_oid_in_gitlink_patch(patch, &oid))
 				; /* ok, the textual part looks sane */
 			else
-				return error("sha1 information is lacking or "
-					     "useless for submodule %s", name);
+				return error(_("sha1 information is lacking or "
+					       "useless for submodule %s"), name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, oid.hash)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_oid(state, patch->old_name, &oid))
-				return error("mode change for %s, which is not "
-					     "in current HEAD", name);
+				return error(_("mode change for %s, which is not "
+					       "in current HEAD"), name);
 		} else
-			return error("sha1 information is lacking or useless "
-				     "(%s).", name);
+			return error(_("sha1 information is lacking or useless "
+				       "(%s)."), name);
 
 		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
@@ -4091,7 +4091,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
 			free(ce);
-			return error("Could not add %s to temporary index",
+			return error(_("could not add %s to temporary index"),
 				     name);
 		}
 	}
@@ -4101,7 +4101,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 	discard_index(&result);
 
 	 if (res)
-		 return error("Could not write temporary index to %s",
+		 return error(_("could not write temporary index to %s"),
 			      state->fake_ancestor);
 
 	 return 0;
-- 
2.10.1.459.g5fd885d

