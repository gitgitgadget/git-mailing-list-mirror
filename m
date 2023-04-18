Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6EC77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 11:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDRLAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRLAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 07:00:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DDC40EF
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 04:00:50 -0700 (PDT)
Received: (qmail 5176 invoked by uid 109); 18 Apr 2023 11:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 11:00:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1315 invoked by uid 111); 18 Apr 2023 11:00:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 07:00:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 07:00:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
Message-ID: <20230418110049.GB516715@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <bfda40a21ddb7abceb6a7eb9aa1f71aa5d856333.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfda40a21ddb7abceb6a7eb9aa1f71aa5d856333.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:39PM -0400, Taylor Blau wrote:

>  for argv in \
> +	"gc" \
>  	"gc --cruft" \
>  	"-c gc.cruftPacks=true gc" \
> -	"-c gc.cruftPacks=false gc --cruft" \
> -	"-c feature.experimental=true gc" \
> -	"-c gc.cruftPacks=true -c feature.experimental=false gc"
> +	"-c gc.cruftPacks=false gc --cruft"
>  do

Oh good. I was a little sad to see the increase in the size of this loop
in the earlier patches, so now reducing the number of combinations is a
welcome change.

The set you have here looks fine, though isn't "gc --cruft" redundant
with "gc" now?

> @@ -246,9 +245,7 @@ done
>  for argv in \
>  	"gc --no-cruft" \
>  	"-c gc.cruftPacks=false gc" \
> -	"-c gc.cruftPacks=true gc --no-cruft" \
> -	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
> -	"-c feature.experimental=false gc"
> +	"-c gc.cruftPacks=true gc --no-cruft"

Likewise here, "gc --no-cruft" would have been redundant with "gc"
before this patch, but we did not even bother with it (so no need to
remove it here!).

The rest of the patch looks good, and I am quite on board with the
overall goal. It's been a long time coming. :)

-Peff
