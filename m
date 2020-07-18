Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3776C433E4
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6784A2076A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WapbT1yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGRRqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:46:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51420 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRRqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 13:46:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB9B172DD0;
        Sat, 18 Jul 2020 13:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hHCVH+bhBfKgmv6VqWJOdu52B5E=; b=WapbT1
        yMN1NdKE1J3+sDmSnDB9qNULDwySwok1gDxIKi6WpTn1yz7xalAc8v3JRKt91EuO
        6uMRvLcn7fo4FdEcCFcJztibn7P01Xwa9gHQoLAtZd8S7R2Vt+OcJAKHQuvKlplk
        bkcUMjOj4eLrMm1MFFhcMr1k24EFsBzKv0Mck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VGIJzadFtVePj2ik/sMjygs2HttmxgmS
        XG0X/tFWEnGKBp5uIHZNzR2WBfR/SGjq9k7EiM4dC+Pg7SzDhEbxyK/uWf68lprO
        0rJlkdvSLeAjVk1L8LysV/vyYKRWQzQqoDxFaV3Vyzz0QzcBVVHLqfV08b696HmA
        lAeZHUNiApU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3F3672DCF;
        Sat, 18 Jul 2020 13:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29F3872DCE;
        Sat, 18 Jul 2020 13:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
        <xmqqeep9d6tm.fsf@gitster.c.googlers.com>
        <CABPp-BGDp_SjJKvi+XVd6KvRLA5PVsK4xBLPvBxAimDft+0M9g@mail.gmail.com>
Date:   Sat, 18 Jul 2020 10:46:25 -0700
In-Reply-To: <CABPp-BGDp_SjJKvi+XVd6KvRLA5PVsK4xBLPvBxAimDft+0M9g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 17 Jul 2020 19:00:22 -0700")
Message-ID: <xmqq8sfgd8cu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AD303EC-C91E-11EA-B4DF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Or, even better, make ce_stage(ce) not be an error; see
> https://lore.kernel.org/git/xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com/.

Hmph, I actually am not convinced with that one, even though I know
I wrote it, I do not think I had thought things through before I
did.  It may make sense in a narrow special case where there is a
single entry at a higher stage to rename it to the destination path
and drop it down to stage #0, but I do not think of a good behaviour
for more general cases.

What should happen, for example, if two or more entries at higher
stages exist for the path being moved?  Renaming all of them to the
destination path without changing their stage number may make more
sense [*1*].  At least, that solution still lets the user to choose
object at which stage [*2*] to use in the final resolution.

Now, if we define that "git mv src dst", when 'src' is a conflicted
path, moves the working tree file src to dst at the same time moves
all the higher stage entries for 'src' to 'dst' while retaining
their stage number, what does the degenerate case of having only one
such entry look like?  You start from the state where you have
$that_path at stage #3, "git mv $that_path $over_there" would put
you in the state where you have the same contents at $over_there and
at stage #3.  If you want to just take "their" contents as the
resolution, "git add $over_there" after doing that "git mv" would
let you record the resolution, so it does not look too bad.

It would also be a handy way to recover from a mistake made by
"directory level rename" heuristics.  Instead of resolving the
content-level conflicts at the wrong path and then moving that
resolved result to the right path, you can first correct the wrong
path by moving the conflicted whole to the right path and then
perform the content-level conflict resolution.  The advantage of the
latter is obvious.  You have to do two things (rename and edit) and
with the former way of doing 'edit' first and then 'rename', after
resolving the conflict and adding the result at the wrong path, "git
ls-files -u" or "git status" no longer help you remember that the
path still needs to be moved.  Instead, you can move first and "git
ls-files -u" would still remember that even after the move you still
need to deal with content-level conflicts.

Anyway, I think the "separate missing entry and conflicted entry
when issuing an error message" is a strict improvement.


[Footnotes]

*1* Of course, the "D/F conflicts are issue only among the entries
    at the same stage" and other usual rules apply when we check if
    the move of these higher stage entries is possible.  I am not
    sure if the low-level API functions like rename_index_entry_at()
    are prepared to deal with higher stage entries, though, so this
    may be a nontrivial amount of new work.  It is unclear to me if
    it is worth doing.

*2* Actually, "the object at stage #1 for conflicted path P" is a
    wrong thing to say.  The index is designed to hold multiple
    stage #1 entries at the same path so that it can express the
    case where there are more than one common ancestors, and
    multiple stage #3 entries to express an octopus merge in
    progress.  The notation to name the object in the index punts
    and does not let you say "git diff :1.0:path :1.1:path" to
    compare the first and the second common ancestor versions of
    path, though it probably should if we wanted to be consistent.

