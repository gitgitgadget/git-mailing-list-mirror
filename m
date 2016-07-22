Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EFE203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 12:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbcGVMYe (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:24:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:65358 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbcGVMYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:24:32 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdpcB-1b04eF3l47-00j55f; Fri, 22 Jul 2016 14:23:57
 +0200
Date:	Fri, 22 Jul 2016 14:23:52 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 00/16] Use merge_recursive() directly in the builtin am
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1469187652.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3ofk8SEc0ZYOyw0qEjlGU4HUR1/E6nLojkMpWswvuXdVB4bk7dy
 VEmVr3J8zyQ/hPrmR56+sFM1svzLRpEWo6PmphYYCvaiRFQlK/v682HfpNJVFRL+0HfDVsG
 Edn+K6ud7KPTTsF/Avo+5GQpOsctNVwKVtGmu1w5xl5cila+4fGX0536eCrOe4rV4ek7/mM
 0Q7MQu4Ov07nE4OQHAPxA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:BWFmAs3ij2c=:6k0cMj0sac9YWNdFi2SKU4
 TEnVUbOQ61TiBas1kd/4c9OyBGZK65eWcz739zuPRJbdoUpSxL8aQshoAMArbf96d5g/N/eLL
 WWplgeSYQcO4CQTksC6aK4rDZJEKviFNP6/3kCKLD3UNfjsBux+nktCYPIExOqtkx9P53sg9x
 IJiCTI7Bjcsrh0KVIwB/sqx89+RVCSBbVoDxMcAdnrWRcRbglVY6zFYRSvT/RqABvLyvHLsXI
 sNPnBdUZ2D9lmkSHthRLsXWvIqfj1N170SYq3t13MFEhP9A1R4TSxTcqloxCFH1ImkEfM8/ny
 NrrHyy3Q0yMXnOVaVIHEMlcHid5+gN/awvQ+KysOCvSrKw+/p9yTUy/HepkzdtRnYTNPnRLJ9
 LIPjgNciw61nGBNl60QPz1BcysjP0Vx7bjBZl5oMg6SRXzjBkH/J4PTxgnwgEP2oAhEydQEBJ
 MOr8aze5WJLrrn1C3qb9SaVawH7Xg79ezxDvXf7ZKyLhgzx+MayeruWwO/PvXtztZzZusSaly
 tr/Xd4DVIUEv4IkWIgBDJxf5h750ZtgXRVeWnI4fadz+PjQ9ZoB+TFGKA/opsQ8CzSKAp2YOz
 bEXGoq278tHQDw2A/425wEidKRNvxLFLS4dWO/LxkCVAjlpQuLT4x7u6dSrDaE+2UmYKwPQ1H
 qA4Jb30LkwE77fMEewk6nfL1O4j+pEs6agM5EnnJpTfFIc1xT6xyEDENlpI49U+B0Wwzd1LO4
 3VRWxrEtHkqv4knbrnkoIzC1u5fxAw6gGePUMxk6xv05abvTXP7jgNKio4V7xotP3aLathuTN
 8ISNNY2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the fourth iteration of the long-awaited re-roll of the attempt to
avoid spawning merge-recursive from the builtin am and use merge_recursive()
directly instead.

The *real* reason for the reroll is that I need a libified recursive
merge to accelerate the interactive rebase by teaching the sequencer to
do rebase -i's grunt work. Coming with a very nice 3x-5x speedup of
`rebase -i`.

