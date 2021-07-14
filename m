Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7958DC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C6661289
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhGNBSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:18:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:48734 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237198AbhGNBSy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:18:54 -0400
Received: (qmail 15949 invoked by uid 109); 14 Jul 2021 01:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 01:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18169 invoked by uid 111); 14 Jul 2021 01:16:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 21:16:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 21:16:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] tests: replace remaining packetize() with
 "test-tool pkt-line"
Message-ID: <YO460pigGesWU/5H@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-4.5-a44e1790f2a-20210712T164208Z-avarab@gmail.com>
 <YO3+dBHL5ZBe/NbU@coredump.intra.peff.net>
 <8735sh3h09.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735sh3h09.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:52:09AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I.e.:
> >
> >   {
> >           printf "git-upload-pack /interp.git\n\0host=localhost" |
> > 	  test-tool pkt-line pack-raw-stdin &&
> > 	  printf "0000" | test-tool pkt-line pack
> >   } >input
> >
> > (again here the packing of "0000" is pointless, but I'm OK with it for
> > consistency).
> 
> Sure, I can use {} blocks, but re the reply on 3/5 about "0000"
> v.s. "0000\n" you'd like to move back to print not-a-newline here
> v.s. having the helper eat lines ending with \n like everywhere else?
> 
> It's not incorrect in this case, it just seems less obvious to
> me. I.e. the printf in the former case is because we explicitly care
> about the exact raw input, if there's a trailing \n or not, in the
> latter case we don't, so I think it's clearier to use the usual <<-\EOF
> pattern rather than printf.

I don't think it's incorrect in any of the cases. I was just noting that
"printf 0000" is fewer characters and fewer processes than either piping
to pkt-line or using a here-doc.

I don't feel strongly on using it if you want to keep things consistent
between the tests. Nor on using a here-doc versus piping (I don't see
any problem with switching between them based on which is shorter or
more readable in any given instance; if you're piping, it could also be
"echo").

-Peff
