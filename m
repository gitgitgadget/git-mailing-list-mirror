Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F7EC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55E064DDF
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 16:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhBJQ7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhBJQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 11:59:11 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4FC06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 08:58:31 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id i3so2783808oif.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 08:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+7x2j/aJ+1GhF5S+sdciGhcJ3AcuoDmfaa3pSxru9s8=;
        b=DWICz6rQSZJJPnX2MRu4CZ0FlXV47wNEPYbF5MchzYiQxDn654CvqVvWWPy3U89x6I
         edR5JjqHuWgzWbOLtjLE2oySSfaevZV7xChp83xYpXVCSKHhdOqbfC2PsBZ5p6Tp98yo
         6k1CRXeDSTYp+ZeTlqj6lLRNuF6Jf1u1NoHBEh4qZytaElawHKALLgC0sLyKbTdig1MG
         5dGLz65pdSBF1Ykz4heOqvxgZRHbDvsEZ9MeXrlUsinyWNdNIY4hQBIjjRDpFhhrMPkf
         haTmHw/v6GCVWvL4ZGJaWag5k9XVuTJmibDHYprhJeUVnlYDPQmhealOZJvlEZDFe0ff
         hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+7x2j/aJ+1GhF5S+sdciGhcJ3AcuoDmfaa3pSxru9s8=;
        b=h+2p/95ZuR3xTKJfT7Ml/FFgqbyXMkdIbDp46n6edBPcsoQCkzBjRJNgIdyOmKSHrn
         /DJcjVw6UvzuHT2NVtim18pDu/mGI2gR16a+aqlCy/tf7tx0VKv/FeYmI7S/8KQtbiTv
         F9yUlACWZXN4ORi8DJgTZvFJGDKXVy10go3Owg5UJrKrcEkg5UG6QpmwRUDBjeiPMoRn
         7aFivhKlbmjRMWscWeQ9EVRAUVgsYPoXrTsx1Ye5GqbCCzxYJaqbriuXidYflZfK6/KO
         45l9699R4JJbncUUdkhJk0T98KyALlUUC42VF2Pcse5cgDyZyS5IKfcPoW3pkp3ewVmz
         Tc5g==
X-Gm-Message-State: AOAM531oSTPRxUow4aM7yip5vq7RxHxJjyIQY98GJP1czFNpEeoDEC/k
        7EaQpzfjXl7Vv51EQ9EDCbcWZWr7OLg3V1eJgLw=
X-Google-Smtp-Source: ABdhPJy/hGBspb0WCZwWGlvAHTuK9ppckPYVGKLILQiE3kR1BvCloaNFUljKQbcoqzrwvvUVZ10OkeWHsdVhX7/0EpI=
X-Received: by 2002:aca:52d1:: with SMTP id g200mr2849923oib.44.1612976311155;
 Wed, 10 Feb 2021 08:58:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
 <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com> <xmqqeehp2jis.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeehp2jis.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 11 Feb 2021 01:00:41 +0800
Message-ID: <CAOLTT8QbutZ2pHZ7Zg7vEJAy=d66YKP12rVW=RSJV+8fH6RRMw@mail.gmail.com>
Subject: Re: [PATCH v3] difftool.c: learn a new way start from specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:17=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftoo=
l.txt
> > index 484c485fd06c..552be097dfea 100644
> > --- a/Documentation/git-difftool.txt
> > +++ b/Documentation/git-difftool.txt
> > @@ -34,6 +34,9 @@ OPTIONS
> >       This is the default behaviour; the option is provided to
> >       override any configuration settings.
> >
> > +--start-from::
> > +     Start viewing diff from the specified file.
> > +
>
> There is nothing that specifies a file in the above ;-)
>
>         --start-from=3D<file>::
>                 Start viewing ...
>
> This is even more important as SYNOPSIS section of this manual page
> does not duplicate the list of options and their arguments.
>
I admit my mistake,thanks for reminding.
> >  -t <tool>::
> >  --tool=3D<tool>::
> >       Use the diff tool specified by <tool>.  Valid values include
>
> There are many things I dislike about this patch, but do not take it
> as a personal attack.  I'll try to suggest an alternative at the end,
> but read along.
>
Of course I humbly accepted your criticism,I am only a sophomore in
university after all,It is extremely important to listen to your suggestion=
s.
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index 6e18e623fddf..67d2befa1210 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -690,7 +690,7 @@ int cmd_difftool(int argc, const char **argv, const=
 char *prefix)
