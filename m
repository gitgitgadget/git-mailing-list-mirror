Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADCDC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 20:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhKZUWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 15:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbhKZUUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 15:20:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A9C0613F6
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 12:14:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so43456250edd.0
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1y5DHS9e+ue9cfl1AEj3CVfH7FRkwbbmiYmK93P1OA=;
        b=VIGZehqHHjzx8x6dmtUc6dJ9gnP//HRRXevo2BbWTEmoVCQkMT0/weaAB+da5uOzuI
         sx+kBYVShZxuEsAHVRluF+BaiIhWKJ3ryjBgTHwUg3cBQgZ20RyPZYBAog3tDWm/xKvr
         Cf/fCueoE6NTae5sgKOYmb1EZcvU4EffxgimF/0FL75m7/0vWMR9h99Qp6BcDCbG6nLR
         dPh4QjI9d2sNDkzYdby4mnvIl2jewvaiRyD6pxOGxmDprujSmdaKPYR4xxspa+rbh14h
         EdoFY92rzCqfcEMVRnkpN6pFqcaGa2w7iHG3lk6xUYbn6f2+v20vUt631uuXEDqcAJMn
         EfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1y5DHS9e+ue9cfl1AEj3CVfH7FRkwbbmiYmK93P1OA=;
        b=ZvEGQKgk6tp/WWeYcQuv9hnxlGvSKIHNiprUY7N26V+O3YKcb02aQRKpXn1O7BG30v
         Hr9XmhlJRbqxUNAaRFQXzkmApySGO2M8fyMWiDKh1qwIPPqJ4yQOC0upChj3OVfzIa1M
         /RPqARTePxZxB/De4FRF9sZndonMBokIQFkXoXkrPfWkCbOUer8ogjcBZQHuB4nCBLNq
         Kd7c52CnlbT2wPSOW+QTuSMQpjW6rnqcLED5f4VIO9AJxSJD0iykp5OrzvB5MZtBgNmK
         qrrB19aT7Ot5vSaJBP2iuiVHfbZxiNuRvlw7vCyVoIdGweyfdvIJ7IP2balcJpcx54Ud
         7o8g==
X-Gm-Message-State: AOAM530aNpYiptsud0klRo6y7i+/G1R617YaE/ejW2lSJ3b4T7iMDFTY
        PonPMW61BuFIaTPa+MYLZ/pCgCerT1UutL4Acsc=
X-Google-Smtp-Source: ABdhPJxdkOglkJPy5WMz5BvagWOO9kI+JxQ0wjn0//uY3NaYwQsQxjFgoIQdtVXnGinWW1TsvWDFnj5qNN80U7r94UU=
X-Received: by 2002:a17:906:4c9:: with SMTP id g9mr40276084eja.172.1637957655169;
 Fri, 26 Nov 2021 12:14:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com> <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
In-Reply-To: <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 12:14:03 -0800
Message-ID: <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] am: support --empty=<option> to handle empty patches
To:     =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbikgdmlhIEdpdEdpdEdhZGdldA==?= 
        <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 8:38 AM =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) via Git=
GitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?=3DE5=3DBE=3D90=3DE6=3DB2=3D9B=3DE6=3D96=3D87=3D20=3D28=
Aleen=3D29?=3D
>  <aleen42@vip.qq.com>
>
> Since that the command 'git-format-patch' can include patches of
> commits that emit no changes, the 'git-am' command should also
> support an option, named as '--empty', to specify how to handle
> those empty patches. In this commit, we have implemented three
> valid options ('die', 'drop' and 'keep').
>
> Signed-off-by: =E5=BE=90=E6=B2=9B=E6=96=87 (Aleen) <aleen42@vip.qq.com>
> ---
>  Documentation/git-am.txt |  8 ++++++
>  builtin/am.c             | 55 ++++++++++++++++++++++++++++++++++++----
>  t/t4150-am.sh            | 49 +++++++++++++++++++++++++++++++++++
>  3 files changed, 107 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0a4a984dfde..ba17063f621 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>          [--exclude=3D<path>] [--include=3D<path>] [--reject] [-q | --qui=
et]
>          [--[no-]scissors] [-S[<keyid>]] [--patch-format=3D<format>]
>          [--quoted-cr=3D<action>]
> +        [--empty=3D(die|drop|keep)]
>          [(<mbox> | <Maildir>)...]
>  'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=
=3D(diff|raw)])
>
> @@ -63,6 +64,13 @@ OPTIONS
>  --quoted-cr=3D<action>::
>         This flag will be passed down to 'git mailinfo' (see linkgit:git-=
mailinfo[1]).
>
> +--empty=3D(die|drop|keep)::
> +       By default, or when the option is set to 'die', the command
> +       errors out on an input e-mail message that lacks a patch. When
> +       this option is set to 'drop', skip such an e-mail message instead=
.
> +       When this option is set to 'keep', create an empty commit,
> +       recording the contents of the e-mail message as its log.

