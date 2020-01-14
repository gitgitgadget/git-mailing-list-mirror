Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEFC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0135424670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgANVVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:21:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:36564 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728748AbgANVVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:21:21 -0500
Received: (qmail 10236 invoked by uid 109); 14 Jan 2020 21:21:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 21:21:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25412 invoked by uid 111); 14 Jan 2020 21:27:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 16:27:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 16:21:20 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 7/8] sparse-checkout: properly match escaped characters
Message-ID: <20200114212120.GC3949560@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <09dbe1f9029d173e579b74442b02bc20e1a82437.1579029963.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09dbe1f9029d173e579b74442b02bc20e1a82437.1579029963.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 07:26:01PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In cone mode, the sparse-checkout feature uses hashset containment
> queries to match paths. Make this algorithm respect escaped asterisk
> (*) and backslash (\) characters.
> 
> Create dup_and_filter_pattern() method to convert a pattern by
> removing escape characters and dropping an optional "/*" at the end.
> This method is available in dir.h as we will use it in
> builtin/sparse-chekcout.c in a later change.

s/chekcout/checkout/

It took me a minute to understand the problem here, but I think it's: if
a path in the sparse-checkout file has "\*" in it, we'd try to match a
literal "\*" in the hash, not "*"?

But we wouldn't run into that yet because we don't properly _write_ the
escaped names until patch 8.

Is that right?

-Peff
