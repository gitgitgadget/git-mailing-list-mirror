Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69348C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491A960249
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 10:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhG2KVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 06:21:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235155AbhG2KVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 06:21:50 -0400
Received: (qmail 8087 invoked by uid 109); 29 Jul 2021 10:21:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 10:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18265 invoked by uid 111); 29 Jul 2021 10:21:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 06:21:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 06:21:41 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
Message-ID: <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
 <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
 <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 10:58:15AM +0100, Philip Oakley wrote:

> In summary, there are two aspect:
> - first, being able to use a common short-form within the command, and
> - second, that the documentation's description includes rather too many
> tricky concepts to properly understand all the ramifications, leaving me
> to think "why can't I just say `git rebase --onto here old..end` or `git
> rebase --onto here start^..end` ? "

I do think "git rebase --onto here old..end" is a sensible thing to ask
for. If we were designing it today, I'd probably suggest that rebase
take arbitrary revision sets (and either require "--onto", or perhaps as
long as there is only one negative tip given, that becomes the "--onto"
point).

It might be possible to migrate to such a syntax, but we'd have to be
careful of ambiguities with the current syntax. It might be possible to
infer the intended use based on the presence or absence of negative tips
(so "git rebase foo bar" must be "foo is the upstream, and therefore
base branch", whereas "git rebase foo..bar" is a range, though the two
would do the same thing).

I think we did something similar with cherry-pick, which originally took
only a series of single commits.

I admit that I haven't thought carefully through the details, though.
There may be some gotchas in how "rebase" treats the base branch.

-Peff
