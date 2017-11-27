Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40A120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbdK0Ehn (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:37:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:40992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750841AbdK0Ehm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:37:42 -0500
Received: (qmail 25184 invoked by uid 109); 27 Nov 2017 04:37:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 04:37:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32336 invoked by uid 111); 27 Nov 2017 04:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 23:38:00 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 23:37:40 -0500
Date:   Sun, 26 Nov 2017 23:37:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Takuto Ikuta <tikuta@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
Message-ID: <20171127043740.GA5994@sigill>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
 <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 01:35:35PM +0900, Junio C Hamano wrote:

> Takuto Ikuta <tikuta@google.com> writes:
> 
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 008b25d3db087..0184584e80599 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -716,7 +716,7 @@ static int everything_local(struct fetch_pack_args *args,
> >  	for (ref = *refs; ref; ref = ref->next) {
> >  		struct object *o;
> >  
> > -		if (!has_object_file(&ref->old_oid))
> > +		if (!has_object_file_with_flags(&ref->old_oid, OBJECT_INFO_QUICK))
> >  			continue;
> >  
> 
> It appears that great minds think alike?
> 
> cf. https://public-inbox.org/git/20171120202920.7ppcwmzkxifywtoj@sigill.intra.peff.net/

It's funny that we'd get two patches so close together. AFAIK the
slowness here has been with us for years, and I just happened to
investigate it recently.

> The 5-patch series that contains the same change as this one is
> cooking and will hopefully be in the released version before the end
> of the year.

I'd be curious if the 5th patch there provides an additional speedup for
Takuto's case.

-Peff
