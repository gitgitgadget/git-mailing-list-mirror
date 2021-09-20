Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC1C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13CD61242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347639AbhIUCV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhIUBrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:47:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14BC061340
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:27:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c21so65978268edj.0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NVM9PhXGa1/AONmv4ZX1ZXQ4cUDjyT+wUbCXnEVd268=;
        b=qxtsj+Stcd6Zep3A5ZJM5+RxnKeZjx6wdgkO5As5NOxg4A/Gd5q98tsreEihklM/1N
         lQYO8mHoK89XpGEJIl+V8Slc+XZIFBwbArp9pwKsBcVC0U/uWSv5uoEI4+BCvKs3SkLr
         bctzv8/07xkNBEz29IQChU9l4UzrFfuF2sVi3OuljWRQIR//v/4zgwuqIlT5AFtXpcPW
         ovpQa+HImH7SLURztyFBpK2YC7A+f5VPB6tzSpCkYqf7S9QJN5LRtAeXRDw5mJr99oE0
         vSe0DjLzmCiFZCX+nJH/0eojPouBpKC2xqoAVXPz8YwJQMUCYrIByRkYYjmhwno7rMQj
         VLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVM9PhXGa1/AONmv4ZX1ZXQ4cUDjyT+wUbCXnEVd268=;
        b=2EZfwZFPZWp6U9+i+kvVlbCYGSw7SIZ7A8Sr60RwmcTfBe7r0UEuqmUOXHGP+CKWcS
         zGfhhCZR3PaCk/u+TwLd8a3YT/2XrUHNFHolU5owDHysRSnnetUsgBj9qexezv9Z8Zlf
         rTH/NTGf4AV5oAlY/X6KcQoeC/nrmhTeucKZC9nICH3Zn5jFbJ8Kqu+BgGCmZO4Bj9V9
         5WpTBaQY78I4r220wrfY0zVYuNTcUHV8usehomxdMOgX0zCUX8kB84iogSCHHG4KrbgV
         dpwHhTj4JdvSeZWAQNqfWlSrHdsI1gGABdVwHdts76dFBXwqc95+RwHpS5Wr8rmlVJ7Z
         IT2w==
X-Gm-Message-State: AOAM531r0KDQgdRR6whNm80R9XGB1mYhSHgFFOZ6gBjTws8r3XB6GyWM
        RoEbcc0+mwyWE4DoEBo3g9hdQhsUafuHvmwylV8=
X-Google-Smtp-Source: ABdhPJxjvE7TLv8zYL6oi6ERvBwFzujityNHipgveDBIHgDfXbzxm0OAMcvM+P/La7z95BV0EWJ4oh7bbv1taLaGIqk=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr31826226ejd.241.1632173232010;
 Mon, 20 Sep 2021 14:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121627.905359-1-bagasdotme@gmail.com>
In-Reply-To: <20210920121627.905359-1-bagasdotme@gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Mon, 20 Sep 2021 14:26:35 -0700
Message-ID: <CAJDDKr4LfTC8h00NCLSu5J=oBTX3LWshrOXMQ7_iBi4RNie9sA@mail.gmail.com>
Subject: Re: [PATCH RESEND] difftool: word spacing fix
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 5:19 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Two grammar fixes related to word spacing:
>
>   - delete space in `non - zero`
>   - add space between diff formats/mode and option parentheses

The changes look like a good start, thanks.

Commit messages are written in an imperative tone, so this commit
message could be touched up.

Maybe?
---
difftool: fix word spacing in the usage strings

Remove spaces in `non - zero` and add a space between the diff
format/mode and option parentheses in difftool's usage strings.
---

But!.. and this is a big but... the po/ translations would be broken
by this change.

I'm unfamiliar with the policy about changes that affect translations,
but in general this seems like a situation where we can make things
easier for the translation team by not leaving behind further work.

My gut feeling is that this patch would be easier to accept if it also
updated the po/ translations to fix these typofixes.

Question for this list -- would that be a separate patch or not? To me
it seems like it'd all be one patch so that git is never in an
in-between state.

The following commands show a few places of interest that should also
be updated.

$ git grep 'combined diff formats('
$ git grep 'tool returns a non - zero'


>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Cc: David Aguilar <davvid@gmail.com>
> Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  builtin/difftool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 6a9242a803..ad9187761e 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -410,9 +410,9 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>                 const char *src_path, *dst_path;
>
>                 if (starts_with(info.buf, "::"))
> -                       die(N_("combined diff formats('-c' and '--cc') ar=
e "
> +                       die(N_("combined diff formats ('-c' and '--cc') a=
re "
>                                "not supported in\n"
> -                              "directory diff mode('-d' and '--dir-diff'=
)."));
> +                              "directory diff mode ('-d' and '--dir-diff=
')."));
>
>                 if (parse_index_info(info.buf, &lmode, &rmode, &loid, &ro=
id,
>                                      &status))
> @@ -713,7 +713,7 @@ int cmd_difftool(int argc, const char **argv, const c=
har *prefix)
>                             "`--tool`")),
>                 OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
>                          N_("make 'git-difftool' exit when an invoked dif=
f "
> -                           "tool returns a non - zero exit code")),
> +                           "tool returns a non-zero exit code")),
>                 OPT_STRING('x', "extcmd", &extcmd, N_("command"),
>                            N_("specify a custom command for viewing diffs=
")),
>                 OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`"=
)),
>
> base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
> --
> 2.25.1
>


--
David
