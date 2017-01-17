Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E56A20756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdAQRlS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:41:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:40313 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbdAQRlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:41:17 -0500
Received: (qmail 13351 invoked by uid 109); 17 Jan 2017 17:34:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 17:34:35 +0000
Received: (qmail 19429 invoked by uid 111); 17 Jan 2017 17:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 12:35:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 12:34:33 -0500
Date:   Tue, 17 Jan 2017 12:34:33 -0500
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117173433.dhz5payccjog4o6s@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
 <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
 <20170117172531.bahjekbj3om43gtq@sigill.intra.peff.net>
 <20170117173003.sgipqc2cijpdrukb@sigill.intra.peff.net>
 <20170117173346.paqrsroauoskxpn6@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170117173346.paqrsroauoskxpn6@LykOS.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 12:33:46PM -0500, Santiago Torres wrote:

> Yeah, this actually looks more cleaner.
> 
> Let me give it a go.

Neat. Note there's a bug:

> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index 9da11e0c2..068f392b6 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -114,7 +114,11 @@ static int verify_tag(const char *name, const char *ref,
> >  	if (fmt_pretty)
> >  		flags = GPG_VERIFY_QUIET;
> >  
> > -	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
> > +	if (gpg_verify_tag(sha1, ref, flags))
> > +		return -1;
> > +
> > +	pretty_print_ref(name, sha1, fmt_pretty);
> > +	return 0;

The final print should be guarded by "if (fmt_pretty)".

-Peff
