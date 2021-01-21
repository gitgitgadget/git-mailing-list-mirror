Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33462C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 11:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C759B23899
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 11:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbhAULB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbhAUK7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 05:59:54 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801BC061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:59:14 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id n127so375541ooa.13
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gNRUfDPwq3qG3IpftgrZ1i7HIkzZDNE8eVPbc97eRys=;
        b=KcDoGrTnP0KeFCh9dcM5fyH4ig0ElXk3HfPoE2j4cpOU/NKbiDnDHovzzajKN5ux8J
         X7VjdSgZQ0czv7Dm5TrUc00miEL8aBJvQPMSio04yTqtWOq/Ejyl3rwCKnEe0LneW9iv
         zWB+QOPckCo1me84xol3QKIcb2//Vo/dBXbKT4A9d3oLcyJdTIwRS/qW556mIcR5kxGn
         JcFoYCgsVlPRwwFld63RI7Iu5S+IckoThm8PxuJbJyRyrrbxJW78/JCHb1sccF7rYFjh
         SLLAjMKi41J0jFPiCraEtfJMlGrVxBqEkgwVEe3hIMjUbyYinunftH93FaMvv8X4pHpD
         DaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gNRUfDPwq3qG3IpftgrZ1i7HIkzZDNE8eVPbc97eRys=;
        b=ULLWHwvl285DZdGuH54UA5maSnSd0giATEA+N8UvHATsEdq4MuFKFrpauAoQ8PeSCb
         gU+lmBgMWcpudPM98smbC2k5cSlPsdJhmkBH5VNxoTiLzxw3CJLVkxB00lSkzdlRRNWm
         T8a1HwMwcttL/T6AP8kcgjQGCXfygZqo98Gsrg/7Hcx+76iOWpvIG1IJzQPRFS0dWn8A
         xkfaIp0nOpQHOcHPawG9ZlQuXELR9b7bJXMs96VI4/fHy+lgSnmFWvSZXzF2W2OxjPtF
         X1WV3wu6gnVVsxAIScaEk2nlyhXJ6a9qv0z1rwEE2gORMT/dtxpKEBwrF78jKC7mfSE2
         eAew==
X-Gm-Message-State: AOAM530ne0hHf3fBotvTMjMR7eSctXjzG3Ln+kxro+57GEhe7zrSf6Ox
        gt5TYPy1XZKa1AQSUG9VlQ4ypoG/GqIZgw1Lph7Nxrowt9YGQuca
X-Google-Smtp-Source: ABdhPJyqPX3VXyHnjT4ffilP/S1xHLsqb4GtJE1/4mjHJJAA1jEkse63m59nQIL+h1/NoXv/FaKrSltJww6QlSd4094=
X-Received: by 2002:a4a:98e7:: with SMTP id b36mr9062201ooj.3.1611226753357;
 Thu, 21 Jan 2021 02:59:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
 <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
 <xmqq7do7fggn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7do7fggn.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 21 Jan 2021 19:00:42 +0800
Message-ID: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=885:26=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -321,30 +324,46 @@ static void show_files(struct repository *repo, s=
truct dir_struct *dir)
> >
> >               construct_fullname(&fullname, repo, ce);
> >
> > +             if (skipping_duplicates && last_shown_ce &&
> > +                     !strcmp(last_shown_ce->name,ce->name))
> > +                             continue;
>
> Style.  Missing SP after comma.
Get it.
>
> >               if ((dir->flags & DIR_SHOW_IGNORED) &&
> >                       !ce_excluded(dir, repo->index, fullname.buf, ce))
> >                       continue;
> >               if (ce->ce_flags & CE_UPDATE)
> >                       continue;
> >               if (show_cached || show_stage) {
> > +                     if (skipping_duplicates && last_shown_ce &&
> > +                             !strcmp(last_shown_ce->name,ce->name))
> > +                                     continue;
>
> OK.  When show_stage is set, skipping_duplicates is automatically
> turned off (and show_unmerged is automatically covered as it turns
> show_stage on automatically).  So this feature has really become
> "are we showing only names, and if so, did we show an entry of the
> same name before?".
Yeah,showing only names,so I yesterday ask such question :)
>
> >                       if (!show_unmerged || ce_stage(ce))
> >                               show_ce(repo, dir, ce, fullname.buf,
> >                                       ce_stage(ce) ? tag_unmerged :
> >                                       (ce_skip_worktree(ce) ? tag_skip_=
worktree :
> >                                               tag_cached));
> > +                     if (show_cached && skipping_duplicates)
> > +                             last_shown_ce =3D ce;
>
> The code that calls show_ce() belonging to a totally separate if()
> statement makes my stomach hurt---how are we going to guarantee that
> "last shown" really will keep track of what was shown last?
>
> Shouldn't the above be more like this?
>
> -                       if (!show_unmerged || ce_stage(ce))
> +                       if (!show_unmerged || ce_stage(ce)) {
>                                 show_ce(repo, dir, ce, fullname.buf,
>                                         ce_stage(ce) ? tag_unmerged :
>                                         (ce_skip_worktree(ce) ? tag_skip_=
worktree :
>                                                 tag_cached));
> +                               last_shown_ce =3D ce;
> +                       }
>
well,I am also thinking about this question :"last_shown_ce" is not true
last shown ce,but may be If "last_shown_ce" truly seen every last shown
ce ,We may need more cumbersome logic to make the program correct.
I have tried the processing method of your above code before, but found
 that some errors may have occurred.
