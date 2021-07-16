Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31428C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0565C613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhGPTi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:38:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:52302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhGPTi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:38:27 -0400
Received: (qmail 21778 invoked by uid 109); 16 Jul 2021 19:35:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 19:35:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12229 invoked by uid 111); 16 Jul 2021 19:35:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 15:35:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 15:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH 1/2] trailer: handle input without trailing newline
Message-ID: <YPHfgyR5ZS2pPr0P@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <c17ff7ac483ad3990680a3bb1b67898564eb9379.1626421416.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c17ff7ac483ad3990680a3bb1b67898564eb9379.1626421416.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 07:43:35AM +0000, Luca Weiss via GitGitGadget wrote:

> From: Luca Weiss <luca@z3ntu.xyz>
> 
> Add a corresponding test case for this as well

The details you put in the cover letter won't make it into the Git
history. This would be a good place to put them.

>  t/t7513-interpret-trailers.sh | 7 +++++++
>  trailer.c                     | 3 +++
>  2 files changed, 10 insertions(+)

That patch itself looks good to me, with one minor style nit:

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 04885d0a5e5..ff5f1724ad0 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -17,6 +17,7 @@ test_expect_success 'setup' '
>  
>  		body
>  	EOF
> +	printf "subject\n\nbody" > basic_message_no_eol &&

Our preferred style is to omit whitespace between redirection operators
and filenames (i.e., ">basic_message_no_eol").

> +test_expect_success 'with message without trailing newline twice' '
> +	git interpret-trailers --trailer "Cc: Peff" basic_message_no_eol > intermediary &&
> +	git interpret-trailers --trailer "Cc: Peff" intermediary > actual &&
> +	test_cmp intermediary actual
> +'

Ditto here.

-Peff
