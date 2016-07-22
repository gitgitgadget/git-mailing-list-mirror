Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDAE20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbcGVM0C (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:26:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:52871 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbcGVM0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:26:00 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MHXXo-1bTsuQ2k9s-003OlG; Fri, 22 Jul 2016 14:25:42
 +0200
Date:	Fri, 22 Jul 2016 14:25:40 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 11/16] am -3: use merge_recursive() directly again
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <667d2f991f1423b138a746f4c685b13c5b572a83.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IfEz151MM8LXFjr06mDyVnTTTIyBEFDLu2XlW2LoNBfKidLWJQz
 jz3Yo4K2tQbdZ5OE47bnsC2GAOkHJF/jXp8B1A0LfEQsF42/jf0J5VIlTol63p0luEAsPOx
 AyYolsxptsY5tSzRs+oqJzFuST7J89HEIkmL2wLwAK3ci6fjX6aibd21VOxN1KbhSRf0eyz
 OL9EQEVUhbfceIEX8mLpA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:M6cF9lmSSTg=:8RdexSxn78aJYcvjDZjoCd
 +dFEloQQjNBCEd+T6jhHdlvMAxwUMHkuK/0Tk75Yhfu3ujLU4OGKzaXipBkChG6ytkH9CfMNm
 l0pNhn0Rq0Gp8coFpBImqHRGMJLAxyTxD02l0f7Sy3PyX8hOZ84wBAfuX03f4EJuHO/ipY+LW
 GJc6D8HYj/hmr2TPMx3KEqNB83946Szw2FYfPKZ0AmkRTVNOPjl0rWKHW7gf66ZDiIHTz0pfE
 CIx+d29ikbPdPlVlZEWQ/lYHFbZNwbGyZDxgSie0cXgTwXeLwvL2QtoXlo0MEeHPLJEdmS6vb
 cVlQwmUrybTs5mk7qzEHG3rF7tqjIzxjy98SMWNUHi2u/dQEzny+hWJRCHsC6UZAvl8dqQXCT
 woPHo9YW6Qm+TL0vyW3Yog48iaCEXWpWhhD/bSmP1Wd92r/21yM3Lb45Jd8jNsxGEKEZFk4fK
 tIeO3MGAiGoTkzN9FoqMVus9u19IH4qoW7mFziD/iPNeK7l+DLCzGQcwdfWbuQQn60yw8Uadn
 o4tYT1LwVA1s5xBkE5zXJGrFlyojFzViUaFIvhJ4QJHfKkdb3FNXQIOmfUWyFLdsGpuwKLo0y
 cEbKnV4MbnD+4yi69yJu0Csvt8S4IU2q7rBgyQgX0yxl6LhvaPmj+zFptJIESGIHC8hTxA7Vc
 hcvtE+LaTHLRLqWwsHYsKufLqje497O6mXWwSRuFhi9f8urjEsCaPobrZN/fr12Le0qyNLkOx
 ydbE2YlyEgpL34O3ppdG7T8Emy8l9RPREsMryiZz60aU2U5Sjii6WaFQqeS6X1qccC1XyeeJy
 b/Mhqzy
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Last October, we had to change this code to run `git merge-recursive`
in a child process: git-am wants to print some helpful advice when the
merge failed, but the code in question was not prepared to return, it
die()d instead.

We are finally at a point when the code *is* prepared to return errors,
and can avoid the child process again.

This reverts commit c63d4b2 (am -3: do not let failed merge from
completing the error codepath, 2015-10-09), with the necessary changes
to adjust for the fact that Git's source code changed in the meantime
(such as: using OIDs instead of hashes in the recursive merge, and a
removed gender bias).

Note: the code now calls merge_recursive_generic() again. Unlike
merge_trees() and merge_recursive(), this function returns 0 upon success,
as most of Git's functions. Therefore, the error value -1 naturally is
handled correctly, and we do not have to take care of it specifically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 62 +++++++++++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b77bf11..cfb79ea 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1579,47 +1579,18 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, their tree constructed
- * from the fake ancestor and the postimage of the patch, and our
- * state.
- */
-static int run_fallback_merge_recursive(const struct am_state *state,
-					unsigned char *orig_tree,
-					unsigned char *our_tree,
-					unsigned char *their_tree)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status;
-
-	cp.git_cmd = 1;
-
-	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(their_tree), linelen(state->msg), state->msg);
-	if (state->quiet)
-		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
-
-	argv_array_push(&cp.args, "merge-recursive");
-	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(their_tree));
-
-	status = run_command(&cp) ? (-1) : 0;
-	discard_cache();
-	read_cache();
-	return status;
-}
-
-/**
  * Attempt a threeway merge, using index_path as the temporary index.
  */
 static int fall_back_threeway(const struct am_state *state, const char *index_path)
 {
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], their_tree[GIT_SHA1_RAWSZ],
-		      our_tree[GIT_SHA1_RAWSZ];
+	struct object_id orig_tree, their_tree, our_tree;
+	const struct object_id *bases[1] = { &orig_tree };
+	struct merge_options o;
+	struct commit *result;
+	char *their_tree_name;
 
-	if (get_sha1("HEAD", our_tree) < 0)
-		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
+	if (get_oid("HEAD", &our_tree) < 0)
+		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
 
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
@@ -1627,7 +1598,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	discard_cache();
 	read_cache_from(index_path);
 
-	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
 
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
@@ -1643,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
-		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
+		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
 	}
@@ -1652,7 +1623,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(their_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(their_tree.hash, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1668,11 +1639,22 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, their_tree)) {
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = their_tree_name;
+
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
 		rerere(state->allow_rerere_autoupdate);
+		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
 
+	free(their_tree_name);
 	return 0;
 }
 
-- 
2.9.0.281.g286a8d9


