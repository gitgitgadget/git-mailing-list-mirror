Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86250C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663862073F
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0QYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:24:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:34034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726514AbfK0QYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:24:17 -0500
Received: (qmail 12382 invoked by uid 109); 27 Nov 2019 16:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 16:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11144 invoked by uid 111); 27 Nov 2019 16:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 11:28:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 11:24:16 -0500
From:   Jeff King <peff@peff.net>
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] t4210: skip i18n tests that don't work on FreeBSD
Message-ID: <20191127162416.GB30581@sigill.intra.peff.net>
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191127151708.50531-1-emaste@freefall.freebsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 03:17:08PM +0000, Ed Maste wrote:

> From: Ed Maste <emaste@freebsd.org>
> 
> A number of t4210-log-i18n tests added in 4e2443b181 set LC_ALL to a UTF-8
> locale (is_IS.UTF-8) but then pass an invalid UTF-8 string to --grep.
> FreeBSD's regcomp() fails in this case with REG_ILLSEQ sequence which git
> then passes to die():
> 
> fatal: command line: '�': illegal byte sequence
> 
> When these tests were added the commit message stated:
> 
> | It's possible that this
> | test breaks the "basic" and "extended" backends on some systems that
> | are more anal than glibc about the encoding of locale issues with
> | POSIX functions that I can remember
> 
> which seems to be the case here.

Makes sense, but...

> Extend test-lib.sh to add a FREEBSD prereq (akin to MINGW) and add !FREEBSD
> to these tests.

Before we start growing more system-specific prereqs here, can we add a
layer of indirection? Convert this test to use a REGEX_ALLOW_ILLSEQ
prereq (or maybe there's a better name), and then set it for both mingw
and freebsd?

-Peff
