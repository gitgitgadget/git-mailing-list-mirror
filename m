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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92753C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7775861042
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhHQUX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhHQUXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 16:23:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B6C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:22:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f11so29413018ioj.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6CLMTI5QMontvCBQoyD/wQQgb2Ge8aPMROrDheWS+IQ=;
        b=pGactXKiMEdawNMUmZ09E8nuJ9FJLXgKicHnMSDaLWI8mTPj+7dYVz1UltSya6QwRy
         Xuhzuax9eA8g9HHv3WRhZSIdq35ohvB2YHMMGjnfabSaX66RwN1l15qoreYGikMc0Yc9
         p3tVfikcELOlz961f+yzPmUIo6vE33Jps0SBdZXN2U+xkIne/ZZmmh7dLo+LZCSNTETZ
         2SS43ncedptQn76wU4UMvjgzdw8zPXh/sA3mCc1QGcQGofCaJBWWG+eKlCJE73sVY/NP
         lJaLLv6FpHsxgnkmxyYJTFZnmd35TZeS5MxFYGY+IF5g8pnFUwy7XymSFatSDIvUzYgC
         edWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6CLMTI5QMontvCBQoyD/wQQgb2Ge8aPMROrDheWS+IQ=;
        b=Dovuz9rj7FSSBTrPSDOc2V61BbXHwfKV9FwXK6CHi3uyp67K5RSJeHXRXS/m5H3xPk
         eh12zbGW7XZNU8noNbeaR2eq4tW2jt0TrUwUgkNNaVAVrcy2AauB89zE+VibqV7D1+5x
         S2AZ1RR+xzdxsPT0Be4u39NZKxn1Nn4On+c/JW9InBV5i3pEfIpig6hqYcU5F8yDZ1kv
         fhx8NxR81QNIbBuJCaPGGMdTZKmZdiVHmy8UPKdqXvQHUd/2L/d35CwKipdW2P5PrGmj
         3if/bma+poHpADOBYaKArvoQI7ROTh/aj+FK8Bpvkb9jgdzNLmlr2HljiwmFekdQrsru
         jdmA==
X-Gm-Message-State: AOAM532FX3hWO8KJFRezorpi6+fETzMwXmUyF2WoHgm6X7CKbi/iuKnY
        UO/zpw/b+jxuDzwDP2MozOkx04m//fqnh2Zx0eA=
X-Google-Smtp-Source: ABdhPJygIiMbrXNlufd+ZmEGj7feHL5+1oogaYF/IRNk2KWr43j0FHdfpTy01y0xgSKAl1vlIkOOHHCxT/VyUncrGgU=
X-Received: by 2002:a5d:9688:: with SMTP id m8mr4342759ion.78.1629231765076;
 Tue, 17 Aug 2021 13:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-6-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 17 Aug 2021 22:22:34 +0200
