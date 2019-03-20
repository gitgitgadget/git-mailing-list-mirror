Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79ED320248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCTINB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:13:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727555AbfCTINB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:13:01 -0400
Received: (qmail 19559 invoked by uid 109); 20 Mar 2019 08:13:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:13:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6220 invoked by uid 111); 20 Mar 2019 08:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:13:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:12:58 -0400
Date:   Wed, 20 Mar 2019 04:12:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/13] more unused parameter cleanups
Message-ID: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another round of -Wunused-parameter cleanups. Previous rounds
were at [1] and [2]. As before, these are mostly just removals, so it's
easy to see there's no behavior change (there are a couple of cleanups
that ride along, though, so watch for those).

There are two minor conflicts when merging with pu:

  - jt/fetch-cdn-offload tweaked the "pack_lockfile" parameter to
    fetch_pack(). A few other parameters are dropped in this series.
    The textual resolution is pretty straightforward.

  - ps/stash-in-c (et al) added a new call to report_path_error() in
    builtin/stash.c, which here loses its redundant "prefix" parameter.
    There's no textual conflict, but the new call needs to drop its
    final NULL parameter in order to compile.

[1] https://public-inbox.org/git/20190214054736.GA20091@sigill.intra.peff.net/
[2] https://public-inbox.org/git/20190124131104.GA24017@sigill.intra.peff.net/

The patches are:

  [01/13]: revision: drop some unused "revs" parameters
  [02/13]: log: drop unused rev_info from early output
  [03/13]: log: drop unused "len" from show_tagger()
  [04/13]: update-index: drop unused prefix_length parameter from do_reupdate()
  [05/13]: test-date: drop unused "now" parameter from parse_dates()
  [06/13]: unpack-trees: drop name_entry from traverse_by_cache_tree()
  [07/13]: unpack-trees: drop unused error_type parameters
  [08/13]: report_path_error(): drop unused prefix parameter
  [09/13]: fetch_pack(): drop unused parameters
  [10/13]: parse-options: drop unused ctx parameter from show_gitcomp()
  [11/13]: pretty: drop unused "type" parameter in needs_rfc2047_encoding()
  [12/13]: pretty: drop unused strbuf from parse_padding_placeholder()
  [13/13]: parse_opt_ref_sorting: always use with NONEG flag

 builtin/branch.c            |  3 +--
 builtin/checkout.c          |  2 +-
 builtin/commit.c            |  6 +++---
 builtin/fetch-pack.c        |  2 +-
 builtin/for-each-ref.c      |  3 +--
 builtin/log.c               | 18 +++++++++---------
 builtin/ls-files.c          |  2 +-
 builtin/ls-remote.c         |  3 +--
 builtin/submodule--helper.c |  2 +-
 builtin/tag.c               |  3 +--
 builtin/update-index.c      |  5 ++---
 dir.c                       |  3 +--
 dir.h                       |  2 +-
 fetch-pack.c                |  3 +--
 fetch-pack.h                |  3 +--
 parse-options.c             |  5 ++---
 pretty.c                    | 12 +++++-------
 ref-filter.c                |  9 +++++++--
 ref-filter.h                |  5 +++++
 revision.c                  | 12 ++++++------
 t/helper/test-date.c        |  4 ++--
 transport.c                 | 10 ++++------
 unpack-trees.c              |  9 +++------
 23 files changed, 60 insertions(+), 66 deletions(-)

-Peff
