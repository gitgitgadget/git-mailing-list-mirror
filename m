Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B3C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFCC64E40
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhBBUOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:14:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65006 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhBBUOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:14:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07A28101C80;
        Tue,  2 Feb 2021 15:13:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=azVwAy/nCsuy
        XYh4ak+cilSZsq4=; b=W9YD0EOMVGyNzvR9jCFiuxh4xr0gnkHdI3hk06XzXMmW
        sMm47hwfmkutA3/Znl4dKXTBrMOOGpitUhoQNhaiASOlT2EIBoHYHUC7A2IkQTS9
        ap2Fik80xBdNY2ZxP+JXdOiYM2m4onn+v03SHBnTqYpBG9aoG46z0zY1rAYOjnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UuT/Om
        UCtor+xFhIYaC83gzSiOASIyurmVfAMbS6OxpwY4T5F7STWsFCvPVIOlf1tOnvx7
        4JMhsEI6qDmqb/Lsh6uKIku0S7a0bNqhxFoEYHhIUyAoeLkR3xFV+2mNbUN0dche
        nCiILPZRrvIwxyF+VH7UZ+7j7mtsyfEFR4lR8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0062A101C7F;
        Tue,  2 Feb 2021 15:13:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 455DE101C7D;
        Tue,  2 Feb 2021 15:13:54 -0500 (EST)
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
Date:   Tue, 02 Feb 2021 12:13:52 -0800
In-Reply-To: <1dfb079e-a472-0259-2a00-100eb7a06297@kdbg.org> (Johannes Sixt's
        message of "Tue, 2 Feb 2021 08:45:51 +0100")
Message-ID: <xmqq35yegrcv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C50BCCC-6593-11EB-AEB1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 02.02.21 um 06:25 schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> Sorry, but you still have lost me---I do not see if/why we even care
>>> about atexit codepath.  As far as the end users are concered, they
>>> are running "git" and observing the exit code from "git".  There,
>>> reporting that "git" was killed by SIGPIPE, instead of exiting
>>> normally, is not something they want to hear about after quitting
>>> their pager, and that is why the signal reception codepath matters.
>>=20
>> (something I noticed that I left unsaid...)
>>=20
>> On the other hand, "git" spawns not just pager but other
>> subprocesses (e.g. "hooks"), and it is entirely up to us what to do
>> with the exit code from them.  When we care about making an external
>> effect (e.g. post-$action hooks that are run for their side effects),
>> we can ignore their exit status just fine.
>>=20
>> And I do not see why the "we waited before leaving, and noticed the
>> pager exited with non-zero status" that we could notice in the
>> atexit codepath has to be so special.  We _could_ (modulo the "exit
>> there is not portable" you noted) make our exit status reflect that,
>> but I do not think it is all that important a "failure" (as opposed
>> to, say, we tried to show a commit message but failed to recode it
>> into utf-8, or we tried to spawn the pager but failed to start a
>> process) to clobber _our_ exit status with pager's exit status.
>>=20
>> So...
>
> The pager is a special case of a sub-process spawned, as it really only
> a courtesy for the user. Without the pager facility, the user would hav=
e
> to use
>
>     git log | less
>
> In that situation, the exit code of the pager *does* override git's, an=
d
> it is also irrelevant for the user that git was killed by SIGPIPE and i=
s
> not worth a visible notice.

All true, except that "GIT_PAGER=3Dless git -p log" reports the exit
status of "git" and not "less" when the entire command finishes
(regardless of how it happens, like user typing 'q', output of log
is shorter than one page and "less" automatically exiting at the
end, etc.), unlike "git log | less", where the exit status of "git"
is hidden.  But from the end-user's point of view, I do think it
is not a good idea to report an abnormal exit of "git" with SIGPIPE;
it is an irrelevant implementation detail.

Anyway, my opinion in the message you are responding to was that the
exit status of the pager subprocess wait_for_pager_atexit() finds
does not matter, and there is no reason to overly complicate the
implementation like the comments in =C3=86var's [v2 5/5] implies, and it
is sufficient to just hide the fact in wait_for_pager_signal() that
we got SIGPIPE.  I am not sure if you are agreeing with me, or are
showing me where/why I was wrong.

Thanks.

