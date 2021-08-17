Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63EC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298A160EB9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhHQUWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhHQUWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 16:22:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B785C0612A9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:20:09 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z2so23612552iln.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LnjxCsDMJBOya7hsnGKWk8899Dl1OYYmV2kkE9ARKNM=;
        b=Sfs2iftQSNvGuC3TQ3Lt5aqDJYvwvUHdACZ5Xb+uUAe73lGcPSArVjxviWwmJOg9Bt
         5Z9DbYWa60+cmjVN1ttuG03KBTMrj2h2zmkUXbpPH6SmyroIMK5WNTa4wLllYNOvanKS
         RZrU8PQSdd4dCBvp94DbqmkZooYkzRVhx0/xXUmnP/XMKlGuKxP74pfMKO6AWqBRu1Al
         rwEqqY19WrcUaLkNkidCQJiKaEG5mBQQ3HYMy4bpp7MFLdYkgVHtamoxTZcDEXYl6nkd
         qwNuB1I7wPzQingSuSNMzcvgMuJoSp85kNwoKFsZG1LOfRNoeke5jRX+MNa4USw/Yiue
         1e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LnjxCsDMJBOya7hsnGKWk8899Dl1OYYmV2kkE9ARKNM=;
        b=A24YywCgj6u/shaxEB/T3Jv2jDYi5jaGsb98OEoDoIwDmrQRHbL3+u2ZUZDpHvbZwU
         37Ja6monZzO/aUHJQZvvzoRhYFrzvY0ze2DdqQB54Vl4LO8VaiCKRrKsEbkICKCVEvCk
         lO4YGZ0RpznZPUnYQkPEn5jCV7LsP0+I2Q7W//0TCN6gE0PPRLJUstd0FUA2Rh8jKg9f
         D4XrvKZ8STKhm1BFC37sDejExWJpV0ZhJryUUbC2DxRcJepojVlbbDHRhUkC88fHoYic
         VgDbXQExxVUGr/CKTOTzny6HOFWXIPtRh6fSTiJt4TA1ww+WLerBN2Ua0cSNMAe3z4uZ
         MiDQ==
X-Gm-Message-State: AOAM530CIUA5UqeiVnv6rIbYdzWHsMn+phnrBriC1iFrUkRucmLy/kct
        J+H6N6g5uQ5fhGdrOAFtNucYkb6dSo8a8IjvQOTRG1NG
X-Google-Smtp-Source: ABdhPJwdIZ3PVYlFVrQU+HuyF8MOyIq6v/Z6BUm/OuzHQcyrWKaYbW5yxTZii0+0FG4WiqJeEkMM5m7f/hYKfHjqk3s=
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr3754249ila.30.1629231608665;
 Tue, 17 Aug 2021 13:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-5-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2108171329241.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108171329241.55@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 17 Aug 2021 22:19:58 +0200
Message-ID: <CAN7CjDC-ND-NtEc31+M=GuW+XczM7R6kAmTq0MfxgupU5Msr=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] bisect--helper: reimplement `bisect_visualize()`shell
 function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El mar, 17 ago 2021 a las 13:30, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> this looks good!
