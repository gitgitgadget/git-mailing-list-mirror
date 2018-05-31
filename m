Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A9B1F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeEaFPt (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:15:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751092AbeEaFPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:15:48 -0400
Received: (qmail 11443 invoked by uid 109); 31 May 2018 05:15:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:15:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9263 invoked by uid 111); 31 May 2018 05:15:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:15:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:15:46 -0400
Date:   Thu, 31 May 2018 01:15:46 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] refs/packed-backend.c: close fd of empty file
Message-ID: <20180531051546.GA17068@sigill.intra.peff.net>
References: <20180530170302.191176-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180530170302.191176-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 10:03:00AM -0700, Stefan Beller wrote:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index cec3fb9e00f..d447a731da0 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -499,6 +499,7 @@ static int load_contents(struct snapshot *snapshot)
>  	size = xsize_t(st.st_size);
>  
>  	if (!size) {
> +		close(fd);
>  		return 0;
>  	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
>  		snapshot->buf = xmalloc(size);

Yep, this is definitely correct. Good catch.

-Peff
