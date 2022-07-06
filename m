Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B908BC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 09:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiGFJXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiGFJXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 05:23:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596FA15A39
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 02:23:19 -0700 (PDT)
Received: (qmail 2881 invoked by uid 109); 6 Jul 2022 09:23:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 09:23:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18555 invoked by uid 111); 6 Jul 2022 09:23:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 05:23:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 05:23:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] sha256: add support for Nettle
Message-ID: <YsVUhjrxPGdZuVWN@coredump.intra.peff.net>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <220706.86fsjeaalo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220706.86fsjeaalo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 10:45:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Would it be viable / at all sane to embed the part of the library we
> need in our sources, similar to what we do for sha1dc? Or perhaps it's
> not worth it at all...

I doubt it's worth it. It's a big library with tons of algorithms, most
of which we won't need. And the implementation has lots of asm and
platform-specific knobs. I wouldn't want to try extracting any of that
from their autoconf file, nor putting (more) autoconf inside our
repository.

For sha1dc, I think including a vendored copy was important for us
making it the default, and we wanted to do that for the security
implications. A 12% speedup is OK to leave on the able for the default
build, and people can easily link against the system libnettle if they
care enough. And other linkable implementations are in the same boat;
openssl is even faster than libnettle on my machine.

-Peff
