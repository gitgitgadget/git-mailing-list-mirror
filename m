Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A749CC43332
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4F2313C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404797AbhASOvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404280AbhASKen (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 05:34:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C593C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:26:06 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r12so16379970ejb.9
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 02:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=KFuQGU3J3ns0uwJj+TEoSTH9XDIImB7SAT+N8j/W4Oc=;
        b=MxRCl7J5RbOWtko/UxBgzAdV0Ns2KivI2XVMaI6F5ySbxuFfxHVO4dteZye7CPrsuw
         tITb9FZbfZs8Q6mUfGcqTRkY42MmL+u7QL67AKHXldWPprmtEdrwKV3qdkgORp3cgIfc
         W2MJwHVfIQSXFnIC8H69HxeQ7Vrnfx3aWoGA8ZPE3l2ctOawRt4h2WLJ1Qf+S2rVep4t
         Cf+L5368boE7/JpNuqTEloDDihaWq55Dpb96M54tDaxQ7nh2b7AJHnbJWO6oSb5m8+Cb
         IBfepUSk19+ZqwyafVqZmiJkaNzvdDRQ2bjOxKl9pCJTJa/mu0XcUXQzNfyEBCnMOUMW
         UQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=KFuQGU3J3ns0uwJj+TEoSTH9XDIImB7SAT+N8j/W4Oc=;
        b=OFGs1GuMrvJ42YfzA5kF2Xw/ohVOMFB8GUtobFab8jFe9IToUANSbnm/xuXvGM15y5
         BXLG9FmJDXzS0gPjoUQVcrxP0oLl3lzoVGpw+KQlXDgRdnYbIkV3d5SiB1kDRZBBi/uo
         tkR4Sf/6YdXrr2ONEGrwTsRGPPIQof9EK5BmmFpz2LfDt4ELPT4vLsz3oLCna+1oKA2/
         FQIUAAQSf4+qlywXdMcmM5Ys0uLaiZRbq9AAxKhjqG1TdEoFa8YD+Aea7z6y85QOB3Tc
         hr9uZah/zZdH2f68lcz4cxm1IYDyF4iCB2v/1cf01XaZBl8x2QjsS3uiwf9RXCQiob+i
         7yLA==
X-Gm-Message-State: AOAM530drcD4BHNODJ5va5GThRAO4jDMdE3p6+t5HJbJRoHi6TKm0oJM
        gMJ4TdJT5weBYzJtgNcCfg0=
X-Google-Smtp-Source: ABdhPJzZ9WeMuUj0KkuNC3RCCWIZeLTcDoYXeZ1USs3f9cjbb6KhEVXKUK8N0VSmaG7sU3CpQBsSKA==
X-Received: by 2002:a17:906:f8d5:: with SMTP id lh21mr2612408ejb.167.1611051965097;
        Tue, 19 Jan 2021 02:26:05 -0800 (PST)
Received: from cpm12071.local ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id u17sm12206698edr.0.2021.01.19.02.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:26:04 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-6-rafaeloliveira.cs@gmail.com>
 <CAPig+cRUrN62CDT+e+q02-S_sCD1Qvi5XtgU3D1dr9fXt--YJA@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/6] worktree: teach `list` to annotate prunable
 worktree
In-reply-to: <CAPig+cRUrN62CDT+e+q02-S_sCD1Qvi5XtgU3D1dr9fXt--YJA@mail.gmail.com>
Message-ID: <gohp6kpn216x51.fsf@gmail.com>
Date:   Tue, 19 Jan 2021 11:26:03 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:

>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> @@ -234,6 +235,9 @@ This can also be set up as the default behaviour by using the
>>  --expire <time>::
>>         With `prune`, only expire unused working trees older than `<time>`.
>> ++
>> +With `list`, annotate missing working trees as prunable if they are
>> +older than `<mtime>`.
>
> s/mtime/time/
>

Oops. thanks for catching that. Will fix it in the next revision.

