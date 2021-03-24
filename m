Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A256C433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994E619ED
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhCXB1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:27:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhCXB1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:27:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AFFFBD6C1;
        Tue, 23 Mar 2021 21:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wun+fhhfIn7qwQtmoZtMxYAWqJo=; b=FGloBj
        mPA/VkXqIMTmC/Q4AhNty7XVEUwsJVcN1LUTCQzWC16fReD2HjLgpAp6E02nTg25
        x34ast23LAmuy3Jc6Hab0PAe49qnQ2HQ+bQq0kiFz17wJ5en9oY/eZkGP40f/Vqa
        y6WHClBwrRy9r1ZGtfhfdJjszvpmGORWtjFkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ci/TjYmi8dNIuJmbDVj0jHpfhGIOWYKE
        VxG6iofuvNx07hFItxgzjRtLVrPuLyLDRYrQ8mWXBRfLZflZiQRo1U2IrVsl/sxx
        Q7xMGLx8ZOxtshAEKnFTjjWD98SKAn3UaPzc76MV5ENHo/o3pTtzTJXXRH1Fh3Pj
        pI0UQzawR8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 917FCBD6C0;
        Tue, 23 Mar 2021 21:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFE98BD6BD;
        Tue, 23 Mar 2021 21:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Renato Botelho <garga@freebsd.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: --no-edit not respected after conflict
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
        <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net>
        <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
        <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
        <CABPp-BEGEcws69sg6Z2=B1nihFG227mAsSx=boU3uSx2xDUEjg@mail.gmail.com>
Date:   Tue, 23 Mar 2021 18:27:19 -0700
In-Reply-To: <CABPp-BEGEcws69sg6Z2=B1nihFG227mAsSx=boU3uSx2xDUEjg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Mar 2021 17:59:46 -0700")
Message-ID: <xmqqzgytz6h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13974B50-8C40-11EB-8B5E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> === Current behavior ===
>                    Non-conflict commits    Right after Conflict
> revert             Edit iff isatty(0)      Edit (ignore isatty(0))
> cherry-pick        No edit                 See above
> Specify --edit     Edit (ignore isatty(0)) See above
> Specify --no-edit  (*)                     See above
>
> (*) Before stopping for conflicts, No edit is the behavior.  After
>     stopping for conflicts, the --no-edit flag is not saved so see the
>     first two rows.
>
> === Expected behavior ===
>
>                    Non-conflict commits    Right after Conflict
> revert             Edit iff isatty(0)      Edit (regardless of isatty(0)?)
> cherry-pick        No edit                 Edit (regardless of isatty(0)?)
> Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
> Specify --no-edit  No edit                 No edit
>
> The thing I'm unsure on is the !isatty(0) handling for revert &
> cherry-pick right after a conflict when neither --edit nor --no-edit
> are specified.

I read the intention behind existing "edit if isatty" as "this is an
operation the human reader deserves a chance to explain what was
done and why by default".  For example, I read the first entry in
your table as: Even if there is no conflict, there should be a
convincing explanation when you revert.  On the other hand, if you
are cherry-picking without any conflict, the intention should be
clear enough in the original commit log message, which ought to be
written why applying that change is a good idea, so it would make
sense not to invoke editor in that case.

If an operation deserves a chance to be explained even in a cleanly
auto resolved case, it does deserve the chance even more if hand
resolution was required---in addition to the original "what and
why", the resolution of the conflict is an additional reason why the
human should be given a chance to explain.

But if it is an automated process, there is no reason to fail the
operation merely because the process is run unattended.  So my
recommendation for "regardless of isatty" part is "do not force
editing".  The same is true for a human user who declines the chance
to explain him/herself with an explicit "--no-edit".
