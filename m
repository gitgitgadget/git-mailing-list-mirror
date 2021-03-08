Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EAC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770A3652AC
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCHTav (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:30:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:55958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhCHTa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:30:26 -0500
Received: (qmail 26794 invoked by uid 109); 8 Mar 2021 19:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Mar 2021 19:30:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21197 invoked by uid 111); 8 Mar 2021 19:30:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Mar 2021 14:30:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 Mar 2021 14:30:25 -0500
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 6/7] init-db: silence template_dir leak when converting
 to absolute path
Message-ID: <YEZ7UXBScYozVfUS@coredump.intra.peff.net>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <6f81f3b2ab285f424c687072d4aef811a2471c24.1615228580.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f81f3b2ab285f424c687072d4aef811a2471c24.1615228580.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 06:36:19PM +0000, Andrzej Hunt via GitGitGadget wrote:

> template_dir starts off pointing to either argv or nothing. However if
> the value supplied in argv is a relative path, absolute_pathdup() is
> used to turn it into an absolute path. absolute_pathdup() allocates
> a new string, and we then "leak" it when cmd_init_db() completes.
> 
> We don't bother to actually free the return value (instead we UNLEAK
> it), because there's no significant advantage to doing so here.
> Correctly freeing it would require more significant changes to code flow
> which would be more noisy than beneficial.

Makes sense. The UNLEAK() could be conditional at the end of the
function (since it is OK to unleak a non-allocated variable, too), but I
like keeping it here with the allocation for clarity.

-Peff
