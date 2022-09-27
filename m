Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA1C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiI0QkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiI0QkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:40:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA11D303
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:39:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D29E913BE2E;
        Tue, 27 Sep 2022 12:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DC9vmibQxPrp3KNckp7EsZeeGu2pvktv8EDa4b
        80UO4=; b=yMtpiR5oQVgvdAchSaNy43+T4VNZMElNtvjYg7I+TuLV1kypBv0931
        xkdmhjn2sJG52tGEVsoJzxLbaIWS2S03Wj+vv504uZdhzLu82mZ9r3W3BIKDbqsG
        Md2tHlGsZb2YM5FFuLNyTYDmHWRkc0CQJH5LV6PtOmXGjT7sRoQAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C79AF13BE2D;
        Tue, 27 Sep 2022 12:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F39A13BE2B;
        Tue, 27 Sep 2022 12:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 4/4] string-list: document iterator behavior on NULL
 input
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
        <73a262cdca46a45aeeda6f47ea3357aaeb937e7b.1664287021.git.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 09:39:56 -0700
In-Reply-To: <73a262cdca46a45aeeda6f47ea3357aaeb937e7b.1664287021.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 27 Sep 2022
        13:57:01 +0000")
Message-ID: <xmqqmtak7ov7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 057DE834-3E83-11ED-8142-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The for_each_string_list_item() macro takes a string_list and
> automatically constructs a for loop to iterate over its contents. This
> macro will segfault if the list is non-NULL.
>
> We cannot change the macro to be careful around NULL values because
> there are many callers that use the address of a local variable, which
> will never be NULL and will cause compile errors with -Werror=address.
>
> For now, leave a documentation comment to try to avoid mistakes in the
> future where a caller does not check for a NULL list.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  string-list.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

For exactly the -Werror=address reason, any other way that checks
list for NULL-ness cannot be done here (other than with Peff's
inline helper that returns the first item or NULL), which is a bit
of shame but this is totally outside the topic, and an additional
comment is a good thing to have here.

Thanks.  All four patches look reasonable.  Will queue (but after I
make sure I can tag and push out -rc2 today).


> diff --git a/string-list.h b/string-list.h
> index d5a744e1438..c7b0d5d0008 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -141,7 +141,12 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t func, void *cb_data);
>  
> -/** Iterate over each item, as a macro. */
> +/**
> + * Iterate over each item, as a macro.
> + *
> + * Be sure that 'list' is non-NULL. The macro cannot perform NULL
> + * checks due to -Werror=address errors.
> + */
>  #define for_each_string_list_item(item,list)            \
>  	for (item = (list)->items;                      \
>  	     item && item < (list)->items + (list)->nr; \
