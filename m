Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372C51FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 14:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbcHZODn (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 10:03:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:60913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbcHZODm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 10:03:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lb5Tp-1bFWRn2b8r-00kdUi; Fri, 26 Aug 2016 15:47:06
 +0200
Date:   Fri, 26 Aug 2016 15:47:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/14] Lib'ify quite a few functions in sequencer.c
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hJ6V69KncycqukrpRnVQBbBKHiH8GOl4mSQI8H9QdtDTBqdWYt3
 WuKr4/k0CbLqP/GrRERFT12mMv6c2LuQcYYecAoNOwnRYx1VQcfLpyhhHHeM/W1+vso3Rc9
 y2RQWbTOG6TIYCJ8RdXQTerXLy/rx3b0kdkyTtFW7GOw5YDQNSp0B1LbguNckEklm+Wa1EW
 VAOFlf2PY0eGgTaqtZ5eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6uOqRbW6rGk=:94Zm7TMShTHbVFsJrYfgz6
 qr5Dw3mSftxnL3/tbqVvxNNdNo2wQM6clEkL7Io/y7I7RjDLulubnENk+hqpTiYFf3TGlqFh8
 IRDm6y0SBk6tJG7fenYbHuqG5NOspmU4SrWbCIeZZhksZi68EUkquJu7FGxoRskkAEJ1ZbZid
 OzF7pnogHlIx//3lIB+wZoBR4+plZZKwk6NmZ6bH3aCTDPvEWU4ra29RfRtXdb2ZMre3mIOiG
 iILZrwGMWyyoZiw4VgxxyqtRA6qvPA0TAx+5bn9zMJ4hzY/4pflmhc2rJxmPZdaoM36B7U5te
 IdBi0Oe+fNUNrHYtSoZ4O0G/4LMmJB3bT4Asl4HNEJn0WsnCL7oVBTITmm4bHgLc5Gfqz8omz
 KGC8OWgEmG9aTTdU2QhqnBK24cUuoTZngvUB8TzYMIR9TtUOCg7SjqjH0UJlh4EFV55eeltUp
 mjc77cGAVCURAwDo+5BvnK7801T8GZGpGr2eF+WvkykTujyieNaDhq2FGVN/50SOr/fV5S1iI
 /IsktYYWEc9JUEb211gjIq2YEB679ymi23HYnMbZMY3+Ajo33ywiYwTCswA97tqduO4gx7Lzn
 jiUHEmPuwC0EMFHDBl7VLWdRhvQ0D/d3vuZxKidRATpQdlacs2k+KM2cdkM+pG4jyhd+h8UWH
 uoPMC9sntgNIGbK7GMlbfGqM8wuIS7AQHQVKdofH/1crMzRNKZodpoT9uHIsajh1qWtVY8Ozq
 dqS/lxHwy+zOTEs5a96ar23tf/kA73/DgCtsEHEVBDFPrZ6IsYXKP0iElp24MBGyZjv/aqS5I
 QDBDU/e
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

Changes since v1:

- two "return error()"s replacing "die_errno()"s were turned into "return
  error_errno()"s instead.

- an strbuf is now released when format_todo() failed (and may have left
  the strbuf with allocated memory).

- a superfluous space (which was inherited from the previous code) was
  fixed, while at it.

- fixed commit messages to report that callers of the libified functions
  are already libified.

- reordered patches to ensure that callers of libified functions are
  already libified.


Johannes Schindelin (14):
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

 sequencer.c | 172 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 104 insertions(+), 68 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/libify-sequencer-v2
Fetch-It-Via: git fetch https://github.com/dscho/git libify-sequencer-v2

Interdiff vs v1:

 diff --git a/sequencer.c b/sequencer.c
 index caba11d..b6481bb 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -464,7 +464,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
  		 * to work on.
  		 */
  		if (write_cache_as_tree(head, 0, NULL))
 -			return error (_("Your index file is unmerged."));
 +			return error(_("Your index file is unmerged."));
  	} else {
  		unborn = get_sha1("HEAD", head);
  		if (unborn)
 @@ -756,8 +756,8 @@ static int read_populate_todo(struct commit_list **todo_list,
  
  	fd = open(git_path_todo_file(), O_RDONLY);
  	if (fd < 0)
 -		return error(_("Could not open %s (%s)"),
 -			git_path_todo_file(), strerror(errno));
 +		return error_errno(_("Could not open %s"),
 +				   git_path_todo_file());
  	if (strbuf_read(&buf, fd, 0) < 0) {
  		close(fd);
  		strbuf_release(&buf);
 @@ -841,8 +841,8 @@ static int create_seq_dir(void)
  		return -1;
  	}
  	else if (mkdir(git_path_seq_dir(), 0777) < 0)
 -		return error(_("Could not create sequencer directory %s (%s)"),
 -			  git_path_seq_dir(), strerror(errno));
 +		return error_errno(_("Could not create sequencer directory %s"),
 +				   git_path_seq_dir());
  	return 0;
  }
  
 @@ -941,8 +941,10 @@ static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
  	if (fd < 0)
  		return error_errno(_("Could not lock '%s'"),
  				   git_path_todo_file());
 -	if (format_todo(&buf, todo_list, opts) < 0)
 +	if (format_todo(&buf, todo_list, opts) < 0) {
 +		strbuf_release(&buf);
  		return error(_("Could not format %s."), git_path_todo_file());
 +	}
  	if (write_in_full(fd, buf.buf, buf.len) < 0) {
  		strbuf_release(&buf);
  		return error_errno(_("Could not write to %s"),

-- 
2.10.0.rc1.99.gcd66998

base-commit: 5cb0d5ad05e027cbddcb0a3c7518ddeea0f7c286
