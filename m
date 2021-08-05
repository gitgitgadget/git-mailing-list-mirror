Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D5C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1E260EE7
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbhHEUOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:14:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50739 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhHEUOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:14:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3AFDCB6D4;
        Thu,  5 Aug 2021 16:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdEo4wFAqpigtRxZmA2vx6jvlTQZxyuDbMHn83
        kYLEI=; b=ijlrLDsR/gwRUCS/O+k7eWqR12TYqFnS5bxPfUKx0CBV8FfwRgXnJH
        Gqvl9NuJBb7jKPIs4RvHCCAuGSLacHThm1NJjEuz2tSY5625WaF3OP8N0m7o+gyq
        6jN5eN0Yv3S0x3L+HsLTX8C8hfzjQ1XD240Kl8OkCvWzmIWNKq9qo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E80EDCB6D1;
        Thu,  5 Aug 2021 16:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B1D5CB6D0;
        Thu,  5 Aug 2021 16:13:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 2/9] submodule--helper: refactor
 resolve_relative_url() helper
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805074054.29916-1-raykar.ath@gmail.com>
        <20210805074054.29916-3-raykar.ath@gmail.com>
Date:   Thu, 05 Aug 2021 13:13:55 -0700
In-Reply-To: <20210805074054.29916-3-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 5 Aug 2021 13:10:47 +0530")
Message-ID: <xmqqv94jk5to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A99C1344-F629-11EB-ABE6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Refactor the helper function to resolve a relative url, by reusing the
> existing `compute_submodule_clone_url()` function.
>
> `compute_submodule_clone_url()` performs the same work that
> `resolve_relative_url()` is doing, so we eliminate this code repetition
> by moving the former function's definition up, and calling it inside
> `resolve_relative_url()`.

Looking good.

> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> ---
>  builtin/submodule--helper.c | 61 +++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)

This step is easier to see with "show --patience --color-moved" to
see that compute_submodule_clone_url() has only been moved without
any change.  And the actual change is much smaller than what the
diffstat suggests above (11 lines lost, 1 line updated, if I counted
correctly).

Nicely done.

