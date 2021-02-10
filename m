Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12F6C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DBF64E15
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhBJSTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:19:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50460 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhBJSRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 13:17:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 300D59854E;
        Wed, 10 Feb 2021 13:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5tZftM5EN+y4
        41JNB6uqc6Wp4oY=; b=tr1sC/NGwdt1yoZZFflEOn78puSdULv1S/HspHZelkJ2
        ZT8j6h6LX2p0XpDwtjGenaeBgpZXdRcLcKOUdgwbMT2WkE0cwyPxB6aSxP153p3L
        bxILNAjEsgHKW41QUOhAT43ie1qCjtL1dJdZosU/roAMsO3ZeGJykRo1f1Om97o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c/I7Yh
        Si0/zyJK5+36x8vNOr4ptrYttZCldisLCygsq4408aOtGOlZdt/T7Xf7SdY2e1n9
        Zu5TTvKtnVoMBf+lHAvh7KaSVjVlMJwrSs3i//dArmbWX+NSV78Xvg9ZZoGKnL65
        3hjZO6k/cvubmdW3o5tsaArAkL+v87a9zpXJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 274149854D;
        Wed, 10 Feb 2021 13:16:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A53629854C;
        Wed, 10 Feb 2021 13:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH v3] difftool.c: learn a new way start from specified file
References: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
        <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
        <xmqqeehp2jis.fsf@gitster.c.googlers.com>
        <CAOLTT8QbutZ2pHZ7Zg7vEJAy=d66YKP12rVW=RSJV+8fH6RRMw@mail.gmail.com>
Date:   Wed, 10 Feb 2021 10:16:56 -0800
In-Reply-To: <CAOLTT8QbutZ2pHZ7Zg7vEJAy=d66YKP12rVW=RSJV+8fH6RRMw@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Thu, 11 Feb 2021 01:00:41
 +0800")
Message-ID: <xmqqk0rf3i07.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29660046-6BCC-11EB-83B2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

> It has no effect on this new feature. I should put this modification
> in an additional commit, right?

Or you can just drop it.  It certainly is a distracting change to be
part of this topic.

> Yes, I want to know why being so cautious in git log?If the file name i=
s
> wrong, why can't I make it exit? :)

Imagine a history where file1 and file2 are in the initial commit.
The second commit adds file3 and modifies file2, and then the third
commit modifies file1.  What would happen when you did this?

  $ git log -p --rotate-to=3Dfile2

For the commit at HEAD, the set of paths shown would be file1 and
nothing else (because it is the only path that gets modified).  You
cannot start showing from "file2".  Dying (and not showing HEAD~1
and HEAD~2) is the last thing you want to do in this situation.  We
do not even want to give a warning or an error, as it is totally
expected that some commits do not touch a given path---it would be
very unusual if a path is touched by every commit ;-).

For "difftool --start-at=3Dfile2", the equation is different.  It does
not traverse history where each commit may or may not modify file2,
and when the user says s/he wants to resume from file2, file2 must
be in the set of paths that have changes, or something is wrong (i.e.
the user meant file3 but mistyped it as file2).

> Awesome idea. In this way, `difftool --rotate-to=3D<file>` can call
> `diff --rotate-to=3D<file>` , user can choose the starting file, and th=
ey can
> also see previous files.

So "difftool --start-at=3D<file>" can of use "diff --rotate-to=3D<file>"
to implement the feature (after all, that is why I wrote it), but
the error condition between the two are quite different.  And ...

> After that, there was too little work I could do,do i just need to add
> the following
>  code in `diff_flush_patch_all_file_pairs`?


> if (o->rotate_to && q->nr && strcmp(q->queue[0]->one->path, o->rotate_t=
o) &&
> strcmp(q->queue[0]->one->path, o->rotate_to)) {
>     error(_("could not find start file name '%s'"), o->rotate_to);
>         return;
> }

... that is why an unconditional change like this in diff.c is not
acceptable, as it would break other codepaths like "git log -p".  If
we were to add an error there, it has to be very limited to exclude
at least "log -p"---there may be other features that share the code
that should not trigger an error for similar reasons.

If diffcore-rotate chooses "missing rotate-to file makes it a no-op"
as its semantics, and if "difftool --start-at" does not want to see
a misspelt filename making it a no-op, then the latter needs to
ensure that the name it got from the user is indeed in the set of
paths that have changes before running "diff --rotate-to" to
implement its "difftool --start-at" feature.

The "missing rotate-to file in the diff_queue MUST NOT cause
diffcore-rotate to error out" rule is probably unnegitiable, but
there are other ways to make it easier to use, though.

For example, we could change the rotate-to logic to mean "start at
the given path, or if such a path does not exist in the diff_queue,
then the first path that sorts after the given path is where we
start".  That way, if the diff_queue has paths A B C D E and
rotate-to gives C, then we rotate the output to C D E A B.  And if
the diff_queue has A B D E and rotate-to gives C, then the output
would become D E A B (instead of becoming a no-op).  Then, a mistyped
filename may not do what the user wanted to do (after all, that is
the definition of MIStyping), but it would do something noticeable
by the user, which may be useful enough and at least would let the
user notice the mistake.

> In addition, Do I need to do the documentation and tests related to
> your `diff --rotate-to`?

Once we know how we want "diff --rotate-to" to behave exactly, I can
help that part further, if you want.  And then you can build on top.

But we need to design exactly what the desired semantics would be
before any of that.

Thanks.

