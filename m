Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2CDC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24454613C2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGNQsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:48:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:49532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGNQsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:48:36 -0400
Received: (qmail 28880 invoked by uid 109); 14 Jul 2021 16:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 16:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25793 invoked by uid 111); 14 Jul 2021 16:45:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 12:45:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 12:45:43 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] doc: document the special handling of -l0
Message-ID: <YO8Ut9b+6D/wR6uf@coredump.intra.peff.net>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:12:32AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
> mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
> historical value associated with it.  Document this value, particularly
> since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
> (diff: remove silent clamp of renameLimit, 2017-11-13).
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/diff-options.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 11e08c3fd36..ba40ac66cc9 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -594,6 +594,9 @@ of a delete/create pair.
>  	exhaustive portion of rename/copy detection from running if
>  	the number of rename/copy targets exceeds the specified
>  	number.  Defaults to diff.renameLimit.
> ++
> +Note that for backward compatibility reasons, a value of 0 is treated
> +the same as if a large value was passed (currently, 32767).

Given the confusion around what "32767" even means to users, I wonder if
we could just say: a value of 0 removes any artificial limits (but Git
still has some internal limits which real-world cases are not likely to
hit).

Removing limits is after all the point of "0". I'm also not sure if it
is simply for backwards compatibility. We commonly let "0" or "-1" mean
"no limit" for convenience. It seems like something we'd want to
support.

-Peff
