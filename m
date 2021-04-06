Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60946C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E406139B
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhDFV54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:57:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65277 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhDFV5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 17:57:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21189BA4C5;
        Tue,  6 Apr 2021 17:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mwjp7ZzXRUy5Vng10PmqsHTnMqg=; b=cxI0za
        VGzC+fXQv34lqsx/W4QpEV+DjyyDK7K/8s3/kaZjZFVH/CTLiVyaFBkQZ3gAIMy5
        mYVQHMeSlFzt6tXkiLqQp0k2MXVYoXfYt59gBIShF3I9M8Q9BDqRaZYN3GMYRwmw
        9aaPYQ53mYj+XN2J/3W+FAFurVlW4rZOoWLwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bTTg+YNiUSrpJrjh4JfsyyUc1by9mhsi
        9/0l/TFH6yuU4N3L8d0JVMjbcXOv/f0fsYgU2NwuAfo1/M1I5YpswSdgk2odx2NW
        JuyTpVG2diMYnbkwqYTJilUQyJeNtoSbqjqclTx36WkG4sEqzQ8HfTzWm+5TlBnv
        3d8XS4aKBic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17CE2BA4C4;
        Tue,  6 Apr 2021 17:57:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D8F2BA4C3;
        Tue,  6 Apr 2021 17:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Nikita Bobko <nikitabobko@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [Bug report] diff.noprefix config is ignored for interactive `add`
References: <CAMJzOtyzu8y5mWdKXe3MPe8ZoJs8O=me8Xuu0t77YVdAMc7Tgg@mail.gmail.com>
        <YGzUerPL7V8jDxHo@coredump.intra.peff.net>
Date:   Tue, 06 Apr 2021 14:57:46 -0700
In-Reply-To: <YGzUerPL7V8jDxHo@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 6 Apr 2021 17:36:58 -0400")
Message-ID: <xmqqsg4313fp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1D9676-9723-11EB-A9C8-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I imagine something like this:
> ...
> would work, but I didn't really test it. There's another hitch, which is
> that this subsystem has all been re-written in C. So we'd really want to
> implement it in the new code (possibly in both places, though maybe it
> is time to consider cutting over from the perl script to the C one by
> deafult?).
>
> But hopefully this illustrates the general idea, and gives somebody
> interested in the feature enough to work up their own patch.

These "cosmetic appearance" configuration that would affect the
output from diff shown to the user would not be limited to just the
.noprefix, though.  Depending on the users, they would care just as
deeply about any of these:

	.context
	.interHunkContext
	.mnemonicPrefix
        .noprefix
	.relative
	.orderFile

as Nikita does for .noprefix to send a bug report.

Luckily or unluckily, .suppressBlankEmpty and the per-filetype
.xfuncname patterns do impact the output from the plumbing, because
git_diff_basic_config() does read them, even though they are merely
"cosmetic" configurations.

I am unsure how much we should cater to end-user controlled
configuration when we are generating diff output for our own
consumption, but if we were to tweak "add -p" and friends to
pay attention to .noprefix, we probably should do the same for
all the others.

Thanks.


