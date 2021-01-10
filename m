Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA1C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A99822581
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAJUNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:13:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55382 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbhAJUNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:13:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED32597235;
        Sun, 10 Jan 2021 15:12:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xwx6L/pNE7mV
        7Bk4rbRmOIJMN9U=; b=BYKLTJF3JDpfhPnQVnMIpe9/7okXdOBJ6hgr+WUZDgxu
        Ih0lH1O1SPOJx7nJicG3z6bkMFPOa1hbSgLlyR//uM7PspKOlBC/1j03Yetz6dsJ
        R05Zq42RqcXwsimXP4xEG/VpgIfjj9C8yWrUqVBoE6POGEm92h8NdN/nHYe5lOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uHCmZx
        QzO93KgahQ5Na/6v+VTGc7onhkos6dBDmLBA0d7tiI+j1ETeQwfvGJv5o+HHFCvJ
        a61q7vorOrci9fjdjI/Ozj+D3icPIpX8mkDoXmMb820as5ftjyo8ZNA7oU/bieAd
        S9bCxddbEVaAxYf+NbpET43gRopghL/AAc+nM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3FFC97234;
        Sun, 10 Jan 2021 15:12:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3608297233;
        Sun, 10 Jan 2021 15:12:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
References: <20201223013606.7972-1-avarab@gmail.com>
        <20210105194252.627-13-avarab@gmail.com>
        <20210110132155.GT8396@szeder.dev>
        <87y2h062jd.fsf@evledraar.gmail.com>
Date:   Sun, 10 Jan 2021 12:12:25 -0800
In-Reply-To: <87y2h062jd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 10 Jan 2021 19:59:50 +0100")
Message-ID: <xmqqczyca6vq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28539150-5380-11EB-BB23-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You prodded me about this and Johannes also did off-list. So given that
> this is already in "next" I think it's best to let usage in this mktag
> series land as-is.

For an issue like this "test_i18ngrep or not?" that would end up
giving a useful hint to future developers, a follow-up commit with
an explanation why test_i18ngrep is preferred (or not) would be a
great way to go forward (if the "fix" is needed in the first place,
that is).  It is easy to add a patch to fix things up while a series
is cooking in 'next', without having to remember doing so after the
series hits 'master'.

>     git some-command >output &&=20
>     test_i18ngrep "c locale string" output
>
> But since 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
> 2018-11-08) this hasn't been needed.

I did not immediately see why that commit changes any equation, but
I am inclined to say that your argument makes sort-of sense, if not
100%, to me.  POISON test is not about testing features that ought
to work (that is what non-POISON tests are for).  The primary
objective of POISON test is to ensure that we didn't over-localize;
if all the output from some-command is expected to be fully
localized, between the above and

	GIT_TEST_GETTEXT_POISON=3Dno git some-command >output &&
	grep "c locale string" output

there wouldn't be much difference.

But if the output contains strings, some of which are expected to be
localized (e.g. human facing messages) and some are not (e.g.
protocol dump), and the test output is inspected for both types of
strings, it would not be an equivalent test.

Having said that, it may be OK that a mixed-output-command is tested
only in C locale without localization.  Our tests do *not* make sure
that the strings that ought to be localized are indeed localized
anyway, so as long as the inspection of the output string does not
check for string that are *not* to be localized, we won't break the
primary objective of having POISON tests.

In any case, if you want to push forward in that direction to use
more GIT_TEST_* settings in the test to replace i18ncmp/grep, please
make sure you propose something easier to read than "GETTEXT_POISON"
for the environment variable name.  It is overly long and makes the
tests unreadable by pushing the part of the command that are more
important off of the right edge of the screen.

Thanks.
