Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BA91F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFMTGq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:06:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727080AbfFMTGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:06:46 -0400
Received: (qmail 4020 invoked by uid 109); 13 Jun 2019 19:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 19:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21184 invoked by uid 111); 13 Jun 2019 19:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 15:07:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 15:06:44 -0400
Date:   Thu, 13 Jun 2019 15:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch 0/5] Add exclusions for tests requiring cvs where cvs is
 not installed
Message-ID: <20190613190644.GC27217@sigill.intra.peff.net>
References: <20190613185313.16120-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190613185313.16120-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 02:53:08PM -0400, randall.s.becker@rogers.com wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> t9600 to t9604 currently depend on cvs to function correctly, otherwise
> all of those tests fail. This patch follows an existing pattern of
> from the t9400 series by attempting to run cvs without arguments,
> which succeeds if installed, and skipping the test if the command
> fails.

Hrm. I don't have cvs installed, and those tests are properly skipped
for me. That's because they include lib-cvs.sh, which has:

  if ! type cvs >/dev/null 2>&1
  then
          skip_all='skipping cvsimport tests, cvs not found'
          test_done
  fi

Why doesn't that work for you? Does the "type" check not work (e.g., you
have something called "cvs" but it does not behave as we expect)? If so,
then it sounds like we just need to harmonize that with the other
checks.

It also sounds like the t9400 tests could be using lib-cvs to avoid
duplicating logic, though it might need some refactoring (they don't
need cvsps, for example).

-Peff
