Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A5C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB486145D
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhD2Hw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:52:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Hw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:52:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9879512E270;
        Thu, 29 Apr 2021 03:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ca8NF+hkflf71fUmoa2LEnFlE3F6/HiVFh9jMM
        8414Y=; b=uKHj1TvG7qCZ21WT7F2je9GnZOhew5NUNkT/dSoAuUr0xehVnDayNI
        SnhZt3hsaFwLNKXh9XMxN27yjyVo7LlNnF86AmWwpRcIbNd9jdSIuET19q/aDRQ2
        ngaUU7rP0XN1NsPKEGFE5zg2O1G+X++/v5uo+AnYfPJx5qA1Oul4Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9098012E26F;
        Thu, 29 Apr 2021 03:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B996A12E26E;
        Thu, 29 Apr 2021 03:52:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
        <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
        <xmqqbl9zcawf.fsf@gitster.g>
Date:   Thu, 29 Apr 2021 16:52:05 +0900
In-Reply-To: <xmqqbl9zcawf.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        28 Apr 2021 13:04:32 +0900")
Message-ID: <xmqqk0ol7cka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB49C0F2-A8BF-11EB-9ACC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Josh Soref <jsoref@gmail.com>
>>
>> Usually, it is easier to read a message if it makes its primary
>> point first, before giving a parenthetical note.
>>
>> Possible messages before include:
>> ` (nothing to squash)Already up to date.
>> `
>> and
>> `Already up to date. Yeeah!
>> `
>>
>> After:
>> `Already up to date (nothing to squash).
>> `
>> and
>> `Already up to date.
>> `
>>
>> Localizations now have two easy to understand translatable strings.
>> (All localizations of the previous strings are broken.)
>>
>> Co-authored-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Josh Soref <jsoref@gmail.com>
>> ---
>
> I am not sure why this is Co-au, and not the more usual "Helped-by".
>
> The patch text makes sense to me.

Actually, not so fast.  The end-users do not care really where the
message originates.

$ git grep -e 'Already up[- ]to' \*.c
maint:builtin/merge.c:		finish_up_to_date(_("Already up to date."));
maint:builtin/merge.c:			finish_up_to_date(_("Already up to date. Yeeah!"));
maint:merge-ort-wrappers.c:		printf(_("Already up to date!"));
maint:merge-recursive.c:		output(opt, 0, _("Already up to date!"));
maint:notes-merge.c:			printf("Already up to date!\n");

It probably makes sense to replace the exclamation point with a full
stop for others, no?


Also, I didn't notice when reading the patch submission earlier, but
what does

>> (All localizations of the previous strings are broken.)

mean, exactly?  Do you mean to say

    Because this changes some messages, the old messages that were
    already translated will no longer be used, and these new
    messages need to be translated anew.

or

    Because of (...some unstated reason...), the entries in the
    message database in po/ that were meant to translate the old
    messages this patch updates were not correctly used.

or something else?




