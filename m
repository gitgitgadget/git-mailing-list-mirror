Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AAB1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 10:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfIHKse (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 06:48:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:43332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728514AbfIHKse (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 06:48:34 -0400
Received: (qmail 17819 invoked by uid 109); 8 Sep 2019 10:48:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 10:48:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 499 invoked by uid 111); 8 Sep 2019 10:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 06:50:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 06:48:33 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908104833.GE15641@sigill.intra.peff.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907170746.273984-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 05:07:46PM +0000, brian m. carlson wrote:

> Our documentation toolchain has traditionally been built around DocBook
> 4.5.  This version of DocBook is the last DTD-based version of DocBook.
> In 2009, DocBook 5 was introduced using namespaces and its syntax is
> expressed in RELAX-NG, which is more expressive and allows a wider
> variety of syntax forms.

Wow, this patch turned out to be much simpler than I had feared. And the
explanation turned out to be much longer and more interesting than I
expected. :) Thanks for writing it all down.

The patch worked well for me.

> Fortunately, there's an easy way forward: ask Asciidoctor to use its
> DocBook 5 backend and tell xmlto to skip validation.  Asciidoctor has
> supported DocBook 5 since v0.1.4 in 2013 and xmlto has supported
> skipping validation for probably longer than that.
> 
> xmlto will still use the non-namespaced DocBook XSL stylesheets (which
> are designed for DocBook 4.5) for building the documentation instead of
> the namespaced ones (which are designed for DocBook 5).  This isn't
> really a problem, since both forms are built from the same source and
> can handle both versions, but it does mean that an ugly message about
> the stylesheets stripping the namespace will be printed to standard
> error.

So I think this does introduce the ugly namespace message even for
people who are using older versions of asciidoctor that understand
docbook45. But it's probably sensible to keep all of our asciidoctor
builds using the same technique. We have enough trouble tracking the
minor differences between the variants as it is.

> The differences in output between AsciiDoc 8.6.10 on master and
> Asciidoctor 2.0.10 with this patch are, with one exception, all due to
> whitespace, wrapping, or quoting and do not affect substantive content.

We know already there are a lot of differences between asciidoc and
asciidoctor here. What's more interesting to me is how it changes the
output between two versions of asciidoctor. Of course we can't check for
2.0.10, because it doesn't build at all. But I did do a "doc-diff"
with and without this patch using 1.5.5. There are quite a few
whitespace changes. Some of them seem good or at least neutral, like:

  --- a/745f6812895b31c02b29bdfe4ae8e5498f776c26-asciidoctor/home/peff/share/man/man1/git-add.1
  +++ b/303729d86b69657777222bf4b3a6f95932e12648-asciidoctor/home/peff/share/man/man1/git-add.1
  [...]
  @@ -43,6 +43,7 @@ DESCRIPTION

   OPTIONS
          <pathspec>...
  +
              Files to add content from. Fileglobs (e.g.  *.c) can be given to
              add all matching files. Also a leading directory name (e.g.  dir to
              add dir/file1 and dir/file2) can be given to update the index to

Some of them seem bad, though:

  --- a/745f6812895b31c02b29bdfe4ae8e5498f776c26-asciidoctor/home/peff/share/man/man1/git-am.1
  +++ b/303729d86b69657777222bf4b3a6f95932e12648-asciidoctor/home/peff/share/man/man1/git-am.1
  [...]
  @@ -175,10 +201,10 @@ DISCUSSION

          to process. Upon seeing the first patch that does not apply, it aborts
          in the middle. You can recover from this in one of two ways:
   
  -        1. skip the current patch by re-running the command with the --skip
  +        1.  skip the current patch by re-running the command with the --skip
              option.
   
  -        2. hand resolve the conflict in the working directory, and update the
  +        2.  hand resolve the conflict in the working directory, and update the
              index file to bring it into a state that the patch should have
              produced. Then run the command with the --continue option.

I tricked doc-diff into doing a comparison against 1.5.5 without the
patch and 2.0.10 with the patch, and the diff is similar.

-Peff
