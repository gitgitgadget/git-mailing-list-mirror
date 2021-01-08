Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1975DC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B474A23406
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbhAHHnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAHHnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:43:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DDC0612F9
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:42:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p22so10180903edu.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=00vvRx0OQG7mCgt0YBpyrk52GTMv9PHTmr/w4oEeVGc=;
        b=flFc/DOBjusnFaOkzTKpj4Pi3nn9KOl6HWzSZSn7c8hwUPT60UK7UxNw0mszUAEphQ
         Un9K1Cehq2Z3MR58tu+VIIvKIBNtk/PinebDk09BNJisLG9rg5g472EwrfTI/pdcb2Ih
         PEflia+cBkMZPQymdkn7R5BdhdQlCzKhlzlGGdCOFxfUsBNqtjx+bUDbYDskOSI038ZK
         imDXDTUX8Ok9IQU4ifO5lIANqzDdDEZsCMCotjbklKT6daKT5mZY3ukhuid2euIcvB23
         rhgzlzLwhwkrGOvZeblrGBsxLfWuG/GiYigKYZua0ovXGZ3Un4iUUH/QP3rrv+BkwzRw
         wCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=00vvRx0OQG7mCgt0YBpyrk52GTMv9PHTmr/w4oEeVGc=;
        b=JBUhY5FuDtedxw5674Sq7eARPHzolrte5LCBnvnmSf3Cs13xBUuvzhss8R+mTJYxnP
         J3PtAzM4nYiRRaZcy9E2KHrJ9YQiuxpvksg2JEV2Eh9IX0LEJsxMd87xLKNukjMoh2Hn
         rDrWSio9eOxKpEG0H6WIHws2CL9PGhbQa05OSt/cLbazUIhxbsgMIM19nJF93rnWkf3s
         7Gqx9Ia0XgDGqETQ+1F55RGmD8ItKRmhUWpBl+Lwc/Eo+rCbrW9O4+aCru9bQi3BjLum
         Ii58/b7xK7fqSMuRXxoh/jMsg6+PFwZ5KY6lDxa4MjQ7X7UHZDJE5vVOmuQNL47CoqXc
         yEag==
X-Gm-Message-State: AOAM531KRnMpZdb/7KSWmfjU/fCNNaskOqT6nEJ9kiVt8Ey3sdRA/A4C
        Ai5AfPUV33BcIHAmRGQ6LFEnbRXvQtvRdA==
X-Google-Smtp-Source: ABdhPJwANnKY7rKxqk7IFUip3DPAeYoqj9If5hQiiQIGsab0/5pV1RQvp+GO3nYRgCtc4bQXvofzhA==
X-Received: by 2002:a05:6402:c1c:: with SMTP id co28mr4354906edb.287.1610091760354;
        Thu, 07 Jan 2021 23:42:40 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id u26sm3450055edo.37.2021.01.07.23.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:42:39 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-3-rafaeloliveira.cs@gmail.com>
 <CAPig+cRNJeDS+TJL24_QGVE+goD2qBV7aorr+EKr9ORTTmusNg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] worktree: implement worktree_prune_reason() wrapper
Message-ID: <gohp6kpn2gm1ky.fsf@gmail.com>
In-reply-to: <CAPig+cRNJeDS+TJL24_QGVE+goD2qBV7aorr+EKr9ORTTmusNg@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:42:39 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> worktree: implement worktree_prune_reason() wrapper
>
> We might be able to give the reader more useful information in the
> subject by explaining a bit more the goal of this patch. Perhaps
> something like this:
>
>     worktree: teach worktree to lazy-load "prunable" reason
>

yeah, that's sounds better. will change it on the next revision.

