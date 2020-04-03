Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2AC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2252076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hk1Qhz4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390993AbgDCSas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:30:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53441 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCSas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:30:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 415764AAF7;
        Fri,  3 Apr 2020 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HPv5M64AAIJ9Wy/RGQA3qtQqBwE=; b=hk1Qhz
        4bxrM1BaEknh17sihx0D0jwJq8f6SLXywDRkUqOtQ4z0hBI1hCjbz3dEUnztmYpv
        zWIWPU6tVNEJYeP+aEBFYmuhF3xoRAs/nEH/OnlwTmbhfjsl3/NxBwwH+9HOybcW
        YnKPWksOKHXtlYL2KBX0HuByjBL72wgYtA3oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kf9iMsn5P+LnjfsSZjaBxPyx15UYVbGb
        SmLrpN4ZxWFV0j8auqQWGdYXWnHl2EdKjILcmDDSeZkFB8IfIy9w3C7Rz3x4GW/V
        A5VyEyyGYFgF56iXnO06+1E2HW59FzkX30yOiqQHE0/UNuEiG/Eo2+fgmYSUBzp3
        /FtTvgOqJNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 370424AAF5;
        Fri,  3 Apr 2020 14:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9050B4AAF2;
        Fri,  3 Apr 2020 14:30:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/11] bisect--helper: fix `cmd_*()` function switch default return
References: <20200321161020.22817-1-mirucam@gmail.com>
        <20200321161020.22817-2-mirucam@gmail.com>
        <xmqqk12x17za.fsf@gitster.c.googlers.com>
        <CAP8UFD3t5ZukXqfEr9W8FFror=SemmoB0hokri2BK6ZYcq619Q@mail.gmail.com>
Date:   Fri, 03 Apr 2020 11:30:42 -0700
In-Reply-To: <CAP8UFD3t5ZukXqfEr9W8FFror=SemmoB0hokri2BK6ZYcq619Q@mail.gmail.com>
        (Christian Couder's message of "Fri, 3 Apr 2020 15:17:54 +0200")
Message-ID: <xmqqv9mgzajx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A6301C6-75D9-11EA-997C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> The return value from error() is *NOT* taken from "enum
>> bisect_error"; its value (-1) happens to be the same as
>> BISECT_FAILED, but that is by accident, and not by design.
>
> In bisect.h we have made sure that BISECT_FAILED would be -1, so it is
> not by accident:

It *is* accident waiting to happen, unless you have a comment to
tell future developers that they are forbidden from changing the
assignment of values; "We've made sure" alone is not a good excuse.

> enum bisect_error {
>         BISECT_OK = 0,
>         BISECT_FAILED = -1,
>         BISECT_ONLY_SKIPPED_LEFT = -2,
>         BISECT_MERGE_BASE_CHECK = -3,
>         BISECT_NO_TESTABLE_COMMIT = -4,
>         BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND = -10,
>         BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
> };
>
>> So the above code is accident waiting to happen, while
>>
>>         default:
>>                 error(_("BUG: ..."));
>>                 res = BISECT_FAILED;
>>
>> would be a lot more correct (by design).
>
> I think it is very unlikely that we will ever change the value
> returned by error(), so I don't think there is an accident waiting to
> happen.
>
> Maybe we should make it clearer though in bisect.h in the comment
> before the enum, that we chose -1 for BISECT_FAILED so that it is the
> same as what error() returns....

In this particular case, you do not even need to rely on such a
comment to tie hands of future developers' needs (e.g. they may need
to add a new enum value that must come between OK and FAILED because
they will find "if (err < FAILED)" is an easy way to do something
they need to do; an ordering requirement similar to how "enum
todo_command" in sequencer.h wants to enforce certain ordering of
values is not uncommon, and they will find it awkward if they are
told that they cannot move FAILED to some value other than -1).  You
were even shown a better way to separate "res" from the value
error() returns (which will always be -1) and BISECT_FAILED (which
may be -1 right now, but future developers may want to change it,
and you have the power to allow it).

I do not see why you are still giving a lame excuse after that.

I even do not like the fact that you are doing so in the context of
being a mentor---please do not spoil the opportunity to educate good
developers of our future; instead please lead them by showing a good
example.

> I am ok with using "-res" here. There are other places where
> "abs(res)" is needed though, so code could look a bit more consistent
> if "abs(res)" was used here too.

If there are two kinds of codepaths, some *need* to deal with both
positive and negative for good reasons, and others only need to deal
with non-positive values, it would make it easier to understand the
code by consistently using -res for the latter while using abs() for
the former.

This is a tangent, but a codepath that needs abs(res) may need to be
reexaimined for correctness, as it is likely that it is a sign that
a sloppy developer swept a deeper underlying problem under the rug.

Imagine that a function A, in one if() statement in it, returns
error() whose value is -1, and in some other if() statement returns
BAD_XYZZY whose value is 1.  The function A also returns BAD_FROTZ
whose value is 2.  The only guarantee the caller gets from the
function A is that an error is signaled by non-zero value, and zero
means success.

And if you use abs() to squash an error and BAD_XYZZY into 1 in your
function B that calls A, what good are you doing to the callers of
your B?  They cannot tell between error and BAD_XYZZY, but they can
tell them from BAD_FROTZ, but does such an arrangement make any
sense?  It would be far more rational to make your B either (1)
return -1 for any error, if B thinks callers do not have to care
(which could be a valid stance to take, depending on the nature of
B), or (2) add an error code to BAD_{XYZZY,FROTZ} family and map -1
that comes from an error to that value, so that the callers can tell
them apart, or (3) do the equivalent of (2) but do so inside A (not
in B), and update call the callers of A.

Any of the above is more sensible and future-proof, compared to
blindly using abs(res) and claim that you are safe because you are
not returning a negative value.

>> By the way, under what condition can the "BUG:" be reached?  Would
>> it only be reachable by a programming error?
>
> It could happen if a user would try to directly use `git
> bisect--helper <cmd> ...` with an unsupported <cmd>. Users are not
> supposed to directly use bisect--helper though.
>
> It could also happen if a developer uses `git bisect--helper <cmd>
> ...` in a script, program or alias if <cmd> is not properly spelled or
> is unavailable for some reason.

If the user can legitimately trigger it, it is not a "BUG:".  Let's
make sure we use "BUG:" (whether it comes from BUG("...") or handcrafted
message like this one here) only when there is a bug in our program.
In other words, when a user sees "BUG:" emitted from our program and
reports it to us, there shouldn't be a room for us to say, "eh,
thanks for reporting, but it is an intended behaviour---you are just
holding it wrong".

If I did not know bisect--helper is its way out (which would be the
endgame of making "git bisect" fully converted to C), I would say
that we should just mark it as an error, but in the endgame state,
there won't be any end-user visible bisect--helper, so I am OK to
label it as a "BUG:" in this case.  It will be in the endgame state.

Thanks.
