Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CA720248
	for <e@80x24.org>; Tue, 19 Mar 2019 03:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfCSDa0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 23:30:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:55972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726743AbfCSDa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 23:30:26 -0400
Received: (qmail 29989 invoked by uid 109); 19 Mar 2019 03:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 03:30:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26238 invoked by uid 111); 19 Mar 2019 03:30:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 23:30:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 23:30:24 -0400
Date:   Mon, 18 Mar 2019 23:30:24 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190319033023.GA25772@sigill.intra.peff.net>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319024645.GA6173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 10:46:45PM -0400, Jeff King wrote:

> >   * Provide the `mansource` attribute to Asciidoctor. This attribute
> >     looks promising until one realizes that it can only be given inside
> >     the source file (the .txt file in our case), *not* on the command
> >     line using `-a mansource=foobar`. I toyed with the idea of injecting
> >     this attribute while feeding Asciidoctor the input on stdin, but it
> >     didn't feel like it was worth the complexity in the Makefile.
> 
> It does seem like "mansource" is the way asciidoctor expects us to do
> this. Why doesn't it work from the command line? Is it a bug in
> asciidoctor, or is there something more subtle going on?
> 
> I think even if it is a bug and gets fixed, though, it still wouldn't
> have the version field (though that seems like something we could
> contribute to asciidoctor).

I just tried with asciidoc 2.0.0.rc.2, which came out last week. It does
seem to work from the command line:

  $ make USE_ASCIIDOCTOR=Yes \
         ASCIIDOC_DOCBOOK=docbook5 \
         ASCIIDOC='asciidoctor -amansource=Git -amanmanual="Git Manual"' \
         git-add.xml
  $ sed -n '/refmeta/,/refmeta/p' git-add.xml
  <refmeta>
  <refentrytitle>git-add</refentrytitle>
  <manvolnum>1</manvolnum>
  <refmiscinfo class="source">Git</refmiscinfo>
  <refmiscinfo class="manual">Git Manual</refmiscinfo>
  </refmeta>

Still no "manversion" attribute, though.

-Peff
