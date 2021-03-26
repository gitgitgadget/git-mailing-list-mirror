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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78EDC433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC70761A18
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCZNaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZNaA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 09:30:00 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D043C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 06:30:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k25so5707819oic.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DCQL6pSMglV44p9N8LUuVKM7BAaz1p2TV5YlSx898Cs=;
        b=RpDvPYCvIXwkD/VFIegUmHOcFzi86r3eLnb/5/D3LU6ZTltBsE2bJH2WjZtXNhn8eO
         OJmEq1ERo+V4ArYH6ziFjdDPIMj4Wd6rPiNM46KLb/X3zXJy+kcaitsLL9aDg+4b6LNj
         Co1Gs4T0N3vU0nksgY7eREDp/1Aand1gAq0sc5/JJH+OQytykqwopDPvuzF05ZEIEGIG
         5E05ZDhfRFfTRdL6xsVEiv+Hfh1Njyz1Ap0iKg5MVs5wvc00etKet1sP/Y95FGqxFHjf
         HNyiwLYrofE/g06IVdlnBgC7vRMo6IXNBKC2t/sZWsVA6p4KpLZBOteTwGfyPgGSO8eC
         KtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DCQL6pSMglV44p9N8LUuVKM7BAaz1p2TV5YlSx898Cs=;
        b=eN2jEoxbFNlN8nN2aEhSxBs5MjBbSTBUG1CyWdsj5kh6ohkPfoo2C+P+sk9PjunFYt
         mapcMmvdsmPlzD3C1Il33TsENjlrcMWCmPimcw0NAtDg4i0SDOlHo1YLvTy0N5unZkE5
         iiIbga+IDThGmA0HCdl0qV5Juc6awghBgXas3kGmwXuFHKKSkqv20VmPdO8ThPavX4It
         QXS91NDLO52ygoVjKI4AXlgQn3KmMlTyfUKzqeljHhNPbKbxWx2d/6GtyAk9ytlojDpv
         hS+Tk0xzE9bMP9UBUbrPBI84jwhxuvBWMVpyg1T15NNbfxMbTYOkeATxCwZ04Bja6HlJ
         Wnyw==
X-Gm-Message-State: AOAM531QI6BcsMBTeJ+SlFOq4iBNpSAhYDdHFFTfm3uruQfr2GGgs0WK
        RFZXaYuQv3b2++hxDibzYBRSJeTexHLVCLh4USc=
X-Google-Smtp-Source: ABdhPJwau8hhJLINnH2WPM0GfNuMujT7YfAMUEPdi9B+GerH7PZ1D19+ThUN1dDVLj1d1MNcv04Upptytp7CvX22VcY=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr7672595oig.120.1616765398550;
 Fri, 26 Mar 2021 06:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com>
 <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com> <xmqqwntuuav7.fsf@gitster.g>
In-Reply-To: <xmqqwntuuav7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 26 Mar 2021 21:29:46 +0800
Message-ID: <CAOLTT8TMFjvH1TzZ9qRtW1v7aDYypdajJxRKpmZ0TaG_xx5H0w@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC]trailer: pass arg as positional parameter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=886:28=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Original implementation of `trailer.<token>.command` use
>
> uses
>
> > `strbuf_replace` to replace $ARG in command with the <value>
> > of the trailer, but it have a problem: `strbuf_replace`
>
> has
>
> > replace the $ARG only once, If the user's trailer command
>
> replaces the $ARG only once.
>

Okay... singular and plural problems.

> > have used more than one $ARG, the remaining replacement will
> > fail.
>
> "will fail" is quite vague.  It is just left unreplaced, and if the
> user expects all of them to be replaced, then the expectation and
> reality would not match, but all of that you have already said by
> "replaces the $ARG only once.", so I think this sentence should be
> removed.
>

Indeed so.

> > If directly modify the implementation of the original
> > `trailer.<token>.command`, The user=E2=80=99s previous `'$ARG'` in
> > trailer command will not be replaced.
>
> That statement does not make much sense.  Depending on the way how
> the implementation is "directly" modified, you can fix the "replaces
> only once" problem without introducing such a problem.  Just look
> for '$ARG' in the string and replace all of them, not just the first
> one.  It's not too difficult.
>
> This confusion primarily comes from the fact that you forgot to
> explain the other problem you are fixing, I think.  Even though the
> trailer.<token>.command documentation implies that the user is
> expected to give a shell script or some sort as the command and the
> use of $ARG makes it look like a shell variable, the original
> implementation does not treat it as a shell variable at all.  And
> the textual replacement is done without making sure the value being
> replaced has characters with special meaning in the shell language.
>

