Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BDC1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 08:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeFKI7d (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 04:59:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:41200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932375AbeFKI7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 04:59:33 -0400
Received: (qmail 12115 invoked by uid 109); 11 Jun 2018 08:59:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 08:59:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14314 invoked by uid 111); 11 Jun 2018 08:59:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 04:59:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 04:59:31 -0400
Date:   Mon, 11 Jun 2018 04:59:31 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180611085930.GA16414@sigill.intra.peff.net>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <20180604044408.GD14451@sigill.intra.peff.net>
 <20180610150727.GE27650@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180610150727.GE27650@jessie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 06:07:27PM +0300, Max Kirillov wrote:

> On Mon, Jun 04, 2018 at 12:44:09AM -0400, Jeff King wrote:
> > On Sun, Jun 03, 2018 at 12:27:49AM +0300, Max Kirillov wrote:
> >> +	env \
> >> +		CONTENT_TYPE=application/x-git-upload-pack-request \
> >> +		QUERY_STRING=/repo.git/git-upload-pack \
> >> +		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
> >> +		GIT_HTTP_EXPORT_ALL=TRUE \
> >> +		REQUEST_METHOD=POST \
> >> +		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> >> +		git http-backend </dev/zero >/dev/null 2>err &&
> >> +	grep -q "fatal:.*CONTENT_LENGTH" err
> > 
> > I'm not sure if these messages should be marked for translation. If so,
> > you'd want test_i18ngrep here.
> 
> Message localization does not seem to be used in
> http-backend at all. It makes sense - server-side software
> probably does not know who is the user on the other side, if
> the message gets to the user at all. So, I think the
> message should not be translated.

OK. I think there's been talk of localizing "fatal:", but whoever does
that patch would have to deal with fallout all over the test-suite. I
don't think we need to worry about it yet.

-Peff
