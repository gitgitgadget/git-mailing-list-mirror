Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8ED71F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbcIIOfm (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:35:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:60914 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbcIIOfl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:35:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MgYGJ-1bN9Pu2ATv-00O1zX; Fri, 09 Sep 2016 16:35:33
 +0200
Date:   Fri, 9 Sep 2016 16:35:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/17] Lib'ify quite a few functions in sequencer.c
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EGPlJb9ikErYHzT9hOCT59Mr3HDVe7ArMwvUIni1DJJURPrXbgG
 b9kZW2XUbKLOXXGXBoxiKY3+u+ii6c8zRe4eFTw9/oiMVpa8YcFn9ahejK4naObIAmV9BUs
 AXjR2PMyyc+IsiTQp0h7+mnc9FcTTcUqQOJvfjT7mxgsyvwzqd9HsgRhPZfSVRYYvhnx1C2
 KuJgBRCnpseF1n1JDvwrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BYJfeN6mvQc=:k4BQL4tyBiBYgvnqrsunzR
 0dMpq4HK8CzFP126csQ1JUh/5BeY9vx8g3VxeKEvfb3zTINoQM+RrxultxXYpta6fWyhCV4+w
 BvGwD8hVDSYpnLJ8lloxzDZkqpm1JhW4WkvZTrSc61Wkum6D3ko5KPYHrh0LUIG8NW87PhOIN
 xZCi8qf6NE/XbYT+qfPgB28yVdCgoelfKiwp+6Fc1xD9sczJU5Wn3fqWr9o9GCxarrIarvPyZ
 eDhUALqld0Lw70MRbdAU8wSTq9dsNESdYVdn5fdahyTI2Wk4dI+u2q6XQ/El1BTBMIbQqEA1Q
 Ljzy0aL5sf1535As5pJBTsTpvGoA/K2zO367jjdTunDTZQWaeg0Hi+TVnyCwES5vBUuBb406P
 ryVbJb+R5Vh/xctZwizmwCKxKlomhtKkMaS7p57mohox5/MBBpRNoVa3uEeEVdkjCB3MIy3D0
 hBfmwx1CYUDEg+aLhN+o11QxvoH0mRipm4jFB24SeqwRXVjAnDay2izm4q+14n5YzQhBEOycM
 5AgfCWE1MzDsDPFOrz4rODSECaYQZ/QUliK1aeFl8c+2X4fW/kjBZioYkZViYK+1NTdjh9aH2
 xJkA8cS5/rOJao7PREMFQHyAv9ExHEIsiJUyKw/AwLS2q7VZ8Z5i1G+EqqF4gTiiMAGM6euxz
 NBmsAuBJtPXXKRjeRBY8pMM7RwiPs6lJREqHTQwnPzFHh4lOFGAVe06/1OC/qDjh2ehkZf0zR
 AumiLhMQoMTYRtdetMgY+Teu4qlYpeUd30as6nljKUfxcjAaJJxHscfSBcF5IYdJwcuz6xObG
 hxRtBfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is one of the half dozen patch series left to move the
bulk of rebase -i into a builtin.

The purpose of this patch series is to switch the functions in
sequencer.c from die()ing to returning errors instead, as proper library
functions should do, to give callers a chance to clean up after an
error.

Changes since v2:

- the commit message of the read_populate_opts() patch now clarifies why
  we do not take care of git_config_from_file() possibly die()ing.

- the save_head() and the save_opts() conditionals are now separate, for
  improved readability.

- the fast_forward_to() libification now happens in its own commit.

- checkout_fast_forward_to() is now libified, too.

- added a code comment to clarify why we don't care about
  git_parse_source() being able to die().

- added rollbacks in case of failure in read_and_refresh_cache() and
  save_head().


Johannes Schindelin (17):
  sequencer: lib'ify sequencer_pick_revisions()
  sequencer: do not die() in do_pick_commit()
  sequencer: lib'ify write_message()
  sequencer: lib'ify do_recursive_merge()
  sequencer: lib'ify do_pick_commit()
  sequencer: lib'ify walk_revs_populate_todo()
  sequencer: lib'ify prepare_revs()
  sequencer: lib'ify read_and_refresh_cache()
  sequencer: lib'ify read_populate_todo()
  sequencer: lib'ify read_populate_opts()
  sequencer: lib'ify create_seq_dir()
  sequencer: lib'ify save_head()
  sequencer: lib'ify save_todo()
  sequencer: lib'ify save_opts()
  sequencer: lib'ify fast_forward_to()
  lib'ify checkout_fast_forward_to()
  sequencer: ensure to release the lock when we could not read the index

 merge.c     |   9 ++-
 sequencer.c | 197 ++++++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 131 insertions(+), 75 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/libify-sequencer-v3
