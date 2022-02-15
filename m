Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479D6C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiBODw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:52:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBODw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 22:52:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B310E541
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 19:52:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so41457858eje.10
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 19:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbIN66UWEQY9VPcQTAlYe5EZKoePvpx1/CiJRx8fzRQ=;
        b=Y9q8c90AbTRriJAIFFg203WEiK2dBgW2qqhiSJC2goxewtW0SxHMhp8ddyCHZWWrsl
         UZwhpEwHVhdBlR9b39Q8k34C0L32zPBNrggbXgb++do5e9ZOHHSY/J1/rlNJ7CGsY4Vq
         Tg7FUQSYTN7vdBbq43JLIv3ScZ9hL55tJwf/Yr/po68QP5V1S0IOVrh4GmrOVLQ0ijK7
         bxnKFgVoiArG6R7GFeYZxB9o3MuddyxKRsiPTYgdsCLVTnjaAUtse26M5K2I4QT53VCd
         cThyub9MXVFKQpCpsg6DuvzUP19AFShMKec5anLYDuLSHP5N/E4WQW7J45FajP2Cy0Re
         3j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbIN66UWEQY9VPcQTAlYe5EZKoePvpx1/CiJRx8fzRQ=;
        b=jOg3N0LfUL8hi5kUWAN3cWMtfr/eHA7y2IlEpbHIrxkqTR3cFN4gtMQkNcpIwejg4E
         dgtCVg5k0RXqPK4UFakw3HVzSIRWCATmE+7i2AzZre0PwLVP75UCwOzbQu4t2bTfd0OG
         iMBN5nB558r3/XEL18twT+eLxtPNsIJEVS/qQ3m7yBT2nTErB1DgSnXCkKbDQIyp+KZQ
         OEcz2PK8KxVzTDz5CGb15wMDpNMBbmWwZRymkMbfWJd7RwWPMhHm+s4iK2NyhffywqSv
         i7jcV9AQsKMHPl+ztsOKt2O9nErDvrLN8ypK0HAWmUvkHk6R9mmKGT3YfbtqSraDJpHr
         gbTA==
X-Gm-Message-State: AOAM533cuMg978fzmf8zR8LK9GJLWGnhNZWAP4a1aUIqCz8tMcUZFnvw
        /GSgJknts45J1wg1VELcBG+p0P0ZFFFhnCX/PbBQCNJejMo=
X-Google-Smtp-Source: ABdhPJwLpmB2u2YPdWz1NetXYCquLm8nR+uBgTvxDNnzLoiSnaF3mwRGeISoT793mlzoBnYRXNQAp1yp6vjByL8LxcQ=
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr1342954ejc.476.1644897167683;
 Mon, 14 Feb 2022 19:52:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <679f869ff11b5c3e61081018f7eafa81c334f3d1.1644712798.git.gitgitgadget@gmail.com>
 <b97d569c-3b5a-a2c8-cdf5-08d74406a29e@github.com>
In-Reply-To: <b97d569c-3b5a-a2c8-cdf5-08d74406a29e@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 19:52:36 -0800
Message-ID: <CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com>
Subject: Re: [PATCH 3/7] sparse-checkout: pay attention to prefix for {set, add}
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 7:50 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In cone mode, non-option arguments to set & add are clearly paths, and
> > as such, we should pay attention to prefix.
> >
> > In non-cone mode, it is not clear that folks intend to provide paths
> > since the inputs are gitignore-style patterns.  Paying attention to
> > prefix would prevent folks from doing things like
> >    git sparse-checkout add /.gitattributes
> >    git sparse-checkout add '/toplevel-dir/*'
> > In fact, the former will result in
> >    fatal: '/.gitattributes' is outside repository...
> > while the later will result in
> >    fatal: Invalid path '/toplevel-dir': No such file or directory
> > despite the fact that both are valid gitignore-style patterns that would
> > select real files if added to the sparse-checkout file.  However, these
> > commands can be run successfully from the toplevel directory, and many
> > gitignore-style patterns ARE paths, and bash completion seems to be
> > suggesting directories and files, so perhaps for consistency we pay
> > attention to the prefix?  It's not clear what is okay here, but maybe
> > that's yet another reason to deprecate non-cone mode as we will do later
> > in this series.
> >
> > For now, incorporate prefix into the positional arguments for either
> > cone or non-cone mode.  For additional discussion of this issue, see
> > https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/
>
> Perhaps this was covered in the issue, but for non-cone mode, it
> matters if there is a leading slash or not in the pattern. Will
> this change make it impossible for a user to input that distinction?
>
> Will there still be a difference between:
>
>         git sparse-checkout set --no-cone /.vs/
>
> and
>
>         git sparse-checkout set --no-cone .vs/
>
> ?

