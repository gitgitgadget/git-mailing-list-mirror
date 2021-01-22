Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C395C4332D
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC6023A80
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 10:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAVKO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbhAVJtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 04:49:42 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9895FC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 01:48:59 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id y14so1250392oom.10
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uceltci0zeUgPeimI85Lt1MAkhpxBjRIOJ0H1yIDgH0=;
        b=fF64Tr+EzWrrIORe4kwFRDhMlvZiyh5vV5ef6A+i+TcdCj6dnrP62mNsIVBKhR/3Sn
         d2ygYi0WHrsdiTzqCYg+1YKcXdoEVYzOsV1DPUgp9dR3Ev0iClhlu/6xwEkfe6bIgPlt
         p16LqjWHYW4O/KJU1qD0QayhUAB+bK0mPe/Rh4Vb0kZ88CPbF1b7amGSCy2XAsnJVia9
         B9xNFlmAJtZnI1MupXEQo2u0HlCF5Kh8Yqd0EHpIhM5kbPr+oyEvdoIg/dPaOIBVryOQ
         ScOmBKuBZi/pvef0AMV2XR+nhqb2nZ3w5dEHwZcYoDunaGpx+mjd25qx2LZyTRgEMoJv
         Aqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uceltci0zeUgPeimI85Lt1MAkhpxBjRIOJ0H1yIDgH0=;
        b=nmj3XMAOGBJOb4mBi7qzzeG6lGsi9+ue2arLoC4sPcVtYcR8bHijtSJxymmo4/FL3A
         VRhCWVaazlsXnewdxPEIuKOHp/10AUAMK7BTi2vKAn523MNPgDsHrjNi5V7rzUE58zai
         jPEKFywaBCV9BUpVV10o7hkJBEPZ1Ea+D+GDTwkvY6gNB4L6cfeJ5qG/nC0+8hqCauvw
         78oKuDX/WHlxUmlThH0qehOVUcZtubTeWVVEA+9wt+jkmRzEovphMto+Dph6AxIBZVAW
         BDPIg6+6o8Obo8LU9JXQ/ZhnTMAT+YmOxQ3Erb2NpVysi+2sj0do8XIX1VLmaBP3+tsY
         Yj0w==
X-Gm-Message-State: AOAM530vVohyx2VnuwHtdDWl6oE5KA4EDJte0akEjHvz2R56MRojxCGF
        B6ZEiQdyO9iq6y7xFaCN89p/M+aEYZSkERz6Sx8=
X-Google-Smtp-Source: ABdhPJwMOv0mEW9L6YYoypl/esZ4o9HiUIg6idU6jCJL3NwqCEFL3YKDSywEq9SLO/h7xiZkhJ0Pe4pR5zrWaYkczfg=
X-Received: by 2002:a4a:8353:: with SMTP id q19mr3122073oog.40.1611308938977;
 Fri, 22 Jan 2021 01:48:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
 <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
 <xmqq7do7fggn.fsf@gitster.c.googlers.com> <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
 <xmqq1reec943.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1reec943.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Fri, 22 Jan 2021 17:50:32 +0800
Message-ID: <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:45=E5=86=99=E9=81=93=EF=BC=9A
>
> =E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:
>
> >> OK.  When show_stage is set, skipping_duplicates is automatically
> >> turned off (and show_unmerged is automatically covered as it turns
> >> show_stage on automatically).  So this feature has really become
> >> "are we showing only names, and if so, did we show an entry of the
> >> same name before?".
> > Yeah,showing only names,so I yesterday ask such question :)
> >>
> >> >                       if (!show_unmerged || ce_stage(ce))
> >> >                               show_ce(repo, dir, ce, fullname.buf,
> >> >                                       ce_stage(ce) ? tag_unmerged :
> >> >                                       (ce_skip_worktree(ce) ? tag_sk=
ip_worktree :
> >> >                                               tag_cached));
> >> > +                     if (show_cached && skipping_duplicates)
> >> > +                             last_shown_ce =3D ce;
> >>
> >> The code that calls show_ce() belonging to a totally separate if()
> >> statement makes my stomach hurt---how are we going to guarantee that
> >> "last shown" really will keep track of what was shown last?
> >>
> >> Shouldn't the above be more like this?
> >>
> >> -                       if (!show_unmerged || ce_stage(ce))
> >> +                       if (!show_unmerged || ce_stage(ce)) {
> >>                                 show_ce(repo, dir, ce, fullname.buf,
> >>                                         ce_stage(ce) ? tag_unmerged :
> >>                                         (ce_skip_worktree(ce) ? tag_sk=
ip_worktree :
> >>                                                 tag_cached));
> >> +                               last_shown_ce =3D ce;
> >> +                       }
> >>
> > well,I am also thinking about this question :"last_shown_ce" is not tru=
e
> > last shown ce,but may be If "last_shown_ce" truly seen every last shown
> > ce ,We may need more cumbersome logic to make the program correct.
> > I have tried the processing method of your above code before, but found
> >  that some errors may have occurred.
>
> I think judicious use of "goto" without introducing the last_shown
> would probably result in a much more maintainable code.  It may look
> somewhat like so:
>
>         for (i =3D 0; i < repo->index->cache_nr; i++) {
>                 const struct cache_entry *ce =3D repo->index->cache[i];
>                 struct stat st;
>                 int stat_err;
>
>                 construct_fullname(&fullname, repo, ce);
>
>                 if ((dir->flags & DIR_SHOW_IGNORED) &&
>                         !ce_excluded(dir, repo->index, fullname.buf, ce))
>                         continue;
>                 if (ce->ce_flags & CE_UPDATE)
>                         continue;
>                 if ((show_cached || show_stage) &&
>                     (!show_unmerged || ce_stage(ce))) {
>                         show_ce(repo, dir, ce, fullname.buf,
>                                 ce_stage(ce) ? tag_unmerged :
>                                 (ce_skip_worktree(ce) ? tag_skip_worktree=
 :
>                                  tag_cached));
>                         if (skip_duplicates)
>                                 goto skip_to_next_name;
>                 }
>
>                 if (!show_deleted && !show_modified)
>                         continue;
>                 if (ce_skip_worktree(ce))
>                         continue;
>                 stat_err =3D lstat(fullname.buf, &st);
>                 if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR)=
)
>                         error_errno("cannot lstat '%s'", fullname.buf);
>
>                 if (show_deleted) {
>                         show_ce(repo, dir, ce, fullname.buf, tag_removed)=
;
>                         if (skip_duplicates)
>                                 goto skip_to_next_name;
>                 }
>                 if (show_modified &&
>                     (stat_err || ie_modified(repo->index, ce, &st, 0)))
>                         show_ce(repo, dir, ce, fullname.buf, tag_modified=
);
>                 continue;
>
>         skip_to_next_name:
>                 {
>                         int j;
>                         const struct cache_entry **cache =3D repo->index-=
>cache;
>                         for (j =3D i + 1; j < repo->index->cache_nr; j++)
>                                 if (strcmp(ce->ce_name, cache[j]->ce_name=
))
>                                         break;
>                         i =3D j - 1; /* compensate for outer for loop */
>                 }
>         }
I have to admit that this is indeed a good way to skip with "goto".
Thanks for your help.
And should I still use gitgitgadget PR on my origin branch "dedup"or
send patch on branch "zh/ls-files-deduplicate"?
