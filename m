Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920F5C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE5061249
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhGLTt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:49:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:46950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbhGLTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:49:56 -0400
Received: (qmail 21274 invoked by uid 109); 12 Jul 2021 19:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 19:47:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9544 invoked by uid 111); 12 Jul 2021 19:47:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 15:47:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 15:47:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YOycOlyqwwWZJ6rH@coredump.intra.peff.net>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
 <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
 <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
 <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
 <xmqqim1f5pz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim1f5pz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 11:47:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think fully-qualifying refs is a complete solution, though. The
> > common use case for --end-of-options is that you're passing along names
> > from somewhere else, and you don't know how to qualify them. E.g., in:
> >
> >   git rev-list --end-of-options "$rev" --
> >
> > you need to behave differently if you got "1234abcd" versus "foo" versus
> > "refs/heads/foo".
> 
> I suspect that you can prefix "^^" unconditionally, just like --not
> can be emulated away by unconditionally prefixing "^".

That would be clever, but I think we only parse a single "^":

  $ git rev-list ^HEAD
  [no output]
  $ git rev-list ^^HEAD
  fatal: bad revision '^^HEAD'

  $ git rev-parse ^HEAD
  ^d486ca60a51c9cb1fe068803c3f540724e95e83a
  $ git rev-parse ^^HEAD
  ^^HEAD
  fatal: ambiguous argument '^^HEAD': unknown revision or path not in the working tree.

-Peff
