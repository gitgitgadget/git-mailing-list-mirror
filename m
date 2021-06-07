Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA9C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B747360200
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGWwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:52:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56062 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGWwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 18:52:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CA74C1AFA;
        Mon,  7 Jun 2021 18:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=NTg4GgjkabdXsMEFSpZRWnKo9
        d8U/YtXkRhJDjGq4OI=; b=YBP91hVzhbfuYCblNUbNe7Hs2bWw1hjTub7RNf1KI
        OQl7LnrAiRsRMUfEYWzgucSRCYyfS4pJk7Q+A6tMGMd0w9hsdOQBhAAUoebtWz1e
        b+2faMI2VtAIryVjoFv7NbvU11a96cjrHmxUObCegJuYKRVjbOfVyUUUe2DfK7ue
        Ig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65E95C1AF9;
        Mon,  7 Jun 2021 18:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED768C1AF7;
        Mon,  7 Jun 2021 18:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/4] test-tool: split up "read-cache" tool
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
Date:   Tue, 08 Jun 2021 07:50:25 +0900
Message-ID: <xmqqr1hdthla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BFD4E1CE-C7E2-11EB-9F05-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When the sparse index topic was being discussed I suggested that the
> t/helper/read-cache.c tool was getting to the point of doing too many
> things and should be split up.
>
> Since that series has landed on master here's that suggestion again in
> the form of patches on top of master. The 4/4 patch is a "while I was
> at it" addition of an extra perf test for index refreshing.
>
> 1. https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   test-tool: split up test-tool read-cache
>   test-tools: migrate read-cache-perf to parse_options()
>   test-tools: migrate read-cache-again to parse_options()
>   read-cache perf: add a perf test for refresh_index()

Is the contrast between tool and tools deliberate?


>  Makefile                         |  2 ++
>  t/helper/test-read-cache-again.c | 47 +++++++++++++++++++++++++++
>  t/helper/test-read-cache-perf.c  | 47 +++++++++++++++++++++++++++
>  t/helper/test-read-cache.c       | 56 +++++++++++++-------------------
>  t/helper/test-tool.c             |  2 ++
>  t/helper/test-tool.h             |  2 ++
>  t/perf/p0002-read-cache.sh       |  7 +++-
>  t/t7519-status-fsmonitor.sh      |  2 +-
>  8 files changed, 130 insertions(+), 35 deletions(-)
>  create mode 100644 t/helper/test-read-cache-again.c
>  create mode 100644 t/helper/test-read-cache-perf.c
