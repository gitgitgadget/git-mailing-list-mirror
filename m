Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF4C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B309B2313B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbhAFV3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:29:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbhAFV3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:29:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA6DB3C8E;
        Wed,  6 Jan 2021 16:29:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6quGLg0pno6muh4Y1eGWvToqAkM=; b=F+mrhW
        q+hPg1JsapTKDR2wVdk/wnrTdhqtjr+lV73/Y+8ffVf3wMitdITUCvibABy2ZZ3b
        oUZz5nP4Lq6j/yQglCvv0EYGwfoJ5X+zr0dssyLnv0pb3Q6jqRxr8xTIvq+5fl+7
        7zKs/rZMEl12HK57Hc/Pv1cTjfTL3e7BEgobQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LGkKKMiVpto2wAjx9cOViUPZ1627mebP
        QjfGzGOSb7saQ7JjuFkVXKW1RAkNUrq06kpQRGJnAbgzEdIEIq+On9JWxhV8cNd+
        LY8RjXhX9LDc7UWRslBkSzyubWHTIKWcTxwrSulFdDs8ocAzrN0WSOeqW6FELIVy
        DB3smx6kZNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 746C0B3C8D;
        Wed,  6 Jan 2021 16:29:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8AF2B3C8C;
        Wed,  6 Jan 2021 16:29:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
Date:   Wed, 06 Jan 2021 13:29:06 -0800
In-Reply-To: <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 6 Jan 2021 11:40:25 -0800")
Message-ID: <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34EC0680-5066-11EB-AAF2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sidenote:
>
> Yeah, checkout --orphan is broken.  You should use switch --orphan,
> which doesn't require the extra 'git rm -rf .' step.  That bit is
> definitely cumbersome.

I doubt "broken" is an appropriate word.  

It only targets a different workflow that wanted to start an
unrelated history with a known contents.

> Out of curiosity, why are you frequently creating orphan branches?
> Such an option would drop the number of commands you need to run from
> four down to two, but I'm surprised this would come up enough to
> matter enough to do much more than create a personal git alias for it.

Yes, a need to have multiple unrelated line of histories in a single
repository may not be there, even though a desire to do so might
exist.  What is done with these unrelated histories that record
unrelated contents [*1*]?

For example, the answer might turn out to be "our hosting provider
charge by number of publishing repositories, so I keep only one
repository there and push unrelated stuff into it, on different
branches", and such a use case to work around external limitation
can be more naturally solved by having separate repositories on the
producing side, and pushing into different branches in that single
publishing repository, which does not require any "--orphan" at all.


[Footnote]

*1* if the trees in these unrelated histories record related
    contents, the user wouldn't be doing "git rm -f ." in the first
    place and "checkout --orphan" would be more appropriate than
    "switch --orphan".
