Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E902098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945599AbcJSPrS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:47:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:62879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942826AbcJSPrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:47:16 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LvhC4-1d22Hw3bMi-017TZS; Wed, 19 Oct 2016 11:18:21
 +0200
Date:   Wed, 19 Oct 2016 11:18:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     gitster@pobox.com
cc:     git@vger.kernel.org
Subject: Drastic jump in the time required for the test suite
Message-ID: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t/RfZMuPLy4NxN1uUTpYp3H5DATCuqV9GGXfijPwgV+JX9BNQkx
 jApVb1RbMW46mkZ7frVqmYciO15x/AlQFs16D5c8nL67aKYs7A5QDcW9BzKH3Dr9o7qdYFn
 sO3rSwVeA+496o5wBNEE9VMZcD3AiclXikO0ctgwVKOwprf9q0XEyAU2pB59qMzTbPPiSbR
 KROvpUOkPmtB1yhvBylqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:70ZQcp4uqrw=:YKv1GGy2yb1WBdPO4yrn/6
 LFM5cp3yKkB8jbaor3uKD0G2gwAlUwKortHzHvrdMrcJ/uL0gMvDg9PMjF6zfUBsi4jKby2cq
 ZmNFPs9Nrel4mmCNZ1MFJ1Ta3T2VeMCfTC2zsM+Vbk68CiFRC/84gcvbskWWNOVimhM+As2y0
 E0rq0AZ/Plo0htumnuntQoKStrCGNp6Ep4TxvBAT+c/K37OC0yQd7Ek2f9x1f/PXjEUplfoUW
 gtZC2LVF1vlBRwRnXvk0mEigZ+h9zFQE66mC28NFW78L8JsdX8Lj/u12Vo0hvoeyCP7ew7FmT
 OQJbVwRr6es5hzhzg5ZP85p8ftmakqdZP6BkDDrAvMGWr+BXRZaC0DahHI6UHOKj373K7czbk
 zjcmchnKJoJsmtC86RVswFwYAH0NFHO761Vl+gDAa/h204xaofgYbokYN5RoXymxbvZVtFj+Q
 zfJ17nIuZdtKf5qCZIqaVjxHC46OEmJ/o5N/r9b62EMJSxMX4tPKPge+jULwj1XVC9NRZgX1g
 ovVn3jqxUJhwQeFZwg7xVy2qDsdBYRb62zTvaUSCJ/CF/lY862Yl0twAFcpkOCVjYfGRq7Lwc
 nZUEYF4OzwU0/ffanGcV3ciuMT1L61+3v9M1cRG8P+e6FIXi/jNxE/o8e3IYU5OCbUbCJHPwG
 We8M6PrNKcYMOgCXLdIgapUgTw67QA62d5KOZjGry+N/59p1MyfEi81jes5U94d1liO5yN1CI
 JjvSie0CQIu82+ZcZluNtuvBQOybcqOlUEFnzzzKUzLzLgrcc/yqjxHI+O7rzJ7LAdPJ2VFmy
 1KWXEnz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I know you are a fan of testing things thoroughly in the test suite, but I
have to say that it is getting out of hand, in particular due to our
over-use of shell script idioms (which really only run fast on Linux, not
a good idea for a portable software).

My builds of `pu` now time out, after running for 3h straight in the VM
dedicated to perform the daily routine of building and testing the git.git
branches in Git for Windows' SDK. For comparison, `next` passes build &
tests in 2.6h. That is quite the jump.

Unfortunately, I cannot tell you precisely when this massive increase
happened (we are talking about half an hour, after all), because there
were build failures preventing the test from being run for the last 40
days (and my build job only retains the results for 7 days currently,
anyway, in addition to the last successful/unsuccessful build).

What I can say for certain is that the version from 41 days ago (commit
7837d4a) ran for only 2.6h, just as `next` does today, and passed without
failure.

Every single revision of `pu` since then has been broken in one way or
another. Mostly already the build, so that the tests would not even start
to run.

What I can also say for certain is that the version from yesterday (commit
4ef44ce) was the first one in a week that built successfully and hence
reached the test phase, and it was the first version of `pu` ever to time
out after running for 3h.

I will increase the time-out, of course, but we are walking into a
dangerous territory here: the build & test requires such an incredibly
long time now that the VM will start to take more than 24h to complete all
8 tasks (building & testing the `pu`, `next`, `master` and `maint`
branches, as well as trying to rebase Git for Windows' patches onto each
of them).

As those tasks are scheduled to run once every 24h, I will no longer be
able to notify you and the mailing list in a timely manner, if at all,
because the queue will clog up.

Maybe we should start optimizing the tests to become more useful again, by
forcing them not to take such an insane amount of time?

Ciao,
Dscho
