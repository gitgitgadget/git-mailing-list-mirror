Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE02C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C8560EB8
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKAUUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:20:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63884 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:20:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8290F1620C1;
        Mon,  1 Nov 2021 16:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DFUUwAU6rrd1
        4HFMkIBogLyi6tDQ8IMp8/XQrJTQrkc=; b=Ro821w1fhsFdJoWNRLeReYj3HHLh
        DuGMBoALcgV0fn8kiuNJBkcX8MwTlUFBvj0lQh1HO8bI/P2EBTRqtInOyqbORDuq
        pZ68eNPHUY8czLmbWNM8GpXHUCs9akx1fTlPQz+whsrxZ5Il46sFK5RqgpJIy8TW
        E2YzxrUEiiNjcNo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AC7E1620C0;
        Mon,  1 Nov 2021 16:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D9421620BC;
        Mon,  1 Nov 2021 16:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: ab/config-based-hooks-2
References: <xmqqr1c3e57a.fsf@gitster.g>
        <211101.861r3z4qyb.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 Nov 2021 13:17:58 -0700
In-Reply-To: <211101.861r3z4qyb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 Nov 2021 20:26:14 +0100")
Message-ID: <xmqqv91bbpft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF3402EE-3B50-11EC-B850-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Oct 29 2021, Junio C Hamano wrote:
>
>> * ab/config-based-hooks-2 (2021-10-20) 14 commits
>>  - run-command: remove old run_hook_{le,ve}() hook API
>>  - receive-pack: convert push-to-checkout hook to hook.h
>>  - read-cache: convert post-index-change to use hook.h
>>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>>  - git-p4: use 'git hook' to run hooks
>>  - send-email: use 'git hook run' for 'sendemail-validate'
>>  - git hook run: add an --ignore-missing flag
>>  - merge: convert post-merge to use hook.h
>>  - hooks: convert 'post-checkout' hook to hook library
>>  - am: convert applypatch to use hook.h
>>  - rebase: convert pre-rebase to use hook.h
>>  - gc: use hook library for pre-auto-gc hook
>>  - hook: add 'run' subcommand
>>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
>>
>>  More "config-based hooks".
>
> Re-rolled with the simplifications you requested, and now with a smalle=
r
> diffstat:
> https://lore.kernel.org/git/cover-v4-00.17-00000000000-20211101T184938Z=
-avarab@gmail.com/

Heh, I didn't request anything.  I just gave an observation or two,
and all the rest happened in your head ;-).

I do find that the new run_hooks() that takes a single hook name
makes the resulting callers much cleaner and simpler to follow.
No callers have to call find_hook() before run_hooks() anymore,
which looks good.

The new _l() variant, not so much contributing to the clarity,
unfortunately.
