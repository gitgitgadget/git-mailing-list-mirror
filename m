Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C174203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 17:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbcG0R6F (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:58:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:49944 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755979AbcG0R6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:58:04 -0400
Received: (qmail 32748 invoked by uid 102); 27 Jul 2016 17:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:58:03 -0400
Received: (qmail 18839 invoked by uid 107); 27 Jul 2016 17:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 13:58:00 -0400
Date:	Wed, 27 Jul 2016 13:58:00 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727175800.GB32219@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
 <20160727135820.GC14928@sigill.intra.peff.net>
 <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
 <xmqqk2g7vurb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2g7vurb.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 10:46:48AM -0700, Junio C Hamano wrote:

> I am not sure about the latter, i.e. the return value from the
> get_reflog_time_t() function (which I think is misnamed, in that the
> function returns "unsigned long", not "time_t", and should be
> renamed to get_reflog_time()) uses the epoch as a fallback value.
> [...]
> @@ -330,7 +330,7 @@ unsigned long get_reflog_time_t(struct reflog_walk_info *reflog_info)
>  	struct reflog_info *info = get_reflog_info(reflog_info);
>  
>  	if (!info)
> -		return NULL;
> +		return 0;
>  	return gm_time_t(info->timestamp, info->tz);
>  }

Our mails just crossed, but I think returning even "0" is not ideal. We
should probably write nothing to match things like "%gd" and "%gs",
which just eat the placeholder and show nothing when they cannot access
the reflog.

-Peff
