Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81C764DFF
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhCDXS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:18:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51788 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhCDXS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 18:18:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77E73119BF8;
        Thu,  4 Mar 2021 18:18:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UVzgSgYh9hUs
        2ZR1ML2wSFtPAXg=; b=BN4aVHNk9LoIzLMrI3TNPvYu0JZ/1mqK6hdCMJytrkSt
        znvJ+W0KieHsOBvgExXmtT0XN+rSteeHFIlh6/WxO9TODp/VhqjWAm8Kkq6vQ9Nw
        IUXTuRh63mnvSaKfnd42XywEXy56aT2fQopvWO3hxXFmyWCq+zQMBJZ5+5l1bMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Q1UZHB
        qtMySy7yzS9fvWL4iW0VmVT/lvWrnY0Y5/ebSTqpdnR4Q4nMOiM8xVS4VqeMQCxJ
        u7lCCIEZDnEE6iSqJnjeQDNC5Xpcqicclkbr4ir70tZCTdWdcl9tc/Jbi27CXiL2
        +uA5GF33VQLopA3qIcnC5jhlMn3Ll3OtMMPgo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71290119BF5;
        Thu,  4 Mar 2021 18:18:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96597119BF0;
        Thu,  4 Mar 2021 18:18:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
References: <20190506234334.GA13296@sigill.intra.peff.net>
        <20210302205103.12230-1-avarab@gmail.com>
Date:   Thu, 04 Mar 2021 15:18:51 -0800
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 2 Mar 2021 21:51:03 +0100")
Message-ID: <xmqq35xacxt0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC6CBF32-7D3F-11EB-8F34-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I've often wondered why "make coccicheck" takes so long. This change
> speeds it up by ~2x and makes it use much less memory. Or a reduction
> of a max of around ~2GB per-process (under the old
> SPATCH_BATCH_SIZE=3D0) to around ~200MB.

>
> Running the full "make coccicheck" now takes ~50 seconds with -j8 on
> my machine, v.s. ~2x of that before. I've got 64GB of memory on that
> machine, or it would be much slower.
>
> Why has it been so slow? Because I think we've always been running it
> in entirely the wrong mode for what we wanted, and much of the
> previous fixing of this target has involved re-arranging the deck
> chairs on that particular Titanic.
>
> What we really want to do with coccicheck is to do search/replacements
> in all our *.c and *.h files. This is now what we do, and we'll
> process a default of 64 files at a time.
>
> What we were doing before was processing all our *.c files, and for
> each of those *.c files we'd recursively look around for includes and
> see if we needed to search/replace in those too.
>
> That we did that dates back to [1] when we were only processing *.c
> files, and it was always very redundant. We'd e.g. visit the likes of
> strbuf.h lots of times since it's widely used as an include.
>
> Then in the most recent attempt to optimize coccicheck in [2] this
> anti-pattern finally turned into a bug.
>
> Namely: before this change, if your coccicheck rule applied to
> e.g. making a change in strbuf.h itself we'd get *lots* of duplicate
> hunks applying the exact same change, as concurrent spatch processes
> invoked by xargs raced one another. In one instance I ended up with 27
> copies of the same hunk in a strbuf.patch.
>
> Setting SPATCH_BATCH_SIZE=3D0 and processing all the files in one giant
> batch mitigated this. I suspect the author of [2] either mostly ran in
> that mode, or didn't test on changes that impacted widely used header
> files.
>
> So since we're going to want to process all our *.c and *.h let's just
> do that, and drop --all-includes for --no-includes. It's not spatch's
> job to find our sources, we're doing that. If someone is manually
> tweaking COCCI_SOURCES they can just tweak SPATCH_FLAGS too.
>
> I'm entirely removing SPATCH_BATCH_SIZE. If you want to tweak it you
> can tweak SPATCH_XARGS_FLAGS to e.g. "-n 256", or "-P 4 -n 128". But
> in my testing it isn't worth it to tweak SPATCH_XARGS_FLAGS for a full
> "make coccicheck".
>
> I'm also the whole "cat $@.log" introduced in [3]. Since we don't call
> this in a loop anymore (and xargs will early-exit) we can just rely on
> standard V=3D1 for debugging issues.
>
> 1. a9a884aea5 (coccicheck: use --all-includes by default, 2016-09-30)
> 2. 960154b9c1 (coccicheck: optionally batch spatch invocations,
>    2019-05-06)
> 3. f5c2bc2b96 (Makefile: detect errors in running spatch, 2017-03-10)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

Nice, so in short, we've been redundantly running the checker code
over and over on the same header files wasting cycles.

Even though I saw you mentioned something about preparing for a
reroll, I'll tentatively queue this version to 'seen' for now.

THanks.