> It does maintain last_shown_ce even when skipping_duplicates is not
> set, but I think that is overall win.  Assigning unconditionally
> would be cheaper than making a conditional jump on the variable and
> make assignment (or not).
>
> >               }
> >               if (ce_skip_worktree(ce))
> >                       continue;
> > +             if (skipping_duplicates && last_shown_ce &&
> > +                     !strcmp(last_shown_ce->name,ce->name))
> > +                             continue;
>
> Style.  Missing SP after comma.
>
> OK, if we've shown an entry of the same name under skip-duplicates
> mode, and the code that follows will show the same entry (if they
> decide to show it), so we can go to the next entry early.
>
> >               err =3D lstat(fullname.buf, &st);
> >               if (err) {
> > -                     if (errno !=3D ENOENT && errno !=3D ENOTDIR)
> > -                             error_errno("cannot lstat '%s'", fullname=
.buf);
> > -                     if (show_deleted)
> > +                     if (skipping_duplicates && show_deleted && show_m=
odified)
> >                               show_ce(repo, dir, ce, fullname.buf, tag_=
removed);
> > -                     if (show_modified)
> > -                             show_ce(repo, dir, ce, fullname.buf, tag_=
modified);
> > +                     else {
> > +                             if (errno !=3D ENOENT && errno !=3D ENOTD=
IR)
> > +                                     error_errno("cannot lstat '%s'", =
fullname.buf);
> > +                             if (show_deleted)
> > +                                     show_ce(repo, dir, ce, fullname.b=
uf, tag_removed);
> > +                             if (show_modified)
> > +                                     show_ce(repo, dir, ce, fullname.b=
uf, tag_modified);
> > +                     }
> >               } else if (show_modified && ie_modified(repo->index, ce, =
&st, 0))
> >                       show_ce(repo, dir, ce, fullname.buf, tag_modified=
);
>
> This part will change shape quite a bit when we follow the
> suggestion I made on 1/3, so I won't analyze how correct this
> version is.
>
Fine...
> > +             last_shown_ce =3D ce;
> >       }
> >
> >       strbuf_release(&fullname);
> > @@ -571,6 +590,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
> >                       N_("pretend that paths removed since <tree-ish> a=
re still present")),
> >               OPT__ABBREV(&abbrev),
> >               OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data=
")),
> > +             OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppres=
s duplicate entries")),
> >               OPT_END()
> >       };
> >
> > @@ -610,6 +630,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
> >                * you also show the stage information.
> >                */
> >               show_stage =3D 1;
> > +     if (show_tag || show_stage)
> > +             skipping_duplicates =3D 0;
>
> OK.
>
> >       if (dir.exclude_per_dir)
> >               exc_given =3D 1;
> >
>
> Thanks.

Thanks,Junio,I find my PR in gitgitgadget have been accepted.
By the way,
I found the problem "leftoverbit" and "good first issue" on gitgitgadget
It may not have been updated for a long time, and most of the above
may have been resolved.

Should it do an update?
Then we can happily be a "bounty hunter" in the git community, haha!
