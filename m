Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C185120984
	for <e@80x24.org>; Wed, 14 Sep 2016 05:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757736AbcINFJZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 01:09:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:43037 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbcINFJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 01:09:25 -0400
Received: (qmail 23897 invoked by uid 109); 14 Sep 2016 05:09:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 05:09:24 +0000
Received: (qmail 28916 invoked by uid 111); 14 Sep 2016 05:09:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 01:09:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 22:09:20 -0700
Date:   Tue, 13 Sep 2016 22:09:20 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 05:04:45PM -0700, Junio C Hamano wrote:

> > @@ -461,6 +506,7 @@ static int check_header(struct mailinfo *mi,
> >  			 */
> >  			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
> >  			decode_header(mi, &sb);
> > +			unescape_quoted_pair(mi, &sb);
> >  			handle_header(&hdr_data[i], &sb);
> >  			ret = 1;
> >  			goto check_header_out;
> 
> I wonder why this call is only in here, not on other headers that
> all call decode_header().  For that matter, I wonder if the call (or
> the logic of the helper function itself) should go at the end of
> decode_header().  After all, this is different kind of decoding; the
> current one knows how to do b/q encoding but forgot about the more
> traditional quoting done with backslash, and you are teaching the
> code that the current decoding it does is insufficient and how to
> handle the one that the original implementors forgot about.

It has been a while since I looked at rfc2822, but aren't the quoting
and syntax rules different for addresses versus other headers? We would
not want to dequote a Subject header, I think.

-Peff
