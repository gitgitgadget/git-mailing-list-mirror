Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E4C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A404C60F8F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhHDA2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:28:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51732 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhHDA23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:28:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF538148D98;
        Tue,  3 Aug 2021 20:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QqRzjMn1lwgk/RpNdSk7prmnDfyr5J3Yu0oL0Q
        tKr9A=; b=WLciHRNgkM52/02bXtrtH2MdRBqS0SO8cWw5NMYRWTfU1Ke/zB2BSU
        f4skBj0P6cM5SLMv7iHgKdE+Z+/6aV8h+BlCDrr4nc+uf/VR9qAQAgtoHlK6/2jl
        Y0jPHRGOq6ZZ6kg9oUJbvBg+ROaBhIL/gX3l/the2eeoobn57gTRI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7AA3148D97;
        Tue,  3 Aug 2021 20:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2D134148D95;
        Tue,  3 Aug 2021 20:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/10] merge-strategies.txt: explain why no-renames
 might be useful
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <7eecf879d608d8be17d4aa0ae087fb610156019c.1628004920.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 17:28:13 -0700
In-Reply-To: <7eecf879d608d8be17d4aa0ae087fb610156019c.1628004920.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 03 Aug 2021
        15:35:17 +0000")
Message-ID: <xmqqeebarr36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBB3F9B6-F4BA-11EB-8EC4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/merge-strategies.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index eb43befac7b..d21dbd1e051 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -75,9 +75,10 @@ no-renormalize;;
>  	`merge.renormalize` configuration variable.
>  
>  no-renames;;
> -	Turn off rename detection. This overrides the `merge.renames`
> -	configuration variable.
> -	See also linkgit:git-diff[1] `--no-renames`.
> +	Turn off rename detection, which can be computationally
> +	expensive.  This overrides the `merge.renames`
> +	configuration variable.  See also linkgit:git-diff[1]
> +	`--no-renames`.

Other reasons are that we may find a pair that the user did not
intend to when they made the change (i.e. it was done purely a
creation and a deletion but we found similarity), or we may find a
wrong original to consolidate changes from a side branch into, and
these are fundamental as it is our early design choice not to
record renames at the time of committing.
