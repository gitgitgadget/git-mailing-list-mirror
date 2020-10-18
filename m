Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C55C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83BA21D47
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o/2R/RtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJRFCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 01:02:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57219 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgJRFCI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 01:02:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C67348DCC8;
        Sun, 18 Oct 2020 01:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0+5fPPtGZqR7TLvpC/aB9KdBnq4=; b=o/2R/R
        tYvyYOPbHT9ditkSBSDl5x0Etohfz9FKKxy2NvMK7gsZq8nsdr+3O8mk5LBwjwy6
        GfePDsfjExip2b7NFuwf1wt8q2gvFvkz+Bqv7YnkYpEWnz9xaPjZ4sTuipq2GeHW
        UGsROMVKRmJmGxmRV5EQHJN3xk+UcQ/bcbmXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpNdEhfKDRHZ+qnrxTAQImmDPZ0u4v1w
        0Y3lUhE0f9Bajn8bRMmqYxKHqum/dWsRurmZPgZjaikQDQ9j8RzWrY32u7v4uYJE
        vKDPzsPmRAGnZMZXhVRVZcHEeDIr34czu3HzfUpRymQOmsw1HPJYSoOnDEmzuKz8
        mROqVEU9Xc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8F0C8DCC7;
        Sun, 18 Oct 2020 01:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CD858DCC5;
        Sun, 18 Oct 2020 01:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
        <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
        <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
        <20201018041642.GB2262492@nand.local>
Date:   Sat, 17 Oct 2020 22:02:04 -0700
In-Reply-To: <20201018041642.GB2262492@nand.local> (Taylor Blau's message of
        "Sun, 18 Oct 2020 00:17:47 -0400")
Message-ID: <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10F45C56-10FF-11EB-94A7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hmm. I do agree that I'd like to stay out of the business of trying to
> figure out exactly what that trade-off is (although I'm sure that it
> exists), only because it seems likely to vary to a large extent from
> repository to repository. (That is, 20% may be a good number for some
> repository, but a terrible choice for another).

I think both of you misunderstood me.  

My question was a simple yes/no "does there a trade off exist?"
question and the sentences with 20% in it were mere example of
possible trade-off I had in mind that _could_ exist.  I wasn't even
suggesting to figure out what the optimum cut-off heuristics would
be (e.g. solving "when more than N% paths are subject to diff
fsmonitor is faster" for N).

I was hoping that we can show that even having to lstat just a
single path is expensive enough---IOW, "there is no trade-off worth
worrying about, because talking to fsmonitor is so cheap compared to
the cost of even a single lstst" would have been a valid and happy
answer.  With such a number, there is no risk of introducing an
unwarranted performance regression to use cases that we did not
anticipate by adding an unconditional call to refresh_fsmonitor().

But without any rationale, the performance implication of adding an
unconditional call to refresh_fsmonitor() would become much muddier.

> But, I think that we can invoke watchman better here; the
> fsmonitor-watchman hook has no notion of a "pathspec", so every query
> just asks for everything that isn't in '$GIT_DIR'. Is there anything
> preventing us from taking an optional pathspec and building up a more
> targeted query?

Yup, it is what I had in mind when I brought up the pathspec.  It
may be something worth pursuing longer term, but not within the
scope of this patch.

> There is some overhead to invoke the hook and talk to watchman, but
> I'd expect that to be dwarfed by not having to issue O(# files)
> syscalls.

"invoke the hook"---is that a pipe+fork+exec, or something else that
is far lighter-weight?

n
