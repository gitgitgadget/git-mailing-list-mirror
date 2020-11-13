Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C8C55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 19:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D822223C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKMTOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 14:14:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:57764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMTOU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 14:14:20 -0500
Received: (qmail 26974 invoked by uid 109); 13 Nov 2020 19:14:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 19:14:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15619 invoked by uid 111); 13 Nov 2020 19:14:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 14:14:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 14:14:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
Message-ID: <20201113191418.GA764688@coredump.intra.peff.net>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
 <20201113161320.16458-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113161320.16458-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 05:13:20PM +0100, Ævar Arnfjörð Bjarmason wrote:

>  * A lot of tests (but a small minority of the total) have master
>    "master" hardcoded in some way. We now inventory them in
>    tests-that-need-master.txt, we can still remove the names from that
>    file and manually change the code later, but this accomplishes a
>    clean test run with a relatively easy-to-review diff.
> 
>    We ignore GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=<name> when it comes
>    to these files, unless
>    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME_HARDER=true is set.

I'm confused how this is better. We could just be setting
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME at the top of those files, couldn't
we? (Likewise, I think annotating individual scripts is more
decentralized than a magic pattern in test-lib.sh, though it amounts to
the same thing).

And if I understand the current state of Dscho's patches, we don't
_have_ to convert any tests right now. We could just annotate those
scripts which are not yet converted to have them use the old name.

But I don't think we want to live in that state indefinitely. It's
slightly annoying to have inconsistent naming within the tests. I'd be
happy to switch individual tests at a leisurely pace over the next
couple of months or whatever. But since Dscho has bothered to write all
of the patches now, why not use them?

I'm much more concerned about the lack of documentation changes
associated with the final patch. We don't necessarily need to eradicate
every mention of "master" from the documentation, but I think we do need
to make sure that examples and instructions are consistent with how Git
will actually behave. And that does need to happen at the same time as
the user-visible flip of the default.

I'm on the fence whether there should be a deprecation period or major
version bump for the final patch, but making the tests flexible enough
to handle the before and after state seems like it can be done uncoupled
from the actual default-flip.

-Peff
