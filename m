Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE488C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJKATW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJKATT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:19:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC75F221
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:19:17 -0700 (PDT)
Received: (qmail 29620 invoked by uid 109); 11 Oct 2022 00:19:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:19:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15099 invoked by uid 111); 11 Oct 2022 00:19:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:19:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:19:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir: use fspathncmp() in pl_hashmap_cmp()
Message-ID: <Y0S2hCA/xoV8RWTt@coredump.intra.peff.net>
References: <cb6ffcdb-d719-7928-96b8-e46482dd141f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb6ffcdb-d719-7928-96b8-e46482dd141f@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 08, 2022 at 01:05:43PM +0200, René Scharfe wrote:

> From: Jeff King <peff@peff.net>
> 
> Call fspathncmp() instead of open-coding it.  This shortens the code and
> makes it less repetitive.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> From https://lore.kernel.org/git/YSv1XZJvYdYj1JtP@coredump.intra.peff.net/

That's an old one. :) Thanks for hanging on to it.

> diff --git a/dir.c b/dir.c
> index 7d56d68355..28f4c6895b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -669,9 +669,7 @@ int pl_hashmap_cmp(const void *cmp_data UNUSED,
>  			 ? ee1->patternlen
>  			 : ee2->patternlen;
> 
> -	if (ignore_case)
> -		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
> -	return strncmp(ee1->pattern, ee2->pattern, min_len);
> +	return fspathncmp(ee1->pattern, ee2->pattern, min_len);
>  }

Unlike the other one discussed in that thread, where there is a shadow
ignore_case, we decided that this one is a true simplification.

-Peff
