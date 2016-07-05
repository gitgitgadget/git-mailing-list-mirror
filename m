Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B48D2023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbcGELXa (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:23:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:54986 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbcGELXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:25 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Mey7N-1avxpv0Xmr-00OTts; Tue, 05 Jul 2016 13:22:54
 +0200
Date:	Tue, 5 Jul 2016 13:22:51 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 00/17] Use merge_recursive() directly in the builtin am
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1467717729.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aqYFGUfk5uiJHSTP+hHNgV95Qgil0me6HdNjXZzw7u7aGZpv5ZP
 DxSdFfyvTOCf4tb2oZjrYGYMMMIQW41PCoHKSsIt/Qc20Evc7FP4llsWDdKOF9+XB8Q/u+S
 AS5rQUpYcI0PCsOciF2m5vHgkIcPaD3tXkEiWy+8w9CJLLSzbzmaD3fwh+eiBIOHjknYIMJ
 Hn5RIyHX9HGPtyjnrw+HQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ipXyHR4yrFc=:rhDPSWpHtfL7tFrWzOwY9P
 SCVm9DvpDv7r9vO6CjDRDlF0R3AJpCHUd51BJL4a0Pm0DvSFZxaB0x05lMvTTGvEhFNxdcuvL
 iWhrUumpLnr5SL7g/SOFNH3uR9J/RNsZVBayFzMso1gyjVBaAutqy8TOYTF2GXTtxiGGqX1Yn
 Ta+NViSmcz3E2E1UocV9YkmYzHF6T8D33r3UBLZe22R2Ycscy6uCrgbXxWfodJpPnAGwEmkIq
 i8gqJL0SrEICD7AlsynfhSWS3bnnrvvfGAnRGz+ktIhtmOVdHiakkguhvfpCnz3HwcOmA4W8T
 l7acIbhbl7JF3K4WXPBLhBQMq8Ub3KYl/p2/0lir1ioxSp3mLdNz8yvohi+doqadD5eIF/EAN
 QyNzLN88Tc5o42Km4AH7Hux7R4qWX3ggAmqwX+VVFLTrEpNVKy9voNSUZXr/fs8mXO2d6Jn2z
 kImOgb/Fpk/dL0yW8TcmLdImgM3rLb32lmy/dQOmM4IFb3W1KggpyvC6zVcHJgj5qomDSAmoh
 pa8VRaX+h//vom0cJ6xFlGnzyg2DdRtsbxnnmqvWZSqOIiIPAONpw9QkWITCdxUsS26/xwi8y
 3G/rQArMv7Za1EnjY4TPBcnE9NYs0NmQoasmISMbL3e//QurYaoIHHSRoVG4f0uUAjY8CsKor
 KnWCpzsYEDbaxMzu0/gz+P9xs+bBUgbkg9fp6iBtLumgKuedgTSvPZxC2U4WHtvLsLKc8sKo3
 PgfI1SzOi7X2dcFy0IOzNAsjQLVdEp3V2sBrfQ6kHx/J8GPYh8HZHaA77gXOAF+aItpFrEhAz
 nt6ayKl
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

The changes relative to the first iteration of this patch series:

- a variable that could be used uninitialized is now initialized (thanks,
  Travis & clang!)

