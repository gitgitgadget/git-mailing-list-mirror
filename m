Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F0C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhK2UpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhK2UnE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:43:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F596C0C084B
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:18:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so74938888eda.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p5QBeOZn5OZT8HYQeLS0iRbd2Nl1fm80PMZJZww8JXs=;
        b=NEybGKQlFJNCs7CaAEmsJ6byVvw6YIKqACzRTrtd+09IyaL0KGanAXMijs5F9Vp17a
         ixXO+a/b0jN9r2J05SeCBCaSZJfakKMEBuoO/6xjrLrqb34T8YWr9Rphvri1uerUsf43
         yDcidA1BpH+4EJVKjtUSNwjNw76JXY80vQ3CDMoAvzsbH1I2hE+1QCk92V1rUu9OohTz
         yAUjRBLndtPuKUh2wNxF/2sPy6Bgd+kgrC9JIkdjXrTvnVvu4rGc7Rd6rfvCIKY5k1Vz
         JX6cx58Lk5ioWI+DLD3lpsGeDSIywPqVaW1A+fS5Gdz+EPPx7XA6qvyPYtqsU+KdMcWG
         eGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p5QBeOZn5OZT8HYQeLS0iRbd2Nl1fm80PMZJZww8JXs=;
        b=Zf+bASq8T97p+BRTjhI/3uJBPS12AxP6Vdu7DsA92KpdNq5EOYByl9uRFI3kmikkcp
         Ul6mV95A2ylH+zv0luXQ6Y691YYFysyIeZh6VQRV/oFEoC63tbz9q0m0uT7sjSLZD/VK
         84wAEdhku6BQVYx/azO+qg4138S+mejsWr21Os0RrO5PPCFJJ4bfF6K8AZ6tgAfUG+Qx
         6kGoDUhC0aj8v1HS8NcHSADSqk8Tv9UR4IdoUSdZqXm9q7dO9ZitJW0ZNGSeJM2dQnhH
         vbLQfWWqEGQfbby9jdsFJxwoeLNKymMTgwVxZ1X3gvXj1nGrfQAllVrzMDte+vSkbZTd
         ybQw==
X-Gm-Message-State: AOAM530zrRkeyInGU6/NI4aUULlc6TRyuSzHsjw31MIpFXHGgmdSTL3S
        wJQ/A9G6a3Cn+z/cEIHIdoxD9tw3Zjgt4JsrcEU=
X-Google-Smtp-Source: ABdhPJxO6S8lqEYVKt6uZ3BmZ89bpl7NbXaUmXoO4kRg7Wi1UhouwOMlNL/2+1Nkf3yNGC/O8CWTZRLx7yiEth0KaTk=
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr61288715ejy.443.1638206323044;
 Mon, 29 Nov 2021 09:18:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
 <48fced3c-1fcb-d5cd-cec0-b9e58be40259@gmail.com>
In-Reply-To: <48fced3c-1fcb-d5cd-cec0-b9e58be40259@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 09:18:31 -0800
Message-ID: <CABPp-BHStJ2x53cffJPb7miaxL2cKr0usgK13HxNDyYMQv11_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
To:     Derrick Stolee <stolee@gmail.com>
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

On Mon, Nov 29, 2021 at 6:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/25/2021 3:39 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> > @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
> >
> >       trace_command_performance(argv);
> >
> > +     startup_info->original_cwd =3D xgetcwd();
> > +
>
> I see this initial assignment in cmd_main()...

It looks like you accidentally responded to v2 when there's a v3
(something I occasionally do too).  v3 changes this to put it in
common-main instead of here, as suggested by =C3=86var, but to answer the
question...

> > +static void setup_original_cwd(void)
> > +{
> > +     struct strbuf tmp =3D STRBUF_INIT;
> > +     const char *worktree =3D NULL;
> > +     int offset =3D -1;
> > +
> > +     /*
> > +      * startup_info->original_cwd wass set early on in cmd_main(), un=
less
> > +      * we're an auxiliary tool like git-remote-http or test-tool.
> > +      */
> > +     if (!startup_info->original_cwd)
> > +             return;
>
> ...which is assumed to be run before this method was called...
>
> > @@ -1330,6 +1378,7 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
> >               setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
> >       }
> >
> > +     setup_original_cwd();
>
> ...here in setup_git_directory_gently().
>
> Why do we need that assignment in cmd_main()? Could we instead
> let setup_original_cwd() do the initial assignment? Or is it
> possible that a chdir has happened already before this point?

In v1, I made that mistake.  Then I realized that when users pass the
-C option to git, there is a chdir() call immediately upon parsing of
the -C option.  So I had to move the strbuf_getcwd() call earlier.
