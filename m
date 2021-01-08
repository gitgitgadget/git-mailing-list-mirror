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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A7BC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872EB23406
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAHHny (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAHHny (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:43:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6323C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:43:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id q22so13360435eja.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=LHY5CCPo5MKyB8Fonytsy1s4R19IlwKjZRqmDF+7HFk=;
        b=mAssyqSZFIVn636GvFNZU7NDGLg43lgz5nPADrvbDU93z9PttTeyx2we2gNBoRW3Nj
         9eh83cBacPLui02QI/FYXRJctTA1lQWn/VkRZQ4bEpj5gKwTylxOSrhWQuqo0sUVAWOx
         vQemb9cpfBGV/JyC9UYAzf+9WnD7wX9Lo7cbi3gnapMloIN/Da2/K9HxaTT3kqVnFjXZ
         OkBavyno8rbKt1Nj3vahemih4xyKGU3yLMivdYseSoWHtLtcT3wx8yuCxzLbYJq593qS
         GFCj+quLoPGR4OFbO1GV88PcokX2kok14R0HYB9C/GrRk1A8YUof1QM7qLRiAd7JGZEr
         /6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=LHY5CCPo5MKyB8Fonytsy1s4R19IlwKjZRqmDF+7HFk=;
        b=pYxfaDG4oL34q/fgCe8o1lGF0/icCZRBFQ0Ly8nMjSAcegJCqRHsAVma65nkHO7dSx
         uqAhLin3Yo3XyGAJKGdnT+mC7y6Z2b0U7UVMCgpEmtDby+6npa5vw6xJsOjlpgAPT4Gp
         VipvCamGzAZEt25ZvDU23W6DBuVwW5xHJIFC4aMl4t/2NDf1YS1PQatTDC0VLhIO2cZB
         6RPuPIvWT6Dsv//7sccHMiJmKQ2NuuHPiVV8XY3o238d1/pcAVckevz9HN9z+/7TqQCy
         d+a9gAnldLZpASQ+yMpgFC2h5D0TN5rF3kdoWxmzRkmRXawJ6clhm0LmqGAmSVVjnp8G
         FJiw==
X-Gm-Message-State: AOAM530/L3kuUTKq0YBQrr9lagxUYPZBD5ekwZp+AS86Xk83YobnV86e
        x/4hq5fgDimPfj6d1aF4ah3YhSjbDQ8pKw==
X-Google-Smtp-Source: ABdhPJygaP5bH5bEBD7CxTib2c98kR2ZQKK9o7fI+kdovbed9SYlnMZgRsTf+v9m80I4eydYCkYIWA==
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr1819987ejc.303.1610091792406;
        Thu, 07 Jan 2021 23:43:12 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id r24sm3514800edo.4.2021.01.07.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:43:11 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-4-rafaeloliveira.cs@gmail.com>
 <CAPig+cRrU-T9ULyoNVtrWxm-5yb5NVSCT3+LvLmA5xJCv4n_9Q@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] worktree: teach worktree_lock_reason() to gently
 handle main worktree
Message-ID: <gohp6k8s94m15w.fsf@gmail.com>
In-reply-to: <CAPig+cRrU-T9ULyoNVtrWxm-5yb5NVSCT3+LvLmA5xJCv4n_9Q@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:43:10 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> The main worktree should not be locked and the worktree_lock_reason() API
>> is aware of this fact and avoids running the check code for the main
>> worktree. This checks is done via assert() macro, Therefore the caller
>
> s/Therefore/therefore/
>

Nice catch. thanks.

>> needs to ensure the function is never called, usually by additional code.
>>
>> We can handle that case more gently by just returning false for the main
>> worktree and not bother checking if the "locked" file exists. This will
>> allowed further simplification from the caller as they will not need to
>> ensure the main worktree is never passed to the API.
>>
>> Teach worktree_lock_reason() to be more gently and just return false for
>> the main working tree.
>
> The situation is even a bit worse since the main worktree restriction
> isn't even documented. Here's a possible rewrite of the commit message
> which addresses that point too:
>
>     worktree_lock_reason() aborts with an assertion failure when
>     called on the main worktree since locking the main worktree is
>     nonsensical. Not only is this behavior undocumented, thus callers
>     might not even be aware that the call could potentially crash the
>     program, but it also forces clients to be extra careful:
>
>         if (!is_main_worktree(wt) && worktree_locked_reason(...))
>            ...
>
>     Since we know that locking makes no sense in the context of the
>     main worktree, we can simply return false for the main worktree,
>     thus making client code less complex by eliminating the need for
>     callers to have inside knowledge about the implementation:
>
>         if (worktree_locked_reason(...))
>             ...
>

Yes, this is a nicer commit message to explain the current situation and
having the code example in there makes even more clearer. Thanks for the
suggestion will definitely make this change on the next revision.

>> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
>> ---
>> diff --git a/worktree.c b/worktree.c
>> @@ -225,9 +225,7 @@ int is_main_worktree(const struct worktree *wt)
>>  const char *worktree_lock_reason(struct worktree *wt)
>>  {
>> -       assert(!is_main_worktree(wt));
>> -
>> -       if (!wt->lock_reason_valid) {
>> +       if (!is_main_worktree(wt) && !wt->lock_reason_valid) {
>>                 struct strbuf path = STRBUF_INIT;
>
> As mentioned in my review of patch [2/7], this would be more idiomatic
> and easier to reason about if the function returns early for the main
> worktree case, thus freeing the reader from having to think about that
> case for the remainder of the code. So:
>
>     if (is_main_worktree(wt))
>         return NULL;
>     if (!wt->lock_reason_valid) {
>         ...
>
> Subjective, and not necessarily worth a re-roll, though.

I'm inclined to change here on the next revision as I will do the same
for the patch [2/7] with the worktree_prune_reason() and use the same
pattern for both functions.

-- 
Thanks
Rafael
