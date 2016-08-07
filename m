Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498B61FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbcHGW5Q (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 18:57:16 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38360 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbcHGW5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 18:57:15 -0400
Received: from x (unknown [IPv6:2605:e000:d5ce:1e00:c5f5:b7bf:c731:5d3f])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DAFD1172097;
	Mon,  8 Aug 2016 00:57:09 +0200 (CEST)
Date:	Sun, 7 Aug 2016 12:57:01 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160807225701.ucv2xunq5vs4uedk@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:38:47PM -0400, Jeff King wrote:
> On Sat, Jul 30, 2016 at 12:11:11PM -0700, Josh Triplett wrote:
> 
> > +enum from {
> > +	FROM_AUTHOR,
> > +	FROM_USER,
> > +	FROM_VALUE,
> > +};
> > +
> > +static void set_from(enum from type, const char *value)
> > +{
> > +	free(from);
> > +	switch (type) {
> > +	case FROM_AUTHOR:
> > +		from = NULL;
> > +		break;
> > +	case FROM_USER:
> > +		from = xstrdup(git_committer_info(IDENT_NO_DATE));
> > +		break;
> > +	case FROM_VALUE:
> > +		from = xstrdup(value);
> > +		break;
> > +	}
> > +}
> 
> Thanks for looking into reducing the duplication. TBH, I am not sure it
> is really an improvement, just because of the amount of boilerplate (and
> this function interface is kind of weird, because of the rules for when
> "value" should or should not be NULL).
> 
> I guess another way to do it would be:
> 
>   #define FROM_AUTO_IDENT ((const char *)(intptr_t)1))
>   void set_from(const char *value)
>   {
> 	if (value == FROM_AUTO_IDENT)
> 		value = git_committer_info(IDENT_NO_DATE);
> 	free(from);
> 	from = xstrdup_or_null(value);
>   }

I'd actually seriously considered this exact approach, which I preferred
as well, but I'd discarded it because I figured it'd get rejected.
Given your suggestion, and Junio's comment, I'll go with this version.

- Josh Triplett
