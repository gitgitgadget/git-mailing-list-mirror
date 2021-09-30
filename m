Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9974C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC204617E6
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347715AbhI3RHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbhI3RHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:07:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D057C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:05:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bd28so24686461edb.9
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mhRUaNkr3FrP5iI3KabDgK8nL64lLx9H/jIPrZmUE8Q=;
        b=BfcVyRiyfveL/iN6HBT7g4Yp4uwnxqC2g3alwRiAflvUeD3pHhVEFSq1hlXsukf95L
         fmeoOibG0MsYWMGsudZGpPrNlu8UlVFW64UFrWpV+juUIP4LLAmlRjwgNBeOW9QmrKZz
         Epg0I46Chlq//4V0Ubwf11qzB3jS+N5cz+Eih0oWp91U0xFMSM8S9Ttw6SH2Rozn4XrH
         84J/ufFRQuXxKZgnFhHEiIER4A52/K0LLbTMQe59X7YcuO4Qg8zSX7f5gWCTu0lPWFtq
         UTznKvhQzyQFiERvHKfmzOBb8YM+w0rwbFg9IYG8VewWU+7sDZu7p/7wTNmviJpU1beu
         kLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mhRUaNkr3FrP5iI3KabDgK8nL64lLx9H/jIPrZmUE8Q=;
        b=nKYnw6rUlm0YJ8vxdyJQS114V8aphEb60X5Vso2C9qIcU/bUGTsquiYSJ79KwIx4FZ
         Uyd2SlSnT0xb3cr9A7Ah9VYc7iiviOXEAPz1GH60KLcF/M17ZiZyc332OxG8HvKhHQN3
         bFFcfgbm0ewm/0UvTiTbrR6EBdiAI+VP5e0IUdWibL6H1K+4BM+aGeeCLovgOIpL21vD
         fCxpW+o8FT31E2xaUpMUHimaUOmdFSeaZociAjHNcjPJmogMQANWw0FCfI3Zb1Ce4M7y
         8d4eWceQxdarjq7mbtIRbwubsNB2xNYtJUtJuZkV4abjR8sxdwP7rg/anYibXj2ss5+B
         vwEA==
X-Gm-Message-State: AOAM532+UQpnDcCJHABIG2WwEXSUof3Xu1WGtX2aTYBlFRJKqA1bYkwT
        r+4ucUOcSSxe4Bxb8GObQvsMo8MtlfCjzC4ho20=
X-Google-Smtp-Source: ABdhPJzWgSQTjkcNZT3xiec5qlcNGhFL1vv14lVOUUWEdlCslfLR/f6ZD7tozLJ8Cr5NXwyTgX9bphnjbjsuTFmioBI=
X-Received: by 2002:a05:6402:1503:: with SMTP id f3mr8502327edw.24.1633021548182;
 Thu, 30 Sep 2021 10:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210923041252.52596-1-davvid@gmail.com> <20210923041252.52596-3-davvid@gmail.com>
 <871r5e45jw.fsf@evledraar.gmail.com>
In-Reply-To: <871r5e45jw.fsf@evledraar.gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 30 Sep 2021 10:05:12 -0700
Message-ID: <CAJDDKr6MqDhGXcPzCW8f96C3XEAp8w+imc9Jzrw+sUEasqXeng@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] difftool: create a tmpdir path without repeated slashes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 3:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Sep 22 2021, David Aguilar wrote:
>
> > @@ -580,7 +574,7 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
> >               flags =3D 0;
> >       } else
> >               setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
> > -     rc =3D run_command_v_opt(helper_argv, flags);
> > +     ret =3D run_command_v_opt(helper_argv, flags);
> >
> >       /* TODO: audit for interaction with sparse-index. */
> >       ensure_full_index(&wtindex);
>
> Just on this part: There was already a logic error in the pre-image
> where we'd return error() return values up to cmd_main() et al. This
> means that (on POSIX) we return 255, not 1, per the C standard doing
> this is "implementation defined".
>
> I think you want the "rc" variable back, and either in another commit or
> in some other cleanup this on top or ahead of this patch:

Good catch. I submitted an incremental follow-up patch that addresses
this issue.


> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index a867c49067c..6605d17e6bc 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -345,6 +345,7 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>         const char *helper_argv[] =3D { "difftool--helper", NULL, NULL, N=
ULL };
>         struct hashmap wt_modified, tmp_modified;
>         int indices_loaded =3D 0;
> +       int rc;
>
>         workdir =3D get_git_work_tree();
>
> @@ -574,7 +575,7 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>                 flags =3D 0;
>         } else
>                 setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
> -       ret =3D run_command_v_opt(helper_argv, flags);
> +       rc =3D run_command_v_opt(helper_argv, flags);
>
>         /* TODO: audit for interaction with sparse-index. */
>         ensure_full_index(&wtindex);
> @@ -660,7 +661,7 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>         strbuf_release(&tmpdir);
>         UNLEAK(working_tree_dups);
>
> -       return ret;
> +       return ret < 0 ? 1 : rc;
>  }


"return ret < 0 ? 1 : rc;" seems rather subtle.

In the submitted patch we're able to keep this as "return ret;" by
never assigning -1 in the first place.

My rationale is that it's better to not have to apply this fixup after the =
fact.

Thanks for reviewing.
--
David
