Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D17EC8743
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbjIGQkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbjIGQhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:37:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3044EEC
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:13:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so138602066b.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103176; x=1694707976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUXbk7EYn59HUKKskEjjkbXnrktwTFggMESpCkoQWJs=;
        b=dURdAJKt/GORIJC66URT2GEfC/4BqkxKSkNY2Z1UIKMF7gX++5x+zluWNABYtUPAr4
         3wPghedzJ25HWatVKZUXxHqBdX+kqnbFvxfgTANpyqbvAiq980MpTMFK7Dim0a+IakkG
         96fzAnfk1qeBGju2S7431eLEaSovpouBYekF8RFpJqD0MO9nnXR0Mo+p1PEQtS0ZzXFY
         8/qs3rrSqOLO0vmBkPjti2haWpRA7JJGbhJzRQ/Zw2QoBwaKR6vzFkuLsifHhGz8eKmd
         5G7B7zxL+KHToKfTe58zLS8VW+D73sAszeGbF0zffeasEm5ZUV10CmIsszOiFh07wnjz
         t1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103176; x=1694707976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUXbk7EYn59HUKKskEjjkbXnrktwTFggMESpCkoQWJs=;
        b=D4+uhfEE2EiZizubnRrQPxHpLzKU2IFhva/1aC4q3syIZNNUuaPRJL6u2ez80eDV3C
         SIc82TprJFINewDjzu4wnAQzi+AswIjfpYpv/kxw+JLptTJZ/W8mpa+Rxq0ymJm+goo5
         Pw1flxrHIpR2FRfhkq8Md/MSbXPYvnqqvJO83XJzp5Lgywqp4hHmTNDyR5tmFzp81tzu
         ZdT/Cnn3kpRhy/Xq5clTigV20Lj6WcwrRZyKwAN3+U1UVKEkWA2qGpGbpjYGFuEmj11c
         zNFCc75mj70YRJWKvo/uyC1VQCFHp9Y+8CsxujuntQAeS3W/Oi6IC0QMKYyWp7zLp0BJ
         zLSg==
X-Gm-Message-State: AOJu0YwoA8On7mtOmdQIIEoE23jP9MO98D7sXTuVYzT9c71b6Iq7DKM5
        N+kia5pqDuuJrsHWFOKJXbwVSnTsI/vRdXgCJLxur/XO
X-Google-Smtp-Source: AGHT+IF4RgBcY5r981gzxaj3UvbaCR9unV0AKtC9/sFBMhzlDU+3gebrJFcRCSNGw8A/ENyD68HRZnfYSgCuNe4HcHA=
X-Received: by 2002:a17:906:53cc:b0:9a9:d5e0:5c57 with SMTP id
 p12-20020a17090653cc00b009a9d5e05c57mr2341990ejo.22.1694075721927; Thu, 07
 Sep 2023 01:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-14-christian.couder@gmail.com>
 <87h6qzst8u.fsf@iotcl.com>
