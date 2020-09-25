Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44E5C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6656B221EB
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgIYHBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:01:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:40406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYHBV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:01:21 -0400
Received: (qmail 13138 invoked by uid 109); 25 Sep 2020 07:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15891 invoked by uid 111); 25 Sep 2020 07:01:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:01:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:01:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/8] parsing trailers with shortlog
Message-ID: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somebody mentioned at the inclusion summit that it would be nice for
mentoring/pairing relationships if we could more easily give credit to
multiple authors of a commit. When people ask about adding multiple
"author" headers, we usually recommend that they use a "co-authored-by"
trailer. But you can't convince shortlog to count it for anything. :)

So this series adds support for counting trailers to shortlog. You can
do a number of fun things with it, like:

    # credit reviewers
    git shortlog -ns --group=trailer:reviewed-by

    # credit authors and co-authors equally
    git shortlog -ns --group=author \
                     --group=trailer:co-authored-by

    # see who helps whom
    git shortlog --format="...helped %an on %as" \
                 --group=trailer:helped-by

If some of this looks familiar, it's because I sent the early patches
years ago. But I won't even bother linking to it; I cleaned up quite a
few rough edges since then, so it's not really worth looking at.

  [1/8]: shortlog: change "author" variables to "ident"
  [2/8]: shortlog: refactor committer/author grouping
  [3/8]: trailer: add interface for iterating over commit trailers
  [4/8]: shortlog: match commit trailers with --group
  [5/8]: shortlog: de-duplicate trailer values
  [6/8]: shortlog: rename parse_stdin_ident()
  [7/8]: shortlog: parse trailer idents
  [8/8]: shortlog: allow multiple groups to be specified

 Documentation/git-shortlog.txt |  29 +++++
 builtin/log.c                  |   1 +
 builtin/shortlog.c             | 218 +++++++++++++++++++++++++++++----
 shortlog.h                     |   8 +-
 t/t4201-shortlog.sh            | 141 +++++++++++++++++++++
 trailer.c                      |  36 ++++++
 trailer.h                      |  44 ++++++-
 7 files changed, 447 insertions(+), 30 deletions(-)

-Peff
