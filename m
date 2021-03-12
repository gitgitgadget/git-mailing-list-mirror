Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6DDC433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFA064F33
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhCLWJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:09:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53493 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhCLWJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:09:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7092FAF3B0;
        Fri, 12 Mar 2021 17:09:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=k1AaNV+2FpLAZJ/8f865fosgn5s=; b=j2+det
        pJMjgY3MazpESkn7HeXrVy/v40og5yzy2LbWLy0MkwVjBFbXp+ernUVAenN6HaF+
        aW4Ue0Lvu0AWfdqDrJRMkgSCVePiJZTm+NJ+jZtDLctuBxTmcm8UR95TNviuc77A
        GBq9uuKvfLg0H4ckSlzVCIJjdDqwG8vU4OaYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iUs/xXwlPiRWt4ttFqGoI5NvaE9cTe0w
        6QnBiNHMx+1sRTDujWLqxLLjKRbN457zSwk7sh13fxq+JdoK/+URSeaoy8OViJm1
        U5MbBUjmOoci96CL3VOnjL2CKdu0VCH1vLp6ZAAhDVZyu8yyOpha11vkZXzPdYtv
        I4CoQoGHPxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 681EBAF3AF;
        Fri, 12 Mar 2021 17:09:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9CF8AF3AE;
        Fri, 12 Mar 2021 17:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC][RFC] format-patch: pass --right-only to range-diff
In-Reply-To: <xmqq1rck6nr8.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 Mar 2021 13:55:07 -0800")
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
        <YEaGbn5rU3pU7/q5@nand.local> <xmqq1rck6nr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Fri, 12 Mar 2021 14:09:33 -0800
Message-ID: <xmqqv99w58iq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0581250-837F-11EB-837C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <ttaylorr@github.com> writes:
>
>> Note that I think (and Johannes--cc'd--could confirm) that what you want
>> is '--left-only' to discard rebased changes from the upstream branch:
>
> Does that mean range-diff got --left-only and --right-only
> backwards?  IOW, doesn't
>
> $ git log --left-only A...B
>
> show what is shown in "git log B..A", and if so, shouldn't
>
> $ git range-diff --left-only A...B
>
> which is a synonym for
>
> $ git range-diff B..A A..B
>
> also give commits in the B..A range?
>
> Puzzled....

Ah, it was only that "range-diff --help" uses confusing
double-negative phrasing.  I.e.

    --left-only::
            Suppress commits that are missing from the first specified range
            (or the "left range" when using the `<rev1>...<rev2>` format).

If you "suppress those that are missing from X", you are effectively
including only those that appear in X, so two conclusions I draw are

 - "range-diff" does not get "--left/right-only" backwards;

 - its documentation should be improved.

Perhaps

    --left-only::
	Include only commits that are in the first range (or the
	"left range" when using the `<rev1>...<rev2>` format).

wouldn't have made me puzzled.

Thanks.
