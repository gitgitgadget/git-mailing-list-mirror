Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659061F4F8
	for <e@80x24.org>; Wed, 19 Oct 2016 09:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757104AbcJSJGR (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 05:06:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:59208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756689AbcJSJEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 05:04:45 -0400
Received: (qmail 5966 invoked by uid 109); 19 Oct 2016 09:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 09:04:33 +0000
Received: (qmail 11222 invoked by uid 111); 19 Oct 2016 09:04:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 05:04:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 05:04:33 -0400
Date:   Wed, 19 Oct 2016 05:04:33 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v4 4/7] builtin/verify-tag: add --format to verify-tag
Message-ID: <20161019090432.xip4r7f6xwcciqk4@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-5-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-5-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 05:07:18PM -0400, santiago@nyu.edu wrote:

> @@ -46,12 +50,17 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  	if (verbose)
>  		flags |= GPG_VERIFY_VERBOSE;
>  
> +	if (fmt_pretty) {
> +		verify_ref_format(fmt_pretty);
> +		flags |= GPG_VERIFY_QUIET;
> +	}

I see why you would want to disable the normal output when there is a
custom format. But it seems a shame that the GPG information cannot be
retrieved as part of that format.

I think in the long run we'd want something like pretty.c's "%G"
placeholders for the ref-filter pretty-printer. But I think we are OK to
do this patch without it. It allows at least:

  tag=v2.0.0
  got=$(git verify-tag --format='%(tag)' "$tag") &&
  test "$tag" = "$got" ||
  echo >&2 "verification failed"

which is better than what we have now, and can be extended in the
future.

-Peff
