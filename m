Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B9C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiBVPu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBVPuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:50:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0B0473A1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645544997;
        bh=wVa6Z6KjDrjJp1cIXHSy3ZssVAZhtyNT7LBYed44ewc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=clTg9LoVzZ8BWRhHsyzGB06guQVPfQez6DCBLhDXDR/2qr4sB8nsc8Y5E1c0nxSsp
         QCUB5MB0GHRlQeUL2NNksba83Jky5GKhv5o2tS7AXlIv8EPp/r2ZbkZrYLDF21BZ9R
         uBYfEeInVX4Xlk0yvA13K/byACOuMz4IL2aySMaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1nns0946Un-00U6js; Tue, 22
 Feb 2022 16:49:57 +0100
Date:   Tue, 22 Feb 2022 16:49:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 07/11] bisect: move even the option parsing to
 `bisect--helper`
In-Reply-To: <CABPp-BG9-UWGLF-P5Cboj4JTv10gUXwO3NjAAgFo6215oo2WHw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221648190.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <515e86e20758ed7f5b4a8ce8f38bfbbac27ec42a.1643328752.git.gitgitgadget@gmail.com> <CABPp-BG9-UWGLF-P5Cboj4JTv10gUXwO3NjAAgFo6215oo2WHw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TeKwbYDGx8/puTtF+ZBC9EzaRCm74uffpj5gPwPeiPpFIZ8N900
 V/dG9xZcTkykDF5+X00zg2rsudYIcyf4s2uuCwh1hsNb4oX+YJwREw63Z3yZN2qYYeTycDW
 mh0sem5p2Ctlsz31ajxB1ERGRgRrVf8yBuN4iBszNBlvreDe4kadfR0SowRSL70TYEHzGrs
 e7LwfepZS0sm/crWVl1AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rw69s5o/umM=:4rM028JY7Vv0GZLbKIGbb0
 m8BR+PqvfKUPXQbxTBlCDtRHMqSlobj5hax14JcjHnkaC6zP20JoSj1TLNXTRmRih3qDRN2tG
 4l3qjgteSN+0tXH97KlFlS9u/XFlgqSYJpLW5bxo3zVEigBUkV/zoskLpqHfGYvFbFne37NmQ
 uK1RVciT1DKyOO/YbpX9tXLM87JkGbWiO/PfgpYj6ZCCz6SSYAwTeUd9q0aqU1yu7HPW+Joss
 4tywBeHgthPXPww36g7J14p/+XToGOp+5l2KKwUEAWIU4GvmDkiDp8siRG2SyEIBrJoOVMi68
 ff+onhIUb3e+uTJUeypYF763bLrGrRM8r5cNJ8+esGcqA56p0sfcad35OSp2N9U0X4IGsg3c9
 tcTl6kYNEwxNgVXQdxpssxkmsBYEB4YmPKJu2G8TAzITvfhene7qCWn/qjUc9qmGXvC1gYDeM
 bxvQHvc+qN+yGkN6m+dMf85z80brFlu8gtgM60SujM0FRfZttEDw4+Zfn2quEsvlgn9vfsTbS
 umCND9b1J+6FZqwb6g6D9LQFwn9A8JgWQobhdxlTv+UUXVdDjtAJ/tTbxcZletAIZ/0bMmgWC
 dYuPVuUDxxKmVb/9Ukzc1szh5KIIuSARGP3jkDaNs17+x/S1kDOqXcgcQTONbIJcZuOJrmtAI
 gFmVM8X9nR0RtZZcacEFVO84krpgwz4iO3nknnEdox0DfWsSdasrrYE+SDqK76y3lG/kEkgVm
 uZXefLXKTXuBo+qsg1ot9zR3vmIO/BabRF7De9Qq4bewQ5qpaGLLwvf9qhKWnpb2xJA/Fs1Xo
 h7acXoV6jSF66AjK6zO7Pgld6EWppMCgXsPCKI+W+GnVPKEvYx2KZaamy0eye9t1c+ShmnnhQ
 1q3oEDpfsv1tdWP+dK4s4/aoq4khdN0h2Ayx+xKuiJbtZxzlvuYAf2h3mcGyN370ioZd1QONi
 W3xHd7OVZitqoXmyfRqEnbCHoq4Tsm1DUahngS9doBdAJICDef2DDUMY95yzwQT6NyLThiBLt
 6gxpI0hwme2NEin0cfa3gcEU/xfzGZLoHJA18RAD7bGYgLiDqOkn00TxXdmSrN8xSamv9AiEv
 OjU1HsGYU6kFFA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Feb 2022, Elijah Newren wrote:

