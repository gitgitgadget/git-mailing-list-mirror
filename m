Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1391F207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161424AbcIZRZU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:25:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034882AbcIZRZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:25:19 -0400
Received: (qmail 5421 invoked by uid 109); 26 Sep 2016 17:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:25:18 +0000
Received: (qmail 6483 invoked by uid 111); 26 Sep 2016 17:25:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:25:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:25:16 -0400
Date:   Mon, 26 Sep 2016 13:25:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 06/10] get_short_sha1: NUL-terminate hex prefix
Message-ID: <20160926172516.frftagyt6aycp75q@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120007.eswpfrzs2ed66d2o@sigill.intra.peff.net>
 <xmqq37kmvb6x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37kmvb6x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 10:10:46AM -0700, Junio C Hamano wrote:

> >  struct disambiguate_state {
> >  	int len; /* length of prefix in hex chars */
> > -	char hex_pfx[GIT_SHA1_HEXSZ];
> > +	char hex_pfx[GIT_SHA1_HEXSZ + 1];
> >  	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
> >  
> >  	disambiguate_hint_fn fn;
> > @@ -291,7 +291,6 @@ static int init_object_disambiguation(const char *name, int len,
> >  		return -1;
> >  
> >  	memset(ds, 0, sizeof(*ds));
> > -	memset(ds->hex_pfx, 'x', GIT_SHA1_HEXSZ);
> 
> As the whole thing is cleared here...
> 
> >  
> >  	for (i = 0; i < len ;i++) {
> >  		unsigned char c = name[i];
> > @@ -313,6 +312,7 @@ static int init_object_disambiguation(const char *name, int len,
> >  	}
> >  
> >  	ds->len = len;
> > +	ds->hex_pfx[len] = '\0';
> 
> ... do we even need this one?  It would not hurt, though.

Sharp eyes. I noticed that while writing it, but wondered if anybody
else would. :)

I left the second one in to make the intention more explicit, and so
readers did not have to worry that the NULs were overwritten in the
loop. I'd be OK with it either way, though.

-Peff
