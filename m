Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFFA49
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn/ne3mB"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D180FA
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:45:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so69869421fa.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 18:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699325133; x=1699929933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iI45n3vAnK+//Sr2+4sA6niO73LtR5gJ5P7gOkZ6u0Q=;
        b=Gn/ne3mBjhL5yflkqQTJsX+sjtih4aMccN/OtRjpSx/lLME5j6RsB9CFt8efMUvOef
         5tKL4SqMfdGxgWXTy32lKOTefsJT7iDFBAL2SAAE2EXFwuz1LSHT5JpIW5MZgbAgl7iR
         vuTxYQ3yYyZWupIx8cr+NQgrbFQjAR2orcgyEITvpNC3KnmzKB7Vpd1wK4AGyOjPlS56
         DH5J8mZzFU4jo24hM6pOnxw7Z6/sgQHAhkx5eC63Q5xHLilrqeQZZHAY8g7bSoRlA6Pp
         ZK6cwuxJzIpuiOiVA+aMOnvED/1fkBCSzyUT1elrISd+jzga6tZQblD8xBlv3TF6c+Ce
         KHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699325133; x=1699929933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI45n3vAnK+//Sr2+4sA6niO73LtR5gJ5P7gOkZ6u0Q=;
        b=bT6eUjBLNgYcJ75ybBVDx0k6PKy9hCr2ePZXe0yWKGim+SLPl3VotCNrCMAuYQw1YO
         Dx4+3DzKjTPzm8BSi8i253HyUzaiKIPBS39+RBN+807NWvwApK9dsOWSodo3oQ1LZGyc
         e88slXZzfN4OlJKgvPF9nZpOeRKj42ZYatcB3Z/4S756X62kPXTWj8yr/AfLudOaSjr2
         AnJmUgJuZDsqlE51pCjBxTDRwJayOfK88pftDXOkDrx68ZT6RdESMoiUPYijhYtZd2fg
         6pTG5Zl4i/TWf59yR7ub7JgKeiTSjRizVEOGGHgVmLXuaZjtB3Ki2XxqCQolCxPnFdd5
         ZQJQ==
X-Gm-Message-State: AOJu0YzV/Td2MGWTfm50+IM/R9rV3I7aQehFtqq92tfvx/tIc8RtJNGm
	V3UEh64jePzBsAEsAGcLS3t3C5v5L9nntPvFrEs=
X-Google-Smtp-Source: AGHT+IHsTxHzQDDddW0PSQPmvJmxvweJC/Lv9homiIk0oBgN0GwvMD301HtXv5Q++39HqAoSAU1oe+tC9NKikkbnJLE=
X-Received: by 2002:ac2:4d81:0:b0:503:388f:30a3 with SMTP id
 g1-20020ac24d81000000b00503388f30a3mr23450109lfe.26.1699325132543; Mon, 06
 Nov 2023 18:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
In-Reply-To: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 6 Nov 2023 18:45:20 -0800
Message-ID: <CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
To: Sam James via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 3, 2023 at 4:25=E2=80=AFAM Sam James via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Sam James <sam@gentoo.org>
>
> This patch adds a config value for 'diff.renames' called 'copies-harder'
> which make it so '-C -C' is in effect always passed for 'git log -p',
> 'git diff', etc.
>
> This allows specifying that 'git log -p', 'git diff', etc should always a=
ct
> as if '-C --find-copies-harder' was passed.
>
> I've found this especially useful for certain types of repository (like
> Gentoo's ebuild repositories) because files are often copies of a previou=
s
> version.

These must be very small repositories?  --find-copies-harder is really
expensive...

But, if you are willing to pay the price, the idea of making this a
configuration item makes sense.

> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>     diff: implement config.diff.renames=3Dcopies-harder
>
>     This patch adds a config value for 'diff.renames' called 'copies-hard=
er'
>     which make it so '-C -C' is in effect always passed for 'git log -p',
>     'git diff', etc.
>
>     This allows specifying that 'git log -p', 'git diff', etc should alwa=
ys
>     act as if '-C --find-copies-harder' was passed.
>
>     I've found this especially useful for certain types of repository (li=
ke
>     Gentoo's ebuild repositories) because files are often copies of a
>     previous version.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1606%2F=
thesamesam%2Fconfig-copies-harder-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1606/thesa=
mesam/config-copies-harder-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1606
>
>  Documentation/config/diff.txt   |  3 ++-
>  Documentation/config/status.txt |  3 ++-
>  diff.c                          | 12 +++++++++---
>  diff.h                          |  1 +
>  diffcore-rename.c               |  4 ++--
>  merge-ort.c                     |  2 +-
>  merge-recursive.c               |  2 +-
>  7 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.tx=
t
> index bd5ae0c3378..d2ff3c62d41 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -131,7 +131,8 @@ diff.renames::
>         Whether and how Git detects renames.  If set to "false",
>         rename detection is disabled. If set to "true", basic rename
>         detection is enabled.  If set to "copies" or "copy", Git will
> -       detect copies, as well.  Defaults to true.  Note that this
> +       detect copies, as well.  If set to "copies-harder", Git will try =
harder
> +       to detect copies.  Defaults to true.  Note that this

"try harder to detect copies" feels like an unhelpful explanation.  I
understand that a lengthy explanation (like the one found under the
`--find-copies-harder` option in git-diff) may not be wanted here
since we are trying to describe things succinctly, but could we at
least reference the `--find-copies-harder` option so that people know
where to go to get a more detailed explanation?