What does 'errors out' mean?  Is the am operation aborted, and the
user return to the pre-am state?  Or is the am operation interrupted,
with the user being asked to choose whether to keep or drop the patch?
 Or something else (my first thought was "Are you going to leave the
index locked?")?  This description is not that clear.  To me, the
wording suggests aborted (or worse), but what you actually implemented
was an interrupt-and-ask.

Can I suggest using 'ask' instead of 'die'?  I think that will be
clearer, and it matches the term used by git rebase --empty.

Also, the only instructions given to the user when you interrupt
include how to skip the patch, but I don't see anything for how to
keep it.  The instructions are:
'''
Patch is empty.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'''

I tried it manually, and it turns out "git am --continue" will just
spit out basically the same message again:
'''
Applying: empty commit
No changes - did you forget to use 'git add'?
If there is nothing left to stage, chances are that something else
already introduced the same changes; you might want to skip this patch.
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'''

And if I try to run `git commit --allow-empty` (which I happen to
remember is the command suggested by `git rebase --empty=3Dask` when it
stops), then I'm given an empty editor; it is not pre-populated with
the appropriate commit message.  Can the portion of the empty patch
corresponding to the commit message be added to .git/COMMIT_EDITMSG to
correct that?  Also, can some extra words be printed before
interrupting to explain what to do when you want to keep the empty
commit?  Something like:
"""
The current commit being applied is empty.  If you wish to commit it
anyway, use:
    git commit --allow-empty
"""

> +
>  -m::
>  --message-id::
>         Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]=
),
> diff --git a/builtin/am.c b/builtin/am.c
> index 8677ea2348a..cc6512275aa 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -87,6 +87,12 @@ enum show_patch_type {
>         SHOW_PATCH_DIFF =3D 1,
>  };
>
> +enum empty_action {
> +       DIE_EMPTY_COMMIT =3D 0,  /* output errors */
> +       DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--q=
uiet" has been passed */
> +       KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
> +};
> +
>  struct am_state {
>         /* state directory path */
>         char *dir;
> @@ -118,6 +124,7 @@ struct am_state {
>         int message_id;
>         int scissors; /* enum scissors_type */
>         int quoted_cr; /* enum quoted_cr_action */
> +       int empty_type; /* enum empty_action */
>         struct strvec git_apply_opts;
>         const char *resolvemsg;
>         int committer_date_is_author_date;
> @@ -178,6 +185,25 @@ static int am_option_parse_quoted_cr(const struct op=
tion *opt,
>         return 0;
>  }
>
> +static int am_option_parse_empty(const struct option *opt,
> +                                    const char *arg, int unset)
> +{
> +       int *opt_value =3D opt->value;
> +
> +       BUG_ON_OPT_NEG(unset);
> +
> +       if (!strcmp(arg, "die"))
> +               *opt_value =3D DIE_EMPTY_COMMIT;
> +       else if (!strcmp(arg, "drop"))
> +               *opt_value =3D DROP_EMPTY_COMMIT;
> +       else if (!strcmp(arg, "keep"))
> +               *opt_value =3D KEEP_EMPTY_COMMIT;
> +       else
> +               return error(_("Invalid value for --empty: %s"), arg);
> +
> +       return 0;
> +}
> +
>  /**
>   * Returns path relative to the am_state directory.
>   */
> @@ -1248,11 +1274,6 @@ static int parse_mail(struct am_state *state, cons=
t char *mail)
>                 goto finish;
>         }
>
> -       if (is_empty_or_missing_file(am_path(state, "patch"))) {
> -               printf_ln(_("Patch is empty."));
> -               die_user_resolve(state);
> -       }
> -
>         strbuf_addstr(&msg, "\n\n");
>         strbuf_addbuf(&msg, &mi.log_message);
>         strbuf_stripspace(&msg, 0);
> @@ -1763,6 +1784,7 @@ static void am_run(struct am_state *state, int resu=
me)
>         while (state->cur <=3D state->last) {
>                 const char *mail =3D am_path(state, msgnum(state));
>                 int apply_status;
> +               int to_keep;
>
>                 reset_ident_date();
>
> @@ -1792,8 +1814,27 @@ static void am_run(struct am_state *state, int res=
ume)
>                 if (state->interactive && do_interactive(state))
>                         goto next;
>
> +               to_keep =3D 0;
> +               if (is_empty_or_missing_file(am_path(state, "patch"))) {
> +                       switch (state->empty_type) {
> +                       case DROP_EMPTY_COMMIT:
> +                               say(state, stdout, _("Skipping: %.*s"), l=
inelen(state->msg), state->msg);
> +                               goto next;
> +                               break;
> +                       case KEEP_EMPTY_COMMIT:
> +                               to_keep =3D 1;
> +                               break;
> +                       case DIE_EMPTY_COMMIT:
> +                               printf_ln(_("Patch is empty."));
> +                               die_user_resolve(state);
> +                               break;
> +                       }
> +               }
> +
>                 if (run_applypatch_msg_hook(state))
>                         exit(1);
> +               if (to_keep)
> +                       goto commit;
>
>                 say(state, stdout, _("Applying: %.*s"), linelen(state->ms=
g), state->msg);
>
> @@ -1827,6 +1868,7 @@ static void am_run(struct am_state *state, int resu=
me)
>                         die_user_resolve(state);
>                 }
>
> +commit:
>                 do_commit(state);
>
>  next:
> @@ -2357,6 +2399,9 @@ int cmd_am(int argc, const char **argv, const char =
*prefix)
>                 { OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_(=
"key-id"),
>                   N_("GPG-sign commits"),
>                   PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +               OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep=
,die}",
> +                 N_("how to handle empty patches"),
> +                 PARSE_OPT_NONEG, am_option_parse_empty),
>                 OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
>                         N_("(internal use for git-rebase)")),
>                 OPT_END()
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 2aaaa0d7ded..8c8bd4db220 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -196,6 +196,12 @@ test_expect_success setup '
>
>         git format-patch -M --stdout lorem^ >rename-add.patch &&
>
> +       git checkout -b empty-commit &&
> +       git commit -m "empty commit" --allow-empty &&
> +
> +       : >empty.patch &&
> +       git format-patch --always --stdout empty-commit^ >empty-commit.pa=
tch &&
> +
>         # reset time
>         sane_unset test_tick &&
>         test_tick
> @@ -1152,4 +1158,47 @@ test_expect_success 'apply binary blob in partial =
clone' '
>         git -C client am ../patch
>  '
>
> +test_expect_success 'an empty input file is error regardless of --empty =
option' '
> +       test_when_finished "git am --abort || :" &&
> +       test_must_fail git am --empty=3Ddrop empty.patch 2>actual &&
> +       echo "Patch format detection failed." >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'invalid when passing the --empty option alone' '
> +       test_when_finished "git am --abort || :" &&
> +       git checkout empty-commit^ &&
> +       test_must_fail git am --empty empty-commit.patch 2>err &&
> +       echo "error: Invalid value for --empty: empty-commit.patch" >expe=
cted &&
> +       test_cmp expected err
> +'
> +
> +test_expect_success 'a message without a patch is an error (default)' '
> +       test_when_finished "git am --abort || :" &&
> +       test_must_fail git am empty-commit.patch >err &&
> +       grep "Patch is empty" err
> +'
> +
> +test_expect_success 'a message without a patch is an error where an expl=
icit "--empty=3Ddie" is given' '
> +       test_when_finished "git am --abort || :" &&
> +       test_must_fail git am --empty=3Ddie empty-commit.patch >err &&
> +       grep "Patch is empty." err
> +'
> +
> +test_expect_success 'a message without a patch will be skipped when "--e=
mpty=3Ddrop" is given' '
> +       git am --empty=3Ddrop empty-commit.patch >output &&
> +       git rev-parse empty-commit^ >expected &&
> +       git rev-parse HEAD >actual &&
> +       test_cmp expected actual &&
> +       grep "Skipping: empty commit" output
> +'
> +
> +test_expect_success 'record as an empty commit when meeting e-mail messa=
ge that lacks a patch' '
> +       git am --empty=3Dkeep empty-commit.patch &&
> +       test_path_is_missing .git/rebase-apply &&
> +       git show empty-commit --format=3D"%s" >expected &&
> +       git show HEAD --format=3D"%s" >actual &&
> +       test_cmp actual expected
> +'
> +
>  test_done
> --
> gitgitgadget
