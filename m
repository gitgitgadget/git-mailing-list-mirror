Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B5D1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbcHALnO (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:43:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:56255 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbcHALnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:43:12 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MTjMy-1bucLj4BYO-00QUEw; Mon, 01 Aug 2016 13:36:12
 +0200
Date:	Mon, 1 Aug 2016 13:36:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 00/16] Use merge_recursive() directly in the builtin am
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9WcovgPppZkItlckluAFpjc5hbLoZcb0/vYvsxYTcskaQTlGdwa
 L+Thxc2zMH/UvBIXP5iaDi1iV/JmOajnvE2+UIiVXzvqhQrNIdyBuIwOt3ev+D9+cOJCeo6
 ODniQ1+JHl8mL5HPtiHh5XXqjzA4BepKZqDF387ClY58sSW7rOxjoA22J2/2r5FJ8Hcwt6s
 Rnhio7k2UHICksQgRRTrQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:q7nxfWM/Kn4=:vTT7fp01sDb7iEy4VVlw6S
 trFvkAcKpEBR0BILsE6SZVjxZcaJBpoqLYPlDsA/Mm0fG/tADoyRzn6/EzvXmaOwgMWV5gpzD
 6D2UfWAEEPZgMzWi4bMWhgtKshDjb2ucACeHU1SytN21gVYBigM9hgYdCFCmRKKVMpGXskiwE
 vUeDh2Wz8I90CEWjJ1Itvi08tvQ9HYMRU5srPximJi6KCqp2/F9tNbqBOsWtGYxgFpJdrh6FH
 gBJ/KO/vwKLqOYkcHlnamy1OHWm0LHYlBufq8kJbcCxs+6pbjwfl7cgbAAajymJ3F2wKkPE72
 0ir8l60qCdcF8uHb2PXiQm76QEhq6uXRxONWpWXaGgMDQTFH/tPlfo9dhTIlJDyVuuT5qLmwP
 aNLfrRpgyh/W9rB2Gl7DxaFRMVkmtVlFLJThmxj5SIqfvtTKOM1A/2hTSd2eZD3ZEBmna9r37
 81PW+I9dxsX4cqoprr/XKPLAgJnwTFT5uDz4XOdDCHqO0UTla3xkjYIp3K6dcwrfvx+g/u9Bw
 2ZKjIL75TOsbVVb+0nMpQoD20jekEXX7Zdrvm+WTb1vVIBxtHEyRAFv42eJFUnxSq+qaYqcxu
 CAo+rgMt7E9GnQvR/7f+plyYPGKrf9IcqzW9dNNjaok+1emlslyfBdeDKd5Bgg/xsbgwW9rrD
 zucslZYNFM2C9iVeNgqMQD64LNbKyb0TlgcEKd2ODtPbe/ft3uaMRlnlu55LUP/aKhFrRkvvc
 By6/amGqNWqlF36Czr+GkmCS5wvISIrP8Dvpd14PmwOO3d113+6zPtnNecE9A7ms3QOSwV3O1
 vXRMBm4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the sixth iteration of the long-awaited re-roll of the attempt to
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

The changes relative to the fifth iteration of this patch series:

- the commit message that talked about swallowing messages was improved

- the va_start()/va_end() statements were moved closer to the vararg usage

- the `buffer_output` field is no longer a bit field because it is now
  logically more like the verbosity level, which we traditionally keep
  as a full `int`

- the flush_output() call is no longer moved, but instead added to the
  code path when we return early

- the commit message saying that we speculated about stdout's buffer
  size now instead states that we made an assumption

This patch series touches rather important code. I appreciate thorough
reviews with a focus on the critical parts of the code, those that could
result in regressions.


Johannes Schindelin (16):
  t5520: verify that `pull --rebase` shows the helpful advice when
    failing
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
 imap-send.c            |   2 +-
 merge-recursive.c      | 578 +++++++++++++++++++++++++++++--------------------
 merge-recursive.h      |   2 +-
 sequencer.c            |   5 +
 sha1_file.c            |   4 +-
 t/t5520-pull.sh        |  32 +++
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 15 files changed, 419 insertions(+), 294 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v6
Interdiff vs v5:

 diff --git a/merge-recursive.c b/merge-recursive.c
 index 66e93e0..c9e4dbc 100644
 --- a/merge-recursive.c
 +++ b/merge-recursive.c
 @@ -35,21 +35,21 @@ static int err(struct merge_options *o, const char *err, ...)
  {
  	va_list params;
  
 -	va_start(params, err);
  	if (o->buffer_output < 2)
  		flush_output(o);
  	else {
  		strbuf_complete(&o->obuf, '\n');
  		strbuf_addstr(&o->obuf, "error: ");
  	}
 +	va_start(params, err);
  	strbuf_vaddf(&o->obuf, err, params);
 +	va_end(params);
  	if (o->buffer_output > 1)
  		strbuf_addch(&o->obuf, '\n');
  	else {
  		error("%s", o->obuf.buf);
  		strbuf_reset(&o->obuf);
  	}
 -	va_end(params);
  
  	return -1;
  }
 @@ -2069,16 +2069,18 @@ int merge_recursive(struct merge_options *o,
  	o->ancestor = "merged common ancestors";
  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
  			    &mrtree);
 -	flush_output(o);
 -	if (clean < 0)
 +	if (clean < 0) {
 +		flush_output(o);
  		return clean;
 +	}
  
  	if (o->call_depth) {
  		*result = make_virtual_commit(mrtree, "merged tree");
  		commit_list_insert(h1, &(*result)->parents);
  		commit_list_insert(h2, &(*result)->parents->next);
  	}
 -	if (o->buffer_output < 2)
 +	flush_output(o);
 +	if (!o->call_depth && o->buffer_output < 2)
  		strbuf_release(&o->obuf);
  	if (show(o, 2))
  		diff_warn_rename_limit("merge.renamelimit",
 diff --git a/merge-recursive.h b/merge-recursive.h
 index 340704c..735343b 100644
 --- a/merge-recursive.h
 +++ b/merge-recursive.h
 @@ -13,7 +13,7 @@ struct merge_options {
  		MERGE_RECURSIVE_THEIRS
  	} recursive_variant;
  	const char *subtree_shift;
 -	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
 +	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
  	unsigned renormalize : 1;
  	long xdl_opts;
  	int verbosity;

-- 
2.9.0.281.g286a8d9

base-commit: f8f7adce9fc50a11a764d57815602dcb818d1816
