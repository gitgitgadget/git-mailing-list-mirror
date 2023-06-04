Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB2C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 06:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjFDGcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFDGcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 02:32:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC5B3
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 23:32:08 -0700 (PDT)
Received: (qmail 1260 invoked by uid 109); 4 Jun 2023 06:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jun 2023 06:32:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17823 invoked by uid 111); 4 Jun 2023 06:32:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jun 2023 02:32:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jun 2023 02:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
Message-ID: <20230604063206.GB47137@coredump.intra.peff.net>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
 <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
 <ae89feda-0a76-29d7-14ce-662214414638@github.com>
 <20230601174746.GA4165405@coredump.intra.peff.net>
 <xmqqa5xh8k4i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5xh8k4i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2023 at 09:28:13AM +0900, Junio C Hamano wrote:

> I agree with the "devil's advocate" above; indeed my suggestion to
> follow-on work that is enabled by introducing this function, i.e. we
> can ensure that the objects already instantiated when the call is
> made are not affected by the replace mechanism, was exactly for such
> a "we already accessed some objects via the replace mechanism and
> then try to close the door of the barn afterwards with this call"
> case.
> 
> Indeed, I think "git branch --no-merged 0369cf" resolves the object
> name down to a commit object in parse_opt_merge_filter() before
> parse_options() call returns.
> 
> Yes.

Ah, very good example. Yes, I'd think it would be appropriate to BUG()
if disable_replace_refs() is called and anybody has looked up an object
already.

-Peff
