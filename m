Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECF020323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdCPO0y (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:26:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45106 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdCPO0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:26:53 -0400
Received: (qmail 4618 invoked by uid 109); 16 Mar 2017 14:26:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:26:50 +0000
Received: (qmail 15435 invoked by uid 111); 16 Mar 2017 14:27:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:26:47 -0400
Date:   Thu, 16 Mar 2017 10:26:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] minor pack-name cleanups
Message-ID: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of the series from:

  http://public-inbox.org/git/20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net/

The general gist is the same, but there are a number of changes:

  - I dropped the first patch factoring out finalize_file(), as Ramsay
    pointed out a subtle difference between the index and pack handling.

  - I added an extra patch on top (5/5 here) to get the same
    pointer-aliasing safety that the factored-out function got us
    (more so, actually, as it protects keep_msg, too).

  - I re-ordered the odb_pack_keep() cleanup before the odb_pack_name()
    cleanups, which lets us do the latter in one swoop (and avoids
    explaining "well, we can't do .keep yet, because..." in the commit
    message)

  - The original had two patches doing the odb_pack_name() conversion.
    Now that it has fewer caveats, I felt comfortable lumping it all
    into one (patch 4/5 here).

  [1/5]: move odb_* declarations out of git-compat-util.h
  [2/5]: sha1_file.c: make pack-name helper globally accessible
  [3/5]: odb_pack_keep(): stop generating keepfile name
  [4/5]: replace snprintf with odb_pack_name()
  [5/5]: index-pack: make pointer-alias fallbacks safer

 builtin/index-pack.c | 31 +++++++++++++++----------------
 cache.h              | 21 +++++++++++++++++++++
 environment.c        |  6 ++----
 fast-import.c        | 26 +++++++++++++-------------
 git-compat-util.h    |  2 --
 sha1_file.c          | 17 ++++++-----------
 6 files changed, 57 insertions(+), 46 deletions(-)

