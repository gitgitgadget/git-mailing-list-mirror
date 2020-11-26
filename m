Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B2C56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5074520770
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgKZAgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:36:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgKZAgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:36:48 -0500
Received: (qmail 12306 invoked by uid 109); 26 Nov 2020 00:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 00:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12182 invoked by uid 111); 26 Nov 2020 00:36:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 19:36:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 19:36:46 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X774nvXcRrP64SZ2@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
 <X75ZNv/8X5Z7Yfci@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X75ZNv/8X5Z7Yfci@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 02:16:38PM +0100, Patrick Steinhardt wrote:

> > I do still think that a "--config-env" option solves your problem in a
> > much simpler way (especially in terms of interface we expose to users
> > that we'll be locked into forever). I sketched out the solution below if
> > it's of interest (and I'd be happy to polish it up, or hand it off to
> > you if so). But if you're unconvinced, I'll stop mentioning it.
> 
> The thing I like more about using envvars only is that you only need to
> modify a single part, while with `--config-env` there's two moving
> parts. E.g. assume you have a script and want certain configuration to
> apply to all git commands in that script. It's trivial in the envvar
> case, while for `--config-env` you'll also have to modify each single
> git call. You could get around that by using a wrapper, but it's still a
> tad more involved. A second thing I briefly wondered about is the
> maximum command line length, which may be easier to hit in case you want
> to pass a lot of config entries.

Yeah, that's true. I haven't typically run across this myself because
usually such a script ends up invoked by git itself. I.e., it is
git-foo, and then I do:

  git -c some.var=value foo

which puts everything in the environment, but it's done by Git itself,
so the exact environment format remains opaque.

-Peff
