Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56083C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F65613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhGPVVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:21:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51677 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhGPVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:21:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E113145CCB;
        Fri, 16 Jul 2021 17:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cup7FCtW1Ow1pBzcecu7oWaUpUesE6BL5xPhb6
        RFWtQ=; b=KvOyInKNp7b8ubBDoxI+veRPnXv52du8RMJlYodf+Ilh0esrudFEtE
        aQEdUKz/HSaiJOwvHLKWx4dh8kl0l/V7wJeFyx6oQwfNV4kXm8OZMESmi4Fsi787
        RoUfhjyMi1DDnI3wlaPKgqipRZnGvn7TOMTMhcEVM9glME0bBxnos=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 563AC145CCA;
        Fri, 16 Jul 2021 17:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EA49145CC9;
        Fri, 16 Jul 2021 17:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
        <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
        <xmqq7dhrtrc2.fsf@gitster.g>
        <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
        <xmqqpmvjs61c.fsf@gitster.g>
        <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
        <xmqqh7gvs2mu.fsf@gitster.g>
        <CABPp-BEHNpfm6mJBDZ30wCEraT03p+2-gGZyZcnUV34trAzAzw@mail.gmail.com>
Date:   Fri, 16 Jul 2021 14:18:01 -0700
In-Reply-To: <CABPp-BEHNpfm6mJBDZ30wCEraT03p+2-gGZyZcnUV34trAzAzw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 16 Jul 2021 11:39:50 -0700")
Message-ID: <xmqqwnpqot4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E57B0FA-E67B-11EB-B253-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> the dozen+ recent messages in the various recent threads, I think I've
> figured out your opinion in all but two cases, but I have no idea your
> intent on those two (I would have thought --rebase override there too,
> but you excluded that), and I'm rather uncertain I've correctly
> understood you for the other ones (I really hope gmail doesn't
> whitespace damage the following table):

Yeah, it's about time somebody made an exhaustive table of cases ;-)

I appreciate it very much.  Without such a table, it is hard to have
discussion and keep track of which part is and which part is not
what people agree to.

Below, I rearranged some rows to group cases I think belong
together to make commenting on them easier, but I didn't remove or
add any rows.

>    pull.ff  pull.rebase  commandline            action
>      *          *        --ff-only --rebase     fast-forward only[1]
>      *          *        --ff-only --no-rebase  fast-forward only
>      *          *        --ff-only              fast-forward only[1]

I think these three make sense.  As you answered to a question in
another thread, I agree that --ff-only from the command line should
fail instead of letting rebase (or merge for that matter) go ahead
when their history is not a descendant of ours and it is a bug if it
does not.

>      *          *        --rebase --no-ff       rebase[1]
>      *          *        --rebase --ff          rebase[1]

OK.

>      *          *        --no-rebase --no-ff    merge --no-ff
>      *          *        --no-rebase --ff       merge --ff

OK.

>     <unset>     *        --no-rebase            merge --ff
>     only        *        --no-rebase            merge --ff[2]
>     false       *        --no-rebase            merge --no-ff
>     true        *        --no-rebase            merge --ff

I think the second one deserves an explanation.  The rationale for
ignoring --ff-only is because the act of giving an explicit
"--rebase" or "--no-rebase" from the command line, when the
configured default is "I expect to have no development on my own
here, and only want to follow along", is a sign enough that the user
does not want to follow along in this particular invocation of
"pull".  And the rationale for the entire thing to become --ff is
only because between --ff and --no-ff, the former is the default.

About the second one, I would understand it if it became "merge
--ff-only", too.  That is more trivially explained.  I however
suspect that it would be less useful, but that is open to
discussion.

All three others I think are not controversial.

>     <unset>     *        --rebase               rebase
>     only        *        --rebase               rebase[2]
>     false       *        --rebase               ?[2]
>     true        *        --rebase               ?[2]

Again the same reasoning applies to the second case that defeats the
configured pull.ff=only setting.  pull.ff=unset and pull.ff=true
would be handled the same, so only the pull.ff=false might deserve
an explanation.  I not think there needs anything special, as there
is no "I want to do something special to mark the fact that we tried
to integrate their work" special case needed even when their history
is descendant of ours in "rebase" workflow, where we replay what we
did on top of theirs (in other words, in "merge" workflow, the shape
of history left with --no-ff would be different from --ff; in "rebase",
there is no difference---either you had your own development before
you ran "pull --rebase" and they got replayed on top of their history,
or you had nothing before you ran "pull --rebase" and you did your
development after that on top of their history, you'd end up with
histories of the same shape.  This would not happen with "merge"
workflow and that is why --no-ff may matter).

So, I agree with the above 4 (and the other 4 for --no-rebase)
entries.


>      *       <unset>     --no-ff                merge --no-ff
>      *        false      --no-ff                merge --no-ff
>      *       <unset>     --ff                   merge --ff
>      *        false      --ff                   merge --ff

OK.

>      *       !false      --no-ff                rebase (ignore --no-ff)[2][3]
>      *       !false      --ff                   rebase (ignore --ff)[2][3]

OK.  We do specified rebase, allowing fast-forward.

pull.rebase=<something> combined with --no-ff could mean "I do
expect I have some development of my own, and please stop me if I
don't" and instead of rebasing nothing, error out without even
repointing our branch tip to their history when it fast forwards,
but I suspect that it would be less useful.  Again, that (and
anything else I said here) is open to discussion.

> It appears you, Phillip, and I all had different opinions about
> correct behavior and in a few cases though the documentation clearly
> implied what we thought.  So, I'd have to say the documentation is
> rather unclear as well.  However, even if the above table is filled
> out, it may be complicated enough that I'm at a bit of a loss about
> how to update the documentation to explain it short of including the
> table in the documentation.

Thanks.
