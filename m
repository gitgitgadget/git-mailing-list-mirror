Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C367211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLCWRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:17:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:57782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbeLCWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:17:31 -0500
Received: (qmail 5399 invoked by uid 109); 3 Dec 2018 22:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 22:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14650 invoked by uid 111); 3 Dec 2018 22:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 17:16:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 17:17:29 -0500
Date:   Mon, 3 Dec 2018 17:17:29 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
Subject: Re: [PATCH v2] revisions.c: put promisor option in specialized struct
Message-ID: <20181203221729.GC11883@sigill.intra.peff.net>
References: <20181203221019.237034-1-matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203221019.237034-1-matvore@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 02:10:19PM -0800, Matthew DeVore wrote:

> Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
> it was in rev_info, it was unclear when it was used, since rev_info is
> passed to functions that don't use the flag. This resulted in
> unnecessary setting of the flag in prune.c, so fix that as well.
> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  builtin/pack-objects.c |  6 ++++--
>  builtin/prune.c        |  1 -
>  builtin/rev-list.c     |  6 ++++--
>  revision.c             | 10 ++++++----
>  revision.h             |  4 ++--
>  5 files changed, 16 insertions(+), 11 deletions(-)

Thanks, this version looks good to me.

One style nit that I don't think is worth a re-roll, but that Junio
might want to tweak while applying:

> diff --git a/revision.c b/revision.c
> index 13e0519c02..f6b32e6a42 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1791,7 +1791,8 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>  }
>  
>  static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
> -			       int *unkc, const char **unkv)
> +			       int *unkc, const char **unkv,
> +			       const struct setup_revision_opt* opt)

We keep the "*" with the variable name, not the type.

-Peff
