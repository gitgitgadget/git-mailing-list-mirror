Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC871F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfJCWiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:38:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62181 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfJCWiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:38:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54ACD260F2;
        Thu,  3 Oct 2019 18:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HxjuJtS8bPyGJQ+F2Xf36WhEnOA=; b=NeLxg3
        A+qPu3IWvVBROx4wZnpY0gYiNgzF04FZTCZBCxnUn1IMcoL8lDJt663g2WnmQVWK
        gUtMUReI+R/ciCyKCH5P6yF3Fstqa528ZGCmRSy3LB5H14oSf3whjHH8bzsBFK4S
        TFKBRW/gMpYkNfaz4SqnBdY0a3TqCQeUxFl/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZHBM9nIB/SMFttSYiqIEktkzoCyNiKsE
        0YSE1Ag+ifI9takmsFrBXrIz1cwa1igRhjQMVPphOFMvLxwUMqCfSzb8kGnWp8st
        DA7lgQS8V96r2wUeslUqg9Qy2dwdp6FW7yvWA9ubhthb7794S06LYRwU34LrSHkS
        RKjI0/vqxSY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A5A5260F1;
        Thu,  3 Oct 2019 18:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 977D6260EF;
        Thu,  3 Oct 2019 18:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/13] push: do not pretend to return `int` from `die_push_simple()`
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
        <4d0b38125a13d85963be5e524becf48271893e2b.1569837329.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 07:37:57 +0900
In-Reply-To: <4d0b38125a13d85963be5e524becf48271893e2b.1569837329.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 30 Sep 2019
        02:55:31 -0700 (PDT)")
Message-ID: <xmqq36g9bgl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73C07060-E62E-11E9-92EF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This function is marked as `NORETURN`, and it indeed does not want to
> return anything. So let's not declare it with the return type `int`.
> This fixes the following warning when building with MSVC:
>
> 	C4646: function declared with 'noreturn' has non-void return type
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/push.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 021dd3b1e4..d216270d5f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -143,8 +143,8 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
>  	return remote->url_nr;
>  }
>  
> -static NORETURN int die_push_simple(struct branch *branch,
> -				    struct remote *remote)
> +static NORETURN void die_push_simple(struct branch *branch,
> +				     struct remote *remote)

Haha ;-)  "I won't return and I'll return int" sounds like an
oxymoron.

>  {
>  	/*
>  	 * There's no point in using shorten_unambiguous_ref here,