Message-ID: <CAN7CjDDEv6vGPKZo3sxz8bgfN2Nzqh0HChR-tGrjDGbkhKZo=A@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El mar, 17 ago 2021 a las 13:42, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Tue, 17 Aug 2021, Miriam Rubio wrote:
>
> > From: Tanushree Tumane <tanushreetumane@gmail.com>
> >
> > Reimplement the `bisect_run()` shell function
> > in C and also add `--bisect-run` subcommand to
> > `git bisect--helper` to call it from git-bisect.sh.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  builtin/bisect--helper.c | 75 ++++++++++++++++++++++++++++++++++++++++
> >  git-bisect.sh            | 62 +--------------------------------
> >  2 files changed, 76 insertions(+), 61 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 4258429c1c..852e0a30fb 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
> >       N_("git bisect--helper --bisect-replay <filename>"),
> >       N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> >       N_("git bisect--helper --bisect-visualize"),
> > +     N_("git bisect--helper --bisect-run <cmd>..."),
> >       NULL
> >  };
> >
> > @@ -1075,6 +1076,71 @@ static int bisect_visualize(struct bisect_terms =
*terms, const char **argv, int a
> >       return res;
> >  }
> >
> > +static int bisect_run(struct bisect_terms *terms, const char **argv, i=
nt argc)
> > +{
> > +     int res =3D BISECT_OK;
> > +     struct strbuf command =3D STRBUF_INIT;
> > +     struct strvec args =3D STRVEC_INIT;
> > +     struct strvec run_args =3D STRVEC_INIT;
> > +     int exit =3D 0;
> > +
> > +     if (bisect_next_check(terms, NULL))
> > +             return BISECT_FAILED;
> > +
> > +     if (argc)
> > +             sq_quote_argv(&command, argv);
> > +     else
> > +             return BISECT_FAILED;
>
> Do we want to say something helpful here, e.g. _("bisect run failed: no
> command provided.")?
>
Ok, noted
> > +
> > +     strvec_push(&run_args, command.buf);
> > +
> > +     while (1) {
> > +             strvec_clear(&args);
> > +             exit =3D 1;
> > +
> > +             printf(_("running %s"), command.buf);
> > +             res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
> > +
> > +             if (res < 0 || 128 <=3D res) {
> > +                     error(_("bisect run failed: exit code %d from"
> > +                             " '%s' is < 0 or >=3D 128"), res, command=
.buf);
> > +                     strbuf_release(&command);
> > +                     return res;
> > +             }
> > +
> > +             if (res =3D=3D 125)
> > +                     strvec_push(&args, "skip");
> > +             else if (res > 0)
> > +                     strvec_push(&args, terms->term_bad);
> > +             else
> > +                     strvec_push(&args, terms->term_good);
> > +
> > +             res =3D bisect_state(terms, args.v, args.nr);
>
> Since `args.nr` will always be 1, it would probably be better to use
> something like this:
>
>                 const char *new_state;
>
>                 [...]
>                 if (res =3D=3D 125)
>                         new_state =3D "skip";
>                 else
>                         new_state =3D res > 0 ?
>                                 terms->term_bad : terms->term_good;
>
>                 res =3D bisect_state(terms, &new_state, 1);
>
Yes, indeed. I will change it.
> Also: I think at this stage, an equivalent to `cat "$GIT_DIR/BISECT_RUN"`
> is missing.
In the previous patch series (v3), I implemented the equivalent to the
cat command but I understood
reviewers wanted to print the output to the user, so I reverted my
changes for this version.
https://lore.kernel.org/git/20210411095538.34129-4-mirucam@gmail.com/

>
> > +
> > +             if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
> > +                     error(_("bisect run cannot continue any more"));
> > +             else if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> > +                     printf(_("bisect run success"));
> > +                     res =3D BISECT_OK;
> > +             } else if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOU=
ND) {
> > +                     printf(_("bisect found first bad commit"));
> > +                     res =3D BISECT_OK;
> > +             } else if (res) {
> > +                     error(_("bisect run failed:'git bisect--helper --=
bisect-state"
> > +                     " %s' exited with error code %d"), args.v[0], res=
);
> > +             } else {
> > +                     exit =3D 0;
>
> Since the only purpose of `exit` seems to be that the loop should continu=
e
> if `exit` is set to 0, and it is only set here, how about doing away with
> the variable altogether and writing `continue;` instead of `exit =3D 0;`?
> Then the conditional block below does not need to be conditional.
>
Noted.
> Other than that: well done!
>
Thank you for reviewing!,
Miriam


> Ciao,
> Dscho
>
> > +             }
> > +
> > +             if (exit) {
> > +                     strbuf_release(&command);
> > +                     strvec_clear(&args);
> > +                     strvec_clear(&run_args);
> > +                     return res;
> > +             }
> > +     }
> > +}
> > +
> >  int cmd_bisect__helper(int argc, const char **argv, const char *prefix=
)
> >  {
> >       enum {
> > @@ -1089,6 +1155,7 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >               BISECT_REPLAY,
> >               BISECT_SKIP,
> >               BISECT_VISUALIZE,
> > +             BISECT_RUN,
> >       } cmdmode =3D 0;
> >       int res =3D 0, nolog =3D 0;
> >       struct option options[] =3D {
> > @@ -1112,6 +1179,8 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >                        N_("skip some commits for checkout"), BISECT_SKI=
P),
> >               OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> >                        N_("visualize the bisection"), BISECT_VISUALIZE)=
,
> > +             OPT_CMDMODE(0, "bisect-run", &cmdmode,
> > +                      N_("use <cmd>... to automatically bisect."), BIS=
ECT_RUN),
> >               OPT_BOOL(0, "no-log", &nolog,
> >                        N_("no log for BISECT_WRITE")),
> >               OPT_END()
> > @@ -1177,6 +1246,12 @@ int cmd_bisect__helper(int argc, const char **ar=
gv, const char *prefix)
> >               get_terms(&terms);
> >               res =3D bisect_visualize(&terms, argv, argc);
> >               break;
> > +     case BISECT_RUN:
> > +             if (!argc)
> > +                     return error(_("bisect run failed: no command pro=
vided."));
> > +             get_terms(&terms);
> > +             res =3D bisect_run(&terms, argv, argc);
> > +             break;
> >       default:
> >               BUG("unknown subcommand %d", cmdmode);
> >       }
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 95f7f3fb8c..e83d011e17 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -39,66 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> >  TERM_BAD=3Dbad
> >  TERM_GOOD=3Dgood
> >
> > -bisect_run () {
> > -     git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail =
|| exit
> > -
> > -     test -n "$*" || die "$(gettext "bisect run failed: no command pro=
vided.")"
> > -
> > -     while true
> > -     do
> > -             command=3D"$@"
> > -             eval_gettextln "running \$command"
> > -             "$@"
> > -             res=3D$?
> > -
> > -             # Check for really bad run error.
> > -             if [ $res -lt 0 -o $res -ge 128 ]
> > -             then
> > -                     eval_gettextln "bisect run failed:
> > -exit code \$res from '\$command' is < 0 or >=3D 128" >&2
> > -                     exit $res
> > -             fi
> > -
> > -             # Find current state depending on run success or failure.
> > -             # A special exit code of 125 means cannot test.
> > -             if [ $res -eq 125 ]
> > -             then
> > -                     state=3D'skip'
> > -             elif [ $res -gt 0 ]
> > -             then
> > -                     state=3D"$TERM_BAD"
> > -             else
> > -                     state=3D"$TERM_GOOD"
> > -             fi
> > -
> > -             git bisect--helper --bisect-state $state >"$GIT_DIR/BISEC=
T_RUN"
> > -             res=3D$?
> > -
> > -             cat "$GIT_DIR/BISECT_RUN"
> > -
> > -             if sane_grep "first $TERM_BAD commit could be any of" "$G=
IT_DIR/BISECT_RUN" \
> > -                     >/dev/null
> > -             then
> > -                     gettextln "bisect run cannot continue any more" >=
&2
> > -                     exit $res
> > -             fi
> > -
> > -             if [ $res -ne 0 ]
> > -             then
> > -                     eval_gettextln "bisect run failed:
> > -'bisect-state \$state' exited with error code \$res" >&2
> > -                     exit $res
> > -             fi
> > -
> > -             if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BI=
SECT_RUN" >/dev/null
> > -             then
> > -                     gettextln "bisect run success"
> > -                     exit 0;
> > -             fi
> > -
> > -     done
> > -}
> > -
> >  get_terms () {
> >       if test -s "$GIT_DIR/BISECT_TERMS"
> >       then
> > @@ -137,7 +77,7 @@ case "$#" in
> >       log)
> >               git bisect--helper --bisect-log || exit ;;
> >       run)
> > -             bisect_run "$@" ;;
> > +             git bisect--helper --bisect-run "$@" || exit;;
> >       terms)
> >               git bisect--helper --bisect-terms "$@" || exit;;
> >       *)
> > --
> > 2.29.2
> >
> >
