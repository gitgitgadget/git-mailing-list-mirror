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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9CC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9F3619B2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 12:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCWMlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCWMlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 08:41:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F23C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 05:41:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so23204208edu.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/eWw9yDhslg0sFux6yhTMrLlDqVaclIHuQiDGx6cY8=;
        b=VlU7t0WpGeRx8ihpfo+WyPNM6VA1D5Dzsg+7cmz0NcK+ep7+vBEKn/YOK8uXqimahs
         eALe6F7AoX6ko4GL24aEX6XwJpXBa9TTwigdsL8wAS+jD2DXdToa8Gj5pkj2uG6zKPYT
         fobpsOf9svT/HcljCUtvaB+Vwtk3juTl5djhpHA+OOjTGihzRe+F5dhctXbQXowMaP2R
         r4hWA9LOGmHk5rzbTiebsyGRlegUUo7YK/OnPFoBkz2aIsF6dewy/+a9j1VS7+HnShRS
         B7bexmt7s0lGEdYISxWXiXezT4ROW8h0NKg2wusHC9jY2fuvvOf8D5PAi+Sby7tVnseo
         bxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/eWw9yDhslg0sFux6yhTMrLlDqVaclIHuQiDGx6cY8=;
        b=PfG9hpakIDQAx9xI4IsS2Bj84chGmRTqbTqHHOtV4PqtNBC9NZ3lqW4BgE0ZudMOkl
         SZMFvWpWuSP4Ejg1fuN3ojRJw8u7asNqvpVXP2eFghhN5GeMFQ96HNdmg6QH1kmmtFM7
         pvC620oCsXgohqpshkLA17WokGCERSCmIMOuR4cmGfrefjk1kbqMFK9nrWqd/fwLTQM1
         Ps0WzP5lW3DrGMR+D0DmbgCKnatVyezy3r+DxM4miNpl9Qhf4DhqfbzrJPK+7Zn5kjHR
         eBZGjDG/YnWzPuXhYeFfxFH/ugHGMvFLeJn21z+/xmuDAmyBQHYeHTX7R1Y7ktTjYj2t
         sC4w==
X-Gm-Message-State: AOAM530WFGdm1yzoNOq7L6H8emyYiz9XtkOQjpqou67UNl4FqvH/eGoJ
        /pIZNa1EZ0BZostCblsj1E2+vFy+p9EigIiNU9h61ymxRzUd4g==
X-Google-Smtp-Source: ABdhPJy4c64Yg1oyCanDHAwAgu+oD2Gg7ZyKzYiPVrsyGv4vEoTDm3dAygwvGPn7FBfQYUzXohjD9OgTZQ2CDeHLaB0=
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr4412274edr.387.1616503279396;
 Tue, 23 Mar 2021 05:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
 <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
 <xmqqv99i4ck2.fsf@gitster.g> <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
In-Reply-To: <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Mar 2021 13:41:08 +0100
Message-ID: <CAP8UFD2v=q45u_jttHmff_1=rBCANmam_-HbNE5Fg=SnhZ_3Hg@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 11:35 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:19=E5=86=99=E9=81=93=EF=BC=9A

> Maybe like this?

Yeah, it's a good idea to work on this, but please make it an
independent patch unrelated to adding --trailer to `git commit`.

Also the documentation might need a bit of tweeking to tell that ARG
is now an exported environment variable.

> -#define TRAILER_ARG_STRING "$ARG"

It might still be better to use a #define or a const char [] to avoid
hard coding "ARG" below.

> static const char *git_generated_prefixes[] =3D {
>        "Signed-off-by: ",
>        "(cherry picked from commit ",
> @@ -222,13 +220,17 @@ static char *apply_command(const char *command,
> const char *arg)
>        struct strbuf buf =3D STRBUF_INIT;
>        struct child_process cp =3D CHILD_PROCESS_INIT;
>        char *result;
> +       const char *const *var;
>
>        strbuf_addstr(&cmd, command);
> -       if (arg)
> -               strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> +       for (var =3D local_repo_env; *var; var++)
> +               strvec_push(&cp.env_array, *var);
> +       if (arg) {
> +               strvec_pushf(&cp.env_array, "ARG=3D%s", arg);
> +       }

You can drop the "{" and "}" above.

>        strvec_push(&cp.args, cmd.buf);
> -       cp.env =3D local_repo_env;
> +
>        cp.no_stdin =3D 1;
>        cp.use_shell =3D 1;

Thanks!
