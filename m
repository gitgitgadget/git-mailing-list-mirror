Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6FFC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9415A23BE3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgLIQYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:24:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:55658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbgLIQYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:24:48 -0500
Received: (qmail 18378 invoked by uid 109); 9 Dec 2020 16:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16587 invoked by uid 111); 9 Dec 2020 16:24:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:24:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:24:03 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <871rfzxctq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rfzxctq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 03:40:17PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > +--config-env=<name>=<envvar>::
> > +	Pass a configuration parameter to the command. The <envvar>
> > +	given will be replaced with the contents of the environment
> > +	variable of that name. In contrast to `-c`, an envvar must
> > +	always be given and exist in the environment. Passing an
> > +	environment variable with empty value will set <name> to the
> > +	empty string which `git config --type=bool` will convert to
> > +	`false`.
> 
> Okey, because "-c foo.bar" (true) "-c foo.bar=" is the empty string, but
> that doesn't make sene with "--config-env". Also the whole part about
> --type=bool is just confusing, because it's referring to `-c`'s magic
> behavior when it comes to `bool` which we don't have here.

Yeah, I agree.

> I think it's also worth describing what this is for & what the
> limitations are. Maybe:

Agreed, and the text you gave looks reasonable. Another reason to use it
is that it will (if we add the patches I just sent on top) avoid the
key/value ambiguity with equals in the section name.

> Not something new, and maybe not something for this series, but I wish
> -c and --config-env would document this limitation that we support "="
> in keys in config, but not via those parameters.

Yeah. If we add in my patches, then the limitation is gone here (but we
should mention the limitation on the environment variable name).

I stopped short of adding a variant of "-c" that avoids the ambiguity.
I'm certainly not opposed to one if somebody wants to do it, but I think
documenting the current limitation makes sense in the meantime (and we
should do it in this series while we're thinking about it).

-Peff
