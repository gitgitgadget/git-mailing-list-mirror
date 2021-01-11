Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F406C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4044322D06
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbhAKVBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:01:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51896 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbhAKVBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 16:01:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95FF7122F96;
        Mon, 11 Jan 2021 16:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QOvoRro3znYgN+q0s70OKqDAu68=; b=o/5kh8
        +gUfntObwHxr4fT8s/wLfccRbW2gKmlJ7ByUb69MNUCpyz2oE2ceQWmW5D4mc8lM
        XwaHKFYl5vStK+fDTvP0FxP7gsdmQIT/iLrfdfj1J8zANxuuGQOZZQGSPs7ku8bS
        L9ySBKifdjmgw0sN8/vNXFiDUvr3U4YT8Pu2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UUFA8B1GWKeqeS/vvEBPS5E8IVua8luy
        PE7y/kLSh3aVkkQB9ef9cAgvi+q2s90/7zqKcp81NqgwUWCZXtkXET4yJADZC7/M
        LYju4omsMjy1dzVkY2obGT9F75l2YagTHsJXrvpFnK2jGNq1AMgNt9nt1soGWPxY
        b8PazwC2igE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C6FD122F95;
        Mon, 11 Jan 2021 16:00:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5D8A122F93;
        Mon, 11 Jan 2021 16:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Robert Pollak <robert.pollak@posteo.net>,
        Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
        <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
        <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
        <23445a9c-46b2-0232-845b-c8d5fe36d506@redhat.com>
        <87mtxfwt3e.fsf@yadavpratyush.com>
        <d1f1691b-2fdc-1e6e-b346-31afb6aa5532@redhat.com>
Date:   Mon, 11 Jan 2021 13:00:22 -0800
In-Reply-To: <d1f1691b-2fdc-1e6e-b346-31afb6aa5532@redhat.com> (Laszlo Ersek's
        message of "Mon, 11 Jan 2021 17:28:24 +0100")
Message-ID: <xmqqmtxf6vfd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05F3ED6E-5450-11EB-89E5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laszlo Ersek <lersek@redhat.com> writes:

> On 01/11/21 13:33, Pratyush Yadav wrote:
>> On Mon, Jan 11 2021, Laszlo Ersek wrote:
>> 
>>> On 01/10/21 13:59, Robert Pollak wrote:
>>>> On 2021-01-06 16:58, Laszlo Ersek wrote:
>>>>> On 01/04/21 20:54, Robert Pollak wrote:
>>>> [...]
>>>>>> I see the following problems with my patch:
>>>>>>
>>>>>> 1) It is totally untested with all the other args that are collected in
>>>>>> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.
>>>>>
>>>>> It would be really great if gitk supported both "-O<orderfile>" and
>>>>> --find-copies-harder!
>>>>
>>>> Can you please test these options with my patch and report back?
>>>>
>>>> -- Robert
>>>>
>>>
>>> The patch doesn't apply with git-am (I'm trying on top of 72c4083ddf91):
>>>
>>>> Applying: gitk: Activate --find-copies-harder
>>>> error: corrupt patch at line 100
>>>> Patch failed at 0001 gitk: Activate --find-copies-harder
>>>> hint: Use 'git am --show-current-patch' to see the failed patch
>>>> When you have resolved this problem, run "git am --continue".
>>>> If you prefer to skip this patch, run "git am --skip" instead.
>>>> To restore the original branch and stop patching, run "git am --abort".
>>>
>>> One problem could be the embedded diff in the notes section (I guess it
>>> could confuse git-am).
>>>
>>> Also, "gitk" has existed at "gitk-git/gitk" since commit 62ba5143ec2a
>>> ("Move gitk to its own subdirectory", 2007-11-18), so the pathname
>>> headers in the patch look wrong.
>> 
>> gitk is maintained as a separate repo by Paul Mackerras at
>> git://ozlabs.org/~paulus/gitk, and then is pulled into the main Git repo
>> from time to time using a subtree merge. That's how gitk changes end up
>> in gitk-git/. Patches for gitk should be based on the gitk repo to make
>> it easier for Paul to apply them.
>
> Thank you for explaining!
>
> (I guess I'm more familiar with submodules than the subtree merge
> strategy in general; I've had to look up the latter on the web now.)
>
>> In short, the paths are fine.
>
> I tried applying the patch again, now on top of 6cd80496e9d3 ("gitk:
> Resize panes correctly when reducing window size", 2020-10-03) -- it
> turns out I'd actually had a clone of the stand-alone gitk repo you
> mention, I just needed to pull.
>
> But: git-am fails the same way.

That is because it has a patch-looking material that is not to be
applied before the real patch.  It is customery to indent such "diff"
that is meant to be read by humans as part of reading log message
and justification of the patch, not the patch itself.