In-Reply-To: <87h6qzst8u.fsf@iotcl.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:35:09 +0200
Message-ID: <CAP8UFD0T64UcDLUrbjrR0DvD4DQLuZ==ATk9ewSMkMn+9VhMAg@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] replay: add --advance or 'cherry-pick' mode
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 12:09=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +     /*
> > +      * When the user specifies e.g.
> > +      *   git replay origin/main..mybranch
> > +      *   git replay ^origin/next mybranch1 mybranch2
>
> When I'm trying these, I'm getting the error:
>     error: option --onto or --advance is mandatory
>
> In what situation can I omit both --onto and --advance?

It was possible with version 1 of this series as one of the patches
allowed the command to guess the base:

https://lore.kernel.org/git/20230407072415.1360068-13-christian.couder@gmai=
l.com/

so --onto wasn't needed to specify it.

Comments on that patch said that it might be better to focus on a
plumbing command first and for that the patch wasn't needed, so I
removed it in version 2.

> > +static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
> > +                               const char *onto_name,
> > +                               const char **advance_name,
> > +                               struct commit **onto,
>
> Would it make sense to call this target?

This is more the new base we are rebasing target branches onto. So if
we want to change the name, `--base` or `--newbase` would make more
sense. `git rebase` already has `--onto` though, so, if we want to be
consistent with it, we should keep `--onto` for this.

> > +                               struct strset **update_refs)
> > +{
> > +     struct ref_info rinfo;
> > +
> > +     get_ref_information(cmd_info, &rinfo);
> > +     if (!rinfo.positive_refexprs)
> > +             die(_("need some commits to replay"));
> > +     if (onto_name && *advance_name)
> > +             die(_("--onto and --advance are incompatible"));
>
> Do we actually need to disallow this? I mean from git-replay's point of
> view, there's no technical limitation why can cannot support both modes
> at once. The update-ref commands in the output will update both target
> and source branches, but it's not up to us whether that's desired.

I am not sure what you call "target" and "source" branches. Anyway
here is in simple terms the way the command works:

  1) it takes either `--onto <newbase>` or `--advance <branch>` and
then one or more <revision-range>,
  2) it replays all the commits in the <revision-range> onto either
<newbase> or <branch>,
  3) in case of `--advance`, it outputs a single command for `git
update-ref --stdin` to advance <branch> to the last commit that was
just replayed,
  4) in case of `--onto`, it outputs a number of commands for `git
update-ref --stdin` to update the branches in <revision-range> to
where the tip commits of these branches have been replayed.

So `--advance` is like a cherry-pick, and `--onto` is like a rebase.

It would be possible to do both a rebase onto a branch and a
cherry-pick of the rebased commits onto that branch, but this is not
very common and you can achieve the same result by just rebasing and
then using `git reset` or `git update-ref` to make the branch point to
the result of the rebase. So I don't see the point of complicating the
command at this point.

> > +     else if (onto_name) {
>
> No need to 'else' here IMHO.
>
> > +             *onto =3D peel_committish(onto_name);
> > +             if (rinfo.positive_refexprs <
> > +                 strset_get_size(&rinfo.positive_refs))
> > +                     die(_("all positive revisions given must be refer=
ences"));
>
> I tested this locally with the following command:
>
> $ git replay --onto main OID..OID
>
> This command didn't give any errors, neither did it return any
> update-ref lines. I would have expected to hit this die().

Yeah, this might be unexpected.

I tested it too and 'rinfo.positive_refexprs' is 1 while
'strset_get_size(&rinfo.positive_refs)' is 0 with such a command.

The result does not look wrong though. Above that code there is:

    if (!rinfo.positive_refexprs)
        die(_("need some commits to replay"));

so it looks like there is at least a check that the revision range
passed to the command contains positive commits.

It might be possible that users prefer a command that outputs nothing
when there is nothing to replay instead of erroring out.

> > +     } else if (*advance_name) {
> > +             struct object_id oid;
> > +             char *fullname =3D NULL;
> > +
> > +             *onto =3D peel_committish(*advance_name);
> > +             if (repo_dwim_ref(the_repository, *advance_name, strlen(*=
advance_name),
> > +                          &oid, &fullname, 0) =3D=3D 1) {
> > +                     *advance_name =3D fullname;
> > +             } else {
> > +                     die(_("argument to --advance must be a reference"=
));
> > +             }
> > +             if (rinfo.positive_refexprs > 1)
> > +                     die(_("cannot advance target with multiple source=
 branches because ordering would be ill-defined"));
>
> The sources aren't always branches, so I suggest something like:
>
> +                       die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));

Yeah, that looks reasonable. I have made this change in version 4 I
will send very soon.

> > +     determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
> > +                           &onto, &update_refs);
> > +
> > +     if (!onto) /* FIXME: Should handle replaying down to root commit =
*/
> > +             die("Replaying down to root commit is not supported yet!"=
);
>
> When I was testing locally I tried the following:
>
> $ git replay --onto main feature
>
> I was expecting this command to find the common ancestor automatically,
> but instead I got this error. I'm fine if for now the command does not
> determine the common ancestor yet, but I think we should provide a
> better error for this scenario.

I agree that it isn't very user friendly. We could indeed try to find
if there is a common ancestor, and, if that's the case, suggest
another way to call the command. This is a plumbing command in its
early stage though for now. So I guess it's Ok to postpone working on
nicer error messages.

> > +test_expect_success 'using replay on bare repo to perform basic cherry=
-pick' '
> > +     git -C bare replay --advance main topic1..topic2 >result-bare &&
> > +     test_cmp expect result-bare
> > +'
> > +
> >  test_done
>
> Shall we add a test case when providing both --onto and --advance? And
> one that omits both?

Ok, I have made this change in version 4.
