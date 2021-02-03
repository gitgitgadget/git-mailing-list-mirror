Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E8C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ABC64F65
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 02:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhBCCzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:55:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53138 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBCCzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 21:55:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FCDE113EA2;
        Tue,  2 Feb 2021 21:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R/M3ltjQ71WZ
        mDdNfWr7zLpYYiQ=; b=eKY55fFItaNhWX730PZwM6X9xxF3Aj8ItqMcy2vUAvDI
        bze2mMYJLi/Qwq94XhrldiNbplf7LLM/7PAqHYKpcCwY5j2VPrHAAvDLyukXnROq
        oU9hTP+jdztQQJtGgWLRZVfvJcCnLw5YqOVYTYjtvSAKShJIcK+ambVc/CRX7B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HYHN5G
        tszzCcL/TPaPeGSgnxUlQUTXY3khibsdBJPBA67IZcMppTJac0UurjCVJmcVHJh/
        VMoBkZnXUQ0CvD+jDFXWDOu6k+JexT3JT/iLmWsf0D+3HmXzaPL4x84pUMOYpxx8
        VyLYVDfVMEXuZmGl8fTZ0pJFDGELGRRXnZSLw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47891113EA0;
        Tue,  2 Feb 2021 21:54:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38EF9113E89;
        Tue,  2 Feb 2021 21:54:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>,
        Johannes Sixt <j6t@kdbg.org>
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
        <87r1lxeuoj.fsf@evledraar.gmail.com>
Date:   Tue, 02 Feb 2021 18:54:15 -0800
In-Reply-To: <87r1lxeuoj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 03 Feb 2021 03:45:00 +0100")
Message-ID: <xmqq35ydeu94.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B1B5F10-65CB-11EB-ACBE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Getting back to the point, whatever anyone thinks of returning SIGHUP a=
s
> we do now or not, I think it's bonkers to ignore SIGHUP and *then*
> return a non-zero *only in the non-atexit case*.
>
> That just means that if you do have a broken pager you're going to get
> flaky exits depending on the state of our flushed buffers, who's going
> to be helped by such a fickle exit code?
>
> So if we're going to change the behavior to not return SIGHUP, and don'=
t
> want to refactor our entire atexit() handling in #2 to be guaranteed to
> pass down the pager's exit code, I don't see how anything except the
> approach of just exit(0) in that case makes sense, which is what Denton
> Liu's patch initially suggested doing.

Then we are on the same page (assuming that all your HUPs are
PIPEs), as the "perhaps we could even exit with pager's error" was
my mistaken reaction to your "we have been losing pager's exit
status" message.

I do want to ignore, as I said in the message you are responding to,
the exit status of the pager, just like we ignore exit status of
some of the hooks that we spawn primarily for their side effects (as
opposed to the pre-* hooks whose status we do use to base our
decision on).

I guess we just want to take just a half of your [WIP/PATCH v2 5/5],
ignoring the return values from finish_command*() and exiting with 0
when we got SIGPIPE (that would mean that there will be no change on
the atexit codepath).  Unlike Denton's change directly on the current
codebase, the resulting code would clearly show that we only care about
the signal codepath, thanks to the refactoring [PATCH v2 1/5] has
done.


