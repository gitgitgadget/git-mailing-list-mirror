Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1A41F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcHCWrD (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:47:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:54365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755167AbcHCWrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:47:02 -0400
Received: (qmail 22131 invoked by uid 102); 3 Aug 2016 22:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:46:23 -0400
Received: (qmail 7654 invoked by uid 107); 3 Aug 2016 22:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 18:46:19 -0400
Date:	Wed, 3 Aug 2016 18:46:19 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
Message-ID: <20160803224619.bwtbvmslhuicx2qi@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <xmqqtwf19263.fsf@gitster.mtv.corp.google.com>
 <0E3FC781-1B2C-4341-9B7B-D9D836596A35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0E3FC781-1B2C-4341-9B7B-D9D836596A35@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 11:48:00PM +0200, Lars Schneider wrote:

> OK. Is this the v2 discussion you are referring to?
> http://public-inbox.org/git/1461972887-22100-1-git-send-email-sbeller%40google.com/
> 
> What format do you suggest?
> 
> packet:          git< git-filter-protocol\n
> packet:          git< version=2\n
> packet:          git< capability=clean\n
> packet:          git< capability=smudge\n
> packet:          git< 0000
> 
> or
> 
> packet:          git< git-filter-protocol\n
> packet:          git< version=2\n
> packet:          git< capability\n
> packet:          git< clean\n
> packet:          git< smudge\n
> packet:          git< 0000
> 
> or  ... ?
> 
> I would prefer the first one, I think.

How about:

  version=2
  clean=true
  smudge=true
  0000

? Then we do not have to care about multiple "capability" keys (so
something naively parsing this could just store them in a string list,
for example).

You could also make "clean" a synonym for "clean=true" or something, and
have:

  version=2
  clean
  smudge
  0000

but it's probably better to have the protocol err on the side of
verbose-but-unambiguous. It's not like people are typing this routinely.

-Peff
