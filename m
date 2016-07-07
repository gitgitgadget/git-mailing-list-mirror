Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCCB2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbcGGOfd (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:55798 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbcGGOf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:29 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lp7d2-1bp1Uh3Lgi-00ewWK; Thu, 07 Jul 2016 16:35:12
 +0200
Date:	Thu, 7 Jul 2016 16:35:06 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 00/16] Use merge_recursive() directly in the builtin am
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1467902082.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0c6H2H5EC/Aaw+9/WJ0Yfcwb/Wax9HqKl5/u/JWCkn4AE1SNzU/
 lF0Ck0jDy2zIPsT1oFGp3uu1zZSzgSWU2BRjgnBsmApqF6SWdZqnXJJauXUkftICZBP1riV
 0Mw7gtsDTiO5UClSj31xMczW/l2TWot6O0z+8jW7pbU9Et1yaxoKY/peSRYx/u0/onZJ9Az
 kmWSayAHtbqRJ5+4HJf4Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AzYu72IwysU=:41Gf1cJI+ESMQGVEBu2JYM
 SxzzjxkB+qkzltjnRBYVQevBwDol94iwr07Brz3H+NQigH3qcn3Vam/T5duFdE2qkPCD9Uqki
 MwLxZkrTtuKsAaeZfu3uFElMZUcOOlcaaErUoufA3rmtWmAkh/6HW6CuIyoUs0RNYk9tfZy3x
 mMm0BGSXi3IQg0bjscHXVLSpK5c+3fCSzstjsM5IPRWE5nS/jCnRG7AYxjp9Nn/ZQuPbe9IQ9
 xVEQtLy/14TAEPswBqGgLJ/gQ+SiClNS8nebSYkIJO2W7ein5FWaKg+5BsP5LbZf7NtT9Z4go
 1IIaWJnkA2zB08NtUVpJHuVDIcaWhgZU+YxGnG6riCsD4OqXdXwciaUuyrcPVmGjaqlgLZp8b
 zDdcm0SahMPtvP3SJWnhKdqlHVTd3uo7LPMs/jQJkk5M56CVZJWcl1K2LUduRen3+XgoeIawc
 e8Mi/EYtUMRSkdoo2lrZTuahZpthz71osOChj+gkKCM+mNqoQIMTxvudIkyx/h31a9pdSyWHm
 goOh5warhCoBEr4piCxE6CC1RBAv/eR+1Ue9rPUmfg5BB0FkECSz3QE+DEOcPCBQN7cmQaxIm
 ihvZWq10/h0KOyrh45w4uWlXatcBt3OpL5riUrV1vyMXxod6cJW+TOgULl+RKDVUNZ4OMW8Do
 dsgpCM6rH6IxI3klTpBpVjhUWRPt26acwGwHlTTK+z4VLABkoyD0vlS39TdRrHwRIyka3O8C/
 NnefZutkAzwn43+5NZe2FUV1+urvmgnUNJMRe4DoTrSlFVJtJnzMgw42v+C9dUNnu0oUdLEp9
 NL1xdi1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the second iteration of the long-awaited re-roll of the attempt to
avoid spawning merge-recursive from the builtin am and use merge_recursive()
directly instead.

The *real* reason for the reroll is that I need a libified recursive
merge to accelerate the interactive rebase by teaching the sequencer to
do rebase -i's grunt work.

