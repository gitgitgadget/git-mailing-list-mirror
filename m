Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764A61F461
	for <e@80x24.org>; Thu, 16 May 2019 21:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfEPVwD (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 17:52:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726750AbfEPVwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 17:52:03 -0400
Received: (qmail 2267 invoked by uid 109); 16 May 2019 21:52:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 21:52:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7683 invoked by uid 111); 16 May 2019 21:52:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 17:52:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 17:52:01 -0400
Date:   Thu, 16 May 2019 17:52:01 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook
 error behavior
Message-ID: <20190516215201.GF10787@sigill.intra.peff.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-8-sandals@crustytoothpaste.net>
 <20190516050200.GB7241@sigill.intra.peff.net>
 <20190516171953.GA265608@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516171953.GA265608@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 05:19:53PM +0000, brian m. carlson wrote:

> > > +	/* Use -2 as sentinel because failure to exec is -1. */
> > > +	int ret = -2;
> > 
> > Maybe this would be simpler to follow by using an enum for the handler
> > return value?
> 
> We can't make this variable an enum because we'd have to define 256
> entries (well, we can, but it would be a hassle), but I can create an
> enum and assign it to the int variable, sure.

I think you can do:

  enum HOOK_ERR {
	HOOK_ERR_NONE = -2,
	HOOK_ERR_EXEC = -1,
	/* otherwise it should be a system exit code */
	HOOK_ERR_MAX = 255
  };

which ensures that the enum can hold any exit status.

-Peff
