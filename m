Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01454C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 05:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGRFOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 01:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGRFOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 01:14:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15EF59E
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 22:14:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AC381405F3;
        Mon, 18 Jul 2022 01:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=2tQtidBi8rGZQS8B+KBk70gVO
        xkGL/BhPiUHmIckZUE=; b=lmd2x9HhEnckQAml6iXxucx6JZFNxGGy9DyoyMF7F
        lvW0jr4Vm84yq4l2TqqxPbIxOcSOcUbF+Er3s6f3wNuQGlOB9IkqN1HOkr68sHdq
        95UlIKtQMU26XaA7GU7sMPCTWM3ls1iXKookARLRw+WMEihZXS1lwAHiQ67kV8Sp
        Vo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3339F1405F2;
        Mon, 18 Jul 2022 01:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 870A51405F1;
        Mon, 18 Jul 2022 01:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
        <xmqqsfn21fmt.fsf@gitster.g>
        <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
Date:   Sun, 17 Jul 2022 22:14:07 -0700
Message-ID: <xmqq1qujt334.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 73A91832-0658-11ED-90C4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> That's all academic.  I wouldn't have written the above if the
>> proposed log message stopped here.  But with the rest of proposed
>> log message that hints that the above statement is backed by a solid
>> study of history, it is wrong to write a wrong version number there.
>>
>> I agree that it is safe to say that anything before Git 2.0.0 is
>> irrelevant at this point (I would actually say before Git 2.16.0,
>> i.e. anything older than 3-4 years).
>
> 1.4.4 is the version that introduced the flag, but the paragraphs I'm
> removing is relevant to 1.6.0, as it discusses concerns with that
> new-in-1.4.4 --delta-base-offset flag being turned on by default.
>
> So this documentation matches e.g. the RelNotes update you made in
> e903b4095a0 (Update draft release notes for 1.6.0, 2008-07-01).
>
> I.e. 1.4.4 was released in late 2006, 1.6.0 in mid-2008. Hence the
> mention of "git clients older than 2008-era git" not being a concern.
>
> I.e. the target audience for this bit of documentatino is someone
> running 1.6.0. or newer that's also concerned about pre-1.4.4.

Step back and think why the 1.6.0 carried the mention in the release
notes, and added the "use of delta-base-offset is incompatible with
versions of Git that are older than 1.4.4" to the documentation.

Back in 1.6.0 days, some of the users still had to refrain from
using the delta-base-offset feature by explicitly disabling it,
because the version of Git running on the other side of their
connection were before eb32d236 (introduce delta objects with offset
to base, 2006-09-21)---1.4.4 was the first version of Git that
learned how to produce packs with delta-base-offset, and how to read
objects out of such packs.

If 1.4.4 were too distant in the past to matter and we were sure
nobody is running such an ancient version back then, we wouldn't
have written such a notice there in the document when we turned it
on by default in 1.6.0.

Or, step back and think what we would have taken into account, if
the patch in question were suggested during the development cycle
toward Git 1.7.0, and what the reason for rejection would have been.
Even if there were tons of folks who were running pre-1.6.0 versions
of Git, as long as these old versions were all newer than 1.4.4,
then we would have said that the warning would not matter.  The
reason to reject such a patch in 1.7.0 cycle would not be because of
the age of 1.6.0 being too young, but because of the age of 1.4.4
being not old enough.

Both are based on how distant in the past 1.4.4 had happened.  As
the removed paragraph says, generated packs with delta-base-offset
are "incompatible with versions of Git older than 1.4.4".  If 1.4.4
and older died out, nobody needs to worry about use of d-b-o.  If
1.4.4 and older are still used, we would need to.  How ancient 1.6.0
does not matter.

Perhaps rein in the temptation to "attack back" in spinal reflex
when somebody bothers to take time to point out where you are
mistaken?  They are often not attacking you, but merely offering
improvements.
