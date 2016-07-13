Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0761F744
	for <e@80x24.org>; Wed, 13 Jul 2016 07:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbcGMH0t (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 03:26:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:43926 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbcGMH0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 03:26:47 -0400
Received: (qmail 16176 invoked by uid 102); 13 Jul 2016 07:26:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 03:26:13 -0400
Received: (qmail 11091 invoked by uid 107); 13 Jul 2016 07:26:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 03:26:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2016 03:26:07 -0400
Date:	Wed, 13 Jul 2016 03:26:07 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v3] config: add conditional include
Message-ID: <20160713072607.GA15153@sigill.intra.peff.net>
References: <20160628172641.26381-3-pclouds@gmail.com>
 <20160712164216.24072-1-pclouds@gmail.com>
 <vpqa8hmroji.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpqa8hmroji.fsf@anie.imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 09:21:37AM +0200, Matthieu Moy wrote:

> > +static int prepare_include_condition_pattern(struct strbuf *pat)
> > +{
> > +	int prefix = 0;
> > +
> > +	/* TODO: maybe support ~user/ too */
> > +	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
> > +		struct strbuf path = STRBUF_INIT;
> > +		const char *home = getenv("HOME");
> > +
> > +		if (!home)
> > +			return error(_("$HOME is not defined"));
> 
> expand_user_path in path.c seems to do the same as you're doing (but
> does deal with ~user). Any reason not to use it?

I had a similar question, which Duy answered in:

  http://article.gmane.org/gmane.comp.version-control.git/298528

It does feel pretty hacky, though (especially for a case that seems
unlikely to come up: people having wildcard patterns in the name of
their home directory).

-Peff
