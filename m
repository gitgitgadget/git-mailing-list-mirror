Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD19EC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A77C208E4
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgIOPio (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 11:38:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:57152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgIOP1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 11:27:38 -0400
Received: (qmail 13035 invoked by uid 109); 15 Sep 2020 15:27:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 15:27:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18850 invoked by uid 111); 15 Sep 2020 15:27:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 11:27:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 11:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915152730.GA2853972@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915140613.GB18984@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 04:06:13PM +0200, Alex Riesen wrote:

> > Yeah, that would solve the duplication problem. We could probably add a
> > "recursive" bit to the parse-options flag variable. Even if
> > parse-options itself doesn't use it, it could be a convenience for
> > callers like this one. It is a little inconvenient to set flags there,
> > just because it usually means ditching our wrapper macros in favor of a
> > raw struct declaration.
> 
> Or extend the list of wrappers with _REC(URSIVE) macros

If you go that route, we have some "_F" macros that take flags. Probably
would make sense to add it more consistently, which lets you convert:

  OPT_BOOL('f', "foo", &foo, "the foo option");

into:

  OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);

but could also be used for other flags.

-Peff
