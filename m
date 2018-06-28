Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9201F516
	for <e@80x24.org>; Thu, 28 Jun 2018 18:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966832AbeF1Sce (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 14:32:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966745AbeF1Scd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 14:32:33 -0400
Received: (qmail 24018 invoked by uid 109); 28 Jun 2018 18:32:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 18:32:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24229 invoked by uid 111); 28 Jun 2018 18:32:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 14:32:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 14:32:31 -0400
Date:   Thu, 28 Jun 2018 14:32:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
Message-ID: <20180628183231.GA12657@sigill.intra.peff.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 04:26:00PM -0500, Taylor Blau wrote:

> For instance, a line containing the following (taken from README.md:27):
> 
>   (`man gitcvs-migration` or `git help cvs-migration` if git is
> 
> Is printed as follows:
> 
>   $ git grep -no -e git -- README.md | grep ":27"
>   README.md:27:7:git
>   README.md:27:16:git
>   README.md:27:38:git

This is with "--column", too, right?

> Like GNU grep, this patch ignores --only-matching when --invert (-v) is
> given. There is a sensible answer here, but parity with the behavior of
> other tools is preferred.

Yeah, after all of our discussion about inverted matching and columns,
I'm sure we could come up with _some_ answer. But I agree that what you
have here is quite sensible, and matching GNU grep seems like a good
idea.

> ---
>  builtin/grep.c  |  6 ++++++
>  grep.c          | 48 +++++++++++++++++++++++++++++++++---------------
>  grep.h          |  1 +
>  t/t7810-grep.sh | 15 +++++++++++++++
>  4 files changed, 55 insertions(+), 15 deletions(-)

The patch itself looks pretty straightforward to me (especially with
"-w"). I didn't hit the compiler warning that Junio did (I have gcc
7.3.0). But I agree it's better to avoid even passing an uninitialized
variable to another function.

-Peff
