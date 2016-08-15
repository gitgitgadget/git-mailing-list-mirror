Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF031F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbcHOVN6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:13:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:55837 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932115AbcHOVN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:13:58 -0400
Received: (qmail 12198 invoked by uid 109); 15 Aug 2016 21:13:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 21:13:57 +0000
Received: (qmail 20044 invoked by uid 111); 15 Aug 2016 21:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 17:13:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 17:13:54 -0400
Date:	Mon, 15 Aug 2016 17:13:54 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160815211354.vsyg3lpira6pttom@sigill.intra.peff.net>
References: <20160815184021.12396-1-sbeller@google.com>
 <20160815184021.12396-2-sbeller@google.com>
 <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
 <xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com>
 <xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 02:10:36PM -0700, Junio C Hamano wrote:

> > Guilty as charged.  I do agree that this is over-engineered.
> 
> Let's discard 1/2 and amend 2/2 with this incremental.

Looks good (though I really am OK the other way if people feel
strongly).

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2a32b5f..337c35a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -656,8 +656,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
>  		if (!opts->quiet) {
>  			if (old->path &&
> -			    (advice_detached_head == 1 ||
> -			     (advice_detached_head == -1 && !opts->force_detach)))
> +			    advice_detached_head == 1 && !opts->force_detach)

Maybe s/== 1//?

That's more idiomatic, though maybe you were future-proofing in case we
turn it into a tri-state later. :)

-Peff
