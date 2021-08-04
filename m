Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B6C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126F660F94
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhHDAHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:07:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63349 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhHDAHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:07:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59075D79C1;
        Tue,  3 Aug 2021 20:06:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pujAOHzuyJo9Q8RkiSL/gMxOrNjIGJlPltXbHn
        ycqyM=; b=EiS5OdhCEAUz/Q6wwqN5MDRwXubnDYZGb2SeAxXFCMpDYsHprkmHtQ
        aas/0n7dAyoS73TpvykD6ofBObD3AslhjeLHsJERWuKZY0rtbKPv9LYq4g28frC4
        DjcRVblLCL5CZwgSEYwnRRR0cysrvF2XjEi1o0Q9z/UQeTI+Sgpew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50D9AD79C0;
        Tue,  3 Aug 2021 20:06:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8D6AD79BF;
        Tue,  3 Aug 2021 20:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/10] directory-rename-detection.txt: small updates due
 to merge-ort optimizations
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <6b89ab8d9b1c03ce97fab73f7a2b4261fd90c0c4.1628004920.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 17:06:52 -0700
In-Reply-To: <6b89ab8d9b1c03ce97fab73f7a2b4261fd90c0c4.1628004920.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 03 Aug 2021
        15:35:12 +0000")
Message-ID: <xmqqv94mrs2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF5B0602-F4B7-11EB-BB56-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
> index 49b83ef3cc4..029ee2cedc5 100644
> --- a/Documentation/technical/directory-rename-detection.txt
> +++ b/Documentation/technical/directory-rename-detection.txt
> @@ -2,9 +2,9 @@ Directory rename detection
>  ==========================
>  
>  Rename detection logic in diffcore-rename that checks for renames of
> -individual files is aggregated and analyzed in merge-recursive for cases
> -where combinations of renames indicate that a full directory has been
> -renamed.
> +individual files is also aggregated there and then analyzed in either
> +merge-ort or merge-recursive for cases where combinations of renames
> +indicate that a full directory has been renamed.
>  
>  Scope of abilities
>  ------------------
> @@ -88,9 +88,11 @@ directory rename detection support in:
>      Folks have requested in the past that `git diff` detect directory
>      renames and somehow simplify its output.  It is not clear whether this
>      would be desirable or how the output should be simplified, so this was
> -    simply not implemented.  Further, to implement this, directory rename
> -    detection logic would need to move from merge-recursive to
> -    diffcore-rename.
> +    simply not implemented.  Also, while diffcore-rename has most of the
> +    logic for detecting directory renames, some of the logic is still found
> +    within merge-ort and merge-recursive.  Fully supporting directory
> +    rename detection in diffs would require copying or moving the remaining
> +    bits of logic to the diff machinery.
>  
>    * am

Looks good.
