Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69F01F461
	for <e@80x24.org>; Thu, 16 May 2019 22:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfEPWZ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:25:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727510AbfEPWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:25:27 -0400
Received: (qmail 3390 invoked by uid 109); 16 May 2019 22:25:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 22:25:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8078 invoked by uid 111); 16 May 2019 22:26:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 18:26:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 18:25:25 -0400
Date:   Thu, 16 May 2019 18:25:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Osipov <michael.osipov@siemens.com>
Subject: Re: [PATCH] Makefile: remove the NO_R_TO_GCC_LINKER flag
Message-ID: <20190516222525.GC11784@sigill.intra.peff.net>
References: <20190516093412.14795-1-avarab@gmail.com>
 <20190516180521.1933-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516180521.1933-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 08:05:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> From what I can tell we should, with the benefit of hindsight, have
> made this change back in 2006. GCC & ld supported this type of
> invocation back then, or since at least binutils-gdb.git's[1]
> a1ad915dc4 ("[...]Add support for -rpath[...]", 1994-07-20). Most
> people compiling git with a custom LIBDIR are going to be on a GNU-ish
> system, and having to provide this NO_R_TO_GCC_LINKER flag on top of a
> custom LIBDIR is annoying.
> 
> There are some OS's that don't support -rpath, e.g. AIX ld just
> supports "-R". Perhaps we should follow this up with some
> config.mak.uname changes, but as noted it's quite possible that nobody
> on these platforms uses this (instead libraries in the system's search
> path). We *could* also use "-Wl,-R", but let's not introduce something
> new.

So...does this mean with just your patch that the build is now broken on
AIX if you use CURLDIR?

Far be it from me to care about AIX, but it seems like this is ripe for
regressions, because we don't know which platforms were relying on "-R"
instead of "-Wl,-rpath", and now everybody will be using the latter by
default.

-Peff
