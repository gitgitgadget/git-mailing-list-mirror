Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA882C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFA61A2D
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCZLBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:01:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:49764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZLAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 07:00:49 -0400
Received: (qmail 32136 invoked by uid 109); 26 Mar 2021 11:00:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 11:00:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4669 invoked by uid 111); 26 Mar 2021 11:00:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 07:00:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 07:00:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] doc lint: fix bugs in, simplify and improve lint
 script
Message-ID: <YF2+4I4rH9CQ1A2F@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-5c8e8f21495-20210326T103454Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 11:36:49AM +0100, Ævar Arnfjörð Bjarmason wrote:

>  lint-docs::
> -	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
> +	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
> +		--section=1 $(MAN1_TXT) \
> +		--section=5 $(MAN5_TXT) \
> +		--section=7 $(MAN7_TXT)	\
> +		--to-lint $(ALL_TXT)

This is probably bikeshedding, but I would have expected the invocation
to be:

  link-gitlink.perl \
    $(HOWTO_TXT) $(INCLUDE_TARGETS_TXT) \
    --section=1 $(MAN1_TXT) \
    --section=5 $(MAN5_TXT) \
    --section=7 $(MAN7_TXT)

I.e., list each filename only once, with the previous --section giving
the expected section (and if before any --section, then expect no
section).

-Peff
