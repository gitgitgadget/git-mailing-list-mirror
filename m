Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35E520D1E
	for <e@80x24.org>; Tue, 31 Jan 2017 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdAaTlu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 14:41:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:47446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbdAaTls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 14:41:48 -0500
Received: (qmail 23100 invoked by uid 109); 31 Jan 2017 19:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 19:41:43 +0000
Received: (qmail 4294 invoked by uid 111); 31 Jan 2017 19:41:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 14:41:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 20:41:39 +0100
Date:   Tue, 31 Jan 2017 20:41:39 +0100
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] blame: draft of line format
Message-ID: <20170131194138.fbcbdnkfjgizxnoa@sigill.intra.peff.net>
References: <20170131022830.8538-1-eantoranz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170131022830.8538-1-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 08:28:30PM -0600, Edmundo Carmona Antoranz wrote:

> +static void pretty_info(char* revid, struct blame_entry *ent, struct strbuf *rev_buffer)
> +{
> +	struct pretty_print_context ctx = {0};
> +	struct rev_info rev;
> +
> +	struct strbuf format = STRBUF_INIT;
> +	strbuf_addstr(&format, format_line);
> +	ctx.fmt = CMIT_FMT_USERFORMAT;
> +	get_commit_format(format.buf, &rev);
> +	pretty_print_commit(&ctx, ent->suspect->commit, rev_buffer);
> +	strbuf_release(&format);
> +}

I think this may be less awkward if you use format_commit_message() as
the entry point. Then you do not need a rev_info struct at all, it
touches fewer global variables, etc.

I don't know if that would cause the other difficulties you mentioned,
though.

-Peff
