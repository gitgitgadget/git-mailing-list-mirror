Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC8D1FCA5
	for <e@80x24.org>; Fri, 30 Dec 2016 00:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbcL3Att (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 19:49:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:33172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbcL3Att (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 19:49:49 -0500
Received: (qmail 32705 invoked by uid 109); 30 Dec 2016 00:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Dec 2016 00:49:49 +0000
Received: (qmail 26985 invoked by uid 111); 30 Dec 2016 00:50:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Dec 2016 19:50:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Dec 2016 19:49:44 -0500
Date:   Thu, 29 Dec 2016 19:49:44 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when
 setting GIT_DIR
Message-ID: <20161230004944.pkblwpxwkacpk7dd@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <20161122004421.GA12263@google.com>
 <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
 <20161230001114.GB7883@aiede.mtv.corp.google.com>
 <CAGZ79kZiR7grGeMrMFRuQQ0kW6eQ4m=ZizGHDbT-s14iAj8hWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZiR7grGeMrMFRuQQ0kW6eQ4m=ZizGHDbT-s14iAj8hWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 04:37:30PM -0800, Stefan Beller wrote:

> > +       mkdir lsremote-root &&
> > +       (
> > +               GIT_CEILING_DIRECTORIES=$(pwd) &&
> > +               export GIT_CEILING_DIRECTORIES &&
> > +               cd lsremote-root &&
> > +               git ls-remote "$HTTPD_URL/smart/repo.git" >../actual
> > +       ) &&
> 
> We could avoid the subshell via
> 
> GIT_CEILING_DIRECTORIES=$(pwd) \
>     git -C lsremote-root lsremote ... >actual
> 
> Not sure if it is worth to trade off a block of code (and an extra shell
> at run time) for an overly long line.
> 
> The rest looks good to me.

I mentioned elsewhere that we now have a "nongit" function to do this as
a one-liner. It might be worth applying your optimization to that
function, so it would take effect in may places.

-Peff
