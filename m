Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797AD20756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdAQPaY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:30:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40181 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdAQPaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:30:22 -0500
Received: (qmail 5116 invoked by uid 109); 17 Jan 2017 15:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:30:21 +0000
Received: (qmail 18119 invoked by uid 111); 17 Jan 2017 15:31:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 10:31:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 10:30:19 -0500
Date:   Tue, 17 Jan 2017 10:30:19 -0500
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 10:24:55AM -0500, Jeff King wrote:

> On Sun, Jan 15, 2017 at 01:47:01PM -0500, santiago@nyu.edu wrote:
> 
> > From: Lukas Puehringer <luk.puehringer@gmail.com>
> > 
> > Calling functions for gpg_verify_tag() may desire to print relevant
> > information about the header for further verification. Add an optional
> > format argument to print any desired information after GPG verification.
> 
> Hrm. Maybe I am missing something, but what does:
> 
>   verify_and_format_tag(sha1, name, fmt, flags);
> 
> get you over:
> 
>   gpg_verify_tag(sha1, name, flags);
>   pretty_print_ref(name, sha1, fmt);
> 
> ? The latter seems much more flexible, and I do not see how the
> verification step impacts the printing at all (or vice versa).
> 
> I could understand it more if there were patches later in the series
> that somehow used the format and verification results together. But I
> didn't see that.

Having read through the rest of the series, it looks like you'd
sometimes have to do:

  int ret;

  ret = gpg_verify_tag(sha1, name, flags);
  pretty_print_ref(name, sha1, fmt);
  if (ret)
      ... do something ...

and this function lets you do it in a single line.

Still, I think I'd rather see it done as a wrapper than modifying
gpg_verify_tag().

-Peff
