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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3007C433E6
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B90F64F69
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhCSH4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhCSH4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 03:56:43 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1466C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 00:56:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id a8so3870071oic.11
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WNN+NemvL4NhupPjcLfJVFtJwQ7r0JxtzPovrnr8vIs=;
        b=kURUkAf+MLWuaThbmSv6t1eNn3d37Yw0HCQ7uws/r6S2Jr2SbgGYSYoKjYppIJXeIc
         xHuD0BaW9JaKm50CsGgITaKrtEOFSsGUFnyGSemsAO1A9zqS4fV3Rys0QcZEbJAn6EOo
         J5oXrPJgHk+h3Ycet4oZSY+OFiReJZCy43no5EOJqS4ScVJKYpYQkZCqDJspWuhJwN7q
         mAPWQAF5iZ2HFa8uFb8ZF8rI61chtudGK9jtASlBM63eakc7SMchr7l9HavTNGWr4ezG
         ZH71wp0hYpLAXZr1MONaSqaBw3ia9tTuIG8BKZ/L6BsijWE3G3fyAi8t9sTFd3bTKxlt
         hnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WNN+NemvL4NhupPjcLfJVFtJwQ7r0JxtzPovrnr8vIs=;
        b=mOPYi2zSG8uCVKIIocVAEznqCAbN6QtW+Eku9I7u1qyyciBJk1N1SK7YyV1PCCS7QX
         Y+hDAego0yUC6EGJZxCiFQ+NV33QELlYCO3IBA952sr+ueA9idF2/+sa0FJkThAziHXS
         FnynQX1sUIy4j2l6kki2ixtb2VmriIPvEnhynNZRP2VLz192ue0FXRACXPKy7Bdch/3q
         kV2BTHlcE1XBHB5QqrD4NxKHyfZBgoZzoLfsBYjsEGt+xBDbzmk3blyNsNdz0ZjF/KHR
         FxX6I8ThDpXOFqJgpv1PEzw772LmixEJzbSar3TM3d7995gVh5c2YygYtz2iLKkgOxH4
         TglA==
X-Gm-Message-State: AOAM532DIAzvIkLDD1Izg5Hilm6WfugcBm9vphwMWFuKXtfOLGvx7Jbq
        h/XEyGtO9EL7xE9EE5b3LCpYhJOpQdAXa6Y2rCA=
X-Google-Smtp-Source: ABdhPJz23iymVjEewanhIxdyRRfb4Aj2O9Rxw6k/ZrB23i9s5877SFoWHr0hbqeEjYgRn+qu6O2bMISnHb0cGH/WA9M=
X-Received: by 2002:aca:af10:: with SMTP id y16mr71630oie.120.1616140603206;
 Fri, 19 Mar 2021 00:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <949faf9ee56a3146a643ba634771779efa89bbc5.1616066156.git.gitgitgadget@gmail.com>
 <YFOAAQmVqUVOpLK1@danh.dev>
In-Reply-To: <YFOAAQmVqUVOpLK1@danh.dev>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 19 Mar 2021 15:56:31 +0800
Message-ID: <CAOLTT8TQJPBRyjsuZ6sMBESfkpOT9moCbkOjdtPs7sDQJ-kd+A@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] [GSOC] commit: add --trailer option
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> =E4=BA=8E=
2021=E5=B9=B43=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:2=
9=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2021-03-18 11:15:54+0000, ZheNing Hu via GitGitGadget <gitgitgadget@gm=
ail.com> wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Historically, Git has supported the 'Signed-off-by' commit trailer
> > using the '--signoff' and the '-s' option from the command line.
> > But users may need to provide other trailer information from the
> > command line such as "Helped-by", "Reported-by", "Mentored-by",
> >
> > Now implement a new `--trailer <token>[(=3D|:)<value>]` option to pass
> > other trailers to `interpret-trailers` and insert them into commit
> > messages.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  Documentation/git-commit.txt |  10 +-
> >  builtin/commit.c             |  23 +++
> >  t/t7502-commit-porcelain.sh  | 336 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 368 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
> > index 17150fa7eabe..c5de981cd40d 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -14,7 +14,7 @@ SYNOPSIS
> >          [--allow-empty-message] [--no-verify] [-e] [--author=3D<author=
>]
> >          [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
> >          [-i | -o] [--pathspec-from-file=3D<file> [--pathspec-file-nul]=
]
> > -        [-S[<keyid>]] [--] [<pathspec>...]
> > +        [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=3D|:)=
<value>])...]
>
> Please move all options before non-option arguments.
> In other words, please move --trailer before [--].
>
> This form implies that there are no way to specify pathspec "--trailer"

Thanks, I didn't pay attention to this little detail before.

