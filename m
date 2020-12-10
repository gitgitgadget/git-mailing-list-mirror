Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B77C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B74622D5B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 06:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgLJG5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:57:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61509 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbgLJG5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 01:57:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC21DA201E;
        Thu, 10 Dec 2020 01:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmpUgy/wCXUj+zMpKYoN3ili9g4=; b=CtaEuV
        mR63mZNep+7XsWFR5VgaiB+gFpelZdSYUdyfEyA8i6VQM5eRujjrPeI2/qhiNzrk
        NdxOfdzL21+zqmtYknTLmmmMiBviAKQusu9VqOC4oaFHfKOwhFot5GowrrkXXZ+u
        l/VfWy7/lnRyImLHWBnmun9KgJLMGHreH5LNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T9eb7HfHPMS7e3HPkP5CSUz1Ti6QtHQW
        uBmCqZh9SxXUQG2Lde1d/EjI5ATjnJ1M7hwOg30T2V+sznWU+YLLaGFVKhJzzMEW
        1a5kx3Nq7pRLw7E+lTgGycjpM77vD+1XtEw5UJ79tKjcb4hromJ5qmdBQHXb7bsJ
        5COVYRBW1E4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3F0AA201D;
        Thu, 10 Dec 2020 01:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66152A201C;
        Thu, 10 Dec 2020 01:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
        <X9FLaiuWpYely6es@nand.local>
        <xmqqtusuxvr8.fsf@gitster.c.googlers.com>
        <CABPp-BFcSV_LPy-_AW+c-1OgzAyHfEM7D+YL+fFwxYKDheqxEg@mail.gmail.com>
Date:   Wed, 09 Dec 2020 22:56:19 -0800
In-Reply-To: <CABPp-BFcSV_LPy-_AW+c-1OgzAyHfEM7D+YL+fFwxYKDheqxEg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Dec 2020 18:17:27 -0800")
Message-ID: <xmqqpn3iw3n0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEE1DDFE-3AB4-11EB-9874-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ah, so would you be okay replacing these with
>
>    if (st_mult(num_targets, limited_sources) <= st_mult(rename_limit,
> rename_limit))

It's subtle that the use of size_t is a sensible thing to do, and
definitely deserves an in-line comment, but I think that is a good
way to go.

