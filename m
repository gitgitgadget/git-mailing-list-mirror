Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F1C1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKHGNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 01:13:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:43938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726517AbeKHGNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 01:13:47 -0500
Received: (qmail 8708 invoked by uid 109); 7 Nov 2018 20:41:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 20:41:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17844 invoked by uid 111); 7 Nov 2018 20:41:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 15:41:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 15:41:42 -0500
Date:   Wed, 7 Nov 2018 15:41:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Message-ID: <20181107204142.GA30078@sigill.intra.peff.net>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 07:52:28PM +0100, Johannes Sixt wrote:

> > Okay, now we know everything you find wrong with the current patch. Do you
> > have any suggestion how to make it right? I.e. what would you suggest as a
> > way to specify in a gitconfig in a portable Git where the certificate
> > bundle is?
> 
> Ah, so your actual problem is quite a different one!
> 
> Do I understand correctly, that you use a leading slash as an indicator to
> construct a path relative to system_path(). How about a "reserved" user
> name? For example,
> 
>   [http] sslcert = ~system_path/what/ever
> 
> although a more unique name, perhaps with some punctuation, may be
> desirable.

It's syntactically a bit further afield, but something like:

  [http]
  sslcert = $RUNTIME_PREFIX/what/ever

would make sense to me, and is a bit less subtle than the fake user. I
don't know if that would confuse people into thinking that we
interpolate arbitrary environment variables, though.

-Peff
