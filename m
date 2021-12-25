Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E8CC433EF
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhLYWUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 17:20:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62694 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhLYWUX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 17:20:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED1FE805E;
        Sat, 25 Dec 2021 17:20:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WH3H6wKCwKcOnqd3tgEOLfLpVtnLRgi+eM1q8x
        iB2UE=; b=Nn0BQ2QpfL2s3lYtBnbnk7i2+XP0lLuTf+bYu6+uSTZ6FPXEUTxw8E
        5Pgj95fV4U0PLxlWJD0WluSXZCeFzo6x54tiAA8zaOVMvxH7855YMU6DjD+ohTKf
        M0m/NJ57011pX3PvAL4PlCB4cPO4vvNRbDPgAwBlbMNmK6wszhB7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96386E805D;
        Sat, 25 Dec 2021 17:20:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10A4FE805C;
        Sat, 25 Dec 2021 17:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: ds/sparse-checkout-requires-per-worktree-config
References: <xmqqsfui6g7q.fsf@gitster.g> <xmqqsfuh5tz4.fsf@gitster.g>
        <CABPp-BFiMy55mCMJSHk9PmKa8EUd-6mR5z5xM7J3P2dZBjRq5g@mail.gmail.com>
Date:   Sat, 25 Dec 2021 14:20:20 -0800
In-Reply-To: <CABPp-BFiMy55mCMJSHk9PmKa8EUd-6mR5z5xM7J3P2dZBjRq5g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 24 Dec 2021 18:49:59 -0800")
Message-ID: <xmqq5yrc5ntn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9A7046A-65D0-11EC-9FD4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 24, 2021 at 6:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>> >  - sparse-checkout: use repo_config_set_worktree_gently()
>> >  - config: add repo_config_set_worktree_gently()
>> >  - worktree: add upgrade_to_worktree_config()
>> >  - config: make some helpers repo-aware
>> >  - setup: use a repository when upgrading format
>> >
>> >  "git sparse-checkout" wants to work with per-worktree configration,
>> >  but did not work well in a worktree attached to a bare repository.
>> >
>> >  Expecting a redesign?
>> >  cf. <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
>> >  source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
>>
>> FWIW, this topic by itself passes its self test, but when queued
>> near the tip of 'seen', it seems to break t1091.
>>
>> For an example run that fails on win+VS test (8), see
>> https://github.com/git/git/runs/4629824103
>
> Unrelated to your comment, other than being about this same series:
>
> I think "redesign" is too strong a word here.  I think the patches are
> a useful start...and might even represent the majority of the code
> needed; it's just that they are focusing too narrowly.  core.worktree
> should also be handled, and I think we should include fixes at the
> `git worktree add` level, not just `git sparse-checkout {init,set}`.

Yup, the last one part is what I meant by "redesign".
