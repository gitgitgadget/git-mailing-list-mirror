Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B1AC433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 20:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhLOUnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 15:43:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59732 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhLOUnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DD2516F891;
        Wed, 15 Dec 2021 15:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MUkqrtrfFbOkED6WfB1ZWHfdt87R6rMrEokeXw
        egyHk=; b=aSfUU24NuBr2r/sbBpqbqhOvETN92pOe6jBnE2s+Zydt/t17/u9LCD
        yWypOdOJ+X+iOUjezjMjaid77MbyZ8jWNu9oSJ8/eFGPixuzkBLK/eG6CgOHzVC4
        e7fg8+vF5WmKh2kXFUJ5tOcM9ihH5IBBOLjkdeEwZ+6nBlBLqrSpg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5642B16F890;
        Wed, 15 Dec 2021 15:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9265116F88A;
        Wed, 15 Dec 2021 15:43:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] sparse-checkout: fix segfault on malformed patterns
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 12:43:07 -0800
In-Reply-To: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 15 Dec 2021 13:46:05
        +0000")
Message-ID: <xmqq5yrp61lw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C807486-5DE7-11EC-98FA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes some issues with parsing sparse-checkout patterns when
> core.sparseCheckoutCone is enabled but the sparse-checkout file itself
> contains patterns that don't match the cone mode format.
>
> The first patch fixes a segfault first reported in [1]. The other two
> patches are from an earlier submission [2] that never got picked up and I
> lost track of. There was another patch involving 'git sparse-checkout init
> --cone' that isn't necessary, especially with Elijah doing some work in that
> space right now.

Thanks.  The segfault fix matters even more with Elijah's "we can
flip between modes" feature, right?


> [1] https://github.com/git-for-windows/git/issues/3498 [2]
> https://lore.kernel.org/git/pull.1043.git.1632160658.gitgitgadget@gmail.com
>
> Thanks, -Stolee
>
>
> Updates in v2 and v3
> ====================
>
>  * I intended to fix a typo in a patch, but accidentally sent the amend!
>    commit in v2
>  * v3 has the typo fix properly squashed in.
>  * Added Elijah's review.
>
> Derrick Stolee (3):
>   sparse-checkout: fix segfault on malformed patterns
>   sparse-checkout: fix OOM error with mixed patterns
>   sparse-checkout: refuse to add to bad patterns
>
>  builtin/sparse-checkout.c          |  5 ++++-
>  dir.c                              |  5 +----
>  t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
>
> base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1069
>
> Range-diff vs v2:
>
>  1:  a0e3dd335c9 ! 1:  1744a26845f sparse-checkout: fix segfault on malformed patterns
>      @@ Commit message
>           there is additional logic that attempts to remove the line from the hashset
>           and free the data. This leads to a segfault in the 'git sparse-checkout
>           list' command because it iterates over the contents of the hashset, which is
>      -    no invalid.
>      +    now invalid.
>       
>           The fix here is to stop trying to remove from the hashset. Better to leave
>           bad data in the sparse-checkout matching logic (with a warning) than to
>  2:  86fbf130c03 = 2:  a2fe867222e sparse-checkout: fix OOM error with mixed patterns
>  3:  5d096e380a4 = 3:  a0e5a942ae0 sparse-checkout: refuse to add to bad patterns
>  4:  7bacb3760f3 < -:  ----------- amend! sparse-checkout: fix segfault on malformed patterns
