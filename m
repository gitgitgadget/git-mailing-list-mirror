Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78EAC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9842619AD
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhF2Wl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:41:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhF2Wlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 18:41:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6760DC269;
        Tue, 29 Jun 2021 18:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=h4MB56lZjUDKr3c1WSt70Ra97
        eOh2/d/2NG4GeJ+u38=; b=k6gYbS2v71VhpExOgUoJQmFMHSa95jioIYlOa5mpT
        g9P0i8VLN5BOksz4ljgqtJLeesL+EORNQNLI3HTryQdEquR6XWxElGhewE1gei7T
        miDIaQTgPaEope8l8OLKRFEL5u6+4E4xo8TrOaJtBQwAde5ZrI2PhNzFpTX8IEhW
        K4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAF21DC268;
        Tue, 29 Jun 2021 18:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AEC3DC266;
        Tue, 29 Jun 2021 18:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
Date:   Tue, 29 Jun 2021 15:39:21 -0700
Message-ID: <xmqqpmw4uwh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D96255D2-D92A-11EB-8998-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> My text may indeed have lacked clarity. I was trying to emphasize to
> hard, that this
> command's "force" enables 2 actions that may both not be
> wanted. Usually if one applies
> "force" to a command only one such action is expected, or at least I
> would only expect the one.

Oh, I do agree wholeheartedly if two things are forced at the same
time, things can become confusing.

But the thing is, there are no such "two things are forced at once"
in this case.  That is why I emphasized, in my response to you, that
"switch -C <newbranch>" does not touch working tree, so "ok, the
switch stops because it requires some working tree files with
changes clobbered, and I can force it to make it happen" is not
involved.  If it were, then it becomes fuzzy if --force is allowing
an existing branch getting overwritten, or allowing a modification
in a working tree file getting discarded, or both.

The one and only thing that is forced is to repoint the tip of an
existing branch.

> The actions being, giving up the link to the commit that is the tip of
> the branch; and
> making commits unreachable.=C2=A0 (for an expert in git tightly linked
> together, but not for everyone)

Sorry, I do not quite see how the removing the reference to a commit
(i.e. the commit C that used to be pointed at by the branch would no
longer be pointed at by that branch---that is by definition what
moving the branch to point at a different commit means) and the
commit becoming not reachable from the reference (i.e. such a commit
C may not be reachable from the branch---unless the new commit it
points at happens to be a descendant of C) are not one and the same
thing.  I do not think there is distinction between expert vs
everyone else involved here at all.

Can you give an example where one of the two holds while the other
one does not?

Thanks.
