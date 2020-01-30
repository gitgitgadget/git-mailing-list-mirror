Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E61C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4D12083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgA3H37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:29:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:48186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726185AbgA3H37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:29:59 -0500
Received: (qmail 21746 invoked by uid 109); 30 Jan 2020 07:29:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 07:29:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21484 invoked by uid 111); 30 Jan 2020 07:37:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 02:37:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 02:29:57 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
Message-ID: <20200130072957.GE2189233@coredump.intra.peff.net>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
 <20200129101713.GB4218@coredump.intra.peff.net>
 <20200129103352.GD4218@coredump.intra.peff.net>
 <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 09:16:11AM -0500, Derrick Stolee wrote:

> I've applied the smaller comments and am now investigating the right
> thing to do with other is_glob_special() characters. There is a small
> chance that I can replace any "c == '*' || c == '\'" with is_glob_special(),
> but we shall see. At the very least, I'll need to expand my tests.

Yeah, that's all I'd expect to need. You mentioned earlier about how
ls-tree would output them, but I don't think it would matter. Now that
you're using unquote_c_style(), you'll get the literal filenames no
matter which way ls-tree decides to quote them (and I don't think it
would quote '?', just as it wouldn't '*', because those are not
syntactically significant in its output).

-Peff