Fetch-It-Via: git fetch https://github.com/dscho/git libify-sequencer-v3

Interdiff vs v2:

 diff --git a/merge.c b/merge.c
 index 5db7d56..23866c9 100644
 --- a/merge.c
 +++ b/merge.c
 @@ -57,7 +57,8 @@ int checkout_fast_forward(const unsigned char *head,
  
  	refresh_cache(REFRESH_QUIET);
  
 -	hold_locked_index(lock_file, 1);
 +	if (hold_locked_index(lock_file, 0) < 0)
 +		return -1;
  
  	memset(&trees, 0, sizeof(trees));
  	memset(&opts, 0, sizeof(opts));
 @@ -90,7 +91,9 @@ int checkout_fast_forward(const unsigned char *head,
  	}
  	if (unpack_trees(nr_trees, t, &opts))
  		return -1;
 -	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 -		die(_("unable to write new index file"));
 +	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK)) {
 +		rollback_lock_file(lock_file);
 +		return error(_("unable to write new index file"));
 +	}
  	return 0;
  }
 diff --git a/sequencer.c b/sequencer.c
 index b6481bb..eec8a60 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -644,14 +644,18 @@ static int read_and_refresh_cache(struct replay_opts *opts)
  {
  	static struct lock_file index_lock;
  	int index_fd = hold_locked_index(&index_lock, 0);
 -	if (read_index_preload(&the_index, NULL) < 0)
 +	if (read_index_preload(&the_index, NULL) < 0) {
 +		rollback_lock_file(&index_lock);
  		return error(_("git %s: failed to read the index"),
  			action_name(opts));
 +	}
  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
  	if (the_index.cache_changed && index_fd >= 0) {
 -		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 +		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
 +			rollback_lock_file(&index_lock);
  			return error(_("git %s: failed to refresh the index"),
  				action_name(opts));
 +		}
  	}
  	rollback_lock_file(&index_lock);
  	return 0;
 @@ -812,6 +816,12 @@ static int read_populate_opts(struct replay_opts **opts)
  {
  	if (!file_exists(git_path_opts_file()))
  		return 0;
 +	/*
 +	 * The function git_parse_source(), called from git_config_from_file(),
 +	 * may die() in case of a syntactically incorrect file. We do not care
 +	 * about this case, though, because we wrote that file ourselves, so we
 +	 * are pretty certain that it is syntactically correct.
 +	 */
  	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
  		return error(_("Malformed options sheet: %s"),
  			git_path_opts_file());
 @@ -853,14 +863,20 @@ static int save_head(const char *head)
  	int fd;
  
  	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 -	if (fd < 0)
 +	if (fd < 0) {
 +		rollback_lock_file(&head_lock);
  		return error_errno(_("Could not lock HEAD"));
 +	}
  	strbuf_addf(&buf, "%s\n", head);
 -	if (write_in_full(fd, buf.buf, buf.len) < 0)
 +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 +		rollback_lock_file(&head_lock);
  		return error_errno(_("Could not write to %s"),
  				   git_path_head_file());
 -	if (commit_lock_file(&head_lock) < 0)
 +	}
 +	if (commit_lock_file(&head_lock) < 0) {
 +		rollback_lock_file(&head_lock);
  		return error(_("Error wrapping up %s."), git_path_head_file());
 +	}
  	return 0;
  }
  
 @@ -1135,8 +1151,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
  		return -1;
  	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
  		return error(_("Can't revert as initial commit"));
 -	if (save_head(sha1_to_hex(sha1)) ||
 -			save_opts(opts))
 +	if (save_head(sha1_to_hex(sha1)))
 +		return -1;
 +	if (save_opts(opts))
  		return -1;
  	return pick_commits(todo_list, opts);
  }

-- 
2.10.0.windows.1.10.g803177d

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
