Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C9C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 12:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiDYMry (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiDYMqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 08:46:37 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D15DA6D9
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 05:43:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r11so9243819ila.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vk9fAL8o0tXQX1JAsfjd4/cUguipbGQfThowjDvKNLA=;
        b=A2Smid7yVCvOoD/XjTCECtz70Xhp9XA5MN6bIWcwDWx84LGnp6XJzjiXoS1sNsx2dr
         LnAhVA8QDSzs5ZrZaPPISLQKBrEapigBJs59tY+SvdCrde3rLygIybGpKED1goRe8BP7
         OiW18XZBNXCLzTRFlEg+Obj+v5uFRRYDGh4sphGwhHMUKWZ2zgKnFzDIknRjfctig/S7
         j1tdUgcyJgLNfzlEhT+Hyq4dBGQ7jLLbXtKHVulWdvFIWgvfCqqQaggB5V6IEDpOx4R9
         A2YFYoErH7wu6OmV23Qvp7X7pdpZ6rK6cY5Myn/pzvahd0GF/AeXvgp1EcN1YyR626jh
         uNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vk9fAL8o0tXQX1JAsfjd4/cUguipbGQfThowjDvKNLA=;
        b=dIDtg9/ppQWvcKtOat+WBcP6IG7lA3hygOO9oMZaqy4ef/APrbLrkbBb0xAvnV5TbK
         zrRFZ1EiPfBbsc9OnchFx5QHKiCXuaSagR16Jz9GbKHSa06SdcsPYGgeNwYjd3LFwBN4
         B8UJFNqZQaNjUjtUPwJNsaBQtGLWOB8LHhu8beCK/YkDN9z/l6PrZ/QLnMMUma0E74ow
         iGeVJqC1EjWjBzgXe8/7/dumgRZ/GaG4h6oCGd8fHkyawtFB/9gNzaA2SjJQIVFDNTf9
         RytkXGcDX0U5N92OkU2UoOosbUR+/chsqAebJKY6YDkJ/1Yx++HJxmJ8vuhlKwENIISn
         nq9w==
X-Gm-Message-State: AOAM531bcIWh6dt3KFmr0xtzdTBDNZrqZsTNiGpJ296WzTuy36xmdw36
        9SoL9lRj1fDe49PzWAIr0JA2NRK9uL8b7xIhTvU=
X-Google-Smtp-Source: ABdhPJyD7UqC12ZEUjaWLGo+sFgmpG5h09VBKuZD2NHL9s11CJNxtPA73f/Z0ggqYefrwBHYVJvDTrDQMBaIOCNYat4=
X-Received: by 2002:a05:6e02:1c04:b0:2cc:183f:b8cc with SMTP id
 l4-20020a056e021c0400b002cc183fb8ccmr6785404ilh.51.1650890612673; Mon, 25 Apr
 2022 05:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com> <xmqqee1ly0ab.fsf@gitster.g>
In-Reply-To: <xmqqee1ly0ab.fsf@gitster.g>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 25 Apr 2022 15:43:21 +0300
Message-ID: <CAGHpTB+K3TP64xBknU9GrH7WAxOLSk76buiGGpNMYA0ryEm=5A@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: fix initialization of warn_if_uninitialized
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Glen Choo <chooglen@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 25, 2022 at 12:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > This field is supposed to be off by default, and it is only enabled when
> > running `git submodule update <path>`, and path is not initialized.
>
> "is supposed to be": can you substantiate it with evidence and
> logic?
>
> One easy way to explain the above is to examine what the default
> value was before the problematic commit, and go back from that
> commit to see how the default was decided, and examine how the
> member is used.
>
> > Commit c9911c9358 changed it to enabled by default. This affects
> > for example git checkout, which displays the following warning for
> > each uninitialized submodule:
> >
> > Submodule path 'sub' not initialized
> > Maybe you want to use 'update --init'?
>
> We refer to an existing commit like this:
>
>     c9911c93 (submodule--helper: teach update_data more options,
>     2022-03-15) changed it to be enabled by default.
>
> So, taking the above together:
>
>     The .warn_if_uninitialized member was introduced by 48308681
>     (git submodule update: have a dedicated helper for cloning,
>     2016-02-29) to submodule_update_clone struct and initialized to
>     false.  When c9911c93 (submodule--helper: teach update_data more
>     options, 2022-03-15) moved it to update_data struct, it started
>     to initialize it to true but this change was not explained in
>     its log message.
>
>     The member is set to true only when pathspec was given, and is
>     used when a submodule that matched the pathspec is found
>     uninitialized to give diagnostic message.  "submodule update"
>     without pathspec is supposed to iterate over all submodules
>     (i.e. without pathspec limitation) and update only the
>     initialized submodules, and finding uninitialized submodules
>     during the iteration is a totally expected and normal thing that
>     should not be warned.
>
>     Fix this regression by initializing the member to 0.

Thank you very much. Updated.

> > Amends c9911c9358e611390e2444f718c73900d17d3d60.
>
> In the context of "git", the verb "amend" has a specific meaning
> (i.e. "commit --amend"), and we should refrain from using it when we
> are doing something else to avoid confusing readers.
>
> We could say
>
>     Fix this problem that was introduced by c9911c93
>     (submodule--helper: teach update_data more options, 2022-03-15)
>
> but it is not necessary, as long as we explained how that commit
> broke the code to justify this change (which we should do anyway).

I'm used to this from other projects, but ok.

> > ---
> >     submodule--helper: fix initialization of warn_if_uninitialized
> > ...
> >     Signed-off-by: Orgad Shaneh orgads@gmail.com
>
> Here under three-dash line is where you would write comment meant
> for those who read the message on the list that are not necessarily
> meant to be part of resulting commit.  Repeating the same message as
> the log message is not desired here.

This was done by GitGitGadget. I have no idea how to avoid it.

> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1258%2Forgads%2Fsub-no-warn-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1258/orgads/sub-no-warn-v1
> > Pull-Request: https://github.com/git/git/pull/1258
> >
> >  builtin/submodule--helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 2c87ef9364f..b28112e3040 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -2026,7 +2026,7 @@ struct update_data {
> >       .references = STRING_LIST_INIT_DUP, \
> >       .single_branch = -1, \
> >       .max_jobs = 1, \
> > -     .warn_if_uninitialized = 1, \
> > +     .warn_if_uninitialized = 0, \
> >  }
>
> This is not wrong per-se, but omitting the mention of the member
> altogether and letting the compiler initialize it to 0 would
> probably be a better fix.

Done.

Thanks for the review.

- Orgad
