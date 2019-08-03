Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851E71F731
	for <e@80x24.org>; Sat,  3 Aug 2019 23:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfHCXpX (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:45:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:33282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729159AbfHCXpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:45:23 -0400
Received: (qmail 23525 invoked by uid 109); 3 Aug 2019 23:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Aug 2019 23:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15732 invoked by uid 111); 3 Aug 2019 23:47:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Aug 2019 19:47:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 3 Aug 2019 19:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] l10n: reformat some localized strings for v2.23.0
Message-ID: <20190803234522.GA5417@sigill.intra.peff.net>
References: <20190730033512.7226-1-worldhello.net@gmail.com>
 <20190803195907.3124-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190803195907.3124-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 03, 2019 at 09:59:07PM +0200, Jean-Noël Avila wrote:

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  builtin/checkout.c |  2 +-
>  builtin/fetch.c    | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 91f8509f85..08e19ed1ed 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1769,7 +1769,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>  	struct option *options;
>  	struct option restore_options[] = {
>  		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
> -			   N_("where the checkout from")),
> +			   N_("where the checkout is from")),

I think your original "where to checkout from" is better.

As a native speaker, "where the checkout is from" implies that checkout
is a noun that is being described. But I think we want checkout to be a
verb (because we are talking about the operation), and the option tells
Git how to do that operation.

(I agree the original "where the checkout from" is nonsense).

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 53ce99d2bb..0e8760e5d4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -850,6 +850,15 @@ static int iterate_ref_map(void *cb_data, struct object_id *oid)
>  	return 0;
>  }
>  
> +static char warn_show_forced_updates[] =
> +N_("Fetch normally indicates which branches had a forced update, but that\n"
> +   "check has been disabled. To re-enable, use '--show-forced-updates' flag\n"
> +   "or run 'git config fetch.showForcedUpdates true'.");

This one isn't a typo fix, right? It's just putting the two warning()
calls into a single message. I can see how this would be useful for
translators, but note that the output will be different. The original
would be something like:

  warning: Fetch normally indicates...
  warning: To re-enable...

where now we'd get:

  warning: Fetch normally indicates...
  check has been disabled...
  or run 'git config...

which might be a bit harder to read because the wrapped lines lose the
prefix. For advise() we nicely pick out the newlines and prefix each
line individually, but warning(), error(), etc, don't do that. Maybe
they should.

That's too big for this late in the -rc cycle, I think. In the meantime,
I'm not sure which (the original or your patch) is the least-bad
solution. :)

This change (if I am right that there's no actual typo fix) should
perhaps be in a separate patch from the earlier hunk, though.

-Peff
