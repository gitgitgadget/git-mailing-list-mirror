Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C208C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2644221FC
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLGHfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:35:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLGHfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:35:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8195784EDA;
        Mon,  7 Dec 2020 02:34:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sp+28LrKZ488nOC31tM9jhtGPXc=; b=RXzvag
        WDfoQZyLOjy8ZLES/ztrfg55gxLzBuNT3aVQarMoYa11PEaA0EoD8Q4jpT3V/WAX
        h8YSSSGaExZ4ilkX/WHUYZArD6O7J/Rs47Dmz3/LmesNV3VeGKxI1xc1ycX57qd+
        YoetfgqvkpqydScW1JAvQucZcBdy7Sx0VbVs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jS7pev18ZllXEoMOCOYESvcLjJadKrxt
        5tKrK7Wfn9TJWWzDN10Lg80F/R6h35w/DF1DT+RjSNMyhgVsTHpQZQ7x+DalG6D2
        YNzyaXM3F/84ChrakzbmULvAglWs4eRR/5Fl6qitfcNFFfop5YFlGlOcBgVvzBRA
        ppiBUXxvUgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69C3284ED8;
        Mon,  7 Dec 2020 02:34:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D860384ED7;
        Mon,  7 Dec 2020 02:34:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] experiment: pull: change --ff-only and default mode
References: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
        <20201205040644.1259845-1-felipe.contreras@gmail.com>
        <CABPp-BE7B5hn3Fc4zD1o+qoqihJqCut=R1TP_fxMXW42+6iL+w@mail.gmail.com>
Date:   Sun, 06 Dec 2020 23:34:30 -0800
In-Reply-To: <CABPp-BE7B5hn3Fc4zD1o+qoqihJqCut=R1TP_fxMXW42+6iL+w@mail.gmail.com>
        (Elijah Newren's message of "Sat, 5 Dec 2020 09:29:01 -0800")
Message-ID: <xmqqa6uqcbnd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4DDEBFE-385E-11EB-B7C1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 4, 2020 at 8:06 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
> This commit message should say something more than just "change x", it
> should have some words about what it is change from or to.  I think
> the thrust of the patch is allowing --ff-only, --merge, and --rebase
> to countermand an earlier otherwise-conflicting option.  Perhaps a
> commit message of the form:
>
> In git, we sometimes allow conflicting command line options with the
> last one winning, e.g.
>   git log --patch --no-patch
>   git log --no-patch --patch
> other times we just error out when conflicting options are given, e.g.
>   git checkout -b --orphan NEWBRANCH
>   git checkout --orphan -b NEWBRANCH
> Previously, we did neither with --no-ff, --merge, and --rebase.
> Change these options to have a last-one-wins behavior.

If the choices are clearly among --ff-only, --merge and --rebase, I
am fine with the last-one-wins change, and your explanation does
make sense.

I however am not sure how --no-ff and other --ff=<how> friends
should interact with the primary two choices.  --ff=no is used by
those who want to merge, so "--merge --ff=no" combination is a
sensible thing to accept.  The same can be said for "--merge --ff"
(fast-forward when able).  It is interesting to realize that it
would not be wrong to say "--rebase --ff" even.  When their history
we are rebasing our own work on top is a descendant of our history,
such a rebase operation ends up in fast-forwarding to their tip.