> On Fri, Jan 28, 2022 at 3:27 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > [...]
> > +       const char *command =3D argc > 1 ? argv[1] : "help";
> >
> > -       argc =3D parse_options(argc, argv, prefix, options,
> > -                            git_bisect_helper_usage,
> > -                            PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_=
UNKNOWN);
> > +       /* Handle -h and invalid options */
> > +       parse_options(argc - 1, argv + 1, prefix, options,
> > +                     git_bisect_usage,
> > +                     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN=
 |
> > +                     PARSE_OPT_ONE_SHOT | PARSE_OPT_STOP_AT_NON_OPTIO=
N);
> >
> > -       if (!cmdmode && argc > 0) {
> > +       if (!strcmp("help", command))
> > +               usage_with_options(git_bisect_usage, options);
>
> I think the rest of the changes in this file would be much easier to
> read if you did a
>    argc -=3D 2
>    argv +=3D 2
> here...
>
> > +       else if (!strcmp("start", command)) {
>
> ...and dropped the else here, just starting a new 'if' instead.

Makes sense.

While at it, I also explicitly handle the `-h` case and no longer bother
with the `parse_options()` call at all anymore.

>
> >                 set_terms(&terms, "bad", "good");
> > -               get_terms(&terms);
> > -               if (!check_and_set_terms(&terms, argv[0]))
> > -                       cmdmode =3D BISECT_STATE;
> > -       }
> > -
> > -       if (!cmdmode)
> > -               usage_with_options(git_bisect_helper_usage, options);
> > -
> > -       switch (cmdmode) {
> > -       case BISECT_START:
> > -               set_terms(&terms, "bad", "good");
> > -               res =3D bisect_start(&terms, argv, argc);
> > -               break;
> > -       case BISECT_TERMS:
> > -               if (argc > 1)
> > -                       return error(_("--bisect-terms requires 0 or 1=
 argument"));
> > -               res =3D bisect_terms(&terms, argc =3D=3D 1 ? argv[0] :=
 NULL);
> > -               break;
> > -       case BISECT_SKIP:
> > +               res =3D bisect_start(&terms, argv + 2, argc - 2);
> > +       } else if (!strcmp("terms", command)) {
> > +               if (argc > 3)
> > +                       return error(_("'terms' requires 0 or 1 argume=
nt"));
> > +               res =3D bisect_terms(&terms, argc =3D=3D 3 ? argv[2] :=
 NULL);
> > +       } else if (!strcmp("skip", command)) {
> >                 set_terms(&terms, "bad", "good");
> >                 get_terms(&terms);
> > -               res =3D bisect_skip(&terms, argv, argc);
> > -               break;
> > -       case BISECT_NEXT:
> > -               if (argc)
> > -                       return error(_("--bisect-next requires 0 argum=
ents"));
> > +               res =3D bisect_skip(&terms, argv + 2, argc - 2);
> > +       } else if (!strcmp("next", command)) {
> > +               if (argc !=3D 2)
> > +                       return error(_("'next' requires 0 arguments"))=
;
> >                 get_terms(&terms);
> >                 res =3D bisect_next(&terms, prefix);
> > -               break;
> > -       case BISECT_RESET:
> > -               if (argc > 1)
> > -                       return error(_("--bisect-reset requires either=
 no argument or a commit"));
> > -               res =3D bisect_reset(argc ? argv[0] : NULL);
> > -               break;
> > -       case BISECT_VISUALIZE:
> > +       } else if (!strcmp("reset", command)) {
> > +               if (argc > 3)
> > +                       return error(_("'reset' requires either no arg=
ument or a commit"));
> > +               res =3D bisect_reset(argc > 2 ? argv[2] : NULL);
> > +       } else if (one_of(command, "visualize", "view", NULL)) {
> >                 get_terms(&terms);
> > -               res =3D bisect_visualize(&terms, argv, argc);
> > -               break;
> > -       case BISECT_REPLAY:
> > -               if (argc !=3D 1)
> > +               res =3D bisect_visualize(&terms, argv + 2, argc - 2);
> > +       } else if (!strcmp("replay", command)) {
> > +               if (argc !=3D 3)
> >                         return error(_("no logfile given"));
> >                 set_terms(&terms, "bad", "good");
> > -               res =3D bisect_replay(&terms, argv[0]);
> > -               break;
> > -       case BISECT_LOG:
> > -               if (argc)
> > -                       return error(_("--bisect-log requires 0 argume=
nts"));
> > +               res =3D bisect_replay(&terms, argv[2]);
> > +       } else if (!strcmp("log", command)) {
> > +               if (argc > 2)
> > +                       return error(_("'log' requires 0 arguments"));
> >                 res =3D bisect_log();
> > -               break;
> > -       case BISECT_RUN:
> > -               if (!argc)
> > +       } else if (!strcmp("run", command)) {
> > +               if (argc < 3)
> >                         return error(_("bisect run failed: no command =
provided."));
> >                 get_terms(&terms);
> > -               res =3D bisect_run(&terms, argv, argc);
> > -               break;
> > -       case BISECT_STATE:
> > -               if (!terms.term_good) {
> > -                       set_terms(&terms, "bad", "good");
> > -                       get_terms(&terms);
> > +               res =3D bisect_run(&terms, argv + 2, argc - 2);
> > +       } else {
> > +               set_terms(&terms, "bad", "good");
> > +               get_terms(&terms);
> > +               if (!check_and_set_terms(&terms, command))
> > +                       res =3D bisect_state(&terms, argv + 1, argc - =
1);
>
> Oh, hmm... this one is +1,-1 while all others are +2,-2, because there
> is not a separate "command"; the command was implicit and so that
> reserved argument is actually part of the terms.  Still if we did the
> offset by two trick above, I guess we'd just add a comment here and do
> argv-1, argc+1?

Right, we can just "shift the command back in".

Thank you,
Dscho
