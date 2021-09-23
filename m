Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3D3611B0
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbhIWQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:25:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242412AbhIWQZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 12:25:38 -0400
Received: (qmail 15295 invoked by uid 109); 23 Sep 2021 16:24:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 16:24:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28988 invoked by uid 111); 23 Sep 2021 16:24:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 12:24:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 12:24:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
Message-ID: <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 02:07:16AM +0200, Ævar Arnfjörð Bjarmason wrote:

> We ensure that the recursive dependencies are correct by depending on
> the *.o file, which in turn will have correct dependencies by either
> depending on all header files, or under
> "COMPUTE_HEADER_DEPENDENCIES=yes" the headers it needs.
> 
> This means that a plain "make sparse" is much slower, as we'll now
> need to make the *.o files just to create the *.sp files, but
> incrementally creating the *.sp files is *much* faster and less
> verbose, it thus becomes viable to run "sparse" along with "all" as
> e.g. "git rebase --exec 'make all sparse'".

OK. I think this solves the dependency issues sufficiently. It is a
tradeoff that you must do the normal build in order to do the sparse
check now. That is certainly fine for my workflow (I am building Git all
the time, and only occasionally run "make sparse"). I don't know if
others would like it less (e.g., if Ramsay is frequently running sparse
checks without having just built).

(I'd say "I do not care that much either way", but then I do not care
all that much either way about incremental sparse checks either, so I'm
not sure my opinion really matters).

-Peff
