Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF821FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935255AbcHJSe6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:34:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53022 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935102AbcHJSe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:34:57 -0400
Received: (qmail 30843 invoked by uid 109); 10 Aug 2016 14:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 14:34:55 +0000
Received: (qmail 334 invoked by uid 111); 10 Aug 2016 14:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 10:34:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 10:34:53 -0400
Date:	Wed, 10 Aug 2016 10:34:53 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 03/15] pkt-line: add `gentle` parameter to
 format_packet()
Message-ID: <20160810143452.siolzmqwgs3xzcal@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-4-larsxschneider@gmail.com>
 <20160810131541.ovpvgwdxjibae5gy@sigill.intra.peff.net>
 <F4D9C42A-5B7F-47B4-B334-704D5F6210F5@gmail.com>
 <20160810133745.wagccvvf35o3pbwb@sigill.intra.peff.net>
 <982CD9A4-E155-4DEE-9B47-BCEA4F0C493C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <982CD9A4-E155-4DEE-9B47-BCEA4F0C493C@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:59:19PM +0200, Lars Schneider wrote:

> > It does still feel a little weird that you cannot tell the difference
> > between a write() error and bad input. Because you really might want to
> > do something different between the two. Like:
> > 
> >  #define MAX_FILENAME (PKTLINE_DATA_MAXLEN - strlen("filename"))
> > 
> >  if (filename > MAX_FILENAME) {
> > 	warning("woah, that name is ridiculous; truncating");
> > 	ret = packet_write_fmt_gently(fd, "%.*s", MAX_FILENAME, filename);
> >  } else
> > 	ret = packet_write_fmt_gently(fd, "%s", filename);
> 
> 
> I can do that. However, I wouldn't truncate the filename as this
> might create a weird outcome. I would just let the filter fail.

Yeah, I think that is probably fine (I don't have a real opinion for
this particular case, but was mostly just trying to think about whether
the pktline interface was suitably flexible).

-Peff