>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -592,6 +592,10 @@ static void show_worktree_porcelain(struct worktree *wt)
>> +       reason = worktree_prune_reason(wt, expire);
>> +       if (reason && *reason)
>> +               printf("prunable %s\n", reason);
>
> I lean toward not including `*reason` in the condition here. While one
> may argue that `*reason` is future-proofing the condition, we know
> today that worktree_prune_reason() will only ever return NULL or a
> non-empty string. So, having `*reason` in the condition is misleading
> and confuses readers into thinking that worktree_prune_reason() could
> return an empty string or that perhaps it did in the past. And
> studying the history of this file or even this commit won't help them
> understand why the author included `*reason` in the condition.
>

Fair enough. The `*reason` condition was indeed added to be safe and
future-proofing and, as you pointed it out, we know that currently
the worktree_prune_reason() returns a non-empty string when its true
and when the code reaches the `*reason` condition in
"if (reason && *reason)" this will always evaluates to true.

Agreed that removing this part of the condition will make the code
clearer and easier to followed. So I will drop this in the next
revision.

>> @@ -617,9 +622,14 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
>> -       if (!is_main_worktree(wt) && worktree_lock_reason(wt))
>> +       reason = worktree_lock_reason(wt);
>> +       if (reason)
>>                 strbuf_addstr(&sb, " locked");
>
> Although I understand what happened here because I read the entire
> series, for anyone reading this patch in the future or even someone
> reading this patch in isolation, the disappearance of
> is_main_worktree() from the condition is mysterious. They won't know
> if its removal was an accident or intentional, or if the change
> introduces a bug. Therefore, it would be better to drop
> is_main_worktree() from this conditional in patch [3/6], which is the
> patch which makes it safe to call worktree_lock_reason() even for the
> main worktree. Thus, in [3/6], this would change from:
>
>     if (!is_main_worktree(wt) && worktree_lock_reason(wt))
>
> to:
>
>     if (worktree_lock_reason(wt))
>
> and then in this patch [5/6], it becomes:
>
>     reason = worktree_lock_reason(wt);
>     if (reason)
>

That's a good point, and even worse this is not mentioned in my commit
message at all. It make sense to move this change into [3/6] where the
API is changed and all the reason is explained in the commit message.

>> +       reason = worktree_prune_reason(wt, expire);
>> +       if (reason)
>> +               strbuf_addstr(&sb, " prunable");
>
> Looking at this also makes me wonder if patches [5/6] and [6/6] should
> be swapped since it's not clear to the reader why you're adding the
> `reason` variable in this patch when the same could be accomplished
> more simply:
>
>     if (worktree_lock_reason(wt))
>         strbuf_addstr(&sb, " locked");
>     if (worktree_prune_reason(wt, expire))
>         strbuf_addstr(&sb, " prunable");
>
> If you swap the patches and add --verbose mode first which requires
> this new `reason` variable, then the mystery goes away, and the use of
> `reason` is obvious when `prunable` annotation is added in the
> subsequent patch.
>
> Having said that, I'm not trying to make extra work for you by
> expecting patch perfection. Sometimes it's fine to craft a patch in
> such a way that it makes subsequent patches simpler, even if it looks
> slightly odd in the current patch, and I haven't read [6/6] yet, so
> whatever opinion I express here is based only upon what I've read up
> to this point.

That's a good point. I'm inclined to leave the [5/6] with the following:

    if (worktree_prune_reason(wt, expire))
        strbuf_addstr(&sb, " prunable");

And move up the changes that includes the `reason` into the [5/6]
patches that introduces the --verbose option. This line seems easier to
follow when the reader is looking on this patch alone and only care
about a reason when the --verbose comes into play in the next patch
[6/6].

Although your suggestion about changing the patch also sounds reasonable
and I'll take into consideration when I re-roll this series.

Btw, I don't mind spending extra work on and I'm all forward
with the changes so we it would be easier to understand not only now where
all the patches are being reviewed together but in the future when
someone is looking at the history of the project, specially for
debugging/bisecting reasons.

Thanks for the insightful comments.

-- 
Thanks
Rafael
