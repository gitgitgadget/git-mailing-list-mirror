Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176DD1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDDSgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:36:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53446 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751296AbeDDSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:36:23 -0400
Received: (qmail 16038 invoked by uid 109); 4 Apr 2018 18:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 18:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6852 invoked by uid 111); 4 Apr 2018 18:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 14:37:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 14:36:20 -0400
Date:   Wed, 4 Apr 2018 14:36:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: commit -> public-inbox link helper
Message-ID: <20180404183620.GC9055@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 06:35:59PM +0200, Johannes Schindelin wrote:

> Hi team,
> 
> I found myself in dear need to quickly look up mails in the public-inbox
> mail archive corresponding to any given commit in git.git. Some time ago,
> I wrote a shell script to help me with that, and I found myself using it a
> couple of times, so I think it might be useful for others, too.
> 
> This script (I call it lookup-commit.sh) needs to be dropped into a *bare*
> clone of http://public-inbox.org/git, and called with its absolute or
> relative path from a git.git worktree, e.g.
> 
> 	~/public-inbox-git.git/lookup-commit.sh \
> 		fea16b47b603e7e4fa7fca198bd49229c0e5da3d
> 
> This will take a while initially, or when the `master` branch of the
> public-inbox mirror was updated, as it will generate two files with
> plain-text mappings.

Junio publishes a git-notes ref with the mapping you want. So you can
do:

  git fetch git://github.com/gitster/git.git refs/notes/amlog:refs/notes/amlog
  mid=$(git notes --ref amlog show $commit | perl -lne '/<(.*)>/ and print $1')
  echo "https://public-inbox.org/git/$mid"

without having to download the gigantic list archive repo at all (though
I do keep my own copy of the archive and index it with mairix, so I can
use "mairix -t m:$mid" and then view the whole thing locally in mutt).

-Peff
