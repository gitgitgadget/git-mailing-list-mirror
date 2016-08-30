Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C9D1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbcH3Td7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 15:33:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53260 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750861AbcH3Td7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 15:33:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 989EC38C81;
        Tue, 30 Aug 2016 15:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/vZKW6d+rzFbWh2/UkBHKg0n2Kc=; b=AamfVn
        qePNy3KCC7IqDYjLgc/79D5sBn2spOU8lEynWK8dJGCADyRYzOOokMtBTZYbQZ/l
        ZFyAvl0WvQLvpKKhoGZDvrVRXLkF5V+akksWvJHcveYQBoXpeZFqaIS9XueZVaWR
        /SvI0Z5QI9sobbYdMBIiR9yul0QLURejx4wf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IOqX/wlbxFyZxkT9Ar2gEOn/rICv3851
        AI1CfCimROM0Z/jJv6zGgWedwhjOmj+dZwqjvZHsz3RTpJ0+LZjLHTFFdQwKHDK1
        syJdyjMQQzQZIWkghIN6SQgQ9NfytJIM3TCrFHoOcBGVGl9IYNbMLLfwGQZzpgjy
        d/Z7c0nh6tQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 926DF38C80;
        Tue, 30 Aug 2016 15:33:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FDA838C7F;
        Tue, 30 Aug 2016 15:33:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v14 14/27] bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6ce-3b204354-849b-40fd-93ff-2ebcf77df91c-000000@eu-west-1.amazonses.com>
        <xmqq37lsmw15.fsf@gitster.mtv.corp.google.com>
        <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
Date:   Tue, 30 Aug 2016 12:33:55 -0700
In-Reply-To: <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
        (Pranit Bauva's message of "Tue, 30 Aug 2016 23:55:40 +0530")
Message-ID: <xmqqvayi2grg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1939C02-6EE8-11E6-BFAC-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> This is a very tricky one. I have purposely not included this after a
> lot of testing. I have hand tested with the original git and with this
> branch. The reason why anyone wouldn't be able to catch this is
> because its not covered in the test suite. I am including a patch with
> this as an attachment (because I am behind a proxy right now but don't
> worry I will include this as a commit in the next series). The
> original behaviour of git does not clean the bisect state when this
> situation occurs.

"We sometimes clean and we sometimes don't and this follows the
original" may be a valid justification but it is not a very useful
explanation.  The real issue is if not cleaning is intended (and if
so why; otherwise, if it is clear that it is simply forgotten, we
can just fix it in the series as a follow-up step).

If not cleaning in some cases (but not others) is the right thing,
at least there needs an in-code comment to warn others against
"fixing" the lack of cleanups (e.g. "don't clean state here, because
the caller still wants to see what state we were for this and that
reason").

>>> +     if (bisect_next_check(terms, terms->term_good.buf))
>>> +             return -1;
>>
>> Mental note.  The "autostart" in the original is gone.  Perhaps it
>> is done by next_check in this code, but we haven't seen that yet.
>
> This will be added back again in a coming patch[1].

In other words, this series is broken at this step and the breakage
stay with the codebase until a later step?

I do not know if reordering the patches in the series is enough to
fix that, or if it is even worth to avoid such a temporary breakage.
It depends on how serious the circularity is, but I would understand
if it is too hard and not worth the effort (I think in a very early
review round some people advised against the bottom-up rewrite
because they anticipated this exact reason).  At least the omission
(and later resurrection) needs to be mentioned in the log so that
people understand what is going on when they later need to bisect.

Thanks.
