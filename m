Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62448C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 20:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiCDUBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiCDUBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:48 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698D286728
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 11:56:06 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8577D17843C;
        Fri,  4 Mar 2022 14:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=cfFiw9FqvgqfKBNUFXemyn8Dj
        NUP+PMGMdIgGEnfVbU=; b=CD91iDp6WZ17zOWXYu50RQC/uM3l7OrfjLrwq7sx6
        tmQVK9y7Tz2mQWU23y8Aa4otXmJzJR866tC9ubt39UYIL+n0v5wKkPn6xtsZwjTr
        KzRAp0/Wk/PnpdQiyfSVL5mBtLQ40J0tbyR/PDVHW4SuYI5XoMOsIslTCE6yiPu3
        9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DDBA17843B;
        Fri,  4 Mar 2022 14:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7C6E178439;
        Fri,  4 Mar 2022 14:41:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: log messages > comments
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-4-gitster@pobox.com>
        <YiFY693P6E/eVS3k@google.com> <xmqqr17i5zlu.fsf@gitster.g>
        <220304.86ilsuf1e8.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Mar 2022 11:41:19 -0800
Message-ID: <xmqqk0d91p5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 112A5A24-9BF3-11EC-84CC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 03 2022, Junio C Hamano wrote:
>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>>>> +The goal of your log message is to convey the _why_ behind your
>>>> +change to help future developers.
>>>> +
>>>
>>> This is pretty compelling. Is it clear enough why we care about this =
in
>>> the commit message, as opposed to in the patch description (cover let=
ter
>>> or post-"---" blurb)? Is it too obvious to explicitly mention that th=
e
>>> commit message is the first thing we try to make sense of during a 'g=
it
>>> blame' or 'git bisect'?
>>
>> Again, patches welcome ;-)
>
> I think for something that's a stylistic preference I'd see why Emily
> would try to see how you feel about it first.

I do not think there is a need to write down stylistic preference.
I may show my preference during my reviews, of course, but I won't
take preference-only things as a blocker.

I also do not think things like "'We used to do X here but we do Y
because ...' does not belong to in-code comment, but to log message"
is "stylistic preference", and if people are unclear about, I agree
that we should spell it out.

An example, I can think of offhand, of what should be in comment,
whether we also write in the log, is "We do X here because that
other code expects us to", when it is tricky to figure out by
reading the code by itself without going back to "git blame".

"git blame" certainly can be used to figure out which commit touched
the line that does X (which is hard to figure out why), and the log
message can refer to "that other code expects us to", but that is an
extra operation.

Also, when we really need to figure out, it is wonderful that we can
ask "blame" to give us the commit, and can look at "that other code"
in the same commit by checking it out to the working tree,
especially when "that other code" may have drifted and the original
reasoning no longer applies (iow, what we find out from "git blame"
may become stale, and it will stay stale forever because we cannot
rewrite the history that old).

Now, it is certainly not black/white decision to say what is and
what is not tricky to figure out in the code.  We shouldn't be
commenting obvious things.  Two yardsticks I use are

 (1) if reviewers raise questions during a review, it may indicate
     that it is worth commenting.

 (2) if an earlier round of the same series had a bug around the
     area, it may indicate that the fixed code is worth commenting.

but the way I use them is more to say "I found this uncommented code
somewhat tricky---but nobody asked a question and it has stayed the
same from the initial round, so it may be clear enough for other
people, and after all I managed to figure out myself, so it probably
is OK to leave it uncommented".