Yes! The accidental injection problem caused should have been the focus
of my explanation.

> So existing .command may incorrectly use $ARG inside a single-quote
> pair and expect it to be replaced to a string inside a single-quote
> pair.  A malformed, or worse, malicious, value would escape out of
> the single-quote pair (remember, the '; rm -fr .' example?) and
> execute arbitrary code in an unexpected way.  The (ungrammatical)
> "if directly modify the implementation" refers to a potential way to
> fix these two problems at the same time by doing the $ARG thing
> without using textual replacement, namely, exporting the value as an
> environment variable ARG.  If that approach was taken, then, $ARG
> enclosed in a single-quote pair will no longer be replaced, which
> makes it a backward incompatible change.
>

Oh, I remeber it: terrible shell injection. Specifically, it looks like thi=
s:

$ git config trailer.sign.command "git log --author=3D'\$ARG'"
$ git interpret-trailers --trailer "sign =3D adl' && rm -rf ./repo/'"

now I know that should be "backward incompatible change" as you said.

> But without describing what solution you are talking about, your
> three-line description does not make much sense.
>
> > So now add new config
> > "trailer.<token>.cmd", pass trailer's value as positional
> > parameter 1 to the user's command, the user can use $1 as
> > trailer's value, to implement original variable replacement.
> >
> > If the user has these two configuration: "trailer.<token>.cmd"
> > and "trailer.<token>.command", "cmd" will execute and "command"
> > will not executed.
> >
> > Original `trailer.<token>.command` can still be used until git
> > completely abandoned it.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> Let's rewrite it completely.
>
>         The `trailer.<token>.command` configuration variable
>         specifies a command (run via the shall, so it does not have
>         to be a single name of or path to the command, but can be a
>         shell script), and the first occurrence of substring $ARG is
>         replaced with the value given to the `interpret-trailer`
>         command for the token.  This has two downsides:
>
>         * The use of $ARG in the mechanism misleads the users that
>           the value is passed in the shell variable, and tempt them
>           to use $ARG more than once, but that would not work, as
>           the second and subsequent $ARG are not replaced.
>
>         * Because $ARG is textually replaced without regard to the
>           shell language syntax, even '$ARG' (inside a single-quote
>           pair), which a user would expect to stay intact, would be
>           replaced, and worse, if the value had an unmatching single
>           quote (imagine a name like "O'Connor", substituted into
>           NAME=3D'$ARG' to make it NAME=3D'O'Connor), it would result in
>           a broken command that is not syntactically correct (or
>           worse).
>
>         Introduce a new `trailer.<token>.cmd` configuration that
>         takes higher precedence to deprecate and eventually remove
>         `trailer.<token>.command`, which passes the value as a
>         parameter to the command.  Instead of "$ARG", the users will
>         refer to the value as positional argument, $1, in their
>         scripts.
>
> I tried to cover everything we need to tell the reviewers about this
> change with the above.  Did I miss anything?

Nothing to blame, feature of the old command, 2 problems, 1 solution,
this is what the log should look like.

>
> > +trailer.<token>.cmd::
> > +     Similar to 'trailer.<token>.command'. But the difference is that
> > +     `$1` is used in the command to replace the value of the trailer
> > +     instead of the original `$ARG`, which means that we can pass the
> > +     trailer value multiple times in the command.
>
> We eventually want to deprecate the .command, so we'd prefer not to
> rely on its description too much (e.g. try to find a way to say what
> you want to say without "instead of the original `$ARG`").
>

Oh! here I can=E2=80=99t rely on the documentation of the old `.command`, o=
therwise it=E2=80=99s
not easy to delete the old documentation.