In this endeavor, we need to be extra careful to retain backwards
compatibility. The test script t6022-merge-rename.sh, for example, verifies
that `git pull` exits with status 128 in case of a fatal error. To that end,
we need to make sure that fatal errors are handled by existing (builtin)
users via exit(128) (or die(), which calls exit(128) at the end).  New users
(such as a builtin helper doing rebase -i's grunt work) may want to print
some helpful advice what happened and how to get out of this mess before
erroring out.

The changes relative to the second iteration of this patch series (I
have a feeling that nobody reviewed the 3rd iteration because it was
based on `pu`):

- the was_tracked() function was adjusted as per Junio's suggestions

- the "counter gender bias" patch was submitted, and accepted,
  separately, even if the version we settled on sends a much weaker
  message than I would have preferred

- this patch series is on top of 'master' again

- a test was introduced to verify that we do not reintroduce the bug
  which required our hot fix to spawn the recursive merge again

- while at it, I fixed a ton of incorrect indentations that I missed in
  the first three iterations

- as the bc/cocci branch was merged, a couple of fixups were necessary
  to the patch that avoids spawning the recursive merge

- the interdiff is relative to v2 rebased onto master. That means that
  I had to simulate the "her_tree" change for the sake of the interdiff.

This patch series touches rather important code. Now that I addressed
concerns such as fixing translated bug reports, I would appreciate thorough
reviews with a focus on the critical parts of the code, those that could
result in regressions.


Johannes Schindelin (16):
  Verify that `git pull --rebase` shows the helpful advice when failing
  Report bugs consistently
  Avoid translating bug messages
  merge-recursive: clarify code in was_tracked()
  Prepare the builtins for a libified merge_recursive()
  merge_recursive: abort properly upon errors
  merge-recursive: avoid returning a wholesale struct
  merge-recursive: allow write_tree_from_memory() to error out
  merge-recursive: handle return values indicating errors
  merge-recursive: switch to returning errors instead of dying
  am -3: use merge_recursive() directly again
  merge-recursive: flush output buffer before printing error messages
  merge-recursive: write the commit title in one go
  merge-recursive: offer an option to retain the output in 'obuf'
  Ensure that the output buffer is released after calling merge_trees()
  merge-recursive: flush output buffer even when erroring out

 builtin/am.c           |  62 ++----
 builtin/checkout.c     |   5 +-
 builtin/ls-files.c     |   3 +-
 builtin/merge.c        |   2 +
 builtin/update-index.c |   2 +-
 grep.c                 |   8 +-
 imap-send.c            |   4 +-
 merge-recursive.c      | 571 +++++++++++++++++++++++++++++--------------------
 merge-recursive.h      |   2 +-
 sequencer.c            |   5 +
 sha1_file.c            |   4 +-
 t/t5520-pull.sh        |  30 +++
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 15 files changed, 413 insertions(+), 293 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v4
Interdiff vs v3:

 diff --git a/builtin/am.c b/builtin/am.c
 index bf4f79b..cfb79ea 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1583,15 +1583,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
   */
  static int fall_back_threeway(const struct am_state *state, const char *index_path)
  {
 -	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 -		      our_tree[GIT_SHA1_RAWSZ];
 -	const unsigned char *bases[1] = {orig_tree};
 +	struct object_id orig_tree, their_tree, our_tree;
 +	const struct object_id *bases[1] = { &orig_tree };
  	struct merge_options o;
  	struct commit *result;
 -	char *her_tree_name;
 +	char *their_tree_name;
  
 -	if (get_sha1("HEAD", our_tree) < 0)
 -		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
 +	if (get_oid("HEAD", &our_tree) < 0)
 +		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
  
  	if (build_fake_ancestor(state, index_path))
  		return error("could not build fake ancestor");
 @@ -1599,7 +1598,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  	discard_cache();
  	read_cache_from(index_path);
  
 -	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
  		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
  
  	say(state, stdout, _("Using index info to reconstruct a base tree..."));
 @@ -1615,7 +1614,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		init_revisions(&rev_info, NULL);
  		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
  		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 -		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
 +		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
  		diff_setup_done(&rev_info.diffopt);
  		run_diff_index(&rev_info, 1);
  	}
 @@ -1624,7 +1623,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		return error(_("Did you hand edit your patch?\n"
  				"It does not apply to blobs recorded in its index."));
  
 -	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(their_tree.hash, &the_index, index_path, 0, NULL))
  		return error("could not write tree");
  
  	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 @@ -1634,7 +1633,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  
  	/*
  	 * This is not so wrong. Depending on which base we picked, orig_tree
 -	 * may be wildly different from ours, but her_tree has the same set of
 +	 * may be wildly different from ours, but their_tree has the same set of
  	 * wildly different changes in parts the patch did not touch, so
  	 * recursive ends up canceling them, saying that we reverted all those
  	 * changes.
 @@ -1643,19 +1642,19 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  	init_merge_options(&o);
  
  	o.branch1 = "HEAD";
 -	her_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 -	o.branch2 = her_tree_name;
 +	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 +	o.branch2 = their_tree_name;
  
  	if (state->quiet)
  		o.verbosity = 0;
  
 -	if (merge_recursive_generic(&o, our_tree, her_tree, 1, bases, &result)) {
 +	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
  		rerere(state->allow_rerere_autoupdate);
 -		free(her_tree_name);
 +		free(their_tree_name);
  		return error(_("Failed to merge in the changes."));
  	}
  
 -	free(her_tree_name);
 +	free(their_tree_name);
  	return 0;
  }
  
 diff --git a/merge-recursive.c b/merge-recursive.c
 index cd2a533..501cfb5 100644
 --- a/merge-recursive.c
 +++ b/merge-recursive.c
 @@ -686,20 +686,19 @@ static int was_tracked(const char *path)
  {
  	int pos = cache_name_pos(path, strlen(path));
  
 -	if (pos >= 0)
 -		return pos < active_nr;
 +	if (0 <= pos)
 +		/* we have been tracking this path */
 +		return 1;
 +
  	/*
 -	 * cache_name_pos() looks for stage == 0, even if we did not ask for
 -	 * it. Let's look for stage == 2 now.
 +	 * Look for an unmerged entry for the path,
 +	 * specifically stage #2, which would indicate
 +	 * that "our" side before the merge started
 +	 * had the path tracked (and resulted in a conflict).
  	 */
 -	for (pos = -1 - pos; pos < active_nr &&
 -	     !strcmp(path, active_cache[pos]->name); pos++)
 -		/*
 -		 * If stage #0, it is definitely tracked.
 -		 * If it has stage #2 then it was tracked
 -		 * before this merge started.  All other
 -		 * cases the path was not tracked.
 -		 */
 +	for (pos = -1 - pos;
 +	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
 +	     pos++)
  		if (ce_stage(active_cache[pos]) == 2)
  			return 1;
  	return 0;
 @@ -761,11 +760,11 @@ static int make_room_for_path(struct merge_options *o, const char *path)
  }
  
  static int update_file_flags(struct merge_options *o,
 -			      const struct object_id *oid,
 -			      unsigned mode,
 -			      const char *path,
 -			      int update_cache,
 -			      int update_wd)
 +			     const struct object_id *oid,
 +			     unsigned mode,
 +			     const char *path,
 +			     int update_cache,
 +			     int update_wd)
  {
  	int ret = 0;
  
 @@ -816,7 +815,7 @@ static int update_file_flags(struct merge_options *o,
  			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
  			if (fd < 0) {
  				ret = err(o, _("failed to open '%s': %s"),
 -					path, strerror(errno));
 +					  path, strerror(errno));
  				goto free_buf;
  			}
  			write_in_full(fd, buf, size);
 @@ -830,8 +829,9 @@ static int update_file_flags(struct merge_options *o,
  					path, strerror(errno));
  			free(lnk);
  		} else
 -			ret = err(o, _("do not know what to do with %06o %s '%s'"),
 -				mode, oid_to_hex(oid), path);
 +			ret = err(o,
 +				  _("do not know what to do with %06o %s '%s'"),
 +				  mode, oid_to_hex(oid), path);
   free_buf:
  		free(buf);
  	}
 @@ -842,10 +842,10 @@ static int update_file_flags(struct merge_options *o,
  }
  
  static int update_file(struct merge_options *o,
 -			int clean,
 -			const struct object_id *oid,
 -			unsigned mode,
 -			const char *path)
 +		       int clean,
 +		       const struct object_id *oid,
 +		       unsigned mode,
 +		       const char *path)
  {
  	return update_file_flags(o, oid, mode, path, o->call_depth || clean, !o->call_depth);
  }
 @@ -973,9 +973,9 @@ static int merge_file_1(struct merge_options *o,
  				ret = err(o, _("Failed to execute internal merge"));
  
  			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
 -					    blob_type, result->oid.hash))
 +						    blob_type, result->oid.hash))
  				ret = err(o, _("Unable to add %s to database"),
 -					a->path);
 +					  a->path);
  
  			free(result_buf.ptr);
  			if (ret)
 @@ -1020,7 +1020,8 @@ static int merge_file_special_markers(struct merge_options *o,
  		side2 = xstrfmt("%s:%s", branch2, filename2);
  
  	ret = merge_file_1(o, one, a, b,
 -		side1 ? side1 : branch1, side2 ? side2 : branch2, mfi);
 +			   side1 ? side1 : branch1,
 +			   side2 ? side2 : branch2, mfi);
  	free(side1);
  	free(side2);
  	return ret;
 @@ -1068,7 +1069,8 @@ static int handle_change_delete(struct merge_options *o,
  		 */
  		ret = remove_file_from_cache(path);
  		if (!ret)
 -			ret = update_file(o, 0, o_oid, o_mode, renamed ? renamed : path);
 +			ret = update_file(o, 0, o_oid, o_mode,
 +					  renamed ? renamed : path);
  	} else if (!a_oid) {
  		if (!renamed) {
  			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 @@ -1129,19 +1131,19 @@ static int conflict_rename_delete(struct merge_options *o,
  	}
  
  	if (handle_change_delete(o,
 -			     o->call_depth ? orig->path : dest->path,
 -			     &orig->oid, orig->mode,
 -			     a_oid, a_mode,
 -			     b_oid, b_mode,
 -			     _("rename"), _("renamed")))
 +				 o->call_depth ? orig->path : dest->path,
 +				 &orig->oid, orig->mode,
 +				 a_oid, a_mode,
 +				 b_oid, b_mode,
 +				 _("rename"), _("renamed")))
  		return -1;
  
  	if (o->call_depth)
  		return remove_file_from_cache(dest->path);
  	else
  		return update_stages(o, dest->path, NULL,
 -			      rename_branch == o->branch1 ? dest : NULL,
 -			      rename_branch == o->branch1 ? NULL : dest);
 +				     rename_branch == o->branch1 ? dest : NULL,
 +				     rename_branch == o->branch1 ? NULL : dest);
  }
  
  static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 @@ -1292,11 +1294,11 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
  	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
  
  	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
 -					    o->branch1, c1->path,
 -					    o->branch2, ci->ren1_other.path, &mfi_c1) ||
 +				       o->branch1, c1->path,
 +				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
  	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
 -					    o->branch1, ci->ren2_other.path,
 -					    o->branch2, c2->path, &mfi_c2))
 +				       o->branch1, ci->ren2_other.path,
 +				       o->branch2, c2->path, &mfi_c2))
  		return -1;
  
  	if (o->call_depth) {
 @@ -1311,7 +1313,7 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
  		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
  		if (!ret)
  			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
 -				b->path);
 +					  b->path);
  	} else {
  		char *new_path1 = unique_path(o, path, ci->branch1);
  		char *new_path2 = unique_path(o, path, ci->branch2);
 @@ -1321,7 +1323,7 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
  		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
  		if (!ret)
  			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
 -				new_path2);
 +					  new_path2);
  		free(new_path2);
  		free(new_path1);
  	}
 @@ -1512,11 +1514,11 @@ static int process_renames(struct merge_options *o,
  				 * update_file().
  				 */
  				if (update_file_flags(o,
 -						  &ren1->pair->two->oid,
 -						  ren1->pair->two->mode,
 -						  ren1_dst,
 -						  1, /* update_cache */
 -						  0  /* update_wd    */))
 +						      &ren1->pair->two->oid,
 +						      ren1->pair->two->mode,
 +						      ren1_dst,
 +						      1, /* update_cache */
 +						      0  /* update_wd    */))
  					clean_merge = -1;
  			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
  				clean_merge = 0;
 @@ -1528,11 +1530,11 @@ static int process_renames(struct merge_options *o,
  				if (o->call_depth) {
  					struct merge_file_info mfi;
  					if (merge_file_one(o, ren1_dst, &null_oid, 0,
 -							 &ren1->pair->two->oid,
 -							 ren1->pair->two->mode,
 -							 &dst_other.oid,
 -							 dst_other.mode,
 -							 branch1, branch2, &mfi)) {
 +							   &ren1->pair->two->oid,
 +							   ren1->pair->two->mode,
 +							   &dst_other.oid,
 +							   dst_other.mode,
 +							   branch1, branch2, &mfi)) {
  						clean_merge = -1;
  						goto cleanup_and_return;
  					}
 @@ -1545,7 +1547,7 @@ static int process_renames(struct merge_options *o,
  					char *new_path = unique_path(o, ren1_dst, branch2);
  					output(o, 1, _("Adding as %s instead"), new_path);
  					if (update_file(o, 0, &dst_other.oid,
 -						    dst_other.mode, new_path))
 +							dst_other.mode, new_path))
  						clean_merge = -1;
  					free(new_path);
  				}
 @@ -1652,11 +1654,11 @@ static int handle_modify_delete(struct merge_options *o,
  				 struct object_id *b_oid, int b_mode)
  {
  	return handle_change_delete(o,
 -			     path,
 -			     o_oid, o_mode,
 -			     a_oid, a_mode,
 -			     b_oid, b_mode,
 -			     _("modify"), _("modified"));
 +				    path,
 +				    o_oid, o_mode,
 +				    a_oid, a_mode,
 +				    b_oid, b_mode,
 +				    _("modify"), _("modified"));
  }
  
  static int merge_content(struct merge_options *o,
 @@ -1701,8 +1703,8 @@ static int merge_content(struct merge_options *o,
  			df_conflict_remains = 1;
  	}
  	if (merge_file_special_markers(o, &one, &a, &b,
 -					 o->branch1, path1,
 -					 o->branch2, path2, &mfi))
 +				       o->branch1, path1,
 +				       o->branch2, path2, &mfi))
  		return -1;
  
  	if (mfi.clean && !df_conflict_remains &&
 @@ -1749,8 +1751,8 @@ static int merge_content(struct merge_options *o,
  				merged.mode = mfi.mode;
  
  				if (update_stages(o, path, NULL,
 -					      file_from_stage2 ? &merged : NULL,
 -					      file_from_stage2 ? NULL : &merged))
 +						  file_from_stage2 ? &merged : NULL,
 +						  file_from_stage2 ? NULL : &merged))
  					return -1;
  			}
  
 @@ -1794,9 +1796,9 @@ static int process_entry(struct merge_options *o,
  		case RENAME_DELETE:
  			clean_merge = 0;
  			if (conflict_rename_delete(o,
 -					       conflict_info->pair1,
 -					       conflict_info->branch1,
 -					       conflict_info->branch2))
 +						   conflict_info->pair1,
 +						   conflict_info->branch1,
 +						   conflict_info->branch2))
  				clean_merge = -1;
  			break;
  		case RENAME_ONE_FILE_TO_TWO:
 @@ -1828,7 +1830,7 @@ static int process_entry(struct merge_options *o,
  			/* Modify/delete; deleted side may have put a directory in the way */
  			clean_merge = 0;
  			if (handle_modify_delete(o, path, o_oid, o_mode,
 -					     a_oid, a_mode, b_oid, b_mode))
 +						 a_oid, a_mode, b_oid, b_mode))
  				clean_merge = -1;
  		}
  	} else if ((!o_oid && a_oid && !b_oid) ||
 @@ -2040,7 +2042,7 @@ int merge_recursive(struct merge_options *o,
  		o->branch1 = "Temporary merge branch 1";
  		o->branch2 = "Temporary merge branch 2";
  		if (merge_recursive(o, merged_common_ancestors, iter->item,
 -				NULL, &merged_common_ancestors) < 0)
 +				    NULL, &merged_common_ancestors) < 0)
  			return -1;
  		o->branch1 = saved_b1;
  		o->branch2 = saved_b2;

-- 
2.9.0.281.g286a8d9

base-commit: 08bb3500a2a718c3c78b0547c68601cafa7a8fd9
