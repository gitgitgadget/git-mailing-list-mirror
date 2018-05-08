Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0309F200B9
	for <e@80x24.org>; Tue,  8 May 2018 14:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeEHOeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 10:34:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755133AbeEHOeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 10:34:11 -0400
Received: (qmail 2788 invoked by uid 109); 8 May 2018 14:34:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 14:34:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5419 invoked by uid 111); 8 May 2018 14:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 10:34:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 10:34:09 -0400
Date:   Tue, 8 May 2018 10:34:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be
 tree, not treeish
Message-ID: <20180508143408.GA30183@sigill.intra.peff.net>
References: <20180501184016.15061-1-avarab@gmail.com>
 <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-10-avarab@gmail.com>
 <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
 <87wowlxko8.fsf@evledraar.gmail.com>
 <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
 <87lgczyfq6.fsf@evledraar.gmail.com>
 <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 01:08:46PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Right, and I'm with you so far, this makes sense to me for all existing
> > uses of the peel syntax, otherwise v2.17.0^{tree} wouldn't be the same
> > as rev-parse v2.17.0^{tree}^{tree}...
> 
> More importantly, you could spell v2.17.0 part of the above with a
> short hexadecimal string.  And that string should be naming some
> tree-ish, the most important thing being that it is *NOT* required
> to be a tree (and practically, it is likely that the user has a
> tree-ish that is *NOT* a tree).
> 
> I guess I have a reaction to the title
> 
>     "get_short_oid/peel_onion: ^{tree} should be tree"
> 
> "X^{tree}" should *RESULT* in a tree, but it should *REQUIRE* X to
> be a tree-ish.  It is unclear "should be tree" is about the former
> and I read (perhaps mis-read) it as saying "it should require X to
> be a tree"---that statement is utterly incorrect as we agreed above.

FWIW, I had the same feeling as you when reading this, that this commit
(and the one after) are doing the wrong thing. And these paragraphs sum
it up. The "^{tree}" is about asking us to peel to a tree, not about
resolving X in the first place. We can use it as a _hint_ when resolving
X, but the correct hint is "something that can be peeled to a tree", not
"is definitely a tree".

-Peff
