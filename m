Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCDC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhKZSZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbhKZSXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 13:23:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453DC0613E1
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:01:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so42282901edd.0
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57rBfhaQ6yFEqysVz049sXi5w3gKFx1jo7JP6DP2yg0=;
        b=ZggL8cQhdt4DQqzaRWYH9ol7jwMo26qG7sKq1mhnXM94Uwep92MSztkZqYTXuy+9A6
         Qk8ZCEKwLM8N86IsUVccrjk9gNixAPYWyat/5gQl6T5AgPaNGPVBC+46qFWf9mwAxyEZ
         9X8GI9v0Qhng2GSYiF7u7eYcHdG6gI1/9KFMT4Z0b8CJ+gcSK/tMYod3CB7Gc2N13j+s
         2OdssmEcY9v5UmEwFKiDrrjnhTcqMh3g9BGY4qztV9ScU9qu8CSPzJuSfk90twCTH1Jh
         2kcXCkOVlS3+bjdwCrFqJgsdT+B8/GiwSns6mpdUG4e3zI4dRbHeHX5Kg7impdxRkNXe
         ymhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57rBfhaQ6yFEqysVz049sXi5w3gKFx1jo7JP6DP2yg0=;
        b=ojWmpusrVVGZErqyO3bMujj8ZZJ3/L3cJOnAuTbnjLgDZOHY7wp3VJkkJlaj1DuKpW
         qRH4EASFwJCCJeV9Tlni2xK4cdiATz4mpLj6ITvt/yFNGEHy7WImjS2Etfzkg8ddg7q4
         Bameiamq7HbD7VTfH971OTLfPvAFH1MGQRprr5wtmdr+95jQj4mI3Vy5tkf0ROps+qEu
         +ZP+VHp/DTybB96803pCNQcaGmQJRfUmA2jKgIX+TOfTVzb3SRtiPLok2HRWbzS64VNM
         CS2iQyNKG7CeyZxWFq13QEIVQy0ZWeZ8QgKxunz6JDVYLYBa/T4E80UJBkLoo5V6Ro/E
         /1lw==
X-Gm-Message-State: AOAM530XYdeDuj27FChSMk44U3WZDld5rF4+6QUmqYIjn/Voj/lGg/e9
        MBpPMX4pJEn8lWifTVxj3iqbV9DhhVII5vteWj4=
X-Google-Smtp-Source: ABdhPJzbyCdJJVwrBCJZPkn4+8HbuDDBtWZ9wJpagLjrLJSmQJUV7EBMuDNJlXH+/7XfYZB12gYEcB468RQQMMfoKuY=
X-Received: by 2002:aa7:d048:: with SMTP id n8mr48069810edo.333.1637949713162;
 Fri, 26 Nov 2021 10:01:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
 <xmqqo8678l3x.fsf@gitster.g>
In-Reply-To: <xmqqo8678l3x.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 10:01:41 -0800
Message-ID: <CABPp-BG8narMYNeaBHQfhcOFJ4hHJM+HGoy7S4hyOA-7PbOEPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/git.c b/git.c
> > index 5ff21be21f3..2c98ab48936 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
> >
> >       trace_command_performance(argv);
> >
> > +     startup_info->original_cwd =3D xgetcwd();
>
> We assume that, unless we are an auxiliary tool like git-remote-http,
> we should always have cwd?

Yeah, =C3=86var caught this mistake too; I should have used
strbuf_getcwd().  Will fix.

> > diff --git a/setup.c b/setup.c
> > index 347d7181ae9..f30657723ea 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -432,6 +432,54 @@ void setup_work_tree(void)
> >       initialized =3D 1;
> >  }
> >
> > +static void setup_original_cwd(void)
> > +{
> > +     struct strbuf tmp =3D STRBUF_INIT;
> > +     const char *worktree =3D NULL;
> > +     int offset =3D -1;
> > +
> > +     /*
> > +      * startup_info->original_cwd wass set early on in cmd_main(), un=
less
>
> s/wass/was/;

Thanks.

> > +      * we're an auxiliary tool like git-remote-http or test-tool.
> > +      */
> > +     if (!startup_info->original_cwd)
> > +             return;
> > +
> > +     /*
> > +      * startup_info->original_cwd points to the current working
> > +      * directory we inherited from our parent process, which is a
> > +      * directory we want to avoid incidentally removing.
> > +      *
> > +      * For convience, we would like to have the path relative to the
> > +      * worktree instead of an absolute path.
> > +      *
> > +      * Yes, startup_info->original_cwd is usually the same as 'prefix=
',
> > +      * but differs in two ways:
> > +      *   - prefix has a trailing '/'
> > +      *   - if the user passes '-C' to git, that modifies the prefix b=
ut
> > +      *     not startup_info->original_cwd.
> > +      */
> > +
> > +     /* Normalize the directory */
> > +     strbuf_realpath(&tmp, startup_info->original_cwd, 1);
> > +     free((char*)startup_info->original_cwd);
> > +     startup_info->original_cwd =3D strbuf_detach(&tmp, NULL);
> > +
> > +     /* Find out if this is in the worktree */
> > +     worktree =3D get_git_work_tree();
> > +     if (worktree)
> > +             offset =3D dir_inside_of(startup_info->original_cwd, work=
tree);
> > +     if (offset >=3D 0) {
> > +             /*
> > +              * original_cwd was inside worktree; precompose it just a=
s
> > +              * we do prefix so that built up paths will match
> > +              */
> > +             startup_info->original_cwd =3D \
> > +                     precompose_string_if_needed(startup_info->origina=
l_cwd
> > +                                                 + offset);
> > +     }
>
> I wonder if we want to clear the .original_cwd member, so that the
> "cwd protection" do not have to worry about anything at all when we
> are in a bare repository.

Yeah, I wondered about this a bit and whether it'd even matter either
way if the original_cwd was something outside the working tree.  I can
obviously come up with scenarios, but can't see protecting or not
protecting such directories as mattering; if the user is in a
directory where git internals are stored and deleted, well, they're
already off-roading.

But, since you bring it up, I might as well scope this to just
protecting a directory within the working tree.  Perhaps that'd make
=C3=86var more comfortable with the change too.  I'll do that.
