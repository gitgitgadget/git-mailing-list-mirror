Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93BA2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 04:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdCCEh2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 23:37:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:37621 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdCCEh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 23:37:27 -0500
Received: (qmail 28051 invoked by uid 109); 3 Mar 2017 03:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 03:37:16 +0000
Received: (qmail 24498 invoked by uid 111); 3 Mar 2017 03:37:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 22:37:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 22:37:14 -0500
Date:   Thu, 2 Mar 2017 22:37:14 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/9] setup_git_directory(): use is_dir_sep() helper
Message-ID: <20170303033714.5h7qrq57hdqwoi3y@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:07AM +0100, Johannes Schindelin wrote:

> It is okay in practice to test for forward slashes in the output of
> getcwd(), because we go out of our way to convert backslashes to forward
> slashes in getcwd()'s output on Windows.
> 
> Still, the correct way to test for a dir separator is by using the
> helper function we introduced for that very purpose. It also serves as a
> good documentation what the code tries to do (not "how").

Makes sense, but...

> @@ -910,7 +910,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>  			return setup_bare_git_dir(&cwd, offset, nongit_ok);
>  
>  		offset_parent = offset;
> -		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
> +		while (--offset_parent > ceil_offset &&
> +		       !is_dir_sep(dir->buf[offset_parent]));

What is "dir"? I'm guessing this patch got reordered and it should stay
as cwd.buf?

-Peff
