Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EADFE1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeELJdr (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:33:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750916AbeELJdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:33:47 -0400
Received: (qmail 25061 invoked by uid 109); 12 May 2018 09:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13783 invoked by uid 111); 12 May 2018 09:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:33:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:33:45 -0400
Date:   Sat, 12 May 2018 05:33:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/12] revision.c: use commit-slab for show_source
Message-ID: <20180512093344.GG28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-7-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:22AM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/revision.h b/revision.h
> index b8c47b98e2..72404e2599 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -6,6 +6,7 @@
>  #include "notes.h"
>  #include "pretty.h"
>  #include "diff.h"
> +#include "commit-slab.h"
>  
>  /* Remember to update object flag allocation in object.h */
>  #define SEEN		(1u<<0)
> @@ -29,6 +30,7 @@ struct rev_info;
>  struct log_info;
>  struct string_list;
>  struct saved_parents;
> +define_commit_slab(source_slab, char *);

Since this one is a global, can we give it a name that ties it to the
revision machinery? Like "revision_source_slab" or something?

I wonder if we can even drop the "slab" to make the name shorter (e.g.,
"revision_sources" or something).

It's a little ugly that everybody who includes revision.h gets the full
set of static functions defined. I wonder if we should have separate
declare/define macros to let these exist as real functions. Maybe it
doesn't really matter, though.

-Peff
