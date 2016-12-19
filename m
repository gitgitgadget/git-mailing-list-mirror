Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3291FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764044AbcLSSbg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:31:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1764027AbcLSSbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:31:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F1ED58040;
        Mon, 19 Dec 2016 13:31:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KlRm2GU6kbmfQpCONvLo/kamxtM=; b=MtfJm1
        i2gWGy20i9KpqAP9xDCOv8PCD9w/I5mmhtymZnY8Uhflh4wtxdDI61h/wicTUXaj
        aJODmZnx3QtMrfRm8hSdIciO40G7hzRSzCPbwY6Cv8iiL1lfK7aHqii5F2fr/0RL
        kyQkuSfs7RltAKf2V7CUmDef3SUcnAqTznU0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iaaj2JWUXfJe5US7SK24URewoDrSeHT2
        I7u84RVXVJk3Hgt1LQ5Iw/sv2cqiz77Iny2eOQZe5fqgXRZG/zgW2c9rYtL3ZSX/
        Nxu1b4PSNwbupmHapDq86zCL4SSvY8gAHUP+I35bsgqpCtYKaVKED0uOypQmeQg8
        XI69cU8b82o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2698A5803F;
        Mon, 19 Dec 2016 13:31:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CF645803E;
        Mon, 19 Dec 2016 13:31:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
        <CA+55aFzxFFNY+dL6s7dLZeVXBsBKD0aeof5Bj2wcD1CpefVSAA@mail.gmail.com>
        <xmqqtwa7ze9i.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612191237400.54750@virtualbox>
Date:   Mon, 19 Dec 2016 10:31:32 -0800
In-Reply-To: <alpine.DEB.2.20.1612191237400.54750@virtualbox> (Johannes
        Schindelin's message of "Mon, 19 Dec 2016 13:51:14 +0100 (CET)")
Message-ID: <xmqqh95zpy7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E104C50-C619-11E6-900A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 13 Dec 2016, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > On Tue, Dec 13, 2016 at 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> >>
>> >>> +/*
>> >>> + * Note that ordering matters in this enum. Not only must it match the mapping
>> >>> + * below, it is also divided into several sections that matter.  When adding
>> >>> + * new commands, make sure you add it in the right section.
>> >>> + */
>> >>
>> >> Good thinking.
>
> Not my thinking... This was in direct response to a suggestion by Dennis
> Kaarsemaker, I cannot take credit for the idea.

I now realize that I was unclear about what "thinking" I found good
in my comment.  I do not particularly like defining two parallel
things and having to maintain them in sync.  The "Good thinking"
praise goes to whoever thought that this burdensome fact deserves a
clear comment in front of these two things.

And ...

>> Makes me wish C were a better language, though ;-)
>> >
>> > Do this:
>> >
>> >   static const char *todo_command_strings[] = {
>> >       [TODO_PICK] = "pick",
>> >       [TODO_REVERT] = "revert",
>> >       [TODO_NOOP] = "noop:,
>> >   };
>> >
>> > which makes the array be order-independent.

... solves only one-half of the problem with the language I had.
The order of the entries in this array[] may become more flexible
in the source, but you still have to define enum separately.

I guess if we really want to, we need to resort to something "ugly
but workable" like what you did in fsck.c with FOREACH_MSG_ID(X).
That approach may be the least ugly way if we have to maintain two
or more parallel things in sync.

    ... and then realizes you wrote pretty much the same thing
    ... after writing all of the above ;-)

But it is way overkill for sequencer commands that are only handful.
