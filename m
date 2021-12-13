Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0220C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhLMJMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:12:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63031 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhLMJMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:12:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CCC715D754;
        Mon, 13 Dec 2021 04:12:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QY5x8vuMMlbQrYPJyRt/1s2jvA7i1EPKB7PcABLu5B0=; b=s1ei
        MtByc/m5BD0LJk+a3XZ4bPmmo+HhtUgfsOelcxmbfFF+jNGrrSvgkxjfw54hMWpU
        wwrQcCn0l0w3sIFkWEaxtFlAHidgLq7YysqNVjeMl2tpfZQXn6YTk7AROS1MmsrL
        6VZMs8StE73Z0HGt2oYpFsCoFfAnPUXHV+dpSPg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E69E115D753;
        Mon, 13 Dec 2021 04:12:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4142915D752;
        Mon, 13 Dec 2021 04:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <YbEpE7UI+ovnNQyj@coredump.intra.peff.net>
        <xmqqczm5u0d4.fsf@gitster.g>
        <YbMR3ePaJHtYKReP@coredump.intra.peff.net>
Date:   Mon, 13 Dec 2021 01:12:40 -0800
Message-ID: <xmqqtufceulz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3A8E14A-5BF4-11EC-8B32-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm don't have strong feelings on it either way. But if we think those
> tests are worth running in CI, then...
>
>> So I am tempted to do
>> 
>> test-extra: all
>> 	$(MAKE) -C contrib/credential/netrc test
>> 	$(MAKE) -C contrib/diff-highlight test
>> 	: $(MAKE) -C contrib/mw-to-git test
>> 	$(MAKE) -C contrib/subtree test
>
> ...we'd probably want to keep running mw-to-git tests, and teach one of
> the CI environments to install the appropriate perl modules to avoid
> skipping them.

I saw netrc credential helper break on one of the jobs that lack
Perl, so the test there needs to be fixed before we can include it
in test-extra.



