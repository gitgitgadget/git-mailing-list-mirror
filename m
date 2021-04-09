Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C624C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B670E61184
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhDIWao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:47256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234602AbhDIWao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:30:44 -0400
Received: (qmail 3390 invoked by uid 109); 9 Apr 2021 22:30:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 22:30:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17474 invoked by uid 111); 9 Apr 2021 22:30:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 18:30:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 18:30:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <YHDVhmveVlkHPBNb@coredump.intra.peff.net>
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
 <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 06:28:19PM -0400, Jeff King wrote:

> +   If <script> is `-` (a single dash), then the script to run is read
> +   from stdin. This lets you more easily use single quotes within the
> +   script by using a here-doc. For example:
> +
> +        test_expect_success 'output contains expected string' <<-\EOT
> +	        grep "this string has 'quotes' in it" output
> +	EOT

Whoops, this should have an extra "-", of course (I got this wrong in
the cover letter, too). I.e.:

  test_expect_success 'whatever' - <<\EOT
     ...
  EOT

It would be nice to drop it, but then:

  test_expect_success PREREQ 'whatever' <<\EOT

becomes ambiguous (and I don't think there is a portable and reliable
way to decide that our input is coming from a here-doc versus the
original stdin).

-Peff
