Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF75C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2E22078C
	for <git@archiver.kernel.org>; Thu, 28 May 2020 22:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ia5YNROX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436932AbgE1WVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 18:21:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51888 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbgE1WVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 18:21:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC6A0D5185;
        Thu, 28 May 2020 18:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rLZreXKz+6b8ZelvesFb2aW8VcY=; b=Ia5YNR
        OX4kP2KCM011X64lYyCBH2PT08/eZN7sNDZEZILHQ+axR6gZ28dNoQM1LOC9d5nf
        7tgnftXjsotHypmFnRGcwVqWa25WdqyfSYSdxqKWaF0nVYYVFomC7EyFjX4/KjeQ
        5+yKLDmLRjYitp1V59IKyKkPdbm+o37Vbp/Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cqCtyEUby41DsmyGLJ//GKxl9JFsPGSS
        Yg5dSlSqHaU6kfwTJqYwr80QWYVVacLQgLJz1TFouvkA0CpT+eW7o2bcPP+lcMtu
        kJd4Y/bM6xRoGt0RS1kqEUjL42CeTjzHb5aZ7S/76wwZ4arcwkgabQD1BXhrtggO
        x9m2xS2XiHI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4651D5184;
        Thu, 28 May 2020 18:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 065CCD5182;
        Thu, 28 May 2020 18:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Steven Willis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
        <20200528215107.GA1265681@coredump.intra.peff.net>
Date:   Thu, 28 May 2020 15:21:34 -0700
In-Reply-To: <20200528215107.GA1265681@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 17:51:07 -0400")
Message-ID: <xmqqy2pb1z0x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97CBE7F0-A131-11EA-B830-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think for now we ought to explain the situation a bit more clearly:
> leave this language as-is, but add a new section describing what
> patterns we do support.

Thanks; you said a lot better than I could ;-)

> In the long run it would be nice to actually match regular pathspecs.
> That would be a backwards-incompatibility, which I think is why nobody
> has pursued it further (and ls-tree is meant to be plumbing that should
> stay consistent, so we need to be extra careful). So we'd need a
> transition plan. Perhaps:
>
>   1. Deprecate the current behavior in the documentation and release
>      notes, encouraging people who want literal matching to use
>      --literal-pathspecs or the ":(literal)" magic. AFAICT we've
>      supported these since at least 2013 for this command, so it should
>      be safe to use unconditionally.
>
>   2. Add a new option, "--use-pathspecs" or similar, that switches the
>      matching code to use match_pathspec(). That lets people use the new
>      feature immediately if they want to.
>
>   3. When --use-pathspecs is not in use, warn to stderr about any
>      wildcard characters in the input. That reinforces the deprecation
>      notice in (1) and is likely to get more people's attention.

Hmph, if we are serious about deprecation and migration, I would
image that in stage #1, we should do this check already.  When
"--literal-pathspecs" is NOT in use, if a pathspec would change its
meaning if not taken literally (e.g. has glob letters, begins with
:-magic introducer, etc.), we warn and do so from the very beginning
of the migration process.

>   4. After several releases, flip the default to --use-pathspecs,
>      leaving --no-use-pathspecs as an escape hatch for people who still
>      haven't switched their scripts.

Wouldn't --literal-pathspecs be the accepted escape hatch that will
always be accepted, even after --use-pathspecs becomes a no-op?

>   5. After several more releases, eventually remove the old-style
>      matching (perhaps leaving --use-pathspecs as a noop).

> To be honest, that may be more careful than we absolutely need to be.

Yeah, there seem to be some room for optimization, but I think the
key steps are about right if we wanted to do this migration.

Thanks.
