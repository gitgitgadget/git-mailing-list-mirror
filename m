Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6541E1F794
	for <e@80x24.org>; Thu, 26 Jan 2017 07:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdAZHnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 02:43:06 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57198 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752662AbdAZHnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 02:43:05 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 912561F437;
        Thu, 26 Jan 2017 07:43:04 +0000 (UTC)
Date:   Thu, 26 Jan 2017 07:43:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: Re: [PATCH] Documentation: implement linkgit macro for Asciidoctor
Message-ID: <20170126074304.GA26530@starla>
References: <20170125234101.n2pzrp77df4zycv7@genre.crustytoothpaste.net>
 <20170126001344.445534-1-sandals@crustytoothpaste.net>
 <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126034655.fwzow2mgkjj5dpek@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, Jan 26, 2017 at 12:13:44AM +0000, brian m. carlson wrote:
> > +
> > +      def process(parent, target, attrs)
> > +        if parent.document.basebackend? 'html'
> > +          prefix = parent.document.attr('git-relative-html-prefix')
> > +          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>\n)
> > +        elsif parent.document.basebackend? 'docbook'
> > +          %(<citerefentry>
> > +<refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
> > +</citerefentry>
> > +)

<snip>

> The multi-line string is kind of ugly because of the indentation.
> Apparently Ruby has here-docs that will eat leading whitespace, but the
> syntax was not introduce until Ruby 2.3, which is probably more recent
> than we should count on.

You can use '\' to continue long lines with any Ruby version:

    "<citerefentry>" \
      "<refentrytitle>#{target}</refentrytitle>" \
      "<manvolnum>#{attrs[1]}</manvolnum>" \
    "</citerefentry>"

The above happens during the parse phase, so there's no garbage
or method call overhead compared to the more-frequently seen '+'
or '<<' method calls to combine strings.

> I think you could write:
> 
>           %(<citerefentry>
>             <refentrytitle>#{target}</refentrytitle><manvolnum>#{attrs[1]}</manvolnum>
>             </citerefentry>
> 	  ).gsub(/^\s*/, "")
> 
> I don't know if that's too clever or not.

Ick...

> But either way, I like this better than introducing an extra dependency.

Agreed.
