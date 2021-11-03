Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D1BC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A759E60EB8
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKCLjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:39:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhKCLju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:39:50 -0400
Received: (qmail 5016 invoked by uid 109); 3 Nov 2021 11:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:37:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18523 invoked by uid 111); 3 Nov 2021 11:37:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:37:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:37:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
Message-ID: <YYJ0aQ11uHA/XUt3@coredump.intra.peff.net>
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
 <20211102164434.1005707-1-thomas@t-8ch.de>
 <211102.86czni1o72.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211102.86czni1o72.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 05:53:46PM +0100, Ævar Arnfjörð Bjarmason wrote:

> The reason I suggested extending "git config" in [1] is because it seems
> like a natural thing for "git config" to learn to spew out our idea of
> default hardcoded config values to the user.
> 
> But creating a variable form of that existing config just so we can have
> "git var" spew it out just seems weird.
> 
> We don't have or need such a variable now for anything else, so why go
> through that indirection, instead of something that closes the feature
> gap of asking what a config variable default is?

To me, the point is that the user is not asking "what is the default
value of this config variable?". They are asking "if I were to init a
new repository, what would Git decide the default branch name is?".

Right now that is very tied to the config mechanism (modulo the
GIT_TEST_* bits, but I think we can ignore those for regular users), so
those two are basically the same question. But it doesn't have to be.
Abstracting it to the question the user actually wants to ask
future-proofs the mechanism.

I.e., I don't think introducing a new variable into "git var" is that
big a deal. They don't have to be related to an environment variable;
the documentation calls them "logical variables". This is exactly the
kind of thing it's designed for.

-Peff
