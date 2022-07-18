Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D7CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGRPOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiGRPO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:14:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182C10540
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:14:28 -0700 (PDT)
Received: (qmail 32259 invoked by uid 109); 18 Jul 2022 15:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 15:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10106 invoked by uid 111); 18 Jul 2022 15:14:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 11:14:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 11:14:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] revisions API: fix more memory leaks
Message-ID: <YtV40w0n9muPnM1O@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:10:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Ævar Arnfjörð Bjarmason (6):
>   bisect.c: add missing "goto" for release_revisions()
>   test-fast-rebase helper: use release_revisions() (again)
>   log: make the intent of cmd_show()'s "rev.pending" juggling clearer
>   log: fix common "rev.pending" memory leak in "git show"
>   bisect.c: partially fix bisect_rev_setup() memory leak
>   revisions API: don't leak memory on argv elements that need free()-ing

This looks correct overall to me. I left a few comments:

  - the readability tweaks in 3 and 4 I think are worth doing. If you
    agree, I'd like to see that in a re-roll.

  - the bigger "rev_info owns its argv" option for patches 5 and 6 is a
    good suggestion, I think, but maybe is a bigger change (though if
    it's optional, it shouldn't need to affect any other callers). But
    if it derails things, it may not be worth doing now. I can live
    without it.

-Peff
