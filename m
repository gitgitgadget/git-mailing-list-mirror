Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E4C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415E6613DA
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 14:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFXOxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:53:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFXOxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 10:53:14 -0400
Received: (qmail 12062 invoked by uid 109); 24 Jun 2021 14:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 14:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12957 invoked by uid 111); 24 Jun 2021 14:50:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 10:50:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 10:50:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] test-lib.sh: set COLUMNS=80 for --verbose repeatability
Message-ID: <YNSbzYvwSC0ZOo+Y@coredump.intra.peff.net>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
 <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 12:19:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Some tests will fail under --verbose because while we've unset COLUMNS
> since b1d645b58ac (tests: unset COLUMNS inherited from environment,
> 2012-03-27), we also look for the columns with an ioctl(..,
> TIOCGWINSZ, ...) on some platforms. By setting COLUMNS again we
> preempt the TIOCGWINSZ lookup in pager.c's term_columns(), it'll take
> COLUMNS over TIOCGWINSZ,
> 
> This fixes the t0500-progress-display.sh test when run as:
> 
>     ./t0500-progress-display.sh --verbose
> 
> It broke because of a combination of the this issue and the progress
> output reacting to the column width since 545dc345ebd (progress: break
> too long progress bar lines, 2019-04-12). The
> t5324-split-commit-graph.sh fails in a similar manner due to progress
> output, see [1] for details.
> 
> A more narrow fix here would be to only do this in the --verbose mode,
> but there's no harm in setting this for everything. If we're not
> connected to a TTY the COLUMNS setting won't matter.

Thanks, this explanation and location make sense to me.

(minor s/the this/this/ in the third paragraph above).

-Peff
