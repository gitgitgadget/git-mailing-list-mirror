Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B200C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F225820855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B7/HGC1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKUINF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:13:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63601 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKUINF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 03:13:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2256136FB8;
        Thu, 21 Nov 2019 03:13:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yqsugjEScIqULLWnV8unBpR0JpI=; b=B7/HGC
        1zTMwvou+C2cWHoQrJ6FuEj3huvK/1qwWLyNWpymkjCs36CTxrTIzgcBi5ysy8+5
        PeqwQR4W4uG87Gj6f9gEVZDMMq7FFnA1WyRbAlT0/7HN8CTwhrjBM0vTJg1O3T4m
        9RYcBdChZRxqqyKJHBUjxYDtZ2/Q20cKnofMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eCuPAiqillq5tnom2hLjULcE3GmZiaQN
        lc3AtMklETRGv/AGcgPWPjt2nWxWAcrD1WLWySHZ8q7HiAxR5K7pU3mqjPOgX7qP
        IO88MW5b4jctkIxGYL1jwfSdmvD4AMKhB6V0TRHGnp2G+hr5UXYfKKuqHh7r97/i
        mMjh9inbFtc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F02E036FB5;
        Thu, 21 Nov 2019 03:13:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4167836FB4;
        Thu, 21 Nov 2019 03:13:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/8] built-in add -i: prepare for multi-selection commands
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <c324b47592dca2cd4967d62d2520a35bfcf04bae.1573821382.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 17:12:59 +0900
In-Reply-To: <c324b47592dca2cd4967d62d2520a35bfcf04bae.1573821382.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 15 Nov 2019
        12:36:16 +0000")
Message-ID: <xmqqa78p8x6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCC249CC-0C36-11EA-9659-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `upgrade`, `revert` and `add-untracked` commands allow selecting
> multiple entries. Let's extend the `list_and_choose()` function to
> accommodate those use cases.

upgrade???

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.c | 114 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 89 insertions(+), 25 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 8ec930ac15..33a751150a 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -72,15 +72,17 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
>  struct prefix_item_list {
>  	struct string_list items;
>  	struct string_list sorted;
> +	int *selected; /* for multi-selections */
>  	size_t min_length, max_length;
>  };

OK.  The shape of the data is enough to tell us what you did in this
patch and I think it makes sense ;-)

