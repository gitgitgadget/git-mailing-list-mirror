Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE8C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjFARrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFARrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:47:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA013D
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:47:47 -0700 (PDT)
Received: (qmail 6052 invoked by uid 109); 1 Jun 2023 17:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25356 invoked by uid 111); 1 Jun 2023 17:47:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:47:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:47:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        gitster@pobox.com
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
Message-ID: <20230601174746.GA4165405@coredump.intra.peff.net>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
 <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
 <ae89feda-0a76-29d7-14ce-662214414638@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae89feda-0a76-29d7-14ce-662214414638@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2023 at 09:37:10AM -0400, Derrick Stolee wrote:

> > In this place and several others in the file, you opt to not just
> > replace the assignment with a function call, but move the action line
> > to later in the file.  In some cases, much later.
> > 
> > I don't think it hurts things, but it certainly makes me wonder why it
> > was moved.  Did it break for some reason when called earlier?  (Is
> > there something trickier about this patch than I expected?)
> 
> Generally, I decided to move it after option-parsing, so it wouldn't
> be called if we are hitting an option-parse error.

Playing devil's advocate: would option parsing ever access an object? I
think in most cases the answer is no, but I could imagine it happening
for some special cases (e.g., update-index uses callbacks to act on
options as we parse them, since order is important).

So I think as a general principle it makes sense for commands to set
this flag as early as possible.

> However, these moves were only important for a draft version where
> I had not separated the global and local scopes, so calling the method
> would also load config.
> 
> In this version of the patch, this is not needed at all, and I could
> do an in-line replacement. Thanks!

It sounds like you were going to switch the locations back anyway, but
maybe the above gives an extra motivation. :)

-Peff
