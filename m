Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A8C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A54233FA
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 08:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbhAWI0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 03:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbhAWI0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 03:26:35 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDAFC06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 00:25:54 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v1so7554622ott.10
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 00:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HC/zF5qzlG4f2O27KW2DiZP+oZ8Sd8sUhZc/vhPJzwE=;
        b=SxnqdkVPCrn4/swFmpsWayzPKdavYNGQf56Liu2THjorBbxkdZ9ES5ay29BW+f7kOk
         PgmxYsx++aG6NFYKyuo/3wa2WfrVqhX4DpPh767rnFfPE9WYWzikYvyrTkDs2pxRCEKA
         l9YFM6zoJwXEY0+wT/SWC3Qpp3NppLJQiKJGpyXxsChe9/zsEw3aFX21hBTz1FZcruT+
         7lO9qXwdYgPmJ/KI4jyxDByhYCFFRES7TB5xeUWSYNSgN6iBoaUjcwqdLdfMQWYUxVfo
         IgIOQDWJZJpJSY9OAVbOhqum+PgLpsigtrSoJT9+Y4zeBDFg1vBXzIPCa5SSzeZWZfw1
         OkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HC/zF5qzlG4f2O27KW2DiZP+oZ8Sd8sUhZc/vhPJzwE=;
        b=Wip08Gv504VZ8OZoXff29HCdFJSDKcQ0A5O3X1Cm5Oc0tsEIlEOFJXsE/hqlTkz2Gz
         7I03M2n6YZhjNWU5oiWdz1/+ZlRLeeOvriGFVmgkb06EiEYKY7jhoTJK9uwkoMrkMifX
         LdhKb01yKorCCaGU0+eIMcedhpkqaXCdjgIYwcz87s0JDiLwazjbSbD5bti9/HQDwm7H
         fOWXbEjMri3KPJfPosh6D/eO4I2x5ZUFTz8lUheCc16bBhP0UXGoATGtvC6hSY17OPtN
         co+QM6TIYfAl2hR1wNCxWcI1d739p9r1/sidOAIIJX5roeMT5UEO1jAN87y8YZXT7nVO
         dk3Q==
X-Gm-Message-State: AOAM530Wi4IwH3p9O/cWaNIfn9b+1auXgFCNddXxFheeHcVCOu8Qh3EK
        9uLpoof+xLOytFKtT+/6edfXyyuzSIwHNtDcHbc=
X-Google-Smtp-Source: ABdhPJxE2cM2Jv4M9oLmpC3UMGJE8ppYz/DKnbTomjAqw5abhohzSveE9037yDl1fuGPY6CnlOj/wl+K7Wz1TrT40po=
X-Received: by 2002:a9d:4812:: with SMTP id c18mr5782738otf.160.1611390354226;
 Sat, 23 Jan 2021 00:25:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
 <20210122154640.3791035-1-adlternative@gmail.com> <xmqqr1mc7kyt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1mc7kyt.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Sat, 23 Jan 2021 16:27:11 +0800
Message-ID: <CAOLTT8Sx0v_xF8KOtf76P5T=BF+CJ3B_J=H2RDDtzezuTUUa2Q@mail.gmail.com>
Subject: Re: [PATCH v6] ls-files.c: add --deduplicate option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:52=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > In order to provide users a better experience
> > when viewing information about files in the index
> > and the working tree, the `--deduplicate` option will suppress
> > some duplicate name under some conditions.
>
> Now is it just a single patch squashing everything together?
> That does not look like it.
>
> > @@ -317,7 +318,7 @@ static void show_files(struct repository *repo, str=
uct dir_struct *dir)
> >       for (i =3D 0; i < repo->index->cache_nr; i++) {
> >               const struct cache_entry *ce =3D repo->index->cache[i];
> >               struct stat st;
> > -             int err;
> > +             int stat_err;
> >
> >               construct_fullname(&fullname, repo, ce);
> >
> > @@ -326,25 +327,43 @@ static void show_files(struct repository *repo, s=
truct dir_struct *dir)
> >                       continue;
> >               if (ce->ce_flags & CE_UPDATE)
> >                       continue;
> > -             if (show_cached || show_stage) {
> > -                     if (!show_unmerged || ce_stage(ce))
> > +             if ((show_cached || show_stage) &&
> > +                     (!show_unmerged || ce_stage(ce))) {
> >                               show_ce(repo, dir, ce, fullname.buf,
> >                                       ce_stage(ce) ? tag_unmerged :
> >                                       (ce_skip_worktree(ce) ? tag_skip_=
worktree :
> >                                               tag_cached));
> > +                     if (show_cached && skipping_duplicates)
> > +                             goto skip_to_next_name;
>
> Why should this be so complex?  You are dropping skipping_duplicates
> when the output is not name-only, so shouldn't this look more like
>
Truly,I may have considered too much,if I have
"show_stage","skipping_duplicates"
must be false.
>                 if ((show_cached || show_stage) &&
>                     (!show_unmerged || ce_stage(ce)) {
>                         show_ce(...);
>                         if (skipping_duplicates)
>                                 goto skip_to_next_name;
>                 }
>
> It seems that this still depends on the 2/3 from the previous
> iteration, against which I suggested to merge the conditions of
> nested if statements into one.  That should be done in the updated
> 2/3, not in this step, no?
>
> >               }
> > +             if (!show_deleted && !show_modified)
> > +                     continue;
>
> And this one also belongs to the step 2/3 that consolidates the two
> loops into one.
>
> I think you'd need to start from the three patches in v5, "rebase -i"
> not just [3/3] but at least [2/3], too.
>
> Thanks.

Thanks,I am rewriting.
