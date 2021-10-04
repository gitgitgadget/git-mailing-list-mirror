Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4DC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A1261108
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhJDQOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:14:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60821 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhJDQOy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:14:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A24AC106C04;
        Mon,  4 Oct 2021 12:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9krnih1qj3bA1JS6yo1a/fpIf9uIidjIJlZQom
        x/Wrc=; b=Llw8I1sPXuFDEMh6TlhctDsIHcmKqGKDOaSo9ZWEfdNW014+h0OZKk
        DriM9ajDLkV25+fKjBqS6jmDZ/ZgNUgwZlHx17R6yjyLc8S19li4258W8ns//wOd
        o1uiSfN4au1QxnmLyfbpNp+qOC2vs94yt7etHEqFkb1wSvIcUnFEs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572D9106C03;
        Mon,  4 Oct 2021 12:13:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06CC8106C02;
        Mon,  4 Oct 2021 12:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/11] reset_head(): fix checkout
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
        <xmqqee947aqn.fsf@gitster.g>
        <648396f6-56ce-b727-4567-2b6eba2f4f46@gmail.com>
Date:   Mon, 04 Oct 2021 09:13:01 -0700
In-Reply-To: <648396f6-56ce-b727-4567-2b6eba2f4f46@gmail.com> (Phillip Wood's
        message of "Mon, 4 Oct 2021 10:58:59 +0100")
Message-ID: <xmqqfstgydiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F37DA828-252D-11EC-A5BA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Sorry, but it is not quite clear what exactly is "fix checkout" in
>> the context of this change, even with the above paragraph that
>> describes the internals but not any end-user visible effect.
>
> "git checkout" refuses to overwrite untracked files but reset_head()
> does when checking out a branch.

By the name of the function, I would have expected that would be the
intended behaviour, though.  Isn't it emulating "reset --hard" that
was used when the calling commands were implemented as scripts?

What I am wondering is if the overwriting behaviour is annoying for
some callers but is essential for other callers, and unless we tell
readers that we vetted all the callers and everybody wants to keep
the paths overwritten from the tree-ish in the working tree that are
not in the index, I feel uneasy to add a label "fix" to such a change
to a callee used from multiple code paths.

> files. However such a test would pass on top of 
> en/remaving-untracked-fixes without the fix in this patch. I cannot
> think of a way to specifically test that unpack_tree_opts.reset == 0 
> unless RESET_HEAD_HARD is given after en/removing-untracked-fixes is
> merged.

Meaning that this fix is redundant, as the other topic has already
been cooking and well in the process of graduating?

Thanks.