If you are in the toplevel directory, you can run either of these and
they have the same meaning they traditionally had.

Before this patch, if you are in a subdirectory, the first of those
would have specified a toplevel ".vs" directory, and the second would
have specified a ".vs/" directory in the toplevel OR any subdirectory.
Those choices might be what the user wanted, or both of those could be
a nasty surprise for the user.

After this patch, if you are in a subdirectory, the first of those
throw an error:
    $ git sparse-checkout set --no-cone /.vs/
    fatal: Invalid path '/.vs': No such file or directory
(which might be an annoyance, but how would you possibly specify a
leading slash on a path that needs to be prefixed anyway?)  The second
will specify a SUBDIR/.vs/ from the toplevel directory (which again,
might be what the user wanted, or might be a nasty surprise if they
were trying to specify a pattern relative to the root).

Does this change make sense?  For some users, sure -- especially those
with the idea that you specify paths for non-cone mode (though
bash-completion may guide folks to presume that).  But for those who
understand that non-cone mode is all about patterns and that we have a
single toplevel file where everything must be recorded, it's possibly
detrimental to them.  To me, I wonder if it seems fraught with nasty
surprises for us to do anything other than throw an error when
--no-cone is specified and we are in a subdirectory.  Perhaps I should
do that instead of this change here.

> > Helped-by: Junio Hamano <gitster@pobox.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> This could probably use a
>
>   Reported-by: Lessley Dennington <lessleydennington@gmail.com>

It'd be more of a "Report-Formalized-by:" if we were to include such a
tag.  Check the history here:
https://lore.kernel.org/git/52d638fc-e7e7-1b0a-482b-cff7c9500b92@gmail.com/

In short: I was the original reporter; I noted the issue while
reviewing her completion series.  The bug was not related to her
series, but her series did prompt me to check and discover the issue.
She didn't want the issue to get lost, and decided to make a formal
report.

> > +static void sanitize_paths(int argc, const char **argv, const char *prefix)
> > +{
> > +     if (!argc)
> > +             return;
> > +
> > +     if (prefix && *prefix) {
> > +             /*
> > +              * The args are not pathspecs, so unfortunately we
> > +              * cannot imitate how cmd_add() uses parse_pathspec().
> > +              */
> > +             int i;
> > +             int prefix_len = strlen(prefix);
> > +
> > +             for (i = 0; i < argc; i++)
> > +                     argv[i] = prefix_path(prefix, prefix_len, argv[i]);
> > +     }
> > +}
> > +
> >  static char const * const builtin_sparse_checkout_add_usage[] = {
> >       N_("git sparse-checkout add (--stdin | <patterns>)"),
> >       NULL
> > @@ -708,6 +726,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
> >                            builtin_sparse_checkout_add_usage,
> >                            PARSE_OPT_KEEP_UNKNOWN);
> >
> > +     sanitize_paths(argc, argv, prefix);
> > +
> >       return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
> >  }
> >
> > @@ -759,6 +779,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
> >       if (!core_sparse_checkout_cone && argc == 0) {
> >               argv = default_patterns;
> >               argc = default_patterns_nr;
> > +     } else {
> > +             sanitize_paths(argc, argv, prefix);
> >       }
>
> Code changes appear to do as described: apply the prefix everywhere
> it matters, no matter the mode.
>
> > +test_expect_success 'set from subdir pays attention to prefix' '
> > +     git -C repo sparse-checkout disable &&
> > +     git -C repo/deep sparse-checkout set --cone deeper2 ../folder1 &&
> > +
> > +     git -C repo sparse-checkout list >actual &&
> > +
> > +     cat >expect <<-\EOF &&
> > +     deep/deeper2
> > +     folder1
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'add from subdir pays attention to prefix' '
> > +     git -C repo sparse-checkout set --cone deep/deeper2 &&
> > +     git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 &&
> > +
> > +     git -C repo sparse-checkout list >actual &&
> > +
> > +     cat >expect <<-\EOF &&
> > +     deep/deeper1/deepest
> > +     deep/deeper2
> > +     folder1
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> >  test_done
>
> These tests could use a non-cone-mode version to demonstrate the behavior
> in that mode.

Fair enough, though I hesitated in part because I wasn't sure we even
wanted to make that change, and I figured getting that answer might be
useful before writing the tests.
