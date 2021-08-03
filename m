Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5DC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF64600EF
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhHCWJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:09:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59763 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHCWJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:09:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B97F0128B11;
        Tue,  3 Aug 2021 18:08:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/epit/7mmfyojE5v2BNBSGyAHxGH9OzxbdRYMu
        Hv0Wo=; b=JXTmUoJ2sJ7uKW5S/6HqBkGICLBQv9Cocd9xoBytZExV/IGv70qT/2
        OYHXgDwehdBnru/UJfXBIBAgRe12u6ALhzVrFadCnnhcHdZgshXDi+RCYDrdnM5T
        JIVgsN1G71jI9yitrsvZsNLzJiN+dxrkBf4jfWFS/mvAG1kI7O1u0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B08D5128B10;
        Tue,  3 Aug 2021 18:08:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00D26128B0B;
        Tue,  3 Aug 2021 18:08:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive
 to ort
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
        <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net>
Date:   Tue, 03 Aug 2021 15:08:53 -0700
In-Reply-To: <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 3 Aug 2021 11:56:37 -0400")
Message-ID: <xmqqim0mtc3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64A5BB24-F4A7-11EB-BFB1-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It would make sense to me to do the switch in 'next' early in the
> post-v2.33 cycle. It can cook there for a bit, but I think we have found
> that it's much more likely to see actual use once it hits 'master'. So I
> don't see a particular reason to have it sit in 'next' for a long time.
> We should get as much exposure in 'master' during the v2.34 cycle as
> possible.

I do not mind queuing what is available today to 'next' to gain 2
more weeks of dogfood time during the pre-release freeze.  If an
simple escape hatch that lets us say "anytime we ask ort, use
recursive instead as an emergency measure" can be added with a
trivially obvious small patch, that would be a plus.

> The nice thing is that the two strategies can co-exist. So if it does
> turn out to have any regressions, it's an easy revert to switch back,
> and even post-release users can switch at runtime. We have pull.twohead,
> but I don't think we have an equivalent that would impact a bare "git
> merge" or "git rebase -m". Maybe it would be worth adding those as an
> escape hatch?

