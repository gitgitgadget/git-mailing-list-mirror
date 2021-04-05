Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE65C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC87E61399
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhDEWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:46:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61007 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhDEWqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:46:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9DB6115233;
        Mon,  5 Apr 2021 18:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N7EFeiF+Qe7Xpe7MeKOCkd8RyTQ=; b=CILVzt
        TVfVXwWvXq8w8BgVZb0IOuJNxJqstvAHOlvvdGaqOmXy9dKrKJ1frNvhVJ1VvIr/
        hHip7IoG9skK0mnW2a0FLNKJkLZFBlAe8mgip6Ouc12uFRGYkqPEln1YIB4DSBXR
        grSzNzyFF10Lr7I0/+8WuUQ2WCOkEP0HivP40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ihtgkKt6dVm82lZfIiNQO+vKGuAo9+2e
        n9RxQ3BDtRr2GdYwXszLzRffokTQ7Q+fS39rXehHQ9AvGNmFV6wSw6w086wf8O8s
        HoL+ggN2MGuOXwHTyummw3/O+H59yUu6TkFVA55OXtDOfREf9EG29JLChtKodWSa
        n95pFfa+INs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1F0F115232;
        Mon,  5 Apr 2021 18:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F574115231;
        Mon,  5 Apr 2021 18:46:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-2-jerry@skydio.com>
        <20210405221902.27998-1-jerry@skydio.com>
Date:   Mon, 05 Apr 2021 15:46:30 -0700
In-Reply-To: <20210405221902.27998-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 5 Apr 2021 15:19:02 -0700")
Message-ID: <xmqqr1jo4aex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C46D33AC-9660-11EB-8A7E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way options

s/Allow/allow/ (cf. "git shortlog --no-merged" output for recent examples)

> Previously, --cached and --3way were not
> allowed to be used together, since --3way
> wrote conflict markers into the working tree.

Hint that you are talking about the "git apply" command by
mentioning the name somewhere.

Drop "previously"; we talk about the status quo in the present tense
in our proposed commit log messages to set the stage, and then describe
what the patch author percieves as a problem, before describing the
proposed solution to the problem.

cf. Documentation/SubmittingPatches[[describe-changes]] (the whole section)

> These changes change semantics so that if
> these flags are given together and there is
> a conflict, the conflicting objects are left
> at a higher order in the cache, and the command
> will return non-zero. If there is no conflict,
> the patch is applied directly to cache as
> expected and the command will return 0.

Give an order to the codebase to "be like so".  Here is my attempt.

    Teach "git apply" to accept "--cached" and "--3way" at the same
    time.  Only when all changes to all paths involved in the
    application auto-resolve cleanly, the result is placed in the
    index at stage #0 and the command exits with 0 status.  If there
    is any path whose conflict cannot be cleanly auto-resolved, the
    original contents from common ancestor (stage #1), our version
    (stage #2) and the contents from the patch (stage #3) for the
    conflicted paths are left at separate stages without any attempt
    to resolve the conflict at the content level, and the command
    exists with non-zero status, because there is no place (like the
    working tree files) to leave a half-resolved conflicted merge
    result to ask the end-user to resolve.

> The user can use `git diff` to view the contents
> of the conflict, or `git checkout -m -- .` to
> regenerate the conflict markers in the working
> directory.

Nice.

> With the combined --3way and --cached flags,
> The conflict markers won't be written to the
> working directory, so there is no point in
> attempting rerere.

I am not sure what this paragraph is trying to convey here.

I agree that when a *new* conflict is encountered in this new mode,
writing out a rerere pre-image, in preparation for accepting the
post-image the end-user gives us after the conflicts are resolved,
does not make sense, because we are not giving the end-user the
conflicted state and asking to help resolve it for us.

But if a rerere database entry records a previous merge result in
which conflicts were resolved by the end user, it would make sense
to try reusing the resolution, I would think.  I offhand do not know
how involved it would be to do so, so punting on that is fine, but
that is "there is no point", but it is "we are not trying".

Perhaps

    When there are conflicts, theoretically, it would be nice to be
    able to replay an existing entry in the rerere database that
    records already resolved conflict that match the current one,
    but that would be too much work, so let's not try it for now.

would be a good explanation why we are not doing (i.e. we made a
trade-off) and recording that is important, as it will allow others
in the future to try building on the change we are proposing here
(it is not like we decided that it is fundamentally wrong to try to
use rerere in this situation).

> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>

Unless we are interacting with two people with the same name, please
sign-off with the same name/address as the name/address that will be
recorded as the author of this change.  I am guessing that dropping
the latter should be sufficient?

Thanks.
