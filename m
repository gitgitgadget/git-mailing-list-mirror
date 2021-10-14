Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEDFC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7EA60551
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhJNQpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:45:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64979 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhJNQpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 12:45:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 785F1F70C4;
        Thu, 14 Oct 2021 12:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=O61etgO0HlvcFu61zPEvRUdgsfUtW9aJI1hF2P
        eauVY=; b=O7PM4JYePYvYuXq0uGLLDEh2PQltvTOn5T2QGB0q+rfiZiMMP2GrEo
        5/T2vFuKqNQBt33tyAfZ77dgIQXwZWAYiqflIzsdsLWdiDfr3k4l9oBCoRvdVC1T
        7TNApPyH9MxzoMmRNnmryAnHqKEzVNkBVzngFgh0XYXXoydlJLQR8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4EBF70C3;
        Thu, 14 Oct 2021 12:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5AA0F70C2;
        Thu, 14 Oct 2021 12:42:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
In-Reply-To: <6dd3ba9f-7054-93f3-7798-d4a4a211899a@gmail.com> (Phillip Wood's
        message of "Thu, 14 Oct 2021 14:34:28 +0100")
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
        <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
        <xmqqee8wpm0u.fsf@gitster.g>
        <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
        <xmqqwnmnjnn5.fsf@gitster.g>
        <6dd3ba9f-7054-93f3-7798-d4a4a211899a@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 14 Oct 2021 09:42:54 -0700
Message-ID: <xmqqmtnbd0c1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C833CE1C-2D0D-11EC-9A1A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm not sure about that. There are really three levels of output from
> rebase - quiet, normal and verbose. I think passing "-q" suppresses 
> virtually all the output - there is no indication of which commits
> have been picked. As test appears to be comparing the output of the
> command for the sparse and non-spare case as a proxy for "it behaves
> the same for sparse and non-sparse checkouts/indexes" passing "-q" to
> rebase weakens the test considerably.

True.  Also because the behaviour of "rebase" using different
backends are sufficiently different, I no longer consider it a funny
inconsistency that one backend has to to use "-q" while the other
doesn't.

> Stolee indicated [1] that he is
> happy for us to drop the "-q" for the "--apply" case so I'd be
> inclined to go back to your corrected version of V2.

OK.  Can we have a v4 that is identical to "corrected" v2, then,
please?  That's easier than having to dig v2 up and remember and
apply the "correction" ;-).

Thanks.
