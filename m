Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106A01F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbeCZIz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 04:55:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:42964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750923AbeCZIz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 04:55:58 -0400
Received: (qmail 9369 invoked by uid 109); 26 Mar 2018 08:55:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 08:55:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17785 invoked by uid 111); 26 Mar 2018 08:56:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 04:56:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 04:55:56 -0400
Date:   Mon, 26 Mar 2018 04:55:56 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/4] Documentation: list all type specifiers in config
 prose
Message-ID: <20180326085556.GC18714@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-3-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324005556.8145-3-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 08:55:54PM -0400, Taylor Blau wrote:

> The documentation for the `git-config(1)` builtin has not been recently
> updated to include new types, such as `--bool-or-int`, and
> `--expiry-date`. To ensure completeness when adding a new type
> specifier, let's update the existing documentation to include the new
> types.
> 
> Since this paragraph is growing in length, let's also convert this to a
> list so that it can be read with greater ease. We provide a minimal
> description of all valid type specifiers, and reference the <<OPTIONS>>
> section where each specifier is described in full detail.
> 
> This commit also prepares for the new type specifier `--color`, so that
> this section will not lag behind when yet more new specifiers are added.

Thanks for reformatting; the result is much easier to read. One nit:

> -The type specifier can be either `--int` or `--bool`, to make
> -'git config' ensure that the variable(s) are of the given type and
> -convert the value to the canonical form (simple decimal number for int,
> -a "true" or "false" string for bool), or `--path`, which does some
> -path expansion (see `--path` below).  If no type specifier is passed, no
> -checks or transformations are performed on the value.
> +A type specifier option can be used to force interpretation of values and
> +conversion to canonical form.  Currently supported type specifiers are:
> +
> +`bool`::
> +    The value is taken as a boolean.
> +
> +`int`::
> +    The value is taken as an integer.
> +
> +`bool-or-int`::
> +    The value is taken as a boolean or integer, as above.
> +
> +`path`::
> +    The value is taken as a filepath.
> +
> +`expiry-date`::
> +    The value is taken as a timestamp.
> +
> +For more information about the above type specifiers, see <<OPTIONS>> below.

The connection between "bool" here and "--bool" below isn't made
explicit. We probably should mention it.

Some of the details for the types are lost. E.g., what is a filepath?
The fact that we expand is not mentioned. I'm not sure how much that
matters, though. The full descriptions should be covered under "--path"
(and "--int", etc).

In fact, that kind of makes me wonder if this "type" list should not
exist at all. If we instead grouped the options and said "these are the
type options", then we'd only need one list.

I'm OK to punt on that for now, though, in the interest of not holding
up this patch series. I do think we should say something like:

  Each type can be specified with the matching command-line option
  (e.g., `--bool`, `--int`, etc); see <<OPTIONS>> below.

-Peff
