Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0746C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86755230FE
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbhASH6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbhASH62 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:58:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C87C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:57:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u19so20389102edx.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=8WE3C3j/6ueCdIJo0zqpgWGCYCPcYsGd7bIFlfUlEG0=;
        b=HIXIbQGCioxDtk1ZuEvev2leyK6IGEoKasJelUOTxpkGOeEqll9GlYD5q36oTC04ZC
         UvAnqG5lNz/2Sxu7EDsv8MuKIkVkJWxBbRYOe0xpwDHZ87BhK7OaCHgJPAA8T5tGP7hk
         q7eMCFKJNsq7DKp/Tcm5OfWstAooa7pF6jC/izbHIAk1nThUoBod+z8hCJ5tzeWMDp0P
         6DdB3/AC3H7/tfmMfqKA2PcPoQiqtJe3e22fmS+GZ6Uw9MmCcCJI86gGqG8JwvTFmT5E
         nVJ/rz6338U6c/eXxBugQfSW43Xry/L1smlvWfDNjUOWEkL7uO2oAFr5d2IFpsWSe5WK
         FX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=8WE3C3j/6ueCdIJo0zqpgWGCYCPcYsGd7bIFlfUlEG0=;
        b=nxt8v097qT4itG0OsEiFWn1CAaOEtG5ruViNR5r0ZPOJvylqd3Yx9DO9xiLS1INNBV
         nGgaqZbwwoMlIPpSz5z/dbLjnJO5Dn+AC81jgBY7PN4W4VUz51CK2OPcDQSRbM60OtEx
         jeynBO6JikAD/JJkL8nmWZkprLvMSmhlw0wJJAwlwcZeb8dnQsxChyiv8rrwtGSPXwNM
         4nw+0KvRP1rhEuKTzXPWwN5jEF/cP108uq/c3pqWMcZTMRT1zJwMqDt/86lsEwHTTtaB
         gpe49zmLHXb9ug/ZbzX5oD3fp7ujZQ0zL/6J6+3i6P0Y6j30JAXxUjYe6yQh2xobIW7c
         ppVA==
X-Gm-Message-State: AOAM531zB4zoS2DeiuLuMi8frVreIc60f77pv/ENkl38ZknDI9pe9/fu
        ygGH3CQrEoWHyj3CJchQ1E+M8XVwi/Y=
X-Google-Smtp-Source: ABdhPJx+0IR4cO0FOQZvYfNdjDZ+Mh5iRD6srIYWodIXs/haqEalU0s0GZWVQPQ9Q57Y19bwkx+6PQ==
X-Received: by 2002:a05:6402:d0a:: with SMTP id eb10mr2408369edb.249.1611043066514;
        Mon, 18 Jan 2021 23:57:46 -0800 (PST)
Received: from cpm12071.local ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id o11sm5653268eds.19.2021.01.18.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:57:45 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-3-rafaeloliveira.cs@gmail.com>
 <CAPig+cQX27n6vpGP4m3S9paUnpNw5etLLAXr=WO9rC1KSSLMmQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/6] worktree: teach worktree to lazy-load "prunable"
 reason
In-reply-to: <CAPig+cQX27n6vpGP4m3S9paUnpNw5etLLAXr=WO9rC1KSSLMmQ@mail.gmail.com>
Message-ID: <gohp6k5z3te4ug.fsf@gmail.com>
Date:   Tue, 19 Jan 2021 08:57:45 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Add worktree_prune_reason() to allow a caller to discover whether a
>> worktree is prunable and the reason that it is, much like
>> worktree_lock_reason() indicates whether a worktree is locked and the
>> reason for the lock. As with worktree_lock_reason(), retrieve the
>> prunable reason lazily and cache it in the `worktree` structure.
>>
>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/worktree.c b/worktree.c
>> @@ -245,6 +246,25 @@ const char *worktree_lock_reason(struct worktree *wt)
>> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
>> +{
>> +       struct strbuf reason = STRBUF_INIT;
>> +       char *path;
>
> The `path` variable is uninitialized...
>
>> +       if (should_prune_worktree(wt->id, &reason, &path, expire))
>> +               wt->prune_reason = strbuf_detach(&reason, NULL);
>
> ...but the very first thing should_prune_worktree() does is
> unconditionally set it to NULL, so it's either NULL or an allocated
> string regardless of the value returned by should_prune_worktree()...
>
>> +       strbuf_release(&reason);
>> +       free(path);
>
> ...which makes the behavior of `free(path)` deterministic. Good.
>
> I'm on the fence about whether or not we should initialize `path` to NULL:
>
>     char *path = NULL;
>
> just to make it easier for the next person to reason about it without
> having to dig into the implementation of should_prune_worktree(). This
> is a really minor point, though, not worth a re-roll.

This is a good point and totally agreed. I'm going to include this
change in the next revision.

-- 
Thanks
Rafael