In this endeavor, we need to be extra careful to retain backwards
compatibility. The test script t6022-merge-rename.sh, for example, verifies
that `git pull` exits with status 128 in case of a fatal error. To that end,
we need to make sure that fatal errors are handled by existing (builtin)
users via exit(128) (or die(), which calls exit(128) at the end).  New users
(such as a builtin helper doing rebase -i's grunt work) may want to print
some helpful advice what happened and how to get out of this mess before
erroring out.

The changes relative to the second iteration of this patch series:

- the was_tracked() function was adjusted as per Junio's suggestions

- the "counter gender bias" patch was submitted separately, in
  $gmane/299009 (please note that the "am -3: use merge_recursive()
  directly again" patch is now slightly awkward as a consequence)

- this patch series is on top of 'pu', to address the conflicts with
  the 'jh/clean-smudge-annex' and the 'bc/cocci' branches

- please note that the interdiff does not show the full picture: I
  generated it relative to v2 rebased on top of pu (resolving many
  merge conflicts in the process that are hidden from the interdiff)

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

 builtin/am.c           |  63 +++---
 builtin/checkout.c     |   5 +-
 builtin/ls-files.c     |   3 +-
 builtin/merge.c        |   2 +
 builtin/update-index.c |   2 +-
 grep.c                 |   8 +-
 imap-send.c            |   4 +-
 merge-recursive.c      | 508 +++++++++++++++++++++++++++++--------------------
 merge-recursive.h      |   2 +-
 sequencer.c            |   5 +
 sha1_file.c            |   4 +-
 t/t5520-pull.sh        |  30 +++
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 15 files changed, 382 insertions(+), 262 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v3
Interdiff vs v2:

 diff --git a/builtin/am.c b/builtin/am.c
 index d626532..8dc4239 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -29,6 +29,7 @@
  #include "prompt.h"
  #include "mailinfo.h"
  #include "apply.h"
 +#include "object.h"
  
  /**
   * Returns the length of the first line of msg.
 @@ -1627,15 +1628,14 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
   */
  static int fall_back_threeway(const struct am_state *state, const char *index_path)
  {
 -	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
 -		      our_tree[GIT_SHA1_RAWSZ];
 -	const unsigned char *bases[1] = {orig_tree};
 +	struct object_id orig_tree, her_tree, our_tree;
 +	const struct object_id *bases[1] = { &orig_tree };
  	struct merge_options o;
  	struct commit *result;
  	char *her_tree_name;
  
 -	if (get_sha1("HEAD", our_tree) < 0)
 -		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
 +	if (get_oid("HEAD", &our_tree) < 0)
 +		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
  
  	if (build_fake_ancestor(state, index_path))
  		return error("could not build fake ancestor");
 @@ -1643,7 +1643,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  	discard_cache();
  	read_cache_from(index_path);
  
 -	if (write_index_as_tree(orig_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
  		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
  
  	say(state, stdout, _("Using index info to reconstruct a base tree..."));
 @@ -1659,7 +1659,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		init_revisions(&rev_info, NULL);
  		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
  		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 -		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
 +		add_pending_sha1(&rev_info, "HEAD", our_tree.hash, 0);
  		diff_setup_done(&rev_info.diffopt);
  		run_diff_index(&rev_info, 1);
  	}
 @@ -1668,7 +1668,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		return error(_("Did you hand edit your patch?\n"
  				"It does not apply to blobs recorded in its index."));
  
 -	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(her_tree.hash, &the_index, index_path, 0, NULL))
  		return error("could not write tree");
  
  	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 @@ -1678,7 +1678,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  
  	/*
  	 * This is not so wrong. Depending on which base we picked, orig_tree
 -	 * may be wildly different from ours, but her_tree has the same set of
 +	 * may be wildly different from ours, but his_tree has the same set of
  	 * wildly different changes in parts the patch did not touch, so
  	 * recursive ends up canceling them, saying that we reverted all those
  	 * changes.
 @@ -1693,7 +1693,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  	if (state->quiet)
  		o.verbosity = 0;
  
 -	if (merge_recursive_generic(&o, our_tree, her_tree, 1, bases, &result)) {
 +	if (merge_recursive_generic(&o, &our_tree, &her_tree, 1, bases, &result)) {
  		rerere(state->allow_rerere_autoupdate);
  		free(her_tree_name);
  		return error(_("Failed to merge in the changes."));
 diff --git a/merge-recursive.c b/merge-recursive.c
 index f80ad35..cb701ee 100644
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

-- 
2.9.0.278.g1caae67

base-commit: 6addd022ce5331ee7dc41781ded714e5d5f01206
