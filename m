Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D1F2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbdBQIMJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:12:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:56956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbdBQIMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:12:08 -0500
Received: (qmail 4158 invoked by uid 109); 17 Feb 2017 08:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 08:12:07 +0000
Received: (qmail 31907 invoked by uid 111); 17 Feb 2017 08:12:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 03:12:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 03:12:06 -0500
Date:   Fri, 17 Feb 2017 03:12:06 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] delete_refs(): accept a reflog message argument
Message-ID: <20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-2-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217035800.13214-2-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 10:57:58PM -0500, Kyle Meyer wrote:

> When the current branch is renamed with 'git branch -m/-M' or deleted
> with 'git update-ref -m<msg> -d', the event is recorded in HEAD's log
> with an empty message.
> 
> In preparation for adding a more meaningful message to HEAD's log in
> these cases, update delete_ref() to take a message argument and pass
> it along to ref_transaction_delete().  Modify all callers to pass NULL
> for the new message argument; no change in behavior is intended.

Seems like a good first step.

> diff --git a/refs.h b/refs.h
> index 9fbff90e7..81627a63d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -277,7 +277,7 @@ int reflog_exists(const char *refname);
>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>   */
>  int delete_ref(const char *refname, const unsigned char *old_sha1,
> -	       unsigned int flags);
> +	       unsigned int flags, const char *msg);

Should the "msg" argument go at the beginning, to match update_ref()?

-Peff
