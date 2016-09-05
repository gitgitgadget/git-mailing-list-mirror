Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3834B20705
	for <e@80x24.org>; Mon,  5 Sep 2016 23:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbcIEXwM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 19:52:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:38527 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751245AbcIEXwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 19:52:11 -0400
Received: (qmail 15480 invoked by uid 109); 5 Sep 2016 23:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 23:52:10 +0000
Received: (qmail 22887 invoked by uid 111); 5 Sep 2016 23:52:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 19:52:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 19:52:08 -0400
Date:   Mon, 5 Sep 2016 19:52:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     Aaron M Watson <watsona4@gmail.com>, Git <git@vger.kernel.org>,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
Message-ID: <20160905235207.jkxmnrwoc6lllomk@sigill.intra.peff.net>
References: <1472944878.19860.4.camel@gmail.com>
 <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
 <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 11:46:34PM +0200, Øystein Walle wrote:

> The bash-specific code is a no-go, so here's a way to do it in a way
> that I think is in line with Git's code style for shell scripts. I took
> the liberty of removing the '|| exit 1' since the rev is verified later
> on anyway, as can be seen in the last piece of context. That way the
> argument munging can be done at a later stage where we don't have to
> loop over multiple ones. The first rev-parse's purpose is just to apply
> --sq.

I wondered how that would impact the error message when there is no such
stash. It looks like rev-parse will still return the bogus name on
stdout, so we do not run afoul of the "No stash found" code path. We do
get:

  $ git.compile stash show foobar
  foobar is not a valid reference

instead of:

  $ git stash show foobar
  fatal: ambiguous argument 'foobar': unknown revision or path not in
  the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

But I do not see that as a big downside (I might even call it an
improvement).

-Peff
