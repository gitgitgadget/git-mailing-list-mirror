Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07846C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 05:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJ1Ffz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 01:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ1Ffy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 01:35:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667C315746B
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 22:35:53 -0700 (PDT)
Received: (qmail 19410 invoked by uid 109); 28 Oct 2022 05:35:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Oct 2022 05:35:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31581 invoked by uid 111); 28 Oct 2022 05:35:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Oct 2022 01:35:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Oct 2022 01:35:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Message-ID: <Y1tqOCh+FwoQezYu@coredump.intra.peff.net>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <08A5BC44-24D9-4C8F-A61A-41983A13553A@gmail.com>
 <221028.86k04k8wbk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221028.86k04k8wbk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 05:11:07AM +0200, Ævar Arnfjörð Bjarmason wrote:

>  - The docs are way easier to scrape with some sed/awk/grep/whatever
>    few-liner than to scrape C code for generating docs. E.g. see
>    config-list.h.
> 
>  - Scraping the C code sucks so much that we'd probably make some
>    dedicated interface for it, e.g. what we have for "git <cmd>
>    --git-completion-helper".

In the general case, scraping C code is awful. But if you are looking
for one particular thing, it is not unreasonable to say something like
"when we write a usage string, we write it like:

  const char *git_cmdname_usage[] = "...";

> But mainly it helps to have a use-case, replacing the linter script with
> e.g. the *.sh I demo'd might be a marginal improvement. But e.g. "git
> help -c" uses one of those generated files (config-list.h), and actually
> does something useful ...

Yeah. In cases like config-list.h, it really is helpful for it to be
something we can query at run-time (the other option would be stuffing
them into git-completion.bash at build-time, but there are some
downsides there).

-Peff