- several commit messages were touched up (and I hope y'all agree, improved)

- an unnecessary hunk was reverted (this was a left-over from an
  unpublished iteration that needed to retain return values faithfully, i.e.
  it made a difference between -1 and -128 as error value)

- Junio's patch to use recursive_merge() directly in the builtin am was
  replaced by a different solution

- an error message was identified as, and converted into, a bug report
  instead

- the code in was_tracked() now avoids a loop when it is unnecessary,
  and further clarifies why we keep looking when cache_name_pos() did
  not find the entry we asked for

- die("BUG: ...") statements are no longer translated

- one die("BUG: ...") report that continued in upper-case after the "BUG:"
  prefix was fixed

- I addressed a gender bias that has been bugging me ever since I noticed it

- recursive merge's error messages are now printed after flushing the
  output buffer (instead of swallowing that output)

- callers of the recursive merge can now ask that the output buffer not be
  flushed, but retained without printing it instead. This gives the caller the
  control about handling errors which Junio asked for.

- some long-standing bugs have been recognized and addressed:

  - when the recursive merge failed, it lost the buffered output

  - the output buffer of the recursive merge was never released

  - some stdout/stderr interference that we tried to address in 2007 is
    now fully addressed (the progress output could be printed in the
    middle of the commit title because the latter was still directly printed
    to stdout, which is buffered, instead of being buffered and flushed)

- a lot of unnecessary 'ret' variables are gone now: originally, I wanted to
  retain the *exact* return value, but now errors are indicated by -1,
  always

- lastly, I remembered that my original attempt at fixing the pull --rebase
  issue contained a test case, and I forward-ported that, and augmented it

So while I addressed all comments, I also went through the patch series a
couple of times myself and whatever bugged me, I tried to resolve, too.

This patch series touches rather important code. Now that I addressed
concerns such as fixing translated bug reports, I would appreciate thorough
reviews with a focus on the critical parts of the code, those that could
result in regressions.


Johannes Schindelin (17):
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
  am: counteract gender bias
  am -3: use merge_recursive() directly again
  merge-recursive: flush output buffer before printing error messages
  merge-recursive: write the commit title in one go
  merge-recursive: offer an option to retain the output in 'obuf'
  Ensure that the output buffer is released after calling merge_trees()
  merge-recursive: flush output buffer even when erroring out

 builtin/am.c           |  55 ++----
 builtin/checkout.c     |   5 +-
 builtin/ls-files.c     |   3 +-
 builtin/merge.c        |   2 +
 builtin/update-index.c |   2 +-
 grep.c                 |   8 +-
 imap-send.c            |   4 +-
 merge-recursive.c      | 490 +++++++++++++++++++++++++++++--------------------
 merge-recursive.h      |   2 +-
 sequencer.c            |   5 +
 sha1_file.c            |   4 +-
 t/t5520-pull.sh        |  30 +++
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 15 files changed, 369 insertions(+), 249 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v2
Interdiff vs v1:

 diff --git a/builtin/am.c b/builtin/am.c
 index dd41154..be652f9 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1578,45 +1578,16 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
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
 -	const unsigned char *bases[1] = {orig_tree};
 -	struct merge_options o;
 -	struct commit *result;
 -	char *his_tree_name;
 -	int status;
 -
 -	init_merge_options(&o);
 -
 -	o.branch1 = "HEAD";
 -	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 -	o.branch2 = his_tree_name;
 -
 -	if (state->quiet)
 -		o.verbosity = 0;
 -
 -	status = merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result);
 -	if (status < 0)
 -		exit(128);
 -	free(his_tree_name);
 -
 -	return status;
 -}
 -
 -/**
   * Attempt a threeway merge, using index_path as the temporary index.
   */
  static int fall_back_threeway(const struct am_state *state, const char *index_path)
  {
 -	unsigned char orig_tree[GIT_SHA1_RAWSZ], his_tree[GIT_SHA1_RAWSZ],
 +	unsigned char orig_tree[GIT_SHA1_RAWSZ], her_tree[GIT_SHA1_RAWSZ],
  		      our_tree[GIT_SHA1_RAWSZ];
 +	const unsigned char *bases[1] = {orig_tree};
 +	struct merge_options o;
 +	struct commit *result;
 +	char *her_tree_name;
  
  	if (get_sha1("HEAD", our_tree) < 0)
  		hashcpy(our_tree, EMPTY_TREE_SHA1_BIN);
 @@ -1652,7 +1623,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  		return error(_("Did you hand edit your patch?\n"
  				"It does not apply to blobs recorded in its index."));
  
 -	if (write_index_as_tree(his_tree, &the_index, index_path, 0, NULL))
 +	if (write_index_as_tree(her_tree, &the_index, index_path, 0, NULL))
  		return error("could not write tree");
  
  	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 @@ -1662,17 +1633,28 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  
  	/*
  	 * This is not so wrong. Depending on which base we picked, orig_tree
 -	 * may be wildly different from ours, but his_tree has the same set of
 +	 * may be wildly different from ours, but her_tree has the same set of
  	 * wildly different changes in parts the patch did not touch, so
  	 * recursive ends up canceling them, saying that we reverted all those
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
 +	if (merge_recursive_generic(&o, our_tree, her_tree, 1, bases, &result)) {
  		rerere(state->allow_rerere_autoupdate);
 +		free(her_tree_name);
  		return error(_("Failed to merge in the changes."));
  	}
  
 +	free(her_tree_name);
  	return 0;
  }
  
 diff --git a/builtin/checkout.c b/builtin/checkout.c
 index 14312f7..ced4ac4 100644
 --- a/builtin/checkout.c
 +++ b/builtin/checkout.c
 @@ -573,6 +573,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
  				exit(128);
  			ret = reset_tree(new->commit->tree, opts, 0,
  					 writeout_error);
 +			strbuf_release(&o.obuf);
  			if (ret)
  				return ret;
  		}
 diff --git a/builtin/merge.c b/builtin/merge.c
 index 133b853..7b898db 100644
 --- a/builtin/merge.c
 +++ b/builtin/merge.c
 @@ -1552,8 +1552,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
  		ret = try_merge_strategy(use_strategies[i]->name,
  					 common, remoteheads,
  					 head_commit, head_arg);
 -		if (ret < 0)
 -			exit(128);
  		if (!option_commit && !ret) {
  			merge_was_ok = 1;
  			/*
 diff --git a/imap-send.c b/imap-send.c
 index cd39805..369f72a 100644
 --- a/imap-send.c
 +++ b/imap-send.c
 @@ -506,7 +506,7 @@ static char *next_arg(char **s)
  
  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
  {
 -	int ret;
 +	int ret = -1;
  	va_list va;
  
  	va_start(va, fmt);
 diff --git a/merge-recursive.c b/merge-recursive.c
 index d5a593c..d94f853 100644
 --- a/merge-recursive.c
 +++ b/merge-recursive.c
 @@ -23,6 +23,37 @@
  #include "dir.h"
  #include "submodule.h"
  
 +static void flush_output(struct merge_options *o)
 +{
 +	if (o->buffer_output < 2 && o->obuf.len) {
 +		fputs(o->obuf.buf, stdout);
 +		strbuf_reset(&o->obuf);
 +	}
 +}
 +
 +static int err(struct merge_options *o, const char *err, ...)
 +{
 +	va_list params;
 +
 +	va_start(params, err);
 +	if (o->buffer_output < 2)
 +		flush_output(o);
 +	else {
 +		strbuf_complete(&o->obuf, '\n');
 +		strbuf_addstr(&o->obuf, "error: ");
 +	}
 +	strbuf_vaddf(&o->obuf, err, params);
 +	if (o->buffer_output > 1)
 +		strbuf_addch(&o->obuf, '\n');
 +	else {
 +		error("%s", o->obuf.buf);
 +		strbuf_reset(&o->obuf);
 +	}
 +	va_end(params);
 +
 +	return -1;
 +}
 +
  static struct tree *shift_tree_object(struct tree *one, struct tree *two,
  				      const char *subtree_shift)
  {
 @@ -148,14 +179,6 @@ static int show(struct merge_options *o, int v)
  	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
  }
  
 -static void flush_output(struct merge_options *o)
 -{
 -	if (o->obuf.len) {
 -		fputs(o->obuf.buf, stdout);
 -		strbuf_reset(&o->obuf);
 -	}
 -}
 -
  __attribute__((format (printf, 3, 4)))
  static void output(struct merge_options *o, int v, const char *fmt, ...)
  {
 @@ -177,28 +200,30 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
  
  static void output_commit_title(struct merge_options *o, struct commit *commit)
  {
 -	int i;
 -	flush_output(o);
 -	for (i = o->call_depth; i--;)
 -		fputs("  ", stdout);
 +	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
  	if (commit->util)
 -		printf("virtual %s\n", merge_remote_util(commit)->name);
 +		strbuf_addf(&o->obuf, "virtual %s\n",
 +			merge_remote_util(commit)->name);
  	else {
 -		printf("%s ", find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 +		strbuf_addf(&o->obuf, "%s ",
 +			find_unique_abbrev(commit->object.oid.hash,
 +				DEFAULT_ABBREV));
  		if (parse_commit(commit) != 0)
 -			printf(_("(bad commit)\n"));
 +			strbuf_addf(&o->obuf, _("(bad commit)\n"));
  		else {
  			const char *title;
  			const char *msg = get_commit_buffer(commit, NULL);
  			int len = find_commit_subject(msg, &title);
  			if (len)
 -				printf("%.*s\n", len, title);
 +				strbuf_addf(&o->obuf, "%.*s\n", len, title);
  			unuse_commit_buffer(commit, msg);
  		}
  	}
 +	flush_output(o);
  }
  
 -static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 +static int add_cacheinfo(struct merge_options *o,
 +		unsigned int mode, const unsigned char *sha1,
  		const char *path, int stage, int refresh, int options)
  {
  	struct cache_entry *ce;
 @@ -206,7 +231,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
  			      (refresh ? (CE_MATCH_REFRESH |
  					  CE_MATCH_IGNORE_MISSING) : 0 ));
  	if (!ce)
 -		return error(_("addinfo_cache failed for path '%s'"), path);
 +		return err(o, _("addinfo_cache failed for path '%s'"), path);
  	return add_cache_entry(ce, options);
  }
  
 @@ -267,7 +292,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
  
  	if (!cache_tree_fully_valid(active_cache_tree) &&
  	    cache_tree_update(&the_index, 0) < 0) {
 -		error(_("error building trees"));
 +		err(o, _("error building trees"));
  		return NULL;
  	}
  
 @@ -535,7 +560,8 @@ static struct string_list *get_renames(struct merge_options *o,
  	return renames;
  }
  
 -static int update_stages(const char *path, const struct diff_filespec *o,
 +static int update_stages(struct merge_options *opt, const char *path,
 +			 const struct diff_filespec *o,
  			 const struct diff_filespec *a,
  			 const struct diff_filespec *b)
  {
 @@ -550,17 +576,19 @@ static int update_stages(const char *path, const struct diff_filespec *o,
  	 */
  	int clear = 1;
  	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 -	int ret = 0;
 -
  	if (clear)
 -		ret = remove_file_from_cache(path);
 -	if (!ret && o)
 -		ret = add_cacheinfo(o->mode, o->sha1, path, 1, 0, options);
 -	if (!ret && a)
 -		ret = add_cacheinfo(a->mode, a->sha1, path, 2, 0, options);
 -	if (!ret && b)
 -		ret = add_cacheinfo(b->mode, b->sha1, path, 3, 0, options);
 -	return ret;
 +		if (remove_file_from_cache(path))
 +			return -1;
 +	if (o)
 +		if (add_cacheinfo(opt, o->mode, o->sha1, path, 1, 0, options))
 +			return -1;
 +	if (a)
 +		if (add_cacheinfo(opt, a->mode, a->sha1, path, 2, 0, options))
 +			return -1;
 +	if (b)
 +		if (add_cacheinfo(opt, b->mode, b->sha1, path, 3, 0, options))
 +			return -1;
 +	return 0;
  }
  
  static void update_entry(struct stage_data *entry,
 @@ -658,24 +686,22 @@ static int was_tracked(const char *path)
  {
  	int pos = cache_name_pos(path, strlen(path));
  
 -	/* cache_name_pos() looks for stage == 0, so pos may be < 0 */
 -	if (pos < 0)
 -		pos = -1 - pos;
 -	while (pos < active_nr &&
 -	       !strcmp(path, active_cache[pos]->name)) {
 +	if (pos >= 0)
 +		return pos < active_nr;
 +	/*
 +	 * cache_name_pos() looks for stage == 0, even if we did not ask for
 +	 * it. Let's look for stage == 2 now.
 +	 */
 +	for (pos = -1 - pos; pos < active_nr &&
 +	     !strcmp(path, active_cache[pos]->name); pos++)
  		/*
  		 * If stage #0, it is definitely tracked.
  		 * If it has stage #2 then it was tracked
  		 * before this merge started.  All other
  		 * cases the path was not tracked.
  		 */
 -		switch (ce_stage(active_cache[pos])) {
 -		case 0:
 -		case 2:
 +		if (ce_stage(active_cache[pos]) == 2)
  			return 1;
 -		}
 -		pos++;
 -	}
  	return 0;
  }
  
 @@ -712,8 +738,8 @@ static int make_room_for_path(struct merge_options *o, const char *path)
  	if (status) {
  		if (status == SCLD_EXISTS)
  			/* something else exists */
 -			return error(msg, path, _(": perhaps a D/F conflict?"));
 -		return error(msg, path, "");
 +			return err(o, msg, path, _(": perhaps a D/F conflict?"));
 +		return err(o, msg, path, "");
  	}
  
  	/*
 @@ -721,7 +747,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
  	 * tracking it.
  	 */
  	if (would_lose_untracked(path))
 -		return error(_("refusing to lose untracked file at '%s'"),
 +		return err(o, _("refusing to lose untracked file at '%s'"),
  			     path);
  
  	/* Successful unlink is good.. */
 @@ -731,7 +757,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
  	if (errno == ENOENT)
  		return 0;
  	/* .. but not some other error (who really cares what?) */
 -	return error(msg, path, _(": perhaps a D/F conflict?"));
 +	return err(o, msg, path, _(": perhaps a D/F conflict?"));
  }
  
  static int update_file_flags(struct merge_options *o,
 @@ -763,9 +789,9 @@ static int update_file_flags(struct merge_options *o,
  
  		buf = read_sha1_file(sha, &type, &size);
  		if (!buf)
 -			return error(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
 +			return err(o, _("cannot read object %s '%s'"), sha1_to_hex(sha), path);
  		if (type != OBJ_BLOB) {
 -			ret = error(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
 +			ret = err(o, _("blob expected for %s '%s'"), sha1_to_hex(sha), path);
  			goto free_buf;
  		}
  		if (S_ISREG(mode)) {
 @@ -789,7 +815,8 @@ static int update_file_flags(struct merge_options *o,
  				mode = 0666;
  			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
  			if (fd < 0) {
 -				ret = error_errno(_("failed to open '%s'"), path);
 +				ret = err(o, _("failed to open '%s': %s"),
 +					path, strerror(errno));
  				goto free_buf;
  			}
  			write_in_full(fd, buf, size);
 @@ -799,17 +826,18 @@ static int update_file_flags(struct merge_options *o,
  			safe_create_leading_directories_const(path);
  			unlink(path);
  			if (symlink(lnk, path))
 -				ret = error_errno(_("failed to symlink '%s'"), path);
 +				ret = err(o, _("failed to symlink '%s': %s"),
 +					path, strerror(errno));
  			free(lnk);
  		} else
 -			ret = error_errno(_("do not know what to do with %06o %s '%s'"),
 +			ret = err(o, _("do not know what to do with %06o %s '%s'"),
  				mode, sha1_to_hex(sha), path);
 -free_buf:
 + free_buf:
  		free(buf);
  	}
   update_index:
  	if (!ret && update_cache)
 -		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 +		add_cacheinfo(o, mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
  	return ret;
  }
  
 @@ -942,11 +970,11 @@ static int merge_file_1(struct merge_options *o,
  						  branch1, branch2);
  
  			if ((merge_status < 0) || !result_buf.ptr)
 -				ret = error(_("Failed to execute internal merge"));
 +				ret = err(o, _("Failed to execute internal merge"));
  
  			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
  					    blob_type, result->sha))
 -				ret = error(_("Unable to add %s to database"),
 +				ret = err(o, _("Unable to add %s to database"),
  					a->path);
  
  			free(result_buf.ptr);
 @@ -964,7 +992,7 @@ static int merge_file_1(struct merge_options *o,
  			if (!sha_eq(a->sha1, b->sha1))
  				result->clean = 0;
  		} else
 -			die(_("BUG: unsupported object type in the tree"));
 +			die("BUG: unsupported object type in the tree");
  	}
  
  	return 0;
 @@ -1090,7 +1118,6 @@ static int conflict_rename_delete(struct merge_options *o,
  	const unsigned char *b_sha = NULL;
  	int a_mode = 0;
  	int b_mode = 0;
 -	int ret = 0;
  
  	if (rename_branch == o->branch1) {
  		a_sha = dest->sha1;
 @@ -1100,22 +1127,19 @@ static int conflict_rename_delete(struct merge_options *o,
  		b_mode = dest->mode;
  	}
  
 -	ret = handle_change_delete(o,
 +	if (handle_change_delete(o,
  			     o->call_depth ? orig->path : dest->path,
  			     orig->sha1, orig->mode,
  			     a_sha, a_mode,
  			     b_sha, b_mode,
 -			     _("rename"), _("renamed"));
 -	if (ret < 0)
 -		return ret;
 +			     _("rename"), _("renamed")))
 +		return -1;
  	if (o->call_depth)
 -		ret = remove_file_from_cache(dest->path);
 +		return remove_file_from_cache(dest->path);
  	else
 -		ret = update_stages(dest->path, NULL,
 +		return update_stages(o, dest->path, NULL,
  			      rename_branch == o->branch1 ? dest : NULL,
  			      rename_branch == o->branch1 ? NULL : dest);
 -
 -	return ret;
  }
  
  static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 @@ -1156,8 +1180,8 @@ static int handle_file(struct merge_options *o,
  	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
  	if (add) {
  		char *add_name = unique_path(o, rename->path, other_branch);
 -		if ((ret = update_file(o, 0, add->sha1, add->mode, add_name)))
 -			return ret;
 +		if (update_file(o, 0, add->sha1, add->mode, add_name))
 +			return -1;
  
  		remove_file(o, 0, rename->path, 0);
  		dst_name = unique_path(o, rename->path, cur_branch);
 @@ -1171,9 +1195,9 @@ static int handle_file(struct merge_options *o,
  	if ((ret = update_file(o, 0, rename->sha1, rename->mode, dst_name)))
  		; /* fall through, do allow dst_name to be released */
  	else if (stage == 2)
 -		ret = update_stages(rename->path, NULL, rename, add);
 +		ret = update_stages(o, rename->path, NULL, rename, add);
  	else
 -		ret = update_stages(rename->path, NULL, add, rename);
 +		ret = update_stages(o, rename->path, NULL, add, rename);
  
  	if (dst_name != rename->path)
  		free(dst_name);
 @@ -1188,7 +1212,6 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
  	struct diff_filespec *one = ci->pair1->one;
  	struct diff_filespec *a = ci->pair1->two;
  	struct diff_filespec *b = ci->pair2->two;
 -	int ret = 0;
  
  	output(o, 1, _("CONFLICT (rename/rename): "
  	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 @@ -1201,12 +1224,12 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
  		struct diff_filespec other;
  		struct diff_filespec *add;
  
 -		if ((ret = merge_file_one(o, one->path,
 +		if (merge_file_one(o, one->path,
  				 one->sha1, one->mode,
  				 a->sha1, a->mode,
  				 b->sha1, b->mode,
 -				 ci->branch1, ci->branch2, &mfi)))
 -			return ret;
 +				 ci->branch1, ci->branch2, &mfi))
 +			return -1;
  
  		/*
  		 * FIXME: For rename/add-source conflicts (if we could detect
 @@ -1214,8 +1237,8 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
  		 * pathname and then either rename the add-source file to that
  		 * unique path, or use that unique path instead of src here.
  		 */
 -		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, one->path)))
 -			return ret;
 +		if (update_file(o, 0, mfi.sha, mfi.mode, one->path))
 +			return -1;
  
  		/*
  		 * Above, we put the merged content at the merge-base's
 @@ -1227,27 +1250,22 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
  		 */
  		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
  		if (add) {
 -			if ((ret = update_file(o, 0, add->sha1, add->mode,
 -					a->path)))
 -				return ret;
 +			if (update_file(o, 0, add->sha1, add->mode, a->path))
 +				return -1;
  		}
  		else
  			remove_file_from_cache(a->path);
  		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
  		if (add) {
 -			if ((ret = update_file(o, 0, add->sha1, add->mode,
 -					b->path)))
 -				return ret;
 +			if (update_file(o, 0, add->sha1, add->mode, b->path))
 +				return -1;
  		}
  		else
  			remove_file_from_cache(b->path);
 -	} else {
 -		if ((ret = handle_file(o, a, 2, ci)) ||
 -		    (ret = handle_file(o, b, 3, ci)))
 -			return ret;
 -	}
 +	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
 +		return -1;
  
 -	return ret;
 +	return 0;
  }
  
  static int conflict_rename_rename_2to1(struct merge_options *o,
 @@ -1272,13 +1290,13 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
  	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
  	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
  
 -	if ((ret = merge_file_special_markers(o, a, c1, &ci->ren1_other,
 +	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
  					    o->branch1, c1->path,
 -					    o->branch2, ci->ren1_other.path, &mfi_c1)) ||
 -	    (ret = merge_file_special_markers(o, b, &ci->ren2_other, c2,
 +					    o->branch2, ci->ren1_other.path, &mfi_c1) ||
 +	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
  					    o->branch1, ci->ren2_other.path,
 -					    o->branch2, c2->path, &mfi_c2)))
 -		return ret;
 +					    o->branch2, c2->path, &mfi_c2))
 +		return -1;
  
  	if (o->call_depth) {
  		/*
 @@ -1314,7 +1332,7 @@ static int process_renames(struct merge_options *o,
  			   struct string_list *a_renames,
  			   struct string_list *b_renames)
  {
 -	int clean_merge = 1, i, j, ret;
 +	int clean_merge = 1, i, j;
  	struct string_list a_by_dst = STRING_LIST_INIT_NODUP;
  	struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
  	const struct rename *sre;
 @@ -1490,14 +1508,13 @@ static int process_renames(struct merge_options *o,
  				 * update_file_flags() instead of
  				 * update_file().
  				 */
 -				ret = update_file_flags(o,
 +				if (update_file_flags(o,
  						  ren1->pair->two->sha1,
  						  ren1->pair->two->mode,
  						  ren1_dst,
  						  1, /* update_cache */
 -						  0  /* update_wd    */);
 -				if (ret)
 -					clean_merge = ret;
 +						  0  /* update_wd    */))
 +					clean_merge = -1;
  			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
  				clean_merge = 0;
  				try_merge = 1;
 @@ -1507,22 +1524,22 @@ static int process_renames(struct merge_options *o,
  				       ren1_dst, branch2);
  				if (o->call_depth) {
  					struct merge_file_info mfi;
 -					if ((ret = merge_file_one(o, ren1_dst, null_sha1, 0,
 +					if (merge_file_one(o, ren1_dst, null_sha1, 0,
  							 ren1->pair->two->sha1, ren1->pair->two->mode,
  							 dst_other.sha1, dst_other.mode,
 -							 branch1, branch2, &mfi))) {
 -						clean_merge = ret;
 +							 branch1, branch2, &mfi)) {
 +						clean_merge = -1;
  						goto cleanup_and_return;
  					}
  					output(o, 1, _("Adding merged %s"), ren1_dst);
 -					if ((ret = update_file(o, 0, mfi.sha, mfi.mode, ren1_dst)))
 -						clean_merge = ret;
 +					if (update_file(o, 0, mfi.sha, mfi.mode, ren1_dst))
 +						clean_merge = -1;
  					try_merge = 0;
  				} else {
  					char *new_path = unique_path(o, ren1_dst, branch2);
  					output(o, 1, _("Adding as %s instead"), new_path);
 -					if ((ret = update_file(o, 0, dst_other.sha1, dst_other.mode, new_path)))
 -						clean_merge = ret;
 +					if (update_file(o, 0, dst_other.sha1, dst_other.mode, new_path))
 +						clean_merge = -1;
  					free(new_path);
  				}
  			} else
 @@ -1568,23 +1585,25 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
  	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
  }
  
 -static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
 +static int read_sha1_strbuf(struct merge_options *o,
 +	const unsigned char *sha1, struct strbuf *dst)
  {
  	void *buf;
  	enum object_type type;
  	unsigned long size;
  	buf = read_sha1_file(sha1, &type, &size);
  	if (!buf)
 -		return error(_("cannot read object %s"), sha1_to_hex(sha1));
 +		return err(o, _("cannot read object %s"), sha1_to_hex(sha1));
  	if (type != OBJ_BLOB) {
  		free(buf);
 -		return error(_("object %s is not a blob"), sha1_to_hex(sha1));
 +		return err(o, _("object %s is not a blob"), sha1_to_hex(sha1));
  	}
  	strbuf_attach(dst, buf, size, size + 1);
  	return 0;
  }
  
 -static int blob_unchanged(const unsigned char *o_sha,
 +static int blob_unchanged(struct merge_options *opt,
 +			  const unsigned char *o_sha,
  			  unsigned o_mode,
  			  const unsigned char *a_sha,
  			  unsigned a_mode,
 @@ -1602,7 +1621,7 @@ static int blob_unchanged(const unsigned char *o_sha,
  		return 0;
  
  	assert(o_sha && a_sha);
 -	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
 +	if (read_sha1_strbuf(opt, o_sha, &o) || read_sha1_strbuf(opt, a_sha, &a))
  		goto error_return;
  	/*
  	 * Note: binary | is used so that both renormalizations are
 @@ -1645,7 +1664,6 @@ static int merge_content(struct merge_options *o,
  	struct merge_file_info mfi;
  	struct diff_filespec one, a, b;
  	unsigned df_conflict_remains = 0;
 -	int ret;
  
  	if (!o_sha) {
  		reason = _("add/add");
 @@ -1675,10 +1693,10 @@ static int merge_content(struct merge_options *o,
  		if (dir_in_way(path, !o->call_depth))
  			df_conflict_remains = 1;
  	}
 -	if ((ret = merge_file_special_markers(o, &one, &a, &b,
 +	if (merge_file_special_markers(o, &one, &a, &b,
  					 o->branch1, path1,
 -					 o->branch2, path2, &mfi)))
 -		return ret;
 +					 o->branch2, path2, &mfi))
 +		return -1;
  
  	if (mfi.clean && !df_conflict_remains &&
  	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
 @@ -1692,7 +1710,7 @@ static int merge_content(struct merge_options *o,
  		 */
  		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
  		if (!path_renamed_outside_HEAD) {
 -			add_cacheinfo(mfi.mode, mfi.sha, path,
 +			add_cacheinfo(o, mfi.mode, mfi.sha, path,
  				      0, (!o->call_depth), 0);
  			return mfi.clean;
  		}
 @@ -1705,8 +1723,8 @@ static int merge_content(struct merge_options *o,
  		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
  				reason, path);
  		if (rename_conflict_info && !df_conflict_remains)
 -			if ((ret = update_stages(path, &one, &a, &b)))
 -				return ret;
 +			if (update_stages(o, path, &one, &a, &b))
 +				return -1;
  	}
  
  	if (df_conflict_remains) {
 @@ -1715,42 +1733,39 @@ static int merge_content(struct merge_options *o,
  			remove_file_from_cache(path);
  		} else {
  			if (!mfi.clean) {
 -				if ((ret = update_stages(path, &one, &a, &b)))
 -					return ret;
 +				if (update_stages(o, path, &one, &a, &b))
 +					return -1;
  			} else {
  				int file_from_stage2 = was_tracked(path);
  				struct diff_filespec merged;
  				hashcpy(merged.sha1, mfi.sha);
  				merged.mode = mfi.mode;
  
 -				if ((ret = update_stages(path, NULL,
 +				if (update_stages(o, path, NULL,
  					      file_from_stage2 ? &merged : NULL,
 -					      file_from_stage2 ? NULL : &merged)))
 -					return ret;
 +					      file_from_stage2 ? NULL : &merged))
 +					return -1;
  			}
  
  		}
  		new_path = unique_path(o, path, rename_conflict_info->branch1);
  		output(o, 1, _("Adding as %s instead"), new_path);
 -		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, new_path))) {
 +		if (update_file(o, 0, mfi.sha, mfi.mode, new_path)) {
  			free(new_path);
 -			return ret;
 +			return -1;
  		}
  		free(new_path);
  		mfi.clean = 0;
 -	} else {
 -		if ((ret = update_file(o, mfi.clean, mfi.sha, mfi.mode, path)))
 -			return ret;
 -	}
 +	} else if (update_file(o, mfi.clean, mfi.sha, mfi.mode, path))
 +		return -1;
  	return mfi.clean;
 -
  }
  
  /* Per entry merge function */
  static int process_entry(struct merge_options *o,
  			 const char *path, struct stage_data *entry)
  {
 -	int clean_merge = 1, ret;
 +	int clean_merge = 1;
  	int normalize = o->renormalize;
  	unsigned o_mode = entry->stages[1].mode;
  	unsigned a_mode = entry->stages[2].mode;
 @@ -1771,23 +1786,21 @@ static int process_entry(struct merge_options *o,
  			break;
  		case RENAME_DELETE:
  			clean_merge = 0;
 -			if ((ret = conflict_rename_delete(o,
 +			if (conflict_rename_delete(o,
  					       conflict_info->pair1,
  					       conflict_info->branch1,
 -					       conflict_info->branch2)))
 -				clean_merge = ret;
 +					       conflict_info->branch2))
 +				clean_merge = -1;
  			break;
  		case RENAME_ONE_FILE_TO_TWO:
  			clean_merge = 0;
 -			if ((ret = conflict_rename_rename_1to2(o,
 -					conflict_info)))
 -				clean_merge = ret;
 +			if (conflict_rename_rename_1to2(o, conflict_info))
 +				clean_merge = -1;
  			break;
  		case RENAME_TWO_FILES_TO_ONE:
  			clean_merge = 0;
 -			if ((ret = conflict_rename_rename_2to1(o,
 -					conflict_info)))
 -				clean_merge = ret;
 +			if (conflict_rename_rename_2to1(o, conflict_info))
 +				clean_merge = -1;
  			break;
  		default:
  			entry->processed = 0;
 @@ -1796,8 +1809,8 @@ static int process_entry(struct merge_options *o,
  	} else if (o_sha && (!a_sha || !b_sha)) {
  		/* Case A: Deleted in one */
  		if ((!a_sha && !b_sha) ||
 -		    (!b_sha && blob_unchanged(o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
 -		    (!a_sha && blob_unchanged(o_sha, o_mode, b_sha, b_mode, normalize, path))) {
 +		    (!b_sha && blob_unchanged(o, o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
 +		    (!a_sha && blob_unchanged(o, o_sha, o_mode, b_sha, b_mode, normalize, path))) {
  			/* Deleted in both or deleted in one and
  			 * unchanged in the other */
  			if (a_sha)
 @@ -1807,9 +1820,9 @@ static int process_entry(struct merge_options *o,
  		} else {
  			/* Modify/delete; deleted side may have put a directory in the way */
  			clean_merge = 0;
 -			if ((ret = handle_modify_delete(o, path, o_sha, o_mode,
 -					a_sha, a_mode, b_sha, b_mode)))
 -				clean_merge = ret;
 +			if (handle_modify_delete(o, path, o_sha, o_mode,
 +						 a_sha, a_mode, b_sha, b_mode))
 +				clean_merge = -1;
  		}
  	} else if ((!o_sha && a_sha && !b_sha) ||
  		   (!o_sha && !a_sha && b_sha)) {
 @@ -1841,18 +1854,16 @@ static int process_entry(struct merge_options *o,
  			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
  			       "Adding %s as %s"),
  			       conf, path, other_branch, path, new_path);
 -			ret = update_file(o, 0, sha, mode, new_path);
 -			if (ret)
 -				clean_merge = ret;
 +			if (update_file(o, 0, sha, mode, new_path))
 +				clean_merge = -1;
  			else if (o->call_depth)
  				remove_file_from_cache(path);
  			free(new_path);
  		} else {
  			output(o, 2, _("Adding %s"), path);
  			/* do not overwrite file if already present */
 -			if ((ret = update_file_flags(o, sha, mode, path, 1,
 -					!a_sha)))
 -				clean_merge = ret;
 +			if (update_file_flags(o, sha, mode, path, 1, !a_sha))
 +				clean_merge = -1;
  		}
  	} else if (a_sha && b_sha) {
  		/* Case C: Added in both (check for same permissions) and */
 @@ -1867,7 +1878,7 @@ static int process_entry(struct merge_options *o,
  		 */
  		remove_file(o, 1, path, !a_mode);
  	} else
 -		return error(_("Fatal merge failure, shouldn't happen."));
 +		die("BUG: fatal merge failure, shouldn't happen.");
  
  	return clean_merge;
  }
 @@ -1895,7 +1906,7 @@ int merge_trees(struct merge_options *o,
  
  	if (code != 0) {
  		if (show(o, 4) || o->call_depth)
 -			error(_("merging of trees %s and %s failed"),
 +			err(o, _("merging of trees %s and %s failed"),
  			    oid_to_hex(&head->object.oid),
  			    oid_to_hex(&merge->object.oid));
  		return -1;
 @@ -1930,7 +1941,7 @@ int merge_trees(struct merge_options *o,
  		for (i = 0; i < entries->nr; i++) {
  			struct stage_data *e = entries->items[i].util;
  			if (!e->processed)
 -				die(_("BUG: unprocessed path??? %s"),
 +				die("BUG: unprocessed path??? %s",
  				    entries->items[i].string);
  		}
  
 @@ -2029,7 +2040,7 @@ int merge_recursive(struct merge_options *o,
  		o->call_depth--;
  
  		if (!merged_common_ancestors)
 -			return error(_("merge returned no commit"));
 +			return err(o, _("merge returned no commit"));
  	}
  
  	discard_cache();
 @@ -2039,6 +2050,7 @@ int merge_recursive(struct merge_options *o,
  	o->ancestor = "merged common ancestors";
  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
  			    &mrtree);
 +	flush_output(o);
  	if (clean < 0)
  		return clean;
  
 @@ -2047,7 +2059,8 @@ int merge_recursive(struct merge_options *o,
  		commit_list_insert(h1, &(*result)->parents);
  		commit_list_insert(h2, &(*result)->parents->next);
  	}
 -	flush_output(o);
 +	if (o->buffer_output < 2)
 +		strbuf_release(&o->obuf);
  	if (show(o, 2))
  		diff_warn_rename_limit("merge.renamelimit",
  				       o->needed_rename_limit, 0);
 @@ -2088,7 +2101,7 @@ int merge_recursive_generic(struct merge_options *o,
  		for (i = 0; i < num_base_list; ++i) {
  			struct commit *base;
  			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
 -				return error(_("Could not parse object '%s'"),
 +				return err(o, _("Could not parse object '%s'"),
  					sha1_to_hex(base_list[i]));
  			commit_list_insert(base, &ca);
  		}
 @@ -2102,7 +2115,7 @@ int merge_recursive_generic(struct merge_options *o,
  
  	if (active_cache_changed &&
  	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 -		return error(_("Unable to write index."));
 +		return err(o, _("Unable to write index."));
  
  	return clean ? 0 : 1;
  }
 diff --git a/merge-recursive.h b/merge-recursive.h
 index 52f0201..407d4fc 100644
 --- a/merge-recursive.h
 +++ b/merge-recursive.h
 @@ -13,7 +13,7 @@ struct merge_options {
  		MERGE_RECURSIVE_THEIRS
  	} recursive_variant;
  	const char *subtree_shift;
 -	unsigned buffer_output : 1;
 +	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
  	unsigned renormalize : 1;
  	long xdl_opts;
  	int verbosity;
 diff --git a/sequencer.c b/sequencer.c
 index 13b794a..8ceeb1b 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -293,6 +293,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  	clean = merge_trees(&o,
  			    head_tree,
  			    next_tree, base_tree, &result);
 +	strbuf_release(&o.obuf);
  	if (clean < 0)
  		return clean;
  
 diff --git a/sha1_file.c b/sha1_file.c
 index aa7006c..5085fe0 100644
 --- a/sha1_file.c
 +++ b/sha1_file.c
 @@ -795,7 +795,7 @@ void close_all_packs(void)
  
  	for (p = packed_git; p; p = p->next)
  		if (p->do_not_close)
 -			die("BUG: Want to close pack marked 'do-not-close'");
 +			die("BUG: want to close pack marked 'do-not-close'");
  		else
  			close_pack(p);
  }
 diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
 index 3159956..b281d6f 100755
 --- a/t/t5520-pull.sh
 +++ b/t/t5520-pull.sh
 @@ -255,6 +255,36 @@ test_expect_success '--rebase' '
  	test new = "$(git show HEAD:file2)"
  '
  
 +test_expect_success '--rebase with conflicts shows advice' '
 +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
 +	git checkout -b seq &&
 +	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
 +	git add seq.txt &&
 +	test_tick &&
 +	git commit -m "Add seq.txt" &&
 +	printf "6\\n" >>seq.txt &&
 +	test_tick &&
 +	git commit -m "Append to seq.txt" seq.txt &&
 +	git checkout -b with-conflicts HEAD^ &&
 +	printf "conflicting\\n" >>seq.txt &&
 +	test_tick &&
 +	git commit -m "Create conflict" seq.txt &&
 +	test_must_fail git pull --rebase . seq 2>err >out &&
 +	grep "When you have resolved this problem" out
 +'
 +test_expect_success 'failed --rebase shows advice' '
 +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
 +	git checkout -b diverging &&
 +	test_commit attributes .gitattributes "* text=auto" attrs &&
 +	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
 +	git update-index --cacheinfo 0644 $sha1 file &&
 +	git commit -m v1-with-cr &&
 +	git checkout -f -b fails-to-rebase HEAD^ &&
 +	test_commit v2-without-cr file "2" file2-lf &&
 +	test_must_fail git pull --rebase . diverging 2>err >out &&
 +	grep "When you have resolved this problem" out
 +'
 +
  test_expect_success '--rebase fails with multiple branches' '
  	git reset --hard before-rebase &&
  	test_must_fail git pull --rebase . copy master 2>err &&
 diff --git a/wt-status.c b/wt-status.c
 index 311ae7c..75c1162 100644
 --- a/wt-status.c
 +++ b/wt-status.c
 @@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
  	case 7:
  		return _("both modified:");
  	default:
 -		die(_("BUG: unhandled unmerged status %x"), stagemask);
 +		die("BUG: unhandled unmerged status %x", stagemask);
  	}
  }
  
 @@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
  	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
  	what = wt_status_diff_status_string(status);
  	if (!what)
 -		die(_("BUG: unhandled diff status %c"), status);
 +		die("BUG: unhandled diff status %c", status);
  	len = label_width - utf8_strwidth(what);
  	assert(len >= 0);
  	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)

-- 
2.9.0.280.g32e2a70

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