>         The command specified by this configuration variable is run
>         with a single parameter, which is the <value> part of an
>         existing trailer with the same <token>.  The output from the
>         command is then used as the value for the <token> in the
>         resulting trailer.
>
> would be the replacement for the part that talks about $ARG in the
> description of trailer.<token>.command.
>
> The original description for `trailer.<token>.command` is so jumbled
> (not your failure at all) that I had a hard time to understand what
> it is trying to say (e.g. what does "as if a special <token>=3D<value>
> argument were added at the beginning of the command line" mean?  Is
> it making a one-shot export of environment variable to run the
> command???), so the above may need further adjustment.  Christian?
> Care to help out?
>
> > +     E.g. `git config trailer.sign.cmd "test -n \"$1\" && echo \"$1\" =
|| true "`.
>
> An example is good.  There is a whole EXAMPLES section in this
> manual page, and the one that uses $ARG may be a good candidate to
> look at and change to use .cmd (instead of .command).
>

Okay, I will modify the paragraphs containing `.command` in these examples.

> > +     If the user has these two configuration: "trailer.<token>.cmd"
> > +     and "trailer.<token>.command", "cmd" will be executed and "comman=
d"
> > +     will not be executed.
>
>         When both .cmd and .command are given for the same <token>,
>         .cmd is used and .command is ignored.
>
> > diff --git a/trailer.c b/trailer.c
> > index be4e9726421c..634d3f1ff04a 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > @@ -14,6 +14,7 @@ struct conf_info {
> >       char *name;
> >       char *key;
> >       char *command;
> > +     char *cmd;
> >       enum trailer_where where;
> >       enum trailer_if_exists if_exists;
> >       enum trailer_if_missing if_missing;
> > @@ -127,6 +128,7 @@ static void free_arg_item(struct arg_item *item)
> >       free(item->conf.name);
> >       free(item->conf.key);
> >       free(item->conf.command);
> > +     free(item->conf.cmd);
> >       free(item->token);
> >       free(item->value);
> >       free(item);
> > @@ -216,18 +218,24 @@ static int check_if_different(struct trailer_item=
 *in_tok,
> >       return 1;
> >  }
> >
> > -static char *apply_command(const char *command, const char *arg)
> > +static char *apply_command(const char *command, const char *cmd_, cons=
t char *arg)
> >  {
> >       struct strbuf cmd =3D STRBUF_INIT;
> >       struct strbuf buf =3D STRBUF_INIT;
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> >       char *result;
> >
> > -     strbuf_addstr(&cmd, command);
> > -     if (arg)
> > -             strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> > -
> > -     strvec_push(&cp.args, cmd.buf);
> > +     if (cmd_) {
> > +             strbuf_addstr(&cmd, cmd_);
> > +             strvec_push(&cp.args, cmd.buf);
> > +             if (arg)
> > +                     strvec_push(&cp.args, arg);
> > +     } else if (command) {
> > +             strbuf_addstr(&cmd, command);
> > +             strvec_push(&cp.args, cmd.buf);
> > +             if (arg)
> > +                     strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> > +     }
>
> OK.  it is clear cmd_ takes precedence this way.
>
> Later (not as part of this patch, but a few releases down the road),
> we may want to add a warning() about using a deprecated feature when
> "else if (command)" block is taken.
>

Fine, I will keep this version of "cmd priority execution" for now.

> > @@ -247,7 +255,7 @@ static char *apply_command(const char *command, con=
st char *arg)
> >
> >  static void apply_item_command(struct trailer_item *in_tok, struct arg=
_item *arg_tok)
> >  {
> > -     if (arg_tok->conf.command) {
> > +     if (arg_tok->conf.command || arg_tok->conf.cmd) {
> >               const char *arg;
> >               if (arg_tok->value && arg_tok->value[0]) {
> >                       arg =3D arg_tok->value;
> > @@ -257,7 +265,7 @@ static void apply_item_command(struct trailer_item =
*in_tok, struct arg_item *arg
> >                       else
> >                               arg =3D xstrdup("");
> >               }
> > -             arg_tok->value =3D apply_command(arg_tok->conf.command, a=
rg);
> > +             arg_tok->value =3D apply_command(arg_tok->conf.command, a=
rg_tok->conf.cmd, arg);
>
> It might be cleaner to just pass arg_tok->conf to apply_command()
> and hide "cmd takes precedence over command" as an implementation
> detail of that helper function.
>
> The implementation looks as good as the original "command" with that
> change at this point.  Documentation may need a bit more polishing.
>

you're right.

> Thanks.

Thanks, Junio.
You and the people in the git community are very enthusiastic,
You have patiently explained these small mistakes that I made,
and taught me a lot of problems that I didn't notice.

Grateful.

--
ZheNing Hu
