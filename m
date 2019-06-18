Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112811F462
	for <e@80x24.org>; Tue, 18 Jun 2019 15:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfFRPx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 11:53:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:58130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729209AbfFRPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 11:53:28 -0400
Received: (qmail 6835 invoked by uid 109); 18 Jun 2019 15:53:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Jun 2019 15:53:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6123 invoked by uid 111); 18 Jun 2019 15:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 11:54:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 11:53:26 -0400
Date:   Tue, 18 Jun 2019 11:53:26 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/2] a few more redundant system include cleanups
Message-ID: <20190618155326.GA4014@sigill.intra.peff.net>
References: <20190618064537.62369-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190618064537.62369-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 17, 2019 at 11:45:37PM -0700, Carlo Marcelo Arenas Belón wrote:

> after b46054b374 ("xdiff: use git-compat-util", 2019-04-11), two system
> headers added in 2012 to xutils where no longer needed and could conflict
> as shown below:
> 
> In file included from xdiff/xinclude.h:26:0,
>                  from xdiff/xutils.c:25:
> ./git-compat-util.h:4:0: warning: "_FILE_OFFSET_BITS" redefined
>  #define _FILE_OFFSET_BITS 64
> 
> In file included from /usr/include/limits.h:37:0,
>                  from xdiff/xutils.c:23:
> /usr/include/sys/feature_tests.h:231:0: note: this is the location of the previous definition
>  #define _FILE_OFFSET_BITS 32
> 
> make sure git-compat-util.h is the first header (through xinclude.h)

Thanks, this looks good to me. I fixed the system headers in xinclude.h,
but didn't think to check for individual C files including them.

I did a quick grep for similar cases, and didn't find any that I think
would be problematic. There were a few cleanups, below.

There are still some other system includes, but they are mostly one-offs
that we wouldn't expect git-compat-util to cover (e.g., threading stuff
in thread-utils.[ch], openssl stuff in hash.h). So I think with your
patch, plus the patches below, there's nothing left to clean up.

  [1/2]: verify-tag: drop signal.h include
  [2/2]: wt-status.h: drop stdio.h include

 builtin/verify-commit.c | 1 -
 builtin/verify-tag.c    | 1 -
 wt-status.h             | 1 -
 3 files changed, 3 deletions(-)

-Peff
