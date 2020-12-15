Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722A5C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B9D224D1
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 01:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgLOBkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 20:40:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:60666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgLOBkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 20:40:32 -0500
Received: (qmail 10239 invoked by uid 109); 15 Dec 2020 01:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 01:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6311 invoked by uid 111); 15 Dec 2020 01:39:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 20:39:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 20:39:51 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9gT57SAHzGm3ET2@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
 <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 02:56:22AM +0000, brian m. carlson wrote:

> > > * We should not ship editor-specific files in the main directory of the
> > >   repository.
> > 
> > Why not?
> 
> Best practices indicate that we don't check in files which are specific
> to a developer.  Anything that controls the specific editor people use
> is by definition specific to the developer.  Checking in these files
> leads to conflicts over which settings to apply and whose settings are
> better when they could just be avoided.

I think that's a good general policy, but it's not unreasonable to
help people make configure some widely used tools. The key things to me
are:

  - we should do so at the most general level possible. I agree that
    .editorconfig is the right level for features it supports. But
    there are bits being suggested here that I think it does not (like
    how to indent case labels).

    We also have .clang-format, for which there's a vim plugin (but I've
    not used it, nor editorconfig, myself). It seems like it may support
    more options.

  - people who use the editor config take responsibility for maintaining
    it, and nobody else needs to care. E.g., I'd expect editorconfig to
    more of a source of truth than any vim config, and if there's a
    conflict for people who care about vim to sort it out (and not
    somebody who touched .editorconfig).

  - it doesn't suggest any actions that might be bad practices. I agree
    that the instructions for auto-loading this .vimrc are more
    complicated than necessary and might have security implications.
    Carrying a file in contrib/vim that says "copy this to ~/.vim/foo"
    or even "copy these lines to your ~/.vimrc" seems a lot safer. And
    it makes it easier for people who prefer to adapt the config to
    their own setup.

So I'm not opposed to carrying some vim config, but I think it's best to
focus on simplicity and providing human-readable instructions, rather
than ad-hoc plugin infrastructure.

-Peff
