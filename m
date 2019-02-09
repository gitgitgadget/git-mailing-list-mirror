Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD471F453
	for <e@80x24.org>; Sat,  9 Feb 2019 04:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBIEYH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 23:24:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:38378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726524AbfBIEYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 23:24:06 -0500
Received: (qmail 17379 invoked by uid 109); 9 Feb 2019 04:24:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Feb 2019 04:24:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29455 invoked by uid 111); 9 Feb 2019 04:24:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 23:24:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 23:24:04 -0500
Date:   Fri, 8 Feb 2019 23:24:04 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Duy Nguyen' <pclouds@gmail.com>
Subject: Re: [Possible Breakage] t1308 - Bad return value from test-tool
Message-ID: <20190209042404.GA18286@sigill.intra.peff.net>
References: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004901d4bff7$2e17dc50$8a4794f0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 04:42:19PM -0500, Randall S. Becker wrote:

> t1308 has me perplexed - this is an old breakage on the NonStop platform,
> that I have just gotten around to checking with the new bash version we
> have. When running sub-test 23, the following was reported:
> 
> Value not found for "foo.bar"
> test_expect_code: command exited with 1, we wanted 2 test-tool config
> configset_get_value foo.bar a-directory
> 
> However, when I looked inside t/helper/test-config.c, every path reporting
> "Value not found" has a goto exit1 not exit2. It seems, from the code, that
> the test is actually incorrect and should be expecting 1 not 2, and that it
> is working properly on NonStop (but the test fails as a result).

We're expecting it to report an error reading the directory, not "value
not found". Which would yield code 2.

It sounds like you might need to set FREAD_READS_DIRECTORIES in your
config.mak.

-Peff
