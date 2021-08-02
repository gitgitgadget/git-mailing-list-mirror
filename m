Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1BC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06866100A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhHBQRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:17:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:35652 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232215AbhHBQRV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:17:21 -0400
Received: (qmail 29265 invoked by uid 109); 2 Aug 2021 16:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Aug 2021 16:17:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1646 invoked by uid 111); 2 Aug 2021 16:17:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Aug 2021 12:17:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Aug 2021 12:17:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     heapcrash heapcrash <heapcrash@gmail.com>, git@vger.kernel.org
Subject: Re: Enhancing --show-function and --function-context in default
 configurations
Message-ID: <YQgahVPT8g0+U1B3@coredump.intra.peff.net>
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
 <875ywoqldr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875ywoqldr.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 02, 2021 at 10:45:25AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I would like to see us have a setting to turn these on by default, but
> think it would be better to make that a diff.* config setting to put
> into ~/.gitconfig, i.e. we'd extend git itself to know about a list of
> extensions for the given userdiff drivers, and use them when rendering
> diffs.

A long time ago we discussed doing this. The relevant thread is:

  https://lore.kernel.org/git/20111216110000.GA15676@sigill.intra.peff.net/

which references a few others:

  https://lore.kernel.org/git/4E569F10.8060808@panasas.com/

  https://lore.kernel.org/git/4E6E928A.6080003@sunshineco.com/

From my re-read of the threads, it seemed like people were mostly on
board with the idea, but:

  - there was some question about a few of the more obscure extensions
    (e.g., '.m' as objective-c versus matlab). Obviously we could drop
    any contentious ones, though I do wonder if this is simply opening
    up a can of worms where people will fight about what ought to go
    into the "official" list.

  - there was some question over whether some of our builtin funcname
    regexps were actually worse than the default behavior (especially
    the "cpp" one). In response we started using .gitattributes more
    heavily within git.git itself, and we've seen quite a few
    improvements in the intervening decade.

    So hopefully there is no reason anybody would _not_ want the
    content-specific driver to kick in, assuming that the extension
    mapping is accurate. There should be no security risk or anything
    like that, since we'd already respect such a mapping from an
    untrusted repository via its .gitattributes file.

It looks like Junio picked up the patch at one point, but it got bumped
to the next release cycle. It was marked as "expecting a re-roll" until
finally getting discarded in Oct 2011; you can see the progression
by searching for "jk/default-attr":

  https://lore.kernel.org/git/?q=jk%2Fdefault-attr

Then in Dec 2011 I posted that re-roll (the top link I gave above), and
it looks like it never got picked up.  I don't see any conclusions
either way in the thread, so I think it just kind of died out due to
lack of anybody pushing it forward (and I don't remember making a
decision either way on that; it may have been the "can of worms" thing
above scaring me off).

-Peff
