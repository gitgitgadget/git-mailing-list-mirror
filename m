Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A32C49EBD
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2381E23A33
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394068AbgLKOVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:21:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:58220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406087AbgLKOVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 09:21:00 -0500
Received: (qmail 9073 invoked by uid 109); 11 Dec 2020 14:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 14:20:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7045 invoked by uid 111); 11 Dec 2020 14:20:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 09:20:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 09:20:18 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9OAIs6cGdNVt4xV@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
 <X9NzE5+LNYqG1s+o@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9NzE5+LNYqG1s+o@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 02:24:35PM +0100, Patrick Steinhardt wrote:

> > > +--config-env=<name>=<envvar>::
> > > +	Pass a configuration parameter to the command. The <envvar>
> > > +	given will be replaced with the contents of the environment
> > > +	variable of that name. In contrast to `-c`, an envvar must
> > > +	always be given and exist in the environment. Passing an
> > > +	environment variable with empty value will set <name> to the
> > > +	empty string which `git config --type=bool` will convert to
> > > +	`false`.
> > 
> > I agree with Ævar that we probably should keep an empty variable as the
> > empty string. I think some options use an empty string to clear a list
> > (e.g., push.pushOption), and I'm not sure how they'd react to a bool
> > instead. It would be nice to also have a way to do the implicit-bool
> > thing, but I don't think it's strictly necessary (it's always correct to
> > put the string "true" into the variable instead).
> 
> I think this is just weirdly worded in the `-c` case, which I mostly
> copied. We _do_ keep the empty string, which effectively means that `git
> config --type=bool` will return `false`.

Oh indeed, I misread what you wrote in the documentation. I think it is
doing the right thing, then. IMHO it is not worth even calling out
specially, since there is no matching implicit-bool form. I.e., I'd
probably just cut the final sentence.

> Or do you mean that we should allow `--config-env=foo.bar=`?

Hmm, yeah, that would work as an "implicit bool". But it's sufficiently
ugly and non-intuitive (and weirdly overlapping with "-c") that I'm not
sure it is worth supporting.

-Peff
