Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F3C2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934106AbdCUToP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:44:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:48917 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933627AbdCUToO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:44:14 -0400
Received: (qmail 17177 invoked by uid 109); 21 Mar 2017 19:43:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 19:43:35 +0000
Received: (qmail 19738 invoked by uid 111); 21 Mar 2017 19:43:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 15:43:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 15:43:31 -0400
Date:   Tue, 21 Mar 2017 15:43:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>}
 case-insensitively
Message-ID: <20170321194330.5nghzisbud5yy6wq@sigill.intra.peff.net>
References: <20170318223409.13441-1-avarab@gmail.com>
 <CACBZZX6g694p9WkiK75+HJCLUPwjpdQhjBrAU713KahAKm53hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6g694p9WkiK75+HJCLUPwjpdQhjBrAU713KahAKm53hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 08:19:34PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Mar 18, 2017 at 11:34 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> 
> > The new starts_with_case() function is a copy of the existing adjacent
> > starts_with(), just with a tolower() in the "else if".
> > [...]
> > +int starts_with_case(const char *str, const char *prefix)
> > +{
> > +       for (; ; str++, prefix++)
> > +               if (!*prefix)
> > +                       return 1;
> > +               else if (tolower(*str) != tolower(*prefix))
> > +                       return 0;
> > +}
> > +
> >  /*
> 
> One thing I'd like feedback on is whether I should be adding this to
> strbuf.c. There are >300 uses of starts_with(), but sha1_name.c will
> be the only one using this modified starts_with_case() function.
> Wouldn't it be better to just add it to sha1_name.c rather than
> expanding the strbuf API with something that'll likely be used by
> nothing else for a while?

I was thinking that I had written this same function before (in a patch
that didn't end up merged), but it was actually the related
skip_prefix_icase(). I'm fine with it either next to starts_with() or as
a static next to its callers.

-Peff