>
> >
> >  DESCRIPTION
> >  -----------
> > @@ -166,6 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `=
-C`, and `-F`.
> >
> >  include::signoff-option.txt[]
> >
> > +--trailer <token>[(=3D|:)<value>]::
> > +     Specify a (<token>, <value>) pair that should be applied as a
> > +     trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
> > +     <committer@example.com>" --trailer "Helped-by:C O Mitter \
> > +     <committer@example.com>"` will add the "Signed-off-by" trailer
> > +     and the "Helped-by" trailer in the commit message.)
> > +     Use `git -c trailer.* commit --trailer` to make the appropriate
> > +     configuration. See linkgit:git-interpret-trailers[1] for details.
> >  -n::
> >  --no-verify::
> >       This option bypasses the pre-commit and commit-msg hooks.
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 739110c5a7f6..7a79aae48f43 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -113,6 +113,7 @@ static int config_commit_verbose =3D -1; /* unspeci=
fied */
> >  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
> >  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, =
*ignored_arg;
> >  static char *sign_commit, *pathspec_from_file;
> > +static struct strvec trailer_args =3D STRVEC_INIT;
> >
> >  /*
> >   * The default commit message cleanup mode will remove the lines
> > @@ -131,6 +132,14 @@ static struct strbuf message =3D STRBUF_INIT;
> >
> >  static enum wt_status_format status_format =3D STATUS_FORMAT_UNSPECIFI=
ED;
> >
> > +static int opt_pass_trailer(const struct option *opt, const char *arg,=
 int unset)
> > +{
> > +     BUG_ON_OPT_NEG(unset);
> > +
> > +     strvec_pushl(&trailer_args, "--trailer", arg, NULL);
> > +     return 0;
> > +}
> > +
> >  static int opt_parse_porcelain(const struct option *opt, const char *a=
rg, int unset)
> >  {
> >       enum wt_status_format *value =3D (enum wt_status_format *)opt->va=
lue;
> > @@ -958,6 +967,19 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
> >
> >       fclose(s->fp);
> >
> > +     if (trailer_args.nr) {
> > +             struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> > +
> > +             strvec_pushl(&run_trailer.args, "interpret-trailers",
> > +                          "--in-place", git_path_commit_editmsg(), NUL=
L);
> > +             strvec_pushv(&run_trailer.args, trailer_args.v);
> > +             run_trailer.git_cmd =3D 1;
> > +             if (run_command(&run_trailer)) {
> > +                     die(_("unable to pass tailers to --trailers"));
>
> s/tailers/trailers/ perhap?
> Also we usually not put {} around single statement.
>

OK.

> > +             }
> > +             strvec_clear(&trailer_args);
> > +     }
> > +
> >       /*
> >        * Reject an attempt to record a non-merge empty commit without
> >        * explicit --allow-empty. In the cherry-pick case, it may be
> > @@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> >               OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("=
use autosquash formatted message to fixup specified commit")),
> >               OPT_STRING(0, "squash", &squash_message, N_("commit"), N_=
("use autosquash formatted message to squash specified commit")),
> >               OPT_BOOL(0, "reset-author", &renew_authorship, N_("the co=
mmit is authored by me now (used with -C/-c/--amend)")),
> > +             OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add=
 custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
> >               OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-b=
y trailer")),
> >               OPT_FILENAME('t', "template", &template_file, N_("use spe=
cified template file")),
> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commi=
t")),
> > diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> > index 6396897cc818..6df71fa00bcb 100755
> > --- a/t/t7502-commit-porcelain.sh
> > +++ b/t/t7502-commit-porcelain.sh
> > @@ -154,6 +154,342 @@ test_expect_success 'sign off' '
> >
> >  '
> >
> > +test_expect_success 'commit --trailer without -c' '
> > +     echo "fun" >>file &&
> > +     git add file &&
> > +     cat >expected <<-\EOF &&
> > +
> > +     Signed-off-by: C O Mitter <committer@example.com>
> > +     Signed-off-by: C1 E1
> > +     Helped-by: C2 E2
> > +     Reported-by: C3 E3
> > +     Mentored-by: C4 E4
> > +     EOF
> > +     git commit -s --trailer "Signed-off-by:C1 E1 " \
> > +             --trailer "Helped-by:C2 E2 " \
> > +             --trailer "Reported-by:C3 E3" \
> > +             --trailer "Mentored-by:C4 E4" \
> > +             -m "hello" &&
>
> It's documented that we're supporting --trailer <token>[(=3D|:)<value>]
> However, only --trailer <token>:<value> is tested.
> I think it's better to have
>
>         --trailer "Helped-by=3DC2 E2" --trailer "Reported-by"
>

In fact, I want to test in `test_expect_success'commit --trailer with
-c and "=3D" as separators'`,
but some changes are needed.

>
> --
> Danh

--=20
ZheNing Hu
