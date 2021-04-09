Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F62C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51935610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhDISKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:10:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:46564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDISKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:10:19 -0400
Received: (qmail 669 invoked by uid 109); 9 Apr 2021 18:10:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:10:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14662 invoked by uid 111); 9 Apr 2021 18:10:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:10:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:10:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/6] object.c: stop supporting len == -1 in
 type_from_string_gently()
Message-ID: <YHCYfeRsHU34ZF/l@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-1.6-820f3aed21-20210409T082935Z-avarab@gmail.com>
 <YHCXux5KJmwX3OSv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHCXux5KJmwX3OSv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 02:06:51PM -0400, Jeff King wrote:

> On Fri, Apr 09, 2021 at 10:32:49AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > diff --git a/object.c b/object.c
> > index 7fdca3ed1e..88de01e5ac 100644
> > --- a/object.c
> > +++ b/object.c
> > @@ -39,9 +39,6 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
> >  {
> >  	int i;
> >  
> > -	if (len < 0)
> > -		len = strlen(str);
> > -
> 
> The "ssize_t len" in the parameters could become a size_t now, right?
> 
> Not strictly necessary, but in theory it may help static analysis catch
> a caller who mistakenly tries to pass -1 (though in practice I suspect
> it does not help that much, because any of gcc's sign-conversion
> warnings generate far too much noise to be useful with our current
> codebase).

Actually, seeing patch 2, which changes the signature, mostly deals with
this. The compiler would complain about any existing calls because of
dropping the "gentle" parameter (it is up to the human to realize that
they need to make sure we are not passing a negative len, but hopefully
they would look at the other commits at that point).

-Peff
