Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BEC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 05:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF67B614A5
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 05:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCUFpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 01:45:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58026 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCUFpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 01:45:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C49AD11707E;
        Sun, 21 Mar 2021 01:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQ7QjHMk8RYXq3jO04oAADNgznA=; b=iETVPR
        qaeQ0x6+kdr1PT4TCiODR8XaW67Kimie27Y9iMV5Avm7uuTASu8P6UFwJ4D6U/dH
        CIuDTm5xKqyUL7CiccWMgCUy4B69KLAyozARhe49V6NajxUTGVhlDC1vWtRnJIMZ
        zUMyfJMh+pI8wvnsBNKCt8w1hmXp2jewNDwkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wf6kdUacAV8ELi6jxsmZWF9kCrhm7s2B
        qxUmZYBoJfwogcxc1sUDvd91CSgBC32dqALwgQDAZl9lWNdp7aB4XbwlXcJ1t9pq
        /paQOvSd1vWRt9/3UtughqeHjnHTk0Qj/SPqAGX5MWa54nugVaKffOjfnazArb3A
        dpHz+0ogsGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B064511707D;
        Sun, 21 Mar 2021 01:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3DEF11707B;
        Sun, 21 Mar 2021 01:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
        <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
        <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
Date:   Sat, 20 Mar 2021 22:45:00 -0700
In-Reply-To: <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 21 Mar 2021 00:05:26 -0400")
Message-ID: <xmqqpmztcb6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94FBBB7A-8A08-11EB-B1E1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This new example raises the question about what happens if the
> argument to --reroll-count contains characters which don't belong in
> pathnames. For instance, what happens if `--reroll-count=1/2` is
> specified? Most likely, it will fail trying to write the
> "v1/2-whatever.patch" file to a nonexistent directory named "v1".
>
>> diff --git a/log-tree.c b/log-tree.c
>> @@ -369,8 +369,8 @@ void fmt_output_subject(struct strbuf *filename,
>> +       if (info->reroll_count)
>> +               strbuf_addf(filename, "v%s-", info->reroll_count);
>>         strbuf_addf(filename, "%04d-%s", nr, subject);
>
> To protect against that problem, you may need to call
> format_sanitized_subject() manually after formatting "v%s-". (I'm just
> looking at this code for the first time, so I could be hopelessly
> wrong. There may be a better way to fix it.)

This kind of discovery of what I and others missed is why I love to
see reviews on this list ;-)

Yes, slash is of course very problematic, but what we've been doing
to the patch filenames was to ensure that they will be free of $IFS
whitespaces and shell glob special characters as well, and we should
treat the "reroll count" just like the other end-user controlled
input, i.e. the title of the patch, and sanitize it the same way.

So I am pretty sure format_sanitized_subject() is the right way to
go.

