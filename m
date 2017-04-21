Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DBF71FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 06:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035826AbdDUGd3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 02:33:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035281AbdDUGd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 02:33:27 -0400
Received: (qmail 2928 invoked by uid 109); 21 Apr 2017 06:33:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 06:33:26 +0000
Received: (qmail 14377 invoked by uid 111); 21 Apr 2017 06:33:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 02:33:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 02:33:25 -0400
Date:   Fri, 21 Apr 2017 02:33:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/15] log: report errno on failure to fopen() a file
Message-ID: <20170421063324.uumqm4shxunyoii4@sigill.intra.peff.net>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170420112609.26089-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420112609.26089-6-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 06:25:59PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index b3b10cc1ed..26d6a3cf14 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -858,7 +858,8 @@ static int open_next_file(struct commit *commit, const char *subject,
>  		printf("%s\n", filename.buf + outdir_offset);
>  
>  	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
> -		return error(_("Cannot open patch file %s"), filename.buf);
> +		return error_errno(_("Cannot open patch file %s"),
> +				   filename.buf);
>  
>  	strbuf_release(&filename);
>  	return 0;

Not a new problem with your patch, but just looking at the context it
seems clear that "filename" is leaked in the error case.

-Peff