>> The should_prune_worktree() machinery is used by the "prune" command to
>> identify whether a worktree is a candidate for pruning. This function
>> however, is not prepared to work directly with "struct worktree" and
>> refactoring is required not only on the function itself, but also also
>> changing get_worktrees() to return non-valid worktrees and address the
>> changes in all "worktree" sub commands.
>>
>> Instead let's implement worktree_prune_reason() that accepts
>> "struct worktree" and uses should_prune_worktree() and returns whether
>> the given worktree is a candidate for pruning. As the "list" sub command
>> already uses a list of "struct worktree", this allow to simply check if
>> the working tree prunable by passing the structure directly without the
>> others parameters.
>
> Everything through "not prepared to work directly with `struct
> worktree`" makes sense when explaining why you are adding this wrapper
> function, however, most of what follows is describing an aborted idea
> about how you originally intended to implement this. The bit about
> get_worktrees() not being able to return non-valid worktrees is
> certainly an important limitation in the overall scheme of things, but
> doesn't really help to sell the change made by this patch, and it
> probably confuses the reader who didn't also read the cover-letter,
> especially since this patch does nothing to help that situation.
>
> It also isn't really necessary to talk about `git worktree list` at
> this stage since this patch stands on its own by fleshing out the API
> without having to cite a specific client.
>

Make sense.

>> Also, let's add prune_reason field to the worktree structure that will
>> store the reason why the worktree can be pruned that is returned by
>> should_prune_worktree() when such reason is available.
>
> In my opinion, this is the real reason this patch exists, thus should
> be the focus of the commit message. All the description above this
> paragraph can likely be dropped.
>
> Taking the above comments into account, perhaps the entire commit
> message could be collapsed to something like this:
>
>     worktree: teach worktree to lazy-load "prunable" reason
>
>     Add worktree_prune_reason() to allow a caller to discover whether
>     a worktree is prunable and the reason that it is, much like
>     worktree_lock_reason() indicates whether a worktree is locked and
>     the reason for the lock. As with worktree_lock_reason(), retrieve
>     the prunable reason lazily and cache it in the `worktree`
>     structure.
>

Interesting point. Rewording the commit message like this seems better,
and as you mentioned this patch can stands on its own and can be more
clear about what the commit is introducing to the code instead of all
the previous message trying to explain why this exists.

Thank you for suggesting this commit message. I will revise and change on
the next revision.

>> diff --git a/worktree.c b/worktree.c
>> @@ -15,6 +15,7 @@ void free_worktrees(struct worktree **worktrees)
>>                 free(worktrees[i]->lock_reason);
>> +               free(worktrees[i]->prune_reason);
>>                 free(worktrees[i]);
>
> Remembering to free the prune-reason. Good.
>
>> @@ -245,6 +246,24 @@ const char *worktree_lock_reason(struct worktree *wt)
>> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
>> +{
>> +       if (!is_main_worktree(wt)) {
>> +               char *path;
>> +               struct strbuf reason = STRBUF_INIT;
>> +
>> +               if (should_prune_worktree(wt->id, &reason, &path, expire))
>> +                       wt->prune_reason = strbuf_detach(&reason, NULL);
>> +               else
>> +                       wt->prune_reason = NULL;
>> +
>> +               free(path);
>> +               strbuf_release(&reason);
>> +       }
>> +
>> +       return wt->prune_reason;
>> +}
>
> A couple observations...
>
> I realize you patterned this after worktree_lock_reason(), however, it
> is more common in this codebase to return early from the function for
> conditions such as `is_main_worktree(wt)` which don't require any
> additional processing. One reason is that doing so allows us to lose
> an indentation level. Another is that it is easier to reason about the
> rest of the function if we get the simple cases out of the way early,
> such that we don't have to think about them again while reading the
> remainder of the code.
>
> If I'm not mistaken, the intention here was to cache `prune_reason`
> for reuse, however, this function just overwrites it each time it's
> called for a particular worktree, thus providing no caching and
> leaking the previously-retrieved reason as well. To fix this, I think
> you need to add a private `prune_reason_valid` member to `struct
> worktree` (similar to `lock_reason_valid`) and check it before calling
> should_prune_worktree().
>

Good point. I totally missed the caching aspect of the implementation
and I greed about getting the simple case out earlier in order to make it
simple to reason about it.

> Taking the above comments into account, perhaps it should be written like this:
>
>     if (is_main_worktree(wt))
>         return NULL;
>     if (wt->prune_reason_valid)
>         return wt->prune_reason;
>     if (should_prune_worktree(wt->id, &reason, &path, expire))
>         wt->prune_reason = strbuf_detach(&reason, NULL);
>     wt_prune_reason_valid = 1;
>     free(path);
>     strbuf_release(&reason);
>

Thanks. I will add this suggestion in the next revision. 

>> diff --git a/worktree.h b/worktree.h
>> @@ -11,6 +11,7 @@ struct worktree {
>>         char *id;
>>         char *head_ref;         /* NULL if HEAD is broken or detached */
>>         char *lock_reason;      /* private - use worktree_lock_reason */
>> +       char *prune_reason;     /* private - use worktree_prune_reason */
>
> As noted above, we also probably need a new `prune_reason_valid`
> member, similar to the existing `lock_reason_valid`.
>

Indeed. will add on the next revision.

>> @@ -73,6 +74,12 @@ int is_main_worktree(const struct worktree *wt);
>> +/*
>> + * Return the reason string if the given worktree should be pruned
>> + * or NULL otherwise.
>> + */
>> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);
>
> The documentation should also talk about `expire` since its purpose
> and meaning is unclear.
>

Good point. I missed adding the message here for the `expire` parameter,
will add it. 

> Nit: I realize that you patterned this description after the one for
> worktree_lock_reason(), but it's a bit unclear. Perhaps rephrasing it
> like this would help:
>
>     Return the reason the worktree should be pruned, otherwise
>     NULL if it should not be pruned.

Also make sense to rephrase like this.


Thank you for this review will address all this changes on the v2.

-- 
Thanks
Rafael
