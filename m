Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D3D1F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbdHJXUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752882AbdHJXUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:20:36 -0400
Received: (qmail 2236 invoked by uid 109); 10 Aug 2017 23:20:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:20:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11762 invoked by uid 111); 10 Aug 2017 23:20:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:20:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:20:34 -0400
Date:   Thu, 10 Aug 2017 19:20:34 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while
 generating patches
Message-ID: <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-2-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810183256.12668-2-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 02:32:55PM -0400, Kevin Willford wrote:

> @@ -1493,6 +1496,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		OPT_FILENAME(0, "signature-file", &signature_file,
>  				N_("add a signature from a file")),
>  		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
> +		OPT_BOOL(0, "progress", &show_progress,
> +			 N_("show progress while generating patches")),

Earlier I suggested allowing --progress="custom text" since this may be
driven as plumbing for other commands. But I don't think there's any
need to worry about it now. It can be added seamlessly later if we find
such a caller.

> @@ -1752,8 +1757,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		start_number--;
>  	}
>  	rev.add_signoff = do_signoff;
> +
> +	if (show_progress)
> +		progress = start_progress_delay(_("Generating patches"), total, 0, 1);

I don't really have an opinion on a 1 second delay versus 2. I thought
we used 2 pretty consistently, though grepping around I do see a couple
of 1's. It probably doesn't matter, but just a curiosity.

-Peff
