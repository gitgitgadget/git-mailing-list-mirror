Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhLQAp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:45:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55834 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLQAp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:45:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 062D0EFD36;
        Thu, 16 Dec 2021 19:45:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AEsE6zLRdMRob+tHWHHYA/V7etLbNBTF31SuXg
        sbsPw=; b=ygT6AuA0GXs3sZL5K7DE79DUPBT+kaVr8Yo5GzSKd95JuhfPp9f+jh
        2gs00SeVu9HiiMAi78kYZuRUtdmnGdYJDev6aYEek/ZCqG0SwCOUZzQVZKZQ5kft
        bGTufrdL5A2E3aOD54315q/k8dq3CqKQR4rHBItvOYYAwPbEb6RM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F04EEEFD35;
        Thu, 16 Dec 2021 19:45:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67705EFD34;
        Thu, 16 Dec 2021 19:45:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 0/5] implement branch --recurse-submodules
References: <20211216003213.99135-1-chooglen@google.com>
        <20211216233324.65126-1-chooglen@google.com>
        <xmqq35ms6pd3.fsf@gitster.g>
Date:   Thu, 16 Dec 2021 16:45:26 -0800
In-Reply-To: <xmqq35ms6pd3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Dec 2021 16:34:32 -0800")
Message-ID: <xmqqwnk45aah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0BB08C2-5ED2-11EC-AD91-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> This series implements branch --recurse-submodules as laid out in the
>> Submodule branching RFC (linked above). If there are concerns about the
>> UX/behavior, I would appreciate feedback on the RFC thread as well :)
>>
>> This series is based off js/branch-track-inherit.
>
> Sigh.
>
> When a series is labelled as "based off of X", I expect that the
> series either apply on the tip of branch X I have, or it applies on
> top of the merge result of branch X into 'master'.  It shouldn't be
> forked at a random point on the 'seen' or 'next' branch, as you'd
> end up depending on not just X but all the other topics that are
> merged before X is merged to these integration branches.
>
> This seems not apply on either c99fa303 (config: require lowercase
> for branch.autosetupmerge, 2021-12-14), which is the tip of the
> js/branch-track-inherit topic, or 47e85bee (Merge branch
> 'js/branch-track-inherit' into gc/branch-recurse-submodules,
> 2021-12-15), which is a merge of that topic into 'master' I prepared
> to queue the previous round of this topic the other day.

Ah, I figured it out.

These are based on the merge of the other branch into 'seen'.  I
have (deliberately) merged js/branch-track-inherit and the previous
round of this tipc in 'seen' next to each other.

And when these five are applied on top of that merge of the other
topic into 'seen', we get an identical tree as the merge of the
previous round of this topic into 'seen'.

So unless you updated some commit log message, nothing is lost if I
ignore this round.  Just to save time for both of us the next time,
plesae fetch from any of the public tree, find on the first parent
chain leading to 'origin/seen' a commit labelled as "Merge branch
'gc/branch-recurse-submodules'", and check out its second parent,
and what we have there.

    $ git checkout "origin/seen^{/^Merge branch .gc/branch-rec}^2"
    $ git log --first-parent --oneline origin/main..
    35bb9f67f9 branch: add --recurse-submodules option for branch creation
    ce3a710d42 builtin/branch: clean up action-picking logic in cmd_branch()
    f368230ca9 branch: add a dry_run parameter to create_branch()
    d77f8a125b branch: make create_branch() always create a branch
    f8a88a03b9 branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
    47e85beee9 Merge branch 'js/branch-track-inherit' into gc/branch-recurse-submodules

If you "rebase -i 47e85beee9" (the exact object name might differ,
as that commit needs to be recreated when 'js/branch-track-inherit'
is updated) these five commits, and format-patch everything on the
topic with --base=47e85beee9, it is guaranteed that I'll be able to
cleanly apply what you meant to send out on top of 47e85beee9.

Thanks.






