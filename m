Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FEBC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3CC420789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgI3M1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:27:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45276 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3M1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:27:33 -0400
Received: (qmail 23878 invoked by uid 109); 30 Sep 2020 12:27:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:27:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27865 invoked by uid 111); 30 Sep 2020 12:27:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:27:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:27:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/10] dropping more unused parameters
Message-ID: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the last of my series of patches to drop (or use) unused
function parameters. I've been holding on to some of these for almost 2
years, because I wanted to make sure they weren't actually bugs
(dropping unused parameters can never _introduce_ a bug, but it's a good
opportunity to investigate whether the parameter _should_ have been
used). I'm still not entirely convinced that patch 10 isn't actually a
bug, but I wasn't able to puzzle it out either way, and it didn't seem
worth holding up the topic any longer.

After this lands, I have a follow-on series that annotates cases where
we can't drop parameters (e.g., functions which have to conform to a
callback interface, but don't care about some of the parameters). And
then after that we can flip on -Wunused-parameters going forward. Which
I think is worth doing, as it has found some bugs (fixed in earlier
series).

  [01/10]: convert: drop unused crlf_action from check_global_conv_flags_eol()
  [02/10]: drop unused argc parameters
  [03/10]: env--helper: write to opt->value in parseopt helper
  [04/10]: assert PARSE_OPT_NONEG in parse-options callbacks
  [05/10]: push: drop unused repo argument to do_push()
  [06/10]: sequencer: drop repository argument from run_git_commit()
  [07/10]: sparse-checkout: fill in some options boilerplate
  [08/10]: test-advise: check argument count with argc instead of argv
  [09/10]: sequencer: handle ignore_footer when parsing trailers
  [10/10]: dir.c: drop unused "untracked" from treat_path_fast()

 builtin/add.c                                |  4 +--
 builtin/am.c                                 |  2 ++
 builtin/commit-graph.c                       |  2 ++
 builtin/commit.c                             | 12 +++----
 builtin/env--helper.c                        | 13 ++++---
 builtin/push.c                               |  4 +--
 builtin/sparse-checkout.c                    | 37 ++++++++++++++++++++
 commit.h                                     |  2 +-
 convert.c                                    |  4 +--
 dir.c                                        |  3 +-
 parse-options-cb.c                           |  2 ++
 revision.c                                   |  6 ++--
 sequencer.c                                  | 20 +++++++----
 t/helper/test-advise.c                       |  4 +--
 t/helper/test-submodule-nested-repo-config.c |  6 ++--
 15 files changed, 88 insertions(+), 33 deletions(-)

-Peff
