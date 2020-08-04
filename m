Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE6C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DA820792
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 18:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHDSvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:51:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:47954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHDSu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 14:50:59 -0400
Received: (qmail 5142 invoked by uid 109); 4 Aug 2020 18:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 18:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14465 invoked by uid 111); 4 Aug 2020 18:50:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 14:50:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 14:50:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200804185057.GA1400256@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 10:35:40PM -0700, Junio C Hamano wrote:

> * ss/cmake-build (2020-06-26) 8 commits
>   (merged to 'next' on 2020-08-03 at a0d70165c1)
>  + ci: modification of main.yml to use cmake for vs-build job
>  + cmake: support for building git on windows with msvc and clang.
>  + cmake: support for building git on windows with mingw
>  + cmake: support for testing git when building out of the source tree
>  + cmake: support for testing git with ctest
>  + cmake: installation support for git
>  + cmake: generate the shell/perl/python scripts and templates, translations
>  + Introduce CMake support for configuring Git
> 
>  Originally merged to 'next' on 2020-08-01
> 
>  CMake support to build with MSVC for Windows bypassing the Makefile.
> 
>  Will merge to 'master'.
>  cf. https://github.com/git/git/runs/892824895

I ran into issues with this, as I have several in-progress topics (not
yet sent to the list) that touch our Makefile, and they needed updates
to the cmake file (because it reproduces a lot of the lists and logic
from the Makefile).

The original philosophy behind putting it in contrib is that most people
wouldn't have to care, and folks interested in cmake would be
responsible for keeping it up to date. But the top patch makes it hard
to ignore, because the vs-build CI job will fail.

I'm not sure of the right path forward. I was definitely unenthused to
be dealing with cmake, and the problem came up as soon as the series hit
next.

On the other hand, it was only 2 out of my 47 topics that triggered
problems. I'd guess that's representative of how often this will come
up. And the vsbuild tests have to use _something_, so we may not be
immune to this problem regardless of the solution (though I never had to
touch the vcxproj files before). Part of me wants to just ignore vsbuild
test results completely, but it has provided value in the past (for
actual code changes with portability issues).

So I dunno. I'm not really asking for or recommending any specific
action, but just raising the data point.

-Peff
