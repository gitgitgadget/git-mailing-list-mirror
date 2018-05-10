Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F511F42D
	for <e@80x24.org>; Thu, 10 May 2018 06:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756572AbeEJGuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:50:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:34414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753497AbeEJGuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:50:11 -0400
Received: (qmail 21626 invoked by uid 109); 10 May 2018 06:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 06:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21053 invoked by uid 111); 10 May 2018 06:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 02:50:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 02:50:09 -0400
Date:   Thu, 10 May 2018 02:50:09 -0400
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
Message-ID: <20180510065009.GB31779@sigill.intra.peff.net>
References: <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
 <87wowlxko8.fsf@evledraar.gmail.com>
 <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
 <87lgczyfq6.fsf@evledraar.gmail.com>
 <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
 <20180508143408.GA30183@sigill.intra.peff.net>
 <87a7tax9m1.fsf@evledraar.gmail.com>
 <20180509075632.GA3327@sigill.intra.peff.net>
 <878t8txfyf.fsf@evledraar.gmail.com>
 <xmqqa7t8kuo0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7t8kuo0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 01:21:19PM +0900, Junio C Hamano wrote:

> When diagnosing such an error, we would give hints.  The hint would
> show possible objects that the user could have meant with X.  The
> ^{<type>} suffix given to it may be used to limit the hints to
> subset of the objects that the user could have meant with X;
> e.g. when there is an object of each of type blob, tree, commit, and
> tag, whose name begins with 7777, the short and ambiguous prefix
> 7777 could mean any of these four objects, but when given with
> suffix, e.g. 7777^{tree}, it makes useless for the hint to include
> the blob object, as it can never peel down to a tree object.
> 
> If the tag whose name begins with 7777 in this example points
> directly to a blob, excluding that tag from the hint would make the
> hint more useful.  I do not offhand know what the code does right
> now.  I wouldn't call it a bug if such a tag is included in the
> hint, but if a change stops such a tag from getting included, I
> would call such a change an improvement.

I actually wondered this while writing an earlier response, and so I
happen to know: when we are looking for a treeish, the disambiguator
will actually peel a candidate tag and only accept one that peels to a
tree or commit. So we would omit the tag-to-blob entirely from
consideration (both as a candidate for ambiguity, and in the hint list).

-Peff
