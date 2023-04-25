Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32917C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjDYF4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjDYF4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:56:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DCAD2A
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:56:21 -0700 (PDT)
Received: (qmail 21839 invoked by uid 109); 25 Apr 2023 05:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 956 invoked by uid 111); 25 Apr 2023 05:56:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:56:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:56:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230425055620.GA4015761@coredump.intra.peff.net>
References: <20230422135001.GA3942563@coredump.intra.peff.net>
 <7f48188b-2e06-9f01-de8d-a24812fb20fe@web.de>
 <20230423003715.GB3953216@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230423003715.GB3953216@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 08:37:15PM -0400, Jeff King wrote:

> > You could use (our own) isdigit() here instead.  It's more concise and
> > efficient.
> 
> Heh, yes, that is much better. I had strspn() on the mind since that is
> what split_ident_line() uses.
> 
> I think it could even just be:
> 
>   if (dateptr != eol)
> 
> which implies that we found some non-whitespace character, and then we
> rely on parse_timestamp() to return 0 (which is what the current code is
> effectively doing).

This should be "dateptr == eol" of course, because the body of the
conditional is "return 0" to signal an error. It's correct in the v2 of
the series I just sent out.

-Peff
