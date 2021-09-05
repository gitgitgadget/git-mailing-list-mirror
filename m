Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A47C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E5760C51
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 22:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhIEWc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 18:32:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51526 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhIEWc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 18:32:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E277D1526EE;
        Sun,  5 Sep 2021 18:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/yhUP2dRjXfM
        qnYiQ7JfHfsENDp54ruvrmWCkiczS20=; b=trSvRV0I/fHW4U7vmIz1XSHFDTWp
        Cs4ESTUypuvj9PTZCmYJzvuQIkBImOIHVbGD8jXXtetRlhCHMWkDFGhiDRK3FDQ1
        VqpaNksl2a3lxOLrRM/MBUGZv8nmbFkXhfnIygNetrK6VN+x0e/Hd7CBGAVka/T3
        64xydZwuP3O2wNA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA5451526ED;
        Sun,  5 Sep 2021 18:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2AB121526EC;
        Sun,  5 Sep 2021 18:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
        <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
        <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
        <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
        <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
        <YTNH2vMPuEW4SBMo@coredump.intra.peff.net>
        <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
Date:   Sun, 05 Sep 2021 15:31:50 -0700
In-Reply-To: <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 4 Sep 2021 22:32:57 -0700")
Message-ID: <xmqqr1e2ejs9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1122C79C-0E99-11EC-BEB0-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> unpack_trees.  In fact, it traces back to (and before)
>     fcc387db9b ("read-tree -m -u: do not overwrite or remove untracked
> working tree files.", 2006-05-17)
> which has additional commentary over at
> https://lore.kernel.org/git/7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net/=
.
> It appears that before this time, git happily nuked untracked files
> and considered them expendable, in basically all cases.  However, this
> patch continued considering them as expendable whenever opts->reset
> was true.

Thanks for digging.  Yes, the 'reset' bit was treated as the license
to kill untracked working tree files and directories that get in the
way in order to carry out the unpack_trees operation.

> So, then...should we preserve untracked (and non-ignored) files in all
> these cases?  This rebase case seems clear, but others might be less
> clear....

In short, the guiding principle ought to be that "checkout --force"
and anything that is given "force" as a stronger override should be
allowed to do whatever minimally necessary to match the end result
in the working tree to what the command wants to show in the absense
of these untracked paths.  And without being forced, untracked and
unignored paths are precious and should cause commands to fail, if
they need to be touched for the commands to complete what they are
asked to do [*].

"reset --hard HEAD" is an oddball.

Na=C3=AFvely, because it is often used as the way to tell Git to "no
matter what, match the working tree to HEAD", even though it does
not have an explicit "--force" on the command line, it feels that it
also should be allowed to do whatever necessary to the working tree
files.  And historically, that is what we wanted to implement.  If
we suddenly made it "safer", I am sure a lot of existing things will
break.

But unfortunately, "--hard" means a bit more than that in the
context of "reset", in that we want to reset in a way that is
different from "--mixed" (reset the index only without touching the
working tree) and "--soft" (do not touch the index or the working
tree), more specifically, with "--hard", we want to reset both the
index and the working tree to match the given committish (often
"HEAD").  From that point of view, "reset --hard" that tries to
preserve untracked and unignored paths, and "reset --force --hard"
that does whatever necessary to untracked and unignored paths to
match the working tree files, when they reset the index and the
working tree to the named committish, may have made sense.  If we
were designing the feature without any existing users, it is no
brainer to imagine that our design would: (1) call the three 'reset'
modes as "both", "index-only" and "neither", instead of "hard",
"mixed" and "soft", and (2) require "--force" to touch untracked and
unignored paths.

And I think that may be a reasonable longer-term goal, but since we
have existing users and scripts, we cannot go there overnight without
devising a migration path.

Thanks.


[Footnote]

* We sometimes talk about adding a precious category of paths that
  are "ignored", but this discussion is orthogonal to that.  Things
  that are not tracked and not ignored ought to be precious in
  principle.