>         affects only 'git diff' Porcelain like linkgit:git-diff[1] and
>         linkgit:git-log[1], and not lower level commands such as
>         linkgit:git-diff-files[1].
> diff --git a/Documentation/config/status.txt b/Documentation/config/statu=
s.txt
> index 2ff8237f8fc..7ca7a4becd7 100644
> --- a/Documentation/config/status.txt
> +++ b/Documentation/config/status.txt
> @@ -33,7 +33,8 @@ status.renames::
>         Whether and how Git detects renames in linkgit:git-status[1] and
>         linkgit:git-commit[1] .  If set to "false", rename detection is
>         disabled. If set to "true", basic rename detection is enabled.
> -       If set to "copies" or "copy", Git will detect copies, as well.
> +       If set to "copies" or "copy", Git will detect copies, as well.  I=
f
> +       set to "copies-harder", Git will try harder to detect copies.

Same here.

>         Defaults to the value of diff.renames.
>
>  status.showStash::
> diff --git a/diff.c b/diff.c
> index 2c602df10a3..0ca906611f5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -206,8 +206,11 @@ int git_config_rename(const char *var, const char *v=
alue)
>  {
>         if (!value)
>                 return DIFF_DETECT_RENAME;
> +       if (!strcasecmp(value, "copies-harder"))
> +               return DIFF_DETECT_COPY_HARDER;
>         if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
> -               return  DIFF_DETECT_COPY;
> +               return DIFF_DETECT_COPY;
> +

As per CodingGuidelines:
"""
 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.
"""
So, the fixing of extra space and the extra blank line should be
placed in a separate patch.

>         return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>
> @@ -4832,8 +4835,11 @@ void diff_setup_done(struct diff_options *options)
>         else
>                 options->flags.diff_from_contents =3D 0;
>
> -       if (options->flags.find_copies_harder)
> +       /* Just fold this in as it makes the patch-to-git smaller */
> +       if (options->flags.find_copies_harder || options->detect_rename =
=3D=3D DIFF_DETECT_COPY_HARDER) {

As per CodingGuidelines, this line is too long and should be split
across two lines at the `||`.

> +               options->flags.find_copies_harder =3D 1;
>                 options->detect_rename =3D DIFF_DETECT_COPY;
> +       }
>
>         if (!options->flags.relative_name)
>                 options->prefix =3D NULL;
> @@ -5264,7 +5270,7 @@ static int diff_opt_find_copies(const struct option=
 *opt,
>         if (*arg !=3D 0)
>                 return error(_("invalid argument to %s"), opt->long_name)=
;
>
> -       if (options->detect_rename =3D=3D DIFF_DETECT_COPY)
> +       if (options->detect_rename =3D=3D DIFF_DETECT_COPY || options->de=
tect_rename =3D=3D DIFF_DETECT_COPY_HARDER)

Also too long.

>                 options->flags.find_copies_harder =3D 1;
>         else
>                 options->detect_rename =3D DIFF_DETECT_COPY;
> diff --git a/diff.h b/diff.h
> index 66bd8aeb293..b29e5b777f8 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -555,6 +555,7 @@ int git_config_rename(const char *var, const char *va=
lue);
>
>  #define DIFF_DETECT_RENAME     1
>  #define DIFF_DETECT_COPY       2
> +#define DIFF_DETECT_COPY_HARDER 3
>
>  #define DIFF_PICKAXE_ALL       1
>  #define DIFF_PICKAXE_REGEX     2
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 5a6e2bcac71..856291d66f2 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -299,7 +299,7 @@ static int find_identical_files(struct hashmap *srcs,
>                 }
>                 /* Give higher scores to sources that haven't been used a=
lready */
>                 score =3D !source->rename_used;
> -               if (source->rename_used && options->detect_rename !=3D DI=
FF_DETECT_COPY)
> +               if (source->rename_used && options->detect_rename !=3D DI=
FF_DETECT_COPY && options->detect_rename !=3D DIFF_DETECT_COPY_HARDER)

This line should also be split.

>                         continue;
>                 score +=3D basename_same(source, target);
>                 if (score > best_score) {
> @@ -1405,7 +1405,7 @@ void diffcore_rename_extended(struct diff_options *=
options,
>         trace2_region_enter("diff", "setup", options->repo);
>         info.setup =3D 0;
>         assert(!dir_rename_count || strmap_empty(dir_rename_count));
> -       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY);
> +       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY || detect_=
rename =3D=3D DIFF_DETECT_COPY_HARDER);

and so should this one.

>         if (dirs_removed && (break_idx || want_copies))
>                 BUG("dirs_removed incompatible with break/copy detection"=
);
>         if (break_idx && relevant_sources)
> diff --git a/merge-ort.c b/merge-ort.c
> index 6491070d965..77498354652 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4782,7 +4782,7 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>          * sanity check them anyway.
>          */
>         assert(opt->detect_renames >=3D -1 &&
> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>         assert(opt->verbosity >=3D 0 && opt->verbosity <=3D 5);
>         assert(opt->buffer_output <=3D 2);
>         assert(opt->obuf.len =3D=3D 0);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e3beb0801b1..d52dd536606 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3708,7 +3708,7 @@ static int merge_start(struct merge_options *opt, s=
truct tree *head)
>         assert(opt->branch1 && opt->branch2);
>
>         assert(opt->detect_renames >=3D -1 &&
> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>         assert(opt->detect_directory_renames >=3D MERGE_DIRECTORY_RENAMES=
_NONE &&
>                opt->detect_directory_renames <=3D MERGE_DIRECTORY_RENAMES=
_TRUE);
>         assert(opt->rename_limit >=3D -1);
>
> base-commit: 692be87cbba55e8488f805d236f2ad50483bd7d5
> --
> gitgitgadget

The overall patch makes sense and looks good, modulo some minor
stylistic things that need cleaning up.
