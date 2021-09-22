Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5FAC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2338F610D1
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhIVU1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:27:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:52934 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237556AbhIVU1c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:27:32 -0400
Received: (qmail 11088 invoked by uid 109); 22 Sep 2021 20:26:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 20:26:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18020 invoked by uid 111); 22 Sep 2021 20:26:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 16:26:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 16:26:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: clean .depend dirs under
 COMPUTE_HEADER_DEPENDENCIES != yes
Message-ID: <YUuRWT8+Q4ls6BHu@coredump.intra.peff.net>
References: <patch-1.1-b8bde2ee7b7-20210922T201615Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-b8bde2ee7b7-20210922T201615Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 10:17:06PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Fix a logic error in dfea575017d (Makefile: lazily compute header
> dependencies, 2010-01-26) where we'd make whether we cleaned the
> .depend dirs contingent on the currently configured
> COMPUTE_HEADER_DEPENDENCIES value. Before this running e.g.:
> 
>     make COMPUTE_HEADER_DEPENDENCIES=yes grep.o
>     make COMPUTE_HEADER_DEPENDENCIES=no clean
> 
> Would leave behind the .depend directory, now it'll be removed.
> 
> Normally we'd need to use another variable, but in this case there's
> no other uses of $(dep_dirs), as opposed to $(dep_args) which is used
> as an argument to $(CC). So just deleting this line makes everything
> work correctly.
> 
> See http://lore.kernel.org/git/xmqqmto48ufz.fsf@gitster.g for a report
> about this issue.

This makes perfect sense to me. Nicely explained, and the patch is
simpler than I'd have expected. :)

-Peff