>
> Just one suggestion (but I won't insist on it):
>
> On Tue, 17 Aug 2021, Miriam Rubio wrote:
>
> > @@ -1036,6 +1037,44 @@ static enum bisect_error bisect_skip(struct bise=
ct_terms *terms, const char **ar
> >       return res;
> >  }
> >
> > +static int bisect_visualize(struct bisect_terms *terms, const char **a=
rgv, int argc)
> > +{
> > +     struct strvec args =3D STRVEC_INIT;
> > +     int flags =3D RUN_COMMAND_NO_STDIN, res =3D 0;
> > +     struct strbuf sb =3D STRBUF_INIT;
> > +
> > +     if (bisect_next_check(terms, NULL) !=3D 0)
> > +             return BISECT_FAILED;
> > +
> > +     if (!argc) {
> > +             if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv=
("MSYSTEM") ||
> > +                  getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk=
"))
> > +                     strvec_push(&args, "gitk");
> > +             else {
> > +                     strvec_pushl(&args, "log", NULL);
>
> This could be written more concisely as `strvec_push(&args, "log")`.
>
> > +                     flags |=3D RUN_GIT_CMD;
> > +             }
> > +     } else {
> > +             if (argv[0][0] =3D=3D '-') {
> > +                     strvec_pushl(&args, "log", NULL);
>
> Same here.
Sure, I will change it in both cases.
Thank you for reviewing,
Miriam.

>
> Otherwise, it looks good to me!
>
> Thank you,
> Dscho
>
> > +                     flags |=3D RUN_GIT_CMD;
> > +             } else if (strcmp(argv[0], "tig") && !starts_with(argv[0]=
, "git"))
> > +                     flags |=3D RUN_GIT_CMD;
> > +
> > +             strvec_pushv(&args, argv);
> > +     }
> > +
> > +     strvec_pushl(&args, "--bisect", "--", NULL);
> > +
> > +     strbuf_read_file(&sb, git_path_bisect_names(), 0);
> > +     sq_dequote_to_strvec(sb.buf, &args);
> > +     strbuf_release(&sb);
> > +
> > +     res =3D run_command_v_opt(args.v, flags);
> > +     strvec_clear(&args);
> > +     return res;
> > +}
> > +
> >  int cmd_bisect__helper(int argc, const char **argv, const char *prefix=
)
> >  {
> >       enum {
> > @@ -1048,7 +1087,8 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >               BISECT_STATE,
> >               BISECT_LOG,
> >               BISECT_REPLAY,
> > -             BISECT_SKIP
> > +             BISECT_SKIP,
> > +             BISECT_VISUALIZE,
> >       } cmdmode =3D 0;
> >       int res =3D 0, nolog =3D 0;
> >       struct option options[] =3D {
> > @@ -1070,6 +1110,8 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >                        N_("replay the bisection process from the given =
file"), BISECT_REPLAY),
> >               OPT_CMDMODE(0, "bisect-skip", &cmdmode,
> >                        N_("skip some commits for checkout"), BISECT_SKI=
P),
> > +             OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> > +                      N_("visualize the bisection"), BISECT_VISUALIZE)=
,
> >               OPT_BOOL(0, "no-log", &nolog,
> >                        N_("no log for BISECT_WRITE")),
> >               OPT_END()
> > @@ -1131,6 +1173,10 @@ int cmd_bisect__helper(int argc, const char **ar=
gv, const char *prefix)
> >               get_terms(&terms);
> >               res =3D bisect_skip(&terms, argv, argc);
> >               break;
> > +     case BISECT_VISUALIZE:
> > +             get_terms(&terms);
> > +             res =3D bisect_visualize(&terms, argv, argc);
> > +             break;
> >       default:
> >               BUG("unknown subcommand %d", cmdmode);
> >       }
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 6a7afaea8d..95f7f3fb8c 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -39,29 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> >  TERM_BAD=3Dbad
> >  TERM_GOOD=3Dgood
> >
> > -bisect_visualize() {
> > -     git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail =
|| exit
> > -
> > -     if test $# =3D 0
> > -     then
> > -             if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set=
}${SECURITYSESSIONID+set}" &&
> > -                     type gitk >/dev/null 2>&1
> > -             then
> > -                     set gitk
> > -             else
> > -                     set git log
> > -             fi
> > -     else
> > -             case "$1" in
> > -             git*|tig) ;;
> > -             -*)     set git log "$@" ;;
> > -             *)      set git "$@" ;;
> > -             esac
> > -     fi
> > -
> > -     eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
> > -}
> > -
> >  bisect_run () {
> >       git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail =
|| exit
> >
> > @@ -152,7 +129,7 @@ case "$#" in
> >               # Not sure we want "next" at the UI level anymore.
> >               git bisect--helper --bisect-next "$@" || exit ;;
> >       visualize|view)
> > -             bisect_visualize "$@" ;;
> > +             git bisect--helper --bisect-visualize "$@" || exit;;
> >       reset)
> >               git bisect--helper --bisect-reset "$@" ;;
> >       replay)
> > --
> > 2.29.2
> >
> >
