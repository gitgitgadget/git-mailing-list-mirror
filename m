Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128881F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcF3JGW (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:06:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:38248 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751911AbcF3JGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:06:18 -0400
Received: (qmail 31393 invoked by uid 102); 30 Jun 2016 09:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:06:19 -0400
Received: (qmail 6606 invoked by uid 107); 30 Jun 2016 09:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:06:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:06:14 -0400
Date:	Thu, 30 Jun 2016 05:06:14 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/5] friendlier handling of overflows in archive-tar
Message-ID: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a re-roll of the jk/big-and-future-archive-tar topic. It
addresses all but one of the review comments, and I hope should be
pretty polished.

The changes are:

  - the dependency on bunzip2 is dropped; instead, we just provide a
    partial object for the 64GB blob. See the first commit message for
    details.

  - the portable "head -c" replacement from t9300 has been factored out,
    and we use it in the new tests

  - symbolic constants for the giant octal numbers (with a comment
    warning that the values are set by posix)

  - the comments for tar_info() and the lazy-prereq were split so the
    two aren't mashed together

  - uses awk in tar_info() instead of "sed | cut"

  - extra simplification in the final commit, as suggested by review

  - typo and awkwardness fixes in the commit messages

The one thing that isn't fixed is the use of "141" to test for sigpipe
death. That should use test_match_signal, but that topic just got
re-rolled, too.

  [1/5]: t9300: factor out portable "head -c" replacement
  [2/5]: t5000: test tar files that overflow ustar headers
  [3/5]: archive-tar: write extended headers for file sizes >= 8GB
  [4/5]: archive-tar: write extended headers for far-future mtime
  [5/5]: archive-tar: drop return value

-Peff
