Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AF720989
	for <e@80x24.org>; Tue, 11 Oct 2016 02:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbcJKCmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 22:42:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbcJKCmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 22:42:07 -0400
Received: (qmail 5186 invoked by uid 109); 11 Oct 2016 02:42:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 02:42:07 +0000
Received: (qmail 4734 invoked by uid 111); 11 Oct 2016 02:42:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 22:42:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 22:42:04 -0400
Date:   Mon, 10 Oct 2016 22:42:04 -0400
From:   Jeff King <peff@peff.net>
To:     Octavio Alvarez <alvarezp@alvarezp.ods.org>
Cc:     git@vger.kernel.org
Subject: Re: Invisible file remove during merge
Message-ID: <20161011024204.dg756vuej4rvg4tl@sigill.intra.peff.net>
References: <d7e42701-363b-70a4-8eb0-da4715cd9ba5@alvarezp.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7e42701-363b-70a4-8eb0-da4715cd9ba5@alvarezp.ods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 06:04:26PM -0700, Octavio Alvarez wrote:

> If I do a "git rm file" during conflict resolution, the removed file
> (mysterious-file.txt) does not show up on "git log --stat" nor "git show
> --patch" for the merge commit.

"git log" does not do merge diffs by default; you need to pass one of
"--cc", "-c", or "-m".

"git show" will do "--cc" by default. Any file that is the same in the
merge result and _any_ of the branches is considered uninteresting here,
and that is what happened in your example. One parent had the file, the
other did not, and you deleted it to match the second parent.

See the "Combined Diff" section of "git help log" for more details.

When debugging merge resolutions, I often find it useful to use "-m",
which diffs separately against _each_ parent (though it is often tedious
to pick through the uninteresting bits, which is why "-c" and "--cc"
were invented in the first place).

> "git log --all --stat --follow -- mysterious-file.txt" only shows the
> commit where the file was added.

Try that with "-m", which will show the merge in question (and another,
more boring merge, which hopefully shows why "-m" is not the default).

-Peff
