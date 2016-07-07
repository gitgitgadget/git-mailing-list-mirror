Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0262070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbcGGOgM (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:63151 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbcGGOgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:09 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaoHI-1bjSXn0DQe-00kOlq; Thu, 07 Jul 2016 16:35:59
 +0200
Date:	Thu, 7 Jul 2016 16:35:58 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 11/16] am -3: use merge_recursive() directly again
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <4d4d65e3f207c10ffa941a547e6394d3b51b2eaa.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zDzUvaaDlqZf76zhvcDm0Ss1kFORgXpnFTC7LuZWxNk6lO/BloI
 7wV1UeXLqXs3MJ2zTH6XRT/bCkiLZFGQl34+8rIaPNtFlJwuqY5/fY4EHpw4/NeyLWojcqM
 Sm7NJ+oF1nqKevg1FU/B4SZ+IqsBmKpnii5wwt+SCqTKW1yedO6n8e/4O6bFWQbjBx6fsn4
 IEg15f0yENGdcTAPSXtlw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qJ/5Ko+ju2A=:l1mswY3SlriBZkGlkNW2+N
 M5oloPPxWFvNuWM2By7ncUFjgxdoQcwWjMD5hPwCYetFm3xjStoKmQuOflG9uozl5hAFp1MuU
 flXzz/cxXEYNabZryBjeM0LaYnsdoWAglMQ5logZBtcyvvugN8oa644r6UTUTDM+Ti32ZS4RW
 HMF//fWdLDTaI9sMcMIli5auqoEElTfHJoIcD5C23qTKeqs8F91VR8xzn/a0GrHGnzHqXytAy
 EW1z7CdXOzDJN9Zb9RtYijpfZN96kioFCa7V7WZZsyeyhovCnkRgiVtnUDYSWerr2xZSbJE22
 ScXgJBCJazOo/4jQIMP5uKOOi9FNrN7riGKQDitUmpoPCWkX+QI7kUhXCHqblhLeh0oNv4aWw
 Ck27VXxgi5Ggix1EFOZjeL40yQpLWTc85oeMJ30b+byd9C9YSb7Ev1DMqCAyJtw6n0cITZK0T
 cncp4M5DAoVntaT+33XXjsEvgpRcKGW0plCV/yOEIo1rmpnFIBqhWNRvnwz29wsfzaaE2/9T1
 zrwoC4/K4GslxS4eDjPCHK+q/a/kTDX+JxxFK8w+n/AlFkhXCQOlpI/ITksK220OHoj3y3XzU
 gbZ32BKV+sKZFlAE/V+06/JhkEDUJmXQAD6WtL0s4IZq6g5QVLejJSGTDpG8saKQhVUZ75DfP
 OXO3tRyd+dHQdlrPK0XQmnpmNM4C2iENn2IOa2Hr/2WqCTJbwPiTb2bbgN5UEjd4ibYLgBTvc
 cAFyuWS2nbNH0zDKjDWi9FBT6cvkulJm3KMtahjwWnjto88BWg1NdqS3ZeTTCMfxX+mTLBIxv
 kcCc9+d
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
(such as: using OIDs instead of hashes in the recursive merge). While at
it, the same undesired gender bias is addressed in the same spirit as in
the separately submitted patch in $gmane/299009.

Note: the code now calls merge_recursive_generic() again. Unlike
merge_trees() and merge_recursive(), this function returns 0 upon success,
as most of Git's functions. Therefore, the error value -1 naturally is
handled correctly, and we do not have to take care of it specifically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 63 ++++++++++++++++++++++--------------------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f9a724e..8dc4239 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -29,6 +29,7 @@
 #include "prompt.h"
 #include "mailinfo.h"
 #include "apply.h"
+#include "object.h"
 
 /**
  * Returns the length of the first line of msg.
@@ -1623,47 +1624,18 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 }
 
 /**
- * Do the three-way merge using fake ancestor, his tree constructed
- * from the fake ancestor and the postimage of the patch, and our
- * state.
- */
-static int run_fallback_merge_recursive(const struct am_state *state,
-					unsigned char *orig_tree,
-					unsigned char *our_tree,
-					unsigned char *his_tree)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status;
-
-	cp.git_cmd = 1;
-
-	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
-	if (state->quiet)
-		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
-
-	argv_array_push(&cp.args, "merge-recursive");
-	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(his_tree));
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
-	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
-		      our_tree[GIT_SHA1_RAWSZ];
+	struct object_id orig_tree, her_tree, our_tree;
+	const struct object_id *bases[1] = { &orig_tree };
+	struct merge_options o;
+	struct commit *result;
+	char *her_tree_name;
 
-	if (get_sha1("HEAD", our_tree) < 0)
-		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
+	if (get_oid("HEAD", &our_tree) < 0)
+		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
 
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
@@ -1671,7 +1643,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	discard_cache();
 	read_cache_from(index_path);
 
-	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
 
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
@@ -1687,7 +1659,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
-		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
+		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
 	}
@@ -1696,7 +1668,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(her_tree.hash, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1712,11 +1684,22 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	if (run_fallback_merge_recursive(state, orig_tree, our_tree, his_tree)) {
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	her_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = her_tree_name;
+
+	if (state->quiet)
+		o.verbosity = 0;
+
+	if (merge_recursive_generic(&o, &our_tree, &her_tree, 1, bases, &result)) {
 		rerere(state->allow_rerere_autoupdate);
+		free(her_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
 
+	free(her_tree_name);
 	return 0;
 }
 
-- 
2.9.0.278.g1caae67


