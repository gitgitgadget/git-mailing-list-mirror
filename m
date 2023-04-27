Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214EDC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbjD0ISq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbjD0ISo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:18:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706403A9A
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:18:43 -0700 (PDT)
Received: (qmail 20746 invoked by uid 109); 27 Apr 2023 08:18:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:18:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17316 invoked by uid 111); 27 Apr 2023 08:18:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:18:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:18:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/4] fixing some parse_commit() timestamp corner cases
Message-ID: <20230427081842.GA1478510@coredump.intra.peff.net>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
 <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
 <xmqqttx43q08.fsf@gitster.g>
 <20230426113658.GC130148@coredump.intra.peff.net>
 <xmqqildiveu6.fsf@gitster.g>
 <20230427081330.GA1461786@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 04:13:31AM -0400, Jeff King wrote:

>     @@ t/t4212-log-corrupt.sh: test_expect_success 'absurdly far-in-future date' '
>      +	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
>      +	echo : >expect &&
>      +	git log -1 --format="%at:%ct" $ws_commit >actual &&
>     ++	test_cmp expect actual &&
>     ++	git log -1 --format="%at:%ct" $vt_commit &&
>      +	test_cmp expect actual

In case anyone is just reading the range-diff, you may notice that the
added git-log invocation here is missing its ">actual" redirect. I
noticed this while sending out, and it's fixed in the actual v3 patch
that was sent.

-Peff
