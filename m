Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB068C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 00:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A348F61361
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 00:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351114AbhJAAHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 20:07:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62133 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351589AbhJAAGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AA4615D8D9;
        Thu, 30 Sep 2021 20:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MpQnmKWdm9ADshAiGBODshEQU/T7nu0jOTSutw
        1PBEw=; b=P+0zeWRjhweCOLzKV3U62Ky63a8kAnCx2aTN10W6gZSKNgcTt3NKy9
        PM4mz033aGChEaB4n6lbp5mdqNDmqEBdD2DTxEx1RqgsaBydi7tS+IlDIqpBA1gK
        um6tWygnSawQh98xN1TrJpGyoibfLcRK3ynchn7S80G3kjGq27zDo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2258915D8D8;
        Thu, 30 Sep 2021 20:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7935415D8D5;
        Thu, 30 Sep 2021 20:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com
Subject: Re: [PATCH 2/7] sparse-index: update command for expand/collapse test
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <a1fa7c080aed2056afaad6415186c125c04a80cb.1633013461.git.gitgitgadget@gmail.com>
        <YVYNW13aVADaR+g6@nand.local>
        <6e9843d5-bc04-e69c-9e53-7bf18ca30fc8@github.com>
        <xmqqk0ixagw8.fsf@gitster.g>
        <e6049a17-c721-c596-51a6-101cb6065829@github.com>
Date:   Thu, 30 Sep 2021 17:04:58 -0700
In-Reply-To: <e6049a17-c721-c596-51a6-101cb6065829@github.com> (Victoria Dye's
        message of "Thu, 30 Sep 2021 18:59:57 -0400")
Message-ID: <xmqqr1d58v9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37C431CC-224B-11EC-A4A9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> Do we need to update this further when "mv a b"
>> learns to expand and then collapse?
>
> Unfortunately, yes. `git mv` was picked more-or-less at random from the set
> of commands that read the index and don't already have sparse index
> integrations (excluding those I know are planned for sparse index
> integration in the near future). If `git mv` were to be updated to disable
> `command_requires_full_index`, the command in the test would need to change
> again.
>
> For what it's worth, I do think the test itself is valuable, since it makes
> sure a command's capability to use the sparse index is always the result of
> an intentional update to (and review of) the code.

Oh, of course.  

I was actually wondering if it woudl be a good idea to leave a
command that will never be "converted" so that we can keep using it
for testing.

Perhaps a new option that is invented exactly for the purpose added
to a plumbing e.g. "git update-index --expand-collapse"?
