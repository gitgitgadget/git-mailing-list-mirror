Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE473C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8423406
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbhAHHky (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHHkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:40:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233AC0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:40:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y24so10217584edt.10
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=p83DLvT+6kg4OqEy0q1WDYHX9VjwQoYYXgQ07oogb/Y=;
        b=BMz+klSM2IseA31z8cuKGCILB3VSak/RmNyLUj2L2KaHtwJn8A0vC+CvNS5+yM2qru
         vR3ciQ+cj6jyUI5MZc1hDsW5Z51cFm+nEpTP8/Wb04F4B5b5IdyA4F2hows7f53Q8i8+
         uE6AaGvqJiX5ilnbONp0yxY8ECLyyIjZbnmvvYgh/NI1dQnuzX+y19QjEptzWP5eyN2e
         oadBhv9AxDcQuerlGU8gZkQRsZaROuWgPHBfYVekAwZnSQaX7kRTFCSUnmYsn/b9xcNT
         HB0mLMMIEBHH+4cVZvOYuwhZT5k5cs3gXyudsiWngkbreBIQ8GXao347v0cmQ/qmk2ab
         K0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=p83DLvT+6kg4OqEy0q1WDYHX9VjwQoYYXgQ07oogb/Y=;
        b=OaOaO6/BhUmePEA2VPqntKaMVF5LuAFHw/Bhn8NzwV3vtm2Z837EjGYCoKKn/jwQB0
         D6b6fA7aTfvAFpLStrWrzXdZCyxTf59mWzlxDIHKxutZjSu+dOH1Yw+opTh7E4bztHL6
         88Bm7k3u6LhAQWAnjPsYmq2FaaWBp068Jp5lc0sLgFFnsOdEsHt8Xlg4PsgrUlcPdzS/
         yITuqBL7uKQH5Vx3vlN/sGBt6pcKRZhfJJvYPXc9Fr4oi3uEyWKCt2MbpUytSh3QlMIf
         wZwChJKyvnZV4jxLEdnbCbCkynyKpKDQYtjq6RzUWgNXmFOD4Ct9HoWJi80hhPLw7F1x
         vhrw==
X-Gm-Message-State: AOAM531wC8FRjb0CKYj1VxpYcW0jiBXW98RHG1HK23dlwJlgGEixJsyL
        hM1J1TXj+w7FGywwV+bHqoypP8y3D77wCQ==
X-Google-Smtp-Source: ABdhPJxE+ix/9K6M/jBAK9XE9fpZMmbOaRTT9lb2IqpWsK3OLAPgwkXql51HBL6m4L/DGRGC8PxSPw==
X-Received: by 2002:a05:6402:1c90:: with SMTP id cy16mr4426566edb.73.1610091610363;
        Thu, 07 Jan 2021 23:40:10 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id p12sm3215889ejc.116.2021.01.07.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:40:09 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cThjBHn6AKaLvH5utD7rXMoj+gBXi-GVrfgoQ99v_38dg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
Message-ID: <gohp6ky2h4qze9.fsf@gmail.com>
In-reply-to: <CAPig+cThjBHn6AKaLvH5utD7rXMoj+gBXi-GVrfgoQ99v_38dg@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:40:09 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thank you for the detailed review.

Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> worktree: move should_prune_worktree() to worktree.c
>
> The subject is a bit confusing since this function already lives in
> `worktree.c` (albeit within the `builtin` directory). An alternate way
> to word this might be:
>
>     worktree: libify and publish should_prune_worktree()
>
> or just:
>
>     worktree: libify should_prune_worktree()
>

yes, I think these seems clearer. I will drop the current subject and
use one of these on the next revision.

>> This function will be used by another API function, implemented in the
>> next patch that will accept a pointer to "worktree" structure directly
>> making it easier to implement the "prunable" annotations.
>
> Okay, though I'm not sure this paragraph adds value since the reader
> understands implicitly from the first paragraph that this is the
> reason this patch is libifying the function. (I'd probably drop this
> paragraph if I was composing the message.)
>

Make sense.

>> should_prune_worktree() knows how to select the given worktree for pruning
>> based on an expiration date, however the expiration value is stored on a
>> global variable and it is not local to the function. In order to move the
>> function, teach should_prune_worktree() to take the expiration date as an
>> argument.
>
> Rather than "on a global variable", it would be more accurate to say
> "static file-scope variable".
>

Good point. I will definitely change that to be more accurate on the next
revision.   

>> diff --git a/worktree.c b/worktree.c
>> @@ -700,3 +700,76 @@ void repair_worktree_at_path(const char *path,
>> +/*
>> + * Return true if worktree entry should be pruned, along with the reason for
>> + * pruning. Otherwise, return false and the worktree's path, or NULL if it
>> + * cannot be determined. Caller is responsible for freeing returned path.
>> + */
>> +int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
>
> The function documentation which was moved here (worktree.c) from
> builtin/worktree.c is duplicated in the header worktree.h. Having it
> in the header is good. Having it here in the source file doesn't
> necessarily hurt, but I worry about it becoming out-of-sync with the
> copy in the header. For that reason, it might make sense to keep it
> only in the header.
>
> All of the above review comments are very minor and several of them
> are subjective, thus not necessarily worth a re-roll.

Make sense as well. 

-- 
Thanks
Rafael
