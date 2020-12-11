Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0EFC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F0322571
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405840AbgLKOnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:43:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:58304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403949AbgLKOm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 09:42:58 -0500
Received: (qmail 9218 invoked by uid 109); 11 Dec 2020 14:42:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 14:42:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7311 invoked by uid 111); 11 Dec 2020 14:42:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 09:42:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 09:42:14 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9OFRiqDDYtbg87i@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase>
 <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 09:27:57AM -0500, Jeff King wrote:

> I don't know what kinds of variables you want to set exactly, but
> another possible option here is some mechanism to point Git to an extra
> config file. This would work if you are setting a bunch of options in
> some static way, but not if you're setting them to custom values for
> each command invocation (because then you'd be dealing with a temp file,
> which is annoying and error-prone).
> 
> I'm thinking something like a $GIT_CONFIG_ENV_FILE that is parsed after
> repo config but before $GIT_CONFIG_PARAMETERS.

One more (probably insane) idea, that you are free to ignore unless it
sparks your interest.

$GIT_CONFIG_ENV could contain an actual config-file snippet itself.
I.e.:

  GIT_CONFIG_ENV='
	[foo]
	bar = value
	[another "section"]
	key = "more complicated value"
  '

In fact, we could have implemented $GIT_CONFIG_PARAMETERS that way from
the very beginning. I'd be hesitant to change it now, though.

It doesn't really make your quoting problem go away, in that you'd now
have to generate a valid and correct config file, which is even more
complicated than shell-quoting. :) But it is at least a well-documented
format whose generator might be used for other things, too.

-Peff
