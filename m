Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0AB20248
	for <e@80x24.org>; Mon,  4 Mar 2019 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCDUkK (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 15:40:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:38354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726101AbfCDUkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 15:40:10 -0500
Received: (qmail 28887 invoked by uid 109); 4 Mar 2019 20:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 20:40:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25832 invoked by uid 111); 4 Mar 2019 20:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 15:40:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 15:40:08 -0500
Date:   Mon, 4 Mar 2019 15:40:08 -0500
From:   Jeff King <peff@peff.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190304204007.GA32691@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551729517.4092.1.camel@libero.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 08:58:37PM +0100, Fabio Aiuto wrote:

> I'm trying to build first commit of git made by Linus. I mean the one
> named e83c5163316f89bfbde7d9ab23... (I think this is enough).
> But at building stage i have the following error:
> 
> make all 
> gcc -g -o update-cache update-cache.o read-cache.o -lssl
> /usr/bin/ld: update-cache.o: undefined reference to symbol
> 'SHA1_Update@@OPENSSL_1_1_0'

The sha1 routines are in libcrypto. See 3be4b61aa4 (Link with -lcrypto
instead of -lssl when using openssl libraries., 2005-05-10). I also
needed -lz. See 9426167765 (Add "-lz" to link line to get in zlib.,
2005-04-08).

You can patch the Makefile, or just override it like:

  make LIBS='-lcrypto -lz'

which builds for me on current Debian unstable. I don't think you can
actually fetch with that old build, but I used periodically check that
Git v1.0 can fetch happily from GitHub. I haven't in a while, so let me
know if you try it and it doesn't work. ;)

-Peff
