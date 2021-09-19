Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BBC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF50460F92
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 02:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhISCV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 22:21:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:50540 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhISCV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 22:21:27 -0400
Received: (qmail 17791 invoked by uid 109); 19 Sep 2021 02:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Sep 2021 02:20:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3264 invoked by uid 111); 19 Sep 2021 02:20:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Sep 2021 22:20:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 18 Sep 2021 22:20:02 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUaeUuX7aoXtS3jQ@coredump.intra.peff.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local>
 <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
 <CAPig+cSSxgVU47wCNpcW2HTwCA60e1oZ6Yzkb5i-W2HDijq+MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSSxgVU47wCNpcW2HTwCA60e1oZ6Yzkb5i-W2HDijq+MQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 09:02:37PM -0400, Eric Sunshine wrote:

> On Sat, Sep 18, 2021 at 6:05 PM Jeff King <peff@peff.net> wrote:
> > Swapping out the "printf >expect" for a here-doc might make it a bit
> > more readable. I used printf because of the tab handling, but:
> >
> >   tab=$(printf "\t")
> >   cat >expect <<-EOF
> >   ref: ${dst}${tab}HEAD
> >   ${oid}${tab}HEAD
> >   EOF
> >
> > isn't too bad.
> 
> Or just use q_to_tab():
> 
>     q_to_tab >expect <<-EOF
>     ref: ${dst}QHEAD
>     ${oid}QHEAD
>     EOF
> 
> However, the typical use-case for q_to_tab() is when we need a leading
> or trailing TAB character.

Ah, yeah, I forgot we had that. I _thought_ we had a variable ($HT or
something) for this, but it looks like we only define and use it in a
few scripts.

I'm not sure using q_to_tab() is all that readable here, because it
blends into the HEAD token.

> When TAB is embedded within the line, we
> often just use a literal TAB character; indeed, many tests in the
> suite do exactly that, so that would be an even simpler option.

Yeah, that'd probably be OK. I usually shy away from embedded tabs
because they can cause confusion in editors. But we have them already,
and this kind of expected output is not touched all that often.

-Peff
