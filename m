Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02AC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 22:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiDYWY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343579AbiDYVjA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 17:39:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAA3AA7A
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 14:35:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CCE711D70A;
        Mon, 25 Apr 2022 17:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8w8PI68iMnrBKfWmYFfXsQK10C4Xxg1FCKdbSW
        rlaIs=; b=xW7UHLjBFhK9dH7VOgWotM7D5g0vigoNDtPy4JZq+kSLo+1OT5cElf
        TZMjX9JJsRL7JM7asjKzTUfC6v3YSFKrVk8tcEgq4HPAq/VofD8VvrHy9mt8nYCT
        Hj1XIOvYjhwU7m6esDY0IqSJ9CzsWB/jFbcf95yfFXZDjEFjDDc/Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5486511D709;
        Mon, 25 Apr 2022 17:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B48FB11D708;
        Mon, 25 Apr 2022 17:35:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 4/7] read-cache: set sparsity when index is new
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <64edbed0f95623e307371cfc3905786e5b0a02f3.1650908958.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 14:35:52 -0700
In-Reply-To: <64edbed0f95623e307371cfc3905786e5b0a02f3.1650908958.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 25 Apr 2022 17:49:14
        +0000")
Message-ID: <xmqq1qxkvoav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF30D6F2-C4DF-11EC-B238-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> When the index read in 'do_read_index()' does not exist on-disk, mark the
> index "sparse" if the executing command does not require a full index and
> sparse index is otherwise enabled.
>
> Some commands (such as 'git stash -u') implicitly create a new index (when
> the 'GIT_INDEX_FILE' variable points to a non-existent file) and perform
> some operation on it. However, when this index is created, it isn't created
> with the same sparsity settings as the repo index. As a result, while these
> indexes may be sparse during the operation, they are always expanded before
> being written to disk. We can avoid that expansion by defaulting the index
> to "sparse", in which case it will only be expanded if the full index is
> needed.

Makes sense.
