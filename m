Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDE61F731
	for <e@80x24.org>; Tue,  6 Aug 2019 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfHFOib (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 10:38:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731166AbfHFOib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 10:38:31 -0400
Received: (qmail 17827 invoked by uid 109); 6 Aug 2019 14:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 14:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2356 invoked by uid 111); 6 Aug 2019 14:40:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 10:40:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 10:38:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] --end-of-options marker
Message-ID: <20190806143829.GA515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's hard for scripted uses of rev-list, etc, to avoid option injection
from untrusted arguments, because revision arguments must come before
any "--" separator. I.e.:

  git rev-list "$revision" -- "$path"

might mistake "$revision" for an option (with rev-list, that would make
it an error, but something like git-log would default to HEAD).

This series provides an alternative to "--" to stop option parsing
without indicating that further arguments are pathspecs.

  [1/3]: revision: allow --end-of-options to end option parsing
  [2/3]: parse-options: allow --end-of-options as a synonym for "--"
  [3/3]: gitcli: document --end-of-options

 Documentation/gitcli.txt | 6 ++++++
 parse-options.c          | 3 ++-
 revision.c               | 8 +++++++-
 t/t0040-parse-options.sh | 7 +++++++
 t/t4202-log.sh           | 7 +++++++
 t/t6000-rev-list-misc.sh | 8 ++++++++
 6 files changed, 37 insertions(+), 2 deletions(-)

