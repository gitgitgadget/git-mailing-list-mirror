Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E6C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiEPQZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiEPQZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:25:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E0BDE9A
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:25:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BBD818EA2E;
        Mon, 16 May 2022 12:25:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0RzUdwRweKkT
        3rzNWskQFOZo1kACSTEBi/PtlCDeyE4=; b=wrYqc9z0pAVEnBaGDL5kLFqcVbiy
        D7cvy0lTNqhsi1SqX7zVaVBggBMcaXPUusWBKcIe7lMnYoTBYR8Pm8vXpkhi3WPA
        ydOpp+8/DlkJ+IdNirRG/LJlXP8ac6ZNbGG1vqmXYACpMLhxcQ14DSqm41r/oZ4H
        phzgXCPQMNubxzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63BDB18EA2D;
        Mon, 16 May 2022 12:25:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0DFC318EA2C;
        Mon, 16 May 2022 12:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-4-carenas@gmail.com>
        <xmqqee0ycjos.fsf@gitster.g>
        <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
        <xmqqr14u7n4l.fsf@gitster.g>
        <CAPUEsphNOf37WB_xUuRNdfcz1TRRsSocbUoCbrmA3OjS_BTpdw@mail.gmail.com>
        <xmqqo7zy59p3.fsf@gitster.g>
        <20220516130753.kgelgbfovs5kze7h@Carlos-MacBook-Pro-2.local>
Date:   Mon, 16 May 2022 09:25:38 -0700
In-Reply-To: <20220516130753.kgelgbfovs5kze7h@Carlos-MacBook-Pro-2.local>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 16 May
 2022 06:07:53
        -0700")
Message-ID: <xmqqee0t4f7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D33E7788-D534-11EC-906C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Sun, May 15, 2022 at 10:27:04PM -0700, Junio C Hamano wrote:
>> Carlo Arenas <carenas@gmail.com> writes:
>>=20
>> >> Hmph, it may not be needed, but it should still work, in which case
>> >> it probably is still worth testing, even with the optional patch #4=
.
>> >
>> > Just because it works, it doesn't mean we have to test it.
>>=20
>> Yes.  It all depends on the answer to this question
>
> Not quite, after all this is part of the "git" testsuite and therefore =
will
> only apply if it would be testing git's functionality, and in this case=
 it
> does not.

It is immaterial if the way how "sudo sudo git" behaves is "git's
functionality" or not, because what we care about is what the end
user sees as a whole and it does not matter all that much to them
where the observed behaviour comes from.

The rule is simple.  If we care about the behaviour to stay with us
over time, we ensure it with a test.  If we are certain that no
users will depend on such a behaviour and are willing to break them
(i.e. users who depend on how "sudo sudo git" behaves, which is an
empty set) when we need to update the code, then we don't.

And if that changes with and without the optional patch #4, it makes
it more important to have test (if we care, that is).  Later we may
find what patch #4 does is detrimental to user experience and decide
to tweak it out (not necessarily with a revert of #4, but doing an
equivalent of reverting of it only in the code part and not tests).

In any case, as I said in the beginning, this was merely "a bit
surprised" and "not a serious enough thing to trigger a reroll", so
I will stop wasting our time on this thread.

Thanks.