> >  {
> >       int use_gui_tool =3D 0, dir_diff =3D 0, prompt =3D -1, symlinks =
=3D 0,
> >           tool_help =3D 0, no_index =3D 0;
> > -     static char *difftool_cmd =3D NULL, *extcmd =3D NULL;
> > +     static char *difftool_cmd =3D NULL, *extcmd =3D NULL, *start_file=
 =3D NULL;
> >       struct option builtin_difftool_options[] =3D {
> >               OPT_BOOL('g', "gui", &use_gui_tool,
> >                        N_("use `diff.guitool` instead of `diff.tool`"))=
,
> > @@ -714,6 +714,8 @@ int cmd_difftool(int argc, const char **argv, const=
 char *prefix)
> >               OPT_STRING('x', "extcmd", &extcmd, N_("command"),
> >                          N_("specify a custom command for viewing diffs=
")),
> >               OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`"=
)),
> > +             OPT_STRING(0, "start-from", &start_file, N_("start-from")=
,
> > +                        N_("start viewing diff from the specified file=
")),
> >               OPT_END()
> >       };
>
> This may be a good UI to "difftool".
>
> > @@ -724,6 +726,9 @@ int cmd_difftool(int argc, const char **argv, const=
 char *prefix)
> >                            builtin_difftool_usage, PARSE_OPT_KEEP_UNKNO=
WN |
> >                            PARSE_OPT_KEEP_DASHDASH);
> >
> > +     if (start_file)
> > +             setenv("START_FILE", start_file, 1);
>
> Unacceptable.  Nothing gives Git the right to squat on such a
> generic name, and there is no hint that it is used to specify the
> starting point of what operation.  In addition, I do not see a good
> reason why we need to use an environment variable in the first
> place.  We run "diff" as an external process, with GIT_EXTERNAL_DIFF
> environment pointing back at us, no?  This information should be
> passed from its command line.
Sure,I using environment variables originally hoped can be used in
git--difftool-helper.sh, later I found it was not easy to deal with, so I a=
m
attempt to use environment variables to transmit information in
`run_external_diff`,now it seems that this method is not very good ...
>
> > diff --git a/diff.c b/diff.c
> > index 69e3bc00ed8f..cdad26f99063 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4249,6 +4249,7 @@ static void run_external_diff(const char *pgm,
> >                             const char *xfrm_msg,
> >                             struct diff_options *o)
> >  {
> > +     const char *start_file =3D NULL;
> >       struct strvec argv =3D STRVEC_INIT;
> >       struct strvec env =3D STRVEC_INIT;
> >       struct diff_queue_struct *q =3D &diff_queued_diff;
> > @@ -4272,9 +4273,17 @@ static void run_external_diff(const char *pgm,
> >
> >       diff_free_filespec_data(one);
> >       diff_free_filespec_data(two);
> > +
> > +     start_file =3D xstrdup_or_null(getenv("START_FILE"));
> > +     if (start_file) {
> > +             if (strcmp(start_file, name))
> > +                     goto finish;
> > +             unsetenv("START_FILE");
> > +     }
>
> Again, an unacceptable "hack".  "start the diff output showing from
> this path" would plausibly a good feature even outside the scope of
> "difftool", and the feature should not be limited to the external
> diff interface.  More on this later.
What you said `from its command line` is using `git difftool
--rotate-to=3D<file>`,
Maybe I didn=E2=80=99t know whether to deal with the subcommands of `diff`,=
 now I admit
that passing from parameters is better than passing environment variables.
>
> >       if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v=
))
> >               die(_("external diff died, stopping at %s"), name);
> >
> > +finish:
> >       remove_tempfile();
> >       strvec_clear(&argv);
> >       strvec_clear(&env);
> > diff --git a/diff.h b/diff.h
> > index 2ff2b1c7f2ca..f67c43f5af95 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -86,18 +86,18 @@ typedef void (*diff_format_fn_t)(struct diff_queue_=
struct *q,
> >
> >  typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, v=
oid *data);
> >
> > -#define DIFF_FORMAT_RAW              0x0001
> > -#define DIFF_FORMAT_DIFFSTAT 0x0002
> > -#define DIFF_FORMAT_NUMSTAT  0x0004
> > -#define DIFF_FORMAT_SUMMARY  0x0008
> > -#define DIFF_FORMAT_PATCH    0x0010
> > -#define DIFF_FORMAT_SHORTSTAT        0x0020
> > -#define DIFF_FORMAT_DIRSTAT  0x0040
> > +#define DIFF_FORMAT_RAW              (1U<<0)
> > +#define DIFF_FORMAT_DIFFSTAT (1U<<1)
> > +#define DIFF_FORMAT_NUMSTAT  (1U<<2)
> > +#define DIFF_FORMAT_SUMMARY  (1U<<3)
> > +#define DIFF_FORMAT_PATCH    (1U<<4)
> > +#define DIFF_FORMAT_SHORTSTAT        (1U<<5)
> > +#define DIFF_FORMAT_DIRSTAT  (1U<<6)
> >
> >  /* These override all above */
> > -#define DIFF_FORMAT_NAME     0x0100
> > -#define DIFF_FORMAT_NAME_STATUS      0x0200
> > -#define DIFF_FORMAT_CHECKDIFF        0x0400
> > +#define DIFF_FORMAT_NAME     (1U<<8)
> > +#define DIFF_FORMAT_NAME_STATUS      (1U<<9)
> > +#define DIFF_FORMAT_CHECKDIFF        (1U<<10)
>
> Do we need these changes for the new feature to work?
It has no effect on this new feature. I should put this modification
in an additional commit, right?
>
> I also find this "skip and discard ones earlier than the given path"
> makes the utility of the feature artificially narrower than needed,
> when I imagine how else this feature, or a variant of it, would be
> useful in other situations.  For example, consider that there are 5
> paths, and you've seen 3 of them so far before you went off, so you
> are restarting from 4th file.  But wouldn't it be more useful, after
> showing the 4th and 5th file, if the tool wraps around to show 1st,
> 2nd, and 3rd file if the user kept going?
>
Well, it would be better if you can see 1st, 2nd, 3rd again.
> I suspect that this feature fits the overall system much better if
> it is implemented as a new step in the diffcore transformation.  The
> way our diff subsystem works is roughly:
>
>  * The front-end "diff", "diff-files", "diff-index" and "diff-trees"
>    are given two "tree like things" to compare, and feeds bunch of
>    <old, new> tuples to the diff internal machinery.  Each of these
>    tuples are called "filepairs", and a "pair" has two "filespecs",
>    one describing the contents, the mode, and the path in the "old"
>    side of the "tree like things", the other describing the
>    contents, the mode, and the path in the "new" side of the "tree
>    like things".
>
>  * The series of filepairs are given to the "diffcore" machinery,
>    where they may be broken (i.e. a filepair that says that the old
>    contents of "hello.txt" was X, and the new contents of
>    "hello.txt" is Y, may become two filepairs, one that says that
>    the "hello.txt" file with contents X used to be in the old tree
>    but there is nothing corresponding to it in the new tree, and the
>    other says that a new "hello.txt" with contents Y appeared
>    without corresponding thing in the old tree), matched (i.e. there
>    may originally be two filepairs, one that says path A.txt appears
>    on the old side but disappeared on the new side, and the other
>    that says path sub/A.txt did not exist on the old side but
>    appears on the new side---these two filepairs may be merged to
>    express "A.txt on the old side got renamed to sub/A.txt on the
>    new side"), etc.
>
Thank you for these interpretations on "git diff" for me, it will help me
understand its principle.
>  * The set of filepairs processed in the "diffcore" machinery is
>    given to the backend and each filepair will be shown in the
>    output, as a series of patches, a diffstat, etc.
>
> There is a step in the "diffcore" machinery called "diffcore-order".
> The front-ends all feed the filepairs alphabetically to the
> "diffcore" machinery, but "diffcore-order" can reorder them, so that
> the original order that the "git diff HEAD --" frontend found the
> changes may be to "hello.c" and then "hello.h" (because .c sorts
> before .h), but the users can specify with the "-O<orderfile>"
> option that they want to view the header files before the source
> files.  When the set of filepairs exits the diffcore machinery, the
> original "hello.c" then "hello.h" order may get modified to show
> "hello.h" then "hello.c".  It probably is the simplest to model this
> new feature after how "diffcore-order" does it.
>
Very magical "diffcore-order", when I was looking for a solution yesterday,
I noticed that these functions similar to "diffcore_apply_filter" in
"diffcore_std",
> So, perhaps we can introduce a new "diffcore-rotate" step, where the
> filepairs before the specified location are rotated out to the end
> of the filepairs?
>
Awesome idea. In this way, `difftool --rotate-to=3D<file>` can call
`diff --rotate-to=3D<file>` , user can choose the starting file, and they c=
an
also see previous files.
> The following is just a quick draft that is only lightly tested by
> running itself with the "--rotate-to=3Ddiffcore-rotate.c" option, but
> it should be sufficient to get you started.  You should add a way to
> diagnose that the name given to the "--start-file" option actually
> exists in the diff on the "difftool" side, because a path that does
> not exist in the patch with the following code is simply ignored
> (and that is very much deliberate, because we do not want it to die
> while running "git log -p --rotate-to=3DX" where some changes may or
> may not touch X).
Yes, I want to know why being so cautious in git log?If the file name is
wrong, why can't I make it exit? :)
>
>
> $ ./git diff --stat -p --rotate-to=3Ddiffcore-rotate.c HEAD
>
>  diffcore-rotate.c | 35 +++++++++++++++++++++++++++++++++++
>  diffcore.h        |  1 +
>  Makefile          |  1 +
>  diff.c            |  4 ++++
>  diff.h            |  1 +
>  5 files changed, 42 insertions(+)
>
> diff --git c/diffcore-rotate.c w/diffcore-rotate.c
> new file mode 100644
> index 0000000000..0d17901616
> --- /dev/null
> +++ w/diffcore-rotate.c
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (C) 2021, Google LLC.
> + * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Haman=
o
> + */
> +#include "cache.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +
> +void diffcore_rotate(const char *rotate_to_filename)
> +{
> +       struct diff_queue_struct *q =3D &diff_queued_diff;
> +       struct diff_queue_struct outq;
> +       int rotate_to, i;
> +
> +       if (!q->nr)
> +               return;
> +
> +       for (i =3D 0; i < q->nr; i++)
> +               if (!strcmp(rotate_to_filename, q->queue[i]->two->path))
> +                       break;
> +       /* we did not find the specified path */
> +       if (q->nr <=3D i)
> +               return;
> +
> +       DIFF_QUEUE_CLEAR(&outq);
> +       rotate_to =3D i;
> +
> +       for (i =3D rotate_to; i < q->nr; i++)
> +               diff_q(&outq, q->queue[i]);
> +       for (i =3D 0; i < rotate_to; i++)
> +               diff_q(&outq, q->queue[i]);
> +
> +       free(q->queue);
> +       *q =3D outq;
> +}
> diff --git c/diffcore.h w/diffcore.h
> index d2a63c5c71..bd5959375b 100644
> --- c/diffcore.h
> +++ w/diffcore.h
> @@ -164,6 +164,7 @@ void diffcore_rename(struct diff_options *);
>  void diffcore_merge_broken(void);
>  void diffcore_pickaxe(struct diff_options *);
>  void diffcore_order(const char *orderfile);
> +void diffcore_rotate(const char *rotate_to_filename);
>
>  /* low-level interface to diffcore_order */
>  struct obj_order {
> diff --git c/Makefile w/Makefile
> index b797033c58..031b0b88e6 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -869,6 +869,7 @@ LIB_OBJS +=3D diffcore-delta.o
>  LIB_OBJS +=3D diffcore-order.o
>  LIB_OBJS +=3D diffcore-pickaxe.o
>  LIB_OBJS +=3D diffcore-rename.o
> +LIB_OBJS +=3D diffcore-rotate.o
>  LIB_OBJS +=3D dir-iterator.o
>  LIB_OBJS +=3D dir.o
>  LIB_OBJS +=3D editor.o
> diff --git c/diff.c w/diff.c
> index 69e3bc00ed..90a8d5abd0 100644
> --- c/diff.c
> +++ w/diff.c
> @@ -5599,6 +5599,8 @@ static void prep_parse_options(struct diff_options =
*options)
>                           DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
>                 OPT_FILENAME('O', NULL, &options->orderfile,
>                              N_("control the order in which files appear =
in the output")),
> +               OPT_STRING(0, "rotate-to", &options->rotate_to, N_("<path=
>"),
> +                          N_("show the change in the specified path firs=
t")),
>                 OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>=
"),
>                                N_("look for differences that change the n=
umber of occurrences of the specified object"),
>                                PARSE_OPT_NONEG, diff_opt_find_object),
> @@ -6669,6 +6671,8 @@ void diffcore_std(struct diff_options *options)
>                 diffcore_pickaxe(options);
>         if (options->orderfile)
>                 diffcore_order(options->orderfile);
> +       if (options->rotate_to)
> +               diffcore_rotate(options->rotate_to);
>         if (!options->found_follow)
>                 /* See try_to_follow_renames() in tree-diff.c */
>                 diff_resolve_rename_copy();
> diff --git c/diff.h w/diff.h
> index 2ff2b1c7f2..0801469e63 100644
> --- c/diff.h
> +++ w/diff.h
> @@ -226,6 +226,7 @@ enum diff_submodule_format {
>   */
>  struct diff_options {
>         const char *orderfile;
> +       const char *rotate_to;
>
>         /**
>          * A constant string (can and typically does contain newlines to =
look for

Thanks for the patch!
After that, there was too little work I could do,do i just need to add
the following
 code in `diff_flush_patch_all_file_pairs`?
if (o->rotate_to && q->nr && strcmp(q->queue[0]->one->path, o->rotate_to) &=
&
strcmp(q->queue[0]->one->path, o->rotate_to)) {
    error(_("could not find start file name '%s'"), o->rotate_to);
        return;
}
In addition, Do I need to do the documentation and tests related to
your `diff --rotate-to`?
If so, I will finish it, otherwise, I will only do corresponding tests
for `git difftool --rotate-to`.

Thank you Junio, you are like a tireless teacher,

Happy Chinese New Year!

--
ZheNing Hu
