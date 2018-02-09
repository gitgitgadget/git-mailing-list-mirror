Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7A21F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeBIU1f (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:27:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:47296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752218AbeBIU1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:27:35 -0500
Received: (qmail 8198 invoked by uid 109); 9 Feb 2018 20:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 20:27:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24875 invoked by uid 111); 9 Feb 2018 20:28:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 15:28:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 15:27:33 -0500
Date:   Fri, 9 Feb 2018 15:27:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as
 fetch [<remote>]
Message-ID: <20180209202733.GA18966@sigill.intra.peff.net>
References: <20180123221326.28495-1-avarab@gmail.com>
 <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-12-avarab@gmail.com>
 <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
 <87zi4ikjyr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zi4ikjyr.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 09:05:00PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> >> @@ -548,18 +548,52 @@ set_config_tristate () {
> >>         *)
> >>                 git config "$1" "$2"
> >> +               key=$(echo $1 | sed -e 's/^remote\.origin/fetch/')
> >
> > Faster (thus more Windows-friendly) assuming that $1 always starts
> > with "remote.origin":
> >
> >     key=fetch${u#remote.origin}
> 
> Tests fail with this and I'm not excited to be the first user in git's
> test suite to use some novel shell feature, no existing uses of
> ${u[...].
> 
> I also think stuff like this is on the wrong side of cleverness
> v.s. benefit. I can't find any reference to this syntax in bash or dash
> manpages (forward-search "${u"), but echo | sed is obvious, and it's not
> going to make a big difference for Windows.

The "u" isn't the magic, it's the "#". I.e.:

  key=fetch${1#remote.origin}

and it's used all over the place in our scripts.  I'm not sure why Eric
wrote "u". :)

-Peff
