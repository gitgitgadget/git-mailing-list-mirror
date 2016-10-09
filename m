Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3691207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbcJIXqV (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 19:46:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:54754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbcJIXqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 19:46:21 -0400
Received: (qmail 5075 invoked by uid 109); 9 Oct 2016 23:46:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 23:46:20 +0000
Received: (qmail 25415 invoked by uid 111); 9 Oct 2016 23:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 19:46:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Oct 2016 19:46:18 -0400
Date:   Sun, 9 Oct 2016 19:46:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: %C(auto) not working as expected
Message-ID: <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 09, 2016 at 03:24:17PM +0200, René Scharfe wrote:

> Offering a way to enable terminal-detection for all color codes of a
> format would be useful, but using the existing "auto," prefix for that
> would be a behaviour change that could surprise users.

Yeah. In retrospect, it probably would have been saner to make %C(red) a
noop when --color is not in effect (either because of --no-color, or
more likely when --color=auto is in effect and stdout is not a
terminal). But that ship has long since sailed, I think.

If we do a revamp of the pretty-formats to bring them more in line with
ref-filter (e.g., something like "%(color:red)") maybe that would be an
opportunity to make minor adjustments. Though, hmm, it looks like
for-each-ref already knows "%(color:red)", and it's unconditional.
<sigh> So perhaps we would need to go through some deprecation period or
other transition.

> ---
>  Documentation/pretty-formats.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index a942d57..89e3bc6 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -166,7 +166,8 @@ endif::git-rev-list[]
>  - '%Cgreen': switch color to green
>  - '%Cblue': switch color to blue
>  - '%Creset': reset color
> -- '%C(...)': color specification, as described in color.branch.* config option;
> +- '%C(...)': color specification, as described under Values, color in the
> +  "CONFIGURATION FILE" section of linkgit:git-config[1];

I like the intent here, though I found "Values, color" hard to parse (it
was not immediately clear that you mean "the color paragraph of the
Values section", as commas are already being used in that sentence for
the parenthetical phrase).

I'm not sure how to say that succinctly, as we are four levels deep
(git-config -> configuration file -> values -> color). Too bad there is
no good link syntax for it. Maybe:

  ...color specification, as described in linkgit:git-config[1] (see the
  paragraph on colors in the "Values" section, under "CONFIGURATION
  FILE")

or something.

-Peff
