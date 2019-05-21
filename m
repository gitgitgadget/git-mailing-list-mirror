Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F029120380
	for <e@80x24.org>; Tue, 21 May 2019 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfEUU6J (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 16:58:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:35348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727136AbfEUU6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 16:58:08 -0400
Received: (qmail 531 invoked by uid 109); 21 May 2019 20:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 May 2019 20:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17137 invoked by uid 111); 21 May 2019 20:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 May 2019 16:58:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 May 2019 16:58:06 -0400
Date:   Tue, 21 May 2019 16:58:06 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Antonio Ospite <ao2@ao2.it>,
        Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repository.c: always allocate 'index' at repo init time
Message-ID: <20190521205806.GA14807@sigill.intra.peff.net>
References: <xmqqftpf5g3d.fsf@gitster-ct.c.googlers.com>
 <20190519025636.24819-1-pclouds@gmail.com>
 <20190520131702.GB13474@sigill.intra.peff.net>
 <CACsJy8CoauTdJ1huU=w2YNbw53iea5U304yAu2oCUuTvFRaV7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CoauTdJ1huU=w2YNbw53iea5U304yAu2oCUuTvFRaV7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 05:34:02PM +0700, Duy Nguyen wrote:

> >   2. There are hundreds of spots that need to swap out "repo->index" for
> >      "&repo->index". In the patch below I just did enough to compile
> >      archive-zip.o, to illustrate. :)
> 
> You are more thorough than me. I saw #2 first and immediately backed
> off (partly for a selfish reason: I have plenty of the_repo conversion
> patches in queue and anything touching "repo" may delay those patches
> even more).

Yeah, that's true, it would be disruptive.

> There's also #3 but this one is minor. So far 'struct repo' is more of
> a glue of things. Embedding index_state in it while leaving
> object_store, ref_store... pointers feels inconsistent and a bit
> weird. It's not a strong reason for making index_state a pointer too,
> but if we have to deal with pointers anyway...

And yeah, I agree it would nice for it to all be consistent. Let's leave
it at your patch for now, and we can think about refactoring this later.

-Peff
