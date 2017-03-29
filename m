Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B337C1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 02:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbdC2CSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 22:18:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:53363 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751785AbdC2CSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 22:18:24 -0400
Received: (qmail 2922 invoked by uid 109); 29 Mar 2017 02:18:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 02:18:10 +0000
Received: (qmail 5377 invoked by uid 111); 29 Mar 2017 02:18:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 22:18:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 22:18:07 -0400
Date:   Tue, 28 Mar 2017 22:18:07 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Can't locate ExtUtils/MakeMaker.pm in @INC
Message-ID: <20170329021807.voys2r65knn6tdwg@sigill.intra.peff.net>
References: <CAH8yC8kpKii+FNZEUqDqLcuEWBsTTnrqMHq_3VLdAzcpDSKFww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kpKii+FNZEUqDqLcuEWBsTTnrqMHq_3VLdAzcpDSKFww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 09:03:43PM -0400, Jeffrey Walton wrote:

> This looks like the last issue with Git 2.12.2. This time the machine
> is Fedora 25.
> 
> I configured with PERL_PATH=/usr/local/bin/perl. The local Perl was
> built specifically for this error, and it includes
> ExtUtils/MakeMaker.pm:

I'm not sure what "configured with PERL_PATH" means exactly. If you did:

  PERL_PATH=/usr/local/bin/perl ./configure

then I don't think that works. The way to tell configure that you want
to use a specific version of perl is with a command-line option:

  ./configure --with-perl=/usr/local/bin/perl

When you're running make itself, you can override the default (or what
was specified during configure) with:

  make PERL_PATH=/usr/local/bin/perl

Both of the latter two work for me:

  $ ./configure --with-perl=/perl/from/configure
  [...]
  $ make
  [...]
  /perl/from/configure Makefile.PL PREFIX='/home/peff/local/git/master' INSTALL_BASE='' --localedir='/home/peff/local/git/master/share/locale'
  make[1]: /perl/from/configure: Command not found

  $ make PERL_PATH=/perl/from/make
  [...]
  /perl/from/make Makefile.PL PREFIX='/home/peff/local/git/master' INSTALL_BASE='' --localedir='/home/peff/local/git/master/share/locale'
  make[1]: /perl/from/make: Command not found

Obviously those are nonsense, but they quickly show that we're using the
requested version of perl.

-Peff
