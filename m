Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3507AC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DA564F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhBBWXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:23:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51858 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhBBWWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:22:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26D7D96424;
        Tue,  2 Feb 2021 17:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tuWddI14JT+P
        a1XKeS/UbwhUksg=; b=Nc8MdTP8RTTGCXJuft1YIRta29bgA72NyKg0/Byt160v
        3nveePIKsejx0nC7j6GHpmJzLdT7gM9rFFGUiZ1yaULZ5wjwmHWlL98H+ZC4v9Ig
        80mb5z+o8Pze0ZiInFVVYgztR21kNFz4Cb2dRD+AtN967aSdfa4hvYOzJEhCFFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Tz9Yud
        wuPj4BbFxI0vCGl5ETVwGJ6RKCRZN4mKy0QRUMQJTdRKCGbmdV4L4rXAii97d/YG
        WeszCpJb0ww4tY9PJ6cY3j7rF5x3kRu9YAkjXT7E7nwk8n+H3zJj/e3kLjDMs/2Y
        asSGEmjllgc4GgmNbVANd/12hgmsqEIy8FqrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E0F296423;
        Tue,  2 Feb 2021 17:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A03EC96422;
        Tue,  2 Feb 2021 17:21:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
        <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
        <87wnvrefbv.fsf@evledraar.gmail.com>
        <xmqq8s87ld8y.fsf@gitster.c.googlers.com>
        <87tuqvdy1b.fsf@evledraar.gmail.com>
        <xmqqo8h3hybf.fsf@gitster.c.googlers.com>
        <xmqqczxjhwgv.fsf@gitster.c.googlers.com>
        <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org>
        <xmqq35yegrcv.fsf@gitster.c.googlers.com>
        <12a440af-c080-089d-bf60-76262d5aec7a@kdbg.org>
Date:   Tue, 02 Feb 2021 14:21:42 -0800
In-Reply-To: <12a440af-c080-089d-bf60-76262d5aec7a@kdbg.org> (Johannes Sixt's
        message of "Tue, 2 Feb 2021 23:15:24 +0100")
Message-ID: <xmqqwnvqdsax.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07055EC0-65A5-11EB-B5F6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Anyway, my opinion in the message you are responding to was that the
>> exit status of the pager subprocess wait_for_pager_atexit() finds
>> does not matter, and there is no reason to overly complicate the
>> implementation like the comments in =C3=86var's [v2 5/5] implies, and =
it
>> is sufficient to just hide the fact in wait_for_pager_signal() that
>> we got SIGPIPE.  I am not sure if you are agreeing with me, or are
>> showing me where/why I was wrong.
>
> We are agreeing that the SIGPIPE should not be reported.
>
> We may be disagreeing whether it is good or bad that git's exit code is
> overridden by the pager's exit code, which =C3=86var wanted to implemen=
t,
> IIUC. I think that is reasonable and I base my opinion on the compariso=
n
> with the pipeline `git log | less`, where git's exit code is ignored.

I guess we are then in agreement---I do think it makes sense to send
the true exit code from the pager as the exit code from the pager to
the trace output, which is what the early part of =C3=86var's patch does,
but I do not think the exit code of the pager should affect the exit
code from "git log" as a whole.

