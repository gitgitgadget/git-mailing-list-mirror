Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42988C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A464E7C
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhBJQnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:43:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhBJQmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:42:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56E78A0BDF;
        Wed, 10 Feb 2021 11:41:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vkyYYDgx6w4qpqHr8er6sOdCDos=; b=RkmViz
        BmrkHBkFp/psHtAZ99+Od9ahJsASC+MPoEs6MZ9+9F7Wx1UpKbH+DzmjtGpR782b
        7P2s8pTfQ5kvzumIqR4TadHdfvP14aUQRS5LlXIRpN7QH3A3JFFfLaqVVVqU+6jC
        EEs3WuxUmBuyuXcktOp0YnHg2WoBuv6CS9yvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZWvEne4YSIjfBEtBFAGgKWEw7RVtaIk
        Blsj+0t3OlH0ZEnLfynzCzHgpwMNR+RfFTeozVJAJTGBj5wesJxeRylmuHtU0vq4
        1vFmvwi4p5bEcY6mv+/6T+V4ZOQuoU32P389ALD7r3uSt2P5M4DxFByHq6SoRj+J
        XoOa7Q6Bhoc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E965A0BDE;
        Wed, 10 Feb 2021 11:41:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7B3EA0BDB;
        Wed, 10 Feb 2021 11:41:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 5/5] gitdiffcore doc: mention new preliminary step
 for rename detection
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
        <fc72d24a3358b1c5cc2753b5f07ac60174e6452b.1612970140.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 08:41:18 -0800
In-Reply-To: <fc72d24a3358b1c5cc2753b5f07ac60174e6452b.1612970140.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 10 Feb 2021
        15:15:40 +0000")
Message-ID: <xmqqtuqj3mfl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCC5C25C-6BBE-11EB-9FE1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> The last few patches have introduced a new preliminary step when rename
> detection is on but both break detection and copy detection are off.
> Document this new step.  While we're at it, add a testcase that checks
> the new behavior as well.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/gitdiffcore.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index c970d9fe438a..36ebe364d874 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -168,6 +168,23 @@ a similarity score different from the default of 50% by giving a
>  number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
>  8/10 = 80%).
>  
> +Note that when rename detection is on but both copy and break
> +detection are off, rename detection adds a preliminary step that first
> +checks if files are moved across directories while keeping their
> +filename the same.  If there is a file added to a directory whose
> +contents is sufficiently similar to a file with the same name that got
> +deleted from a different directory, it will mark them as renames and
> +exclude them from the later quadratic step (the one that pairwise
> +compares all unmatched files to find the "best" matches, determined by
> +the highest content similarity).  So, for example, if
> +docs/extensions.txt and docs/config/extensions.txt have similar
> +content, then they will be marked as a rename even if it turns out
> +that docs/extensions.txt was more similar to src/extension-checks.c.

I'd rather use docs/extensions.md instead of src/extension-checks.c;
it would be more realistic for .md to be similar to .txt than .c.

With a raised bar for this step, the equation changes a bit, no?  

    So, for example, if a deleted docs/ext.txt and an added
    docs/config/ext.txt are similar enough, they will be marked as a
    rename and prevent an added docs/ext.md that may be even similar
    to the deleted docs/ext.txt from being considered as the rename
    destination in the later step.  For this reason, the preliminary
    "match same filename" step uses a bit higher threshold to mark a
    file pair as a rename and stop considering other candidates for
    better matches.

or something?

> +At most, one comparison is done per file in this preliminary pass; so
> +if there are several extensions.txt files throughout the directory
> +hierarchy that were added and deleted, this preliminary step will be
> +skipped for those files.

Other than that, the whole series looked sensible to my cursory
read.

Thanks.

