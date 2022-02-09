Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95945C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiBIQn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiBIQnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 11:43:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBEAC0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 08:43:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m11so6238015edi.13
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPX92nrNnkauakrnLyy762vV4akYXlVJbcnrwakC6ps=;
        b=ChtqxAYuCb6aeMvU0Lpgf+gzdZJr6XRHlL2CTXMW1mN6uAasFRxWabuuUNdrX7VcnX
         ETLy5vCC9NbE7hPG/8XTkB0BhU0bel8CpjZajYeaEBc/7JxrqPnC8wtgCJIcvcX/DKGZ
         Jj2QKa5mFx0nnR0WfoUbTPLgCVu9urlAdWQt5QS5qm59kkfGJtzShAQLhV7u4Lsj/TcS
         qaP6z+qs//Lj9SJ69ByDhbxvOmgH1v5FWnF8ILyGHrlp+YBK7zdqfaelp9T3qDrL7Vmm
         JBxYZe0S2HQA+7o5oW2dfLUHi3cCxooCJWpOp0agr1Z06t4cK0bClr7Pr6x+wHx9OAAA
         ixDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPX92nrNnkauakrnLyy762vV4akYXlVJbcnrwakC6ps=;
        b=AaSAhMtFbhtHQbaPlx7eUaVoEmdQWiH+EY3shLXUKodcus3esj5dxYjtYfzAW4nN3R
         XquenKSjgvlBIBBKOBJcEVKY9Gt6vIlnrMry1v/89g6zchvKYTlO0f4buCeWoUM0Bcpi
         f+k6PMm5r9mAnTjYcFMr1jp/zD23rmQK6LVATrzANm/pMg1+n9MMWWAF/ewuT0sEbgyv
         NwTrqWJTJ9o0VhAhAgqcv/EKCLJCVvKfM2G2aZgN6BOovLDIzQHe8jIRodwx9RMZzFew
         +ZTdhBXXfVWPT80eBiIrEY/3MkKf05aoOrAgZzKI0mNGJ+xqAlVeqn+asta062gipXgM
         MadQ==
X-Gm-Message-State: AOAM533gddWGr84q4g7bbaDtfmSWO8pmnttz+k5SE++wdY6JVoVgK1P6
        xZvhUZl2HifIixweVLY+V+RjPnA7qCfpjKEe/h31/58KIVg=
X-Google-Smtp-Source: ABdhPJwR6CwGgZucLrnwhx+V6VONfctGUdyR7zMge8IuuoRVaPnOXlldbfo8fpKi7TlIahbL+JWsKz1IhgMesxLfIQY=
X-Received: by 2002:a05:6402:350d:: with SMTP id b13mr3452651edd.192.1644425035775;
 Wed, 09 Feb 2022 08:43:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <5d0cc242d92c68bf239f9e17eab9c80ec6b2d469.1644269583.git.gitgitgadget@gmail.com>
 <xmqq1r0dc8om.fsf@gitster.g>
In-Reply-To: <xmqq1r0dc8om.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Feb 2022 08:43:44 -0800
Message-ID: <CABPp-BG0pKWZ=vowE7eGWUzXJ6wpY1udEAzb322fO38v3ZRZ=w@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] worktree: create init_worktree_config()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static int move_config_setting(const char *key, const char *value,
> > +                            const char *from_file, const char *to_file)
> > +{
> > +     if (git_config_set_in_file_gently(to_file, key, value))
> > +             return error(_("unable to set %s in '%s'"), key, to_file);
> > +     if (git_config_set_in_file_gently(from_file, key, NULL))
> > +             return error(_("unable to unset %s in '%s'"), key, from_file);
> > +     return 0;
> > +}
>
> Interesting.
>
> The verb "move" in its name made me expect a "get (and remove)
> whatever value(s) defined out of the old file, and set them
> identically in the new file" sequence, but that is not what is done
> here.  "set to this new single value in the new file and unset from
> the old one".
>
> I can see the need to say "move it only when its value is X",
> so having the caller to extract the value before deciding to call
> the function (hence not "moving from old") does make sense, but then
> the function is misnamed---it is not "moving", it is doing something
> else.
>
> > +int init_worktree_config(struct repository *r)
> > +{
> > +     int res = 0;
> > +     int bare = 0;
> > +     struct config_set cs = { { 0 } };
> > +     const char *core_worktree;
> > +     char *common_config_file;
> > +     char *main_worktree_file;
> > +
> > +     /*
> > +      * If the extension is already enabled, then we can skip the
> > +      * upgrade process.
> > +      */
> > +     if (repository_format_worktree_config)
> > +             return 0;
>
> OK.
>
> > +     if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
> > +             return error(_("failed to set extensions.worktreeConfig setting"));
>
> OK.
>
> > +     common_config_file = xstrfmt("%s/config", r->commondir);
> > +     main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> > +
> > +     git_configset_init(&cs);
> > +     git_configset_add_file(&cs, common_config_file);
> > +
> > +     /*
> > +      * If core.bare is true in the common config file, then we need to
> > +      * move it to the main worktree's config file or it will break all
> > +      * worktrees. If it is false, then leave it in place because it
> > +      * _could_ be negating a global core.bare=true.
> > +      */
>
> Is the assumption that the secondary worktrees are never bare, but
> the primary one could be (iow, adding worktrees to a bare repository
> would leave the original bare repository as the primary "worktree"
> that does not have "working tree")?

Yes, and in fact that was the case which generated the original bug
report -- a bare clone where the affected individual started using
`git worktree add` to create some non-primary worktrees (and then also
used sparse-checkout in some of them).

>  I am trying to see what downsides
> it tries to avoid by not moving the core.bare==false setting.  Shouldn't
> core.bare be set to false when "worktree add" creates a new one anyway,
> if the secondaries are never bare?

Moving the core.bare==false setting might make sense.  In the previous
discussions, we tried to hypothesize about usage of old git clients
and non-git clients (jgit, etc.) on the same repos, and didn't know if
some of those would break if they couldn't find a `core.bare` setting
anywhere (since they wouldn't know to look in config.worktree).  We
needed to migrate core.bare=true to avoid an incorrect value affecting
all worktrees (and thus we figured it was worth the risk of breaking
older git/non-git clients because having older clients be broken is
better than having all clients including current git be broken), but
the same wasn't true for core.bare=false.  That said, we don't
actively know of any such clients that would be hurt by such a
migration.
