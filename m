Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAAEC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949DB22AAE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgLDMu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 07:50:26 -0500
Received: from mout.web.de ([212.227.15.14]:60373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgLDMu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 07:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1607086112;
        bh=jPzntKxPuOxhnXlSPfx98F+xcdaSgaNup2qO8rEbr08=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lR3wZokOP3YhjgSaJtnb3XR3fThJ17tPcdm+LufxpYpU/zo6YNVjZTngWxY0L8wVt
         gE2hR1vVackyY9NGlEwFjAaQbk4Omu6P9cvfI/dJ/rT8VUXoLKnZuaORgcuSWlBcVs
         tgN+oYrvu+GIjaMmU1qqtlPVZQFWHK1oYmX5EJrI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1kpHNr1sDT-005LX4; Fri, 04
 Dec 2020 13:48:32 +0100
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
Date:   Fri, 4 Dec 2020 13:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6LdtzMT58hd8qIObov7J9LoD2DalRClvY+6vNM9XCp1CuSKUra3
 NfjNs5fyu6GmiQrYPPXBE9O8aGsQf0uD8y+16XhFYWCJiHhsoyHhPlmjX+JHuQlgJaybjwn
 mJh/BfNAptY1YG37twXv2a+qsRPj+/IEigPZ0Rqp9+uDlXXde/g8OJQ1XQ3rsXUqkQciD9a
 SEFYuXa2Kqmhuu4JpUmiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vCl9wXLOb3I=:v6q5gcUH5N6oRbngNK1bDX
 W6QuTLCOBBgt2AnkXl/3lo5DxaeFzshdaUAROVoiS7q/yGwqUgdLU9TpWKOees8k+3ZcBhIlA
 EdLP4dYeP+rKuPoF9V+XMAnbCLP7+hDBoH7ltZIrXhBUJApKUUYAgLtETXYxLl9ipimi5NqMo
 dorlgePAx7X97481/TSmRxsUf7BExuPBrfWSxvSmtJP2WHIEVzjZSBLLfEsZKNwu4xUynJn4k
 tCIr2bNy9ktefpBjqzxuH2jWNRX4JAE03Feg1xgDzXBvfkFu2k0zeavM8SujQc9z2dZNdMOKc
 YdHF1EMi35KUvlISbqbpnTbFf1R2qK/fKm+sHVEBZajiFv0y2WWR0Ed/16g01EQnRAFwnekhz
 G5u0ZwxRaJzKGn7+l7r4W5aziv8yNNyUcg6p6cp56ZyD8H6y+Dp6+bGOHeOw3BGOTVOJl+dOj
 vFy2ZBoQtkZLR3HTMLyQN5askP9OzFg/ShV20QOao4HQ3+nKfAbSzNAbuzJPFp+YqGRLry6NM
 v3h1s2HlqMTq3XIC1MfoCiK+sJNc0efCV7Ro88KBIcvAd19VCjHKzPBorfZenH1RaUTOuuCIi
 sYiJeuXzNdq87lP2j1dkG5LNwgmWEpCIcDgMXWUTQEoIh9S5a8iPEWbJF4xB3ziFlF91r1f9O
 m6EKWppUMAlPuCiST/XzsvN+bb7EF/BPV+hVzR1iNUD1+e0pMnMayxTYh4P2kEJO97WMrnWAo
 bea3eM/s5mqetEYMDUQVN/aCYjUQVEkiAJlVNdOckMoT8XhdAJF2bqGhWNOfhlEiJ/WzwVoCO
 hsuHQ6o+zz2xiBRVQC4YYcl579OsAP7fmi9oY0iqSIQOrQOYlRLxN24Q9pN+riwpdB4vmBLEJ
 ewWOVFMHEPVBmviWC1Xg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.20 um 17:16 schrieb Derrick Stolee via GitGitGadget:
> I was thinking about file formats recently and realized that the "chunks=
"
> that are common to the commit-graph and multi-pack-index could inform fu=
ture
> file formats. To make that process easier, let's combine the process of
> writing and reading chunks into a common API that both of these existing
> formats use.
>
> There is some extra benefit immediately: the writing and reading code fo=
r
> each gets a bit cleaner. Also, there were different checks in each that =
made
> the process more robust. Now, these share a common set of checks.

>  Documentation/technical/chunk-format.txt      |  54 ++
>  .../technical/commit-graph-format.txt         |   3 +
>  Documentation/technical/pack-format.txt       |   3 +
>  Makefile                                      |   1 +
>  chunk-format.c                                | 105 ++++
>  chunk-format.h                                |  69 +++
>  commit-graph.c                                | 298 ++++++-----
>  midx.c                                        | 466 ++++++++----------
>  t/t5318-commit-graph.sh                       |   2 +-
>  t/t5319-multi-pack-index.sh                   |   6 +-
>  10 files changed, 623 insertions(+), 384 deletions(-)

623-384-54-3-3-1-69-2-6 =3D 101

So if we ignore changes to documentation, headers, tests and build
script this spends ca. 100 more lines of code than the current version.
That's roughly the size of the new file chunk-format.c -- from this
bird's-eye-view the new API seems to be pure overhead.

In the new code I see several magic numbers, use of void pointers and
casting as well as repetition -- is this really going in the right
direction?  I get the feeling that YAGNI.

Ren=C3=A9
