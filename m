Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C4C433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC7F601FF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhJYQvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:51:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61470 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhJYQvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:51:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0D2FF77D2;
        Mon, 25 Oct 2021 12:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BbhimHfYq7e+zn3sZL3uSXMA7NSA9n/2WxHL8+
        RLUEk=; b=blysrkL0l/33cswDMCwbeJk4XTNEcHM7kCvW+b0/bGtgsPM5o338EU
        j8+NXKZSX8ytRvWW5dPz4sbOvvUiUmjrcZF6OjYAFp5QfbYSYAaByCzbBaVKpmC4
        p7Q+DqoqJ8yScRcrSzq3brOr2xnO65TdVgTvmXhF2Ua2HTNCrnPz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A831DF77D1;
        Mon, 25 Oct 2021 12:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19D0CF77D0;
        Mon, 25 Oct 2021 12:48:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
        <006c186e-c005-28a3-7a5c-27d365ffe026@gigacodes.de>
Date:   Mon, 25 Oct 2021 09:48:40 -0700
In-Reply-To: <006c186e-c005-28a3-7a5c-27d365ffe026@gigacodes.de> (Fabian
        Stelzer's message of "Mon, 25 Oct 2021 10:59:53 +0200")
Message-ID: <xmqqilxl2gpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 688E20B2-35B3-11EC-9BCE-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 23.10.21 22:32, Junio C Hamano wrote:>  * A new feature should be
> based on `master` in general. If the new
>> -  feature depends on a topic that is in `seen`, but not in `master`,
>> -  base your work on the tip of that topic.
>> +  feature depends on other topics that are in `next`, but not in
>> +  `master`, fork a branch from the tip of `master`, merge these topics
>> +  to the branch, and work on that branch.  You can remind yourself of
>> +  how you prepared the base with `git log --first-parent master..`
>> +  easily by doing so.
>
> Using the topic branches from gitster/git that were merged? Or by
> selecting the specific commits from the merge into next?

If I were doing this, I would find the tip(s) of things I would
depend on out of the output from

  $ git log --oneline --first-parent origin/master..origin/next

This lists a series of merge commits and the second parent of each
merge commit is the tip of the topic that was merged to 'next'.

>> @@ -260,8 +281,8 @@ or include any extra files which do not relate to what your patch
>>  is trying to achieve. Make sure to review
>>  your patch after generating it, to ensure accuracy.  Before
>>  sending out, please make sure it cleanly applies to the `master`
>> -branch head.  If you are preparing a work based on "next" branch,
>> -that is fine, but please mark it as such.
>> +branch head.  If you are preparing a work based on selected topics
>> +merged to `master`, please mark your patch as such.
>
> I think this meant to say 'merged to "next|maint|seen"'?
> Or topics selected for being merged into master?

Ah, thanks for catching.  I meant "not merged to 'master'" (will fix
locally).

Depending on stuff that are already in 'master', unless you are
preparing a fix that would also apply to the maintenance track, is
rather easy---you can just build on top of 'master'.

And in general, I do not want to see a new topic based on another
topic that is not yet in 'next'.  If a developer has such a topic,
I'd appreciate if the developer waits and shifts their attention to
help the other topics they are planning to depend on---and one way
to do so is to review these other topics ;-)

Thanks.
