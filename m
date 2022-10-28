Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6375AFA373D
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 00:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiJ1A5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ1A5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 20:57:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A19A50EC
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:57:31 -0700 (PDT)
Received: (qmail 18580 invoked by uid 109); 28 Oct 2022 00:57:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Oct 2022 00:57:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27635 invoked by uid 111); 28 Oct 2022 00:57:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Oct 2022 20:57:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Oct 2022 20:57:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] Makefile: fix issues with bin-wrappers/% rule
Message-ID: <Y1so+kU1sZqYAS4y@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 04:42:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This simple topic fixes issues with the bin-wrappers/% rules, as seen
> in the range-diff below this never worked properly:
> 
> 	make bin-wrappers/git
> 
> I.e. we'd make the scirpt, but not "git".

Maybe I'm missing something, but the current behavior is what I'd expect
to happen. Sure, bin-wrappers/git depends on "git" at run-time if you
want it to do something useful. But AFAIK it doesn't at build-time. Why
do we want a build-time dependency?  Are we expecting rules to depend on
bin-wrappers/foo but not also on foo? Or people to ask manually for
those targets?

This kind of feels like making git-repack depend on git-pack-objects.
One will call the other at run-time, but there's no reason the builds
have to be together. And if you try to build and run one without
building the other, well...if it hurts, don't do it.

-Peff
