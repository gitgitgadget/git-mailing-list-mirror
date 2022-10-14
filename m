Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F92C43217
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJNUOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiJNUOW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:14:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82544495
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:14:18 -0700 (PDT)
Received: (qmail 15183 invoked by uid 109); 14 Oct 2022 20:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Oct 2022 20:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2198 invoked by uid 111); 14 Oct 2022 20:14:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Oct 2022 16:14:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Oct 2022 16:14:16 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] config: respect includes in protected config
Message-ID: <Y0nDGFVxC4ImbLFQ@coredump.intra.peff.net>
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
 <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 05:43:47PM +0000, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
> 
> Protected config is implemented by reading a fixed set of paths,
> which ignores config [include]-s. Replace this implementation with a
> call to config_with_options(), which handles [include]-s and saves us
> from duplicating the logic of 1) identifying which paths to read and 2)
> reading command line config.

FWIW, this left me scratching my head for a moment, as I thought it was
advocating reading includes from unsafe sources (which, since they can
specify arbitrary paths, can cause various bits of mischief).

But looking at the patch, you mean that when reading potentially-unsafe
sources, we'll skip the unsafe ones (like .git/config) entirely, but we
fail to respect includes in the safe ones (like ~/.gitconfig)? That
makes sense.

-Peff
