Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF9C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 16:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiBAQzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiBAQzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 11:55:08 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B01C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 08:55:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k25so55718650ejp.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vnPpKn+V/14NVtSaO5lN9JEXjf5kgGd8AyvaNwTi7/o=;
        b=Z5e5vYxf9S/nkSXRgKeCBfhFxsxTyGX0H593DXAP6XiUF1UlMe9LKLojy07DgknoJz
         60IzO1LwEH44oAKQH2LlrJc8l9U+i3lFu0Dj1KGOQx1grrmDDOerzSwhcILqAsF0sDrV
         3DDTMjd3QK2amxuPB7y/w++93NYOKMUDpDuM3xg6CtfqbM8YIuqiD5TkIT5TJxpI3k1b
         rpU2FILYYGidsZCimRetSQ3Sh37uOuLa7wRL5YE6IGbUi5wdHirGqvSqSBM3F0MyNEYo
         MdtY9jWWrYzLdrOAnPlPPwhLOYnjYaVjgRJTukuoOAwVByOLr7sgr2PatvvO8Yx+Iuo+
         xmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vnPpKn+V/14NVtSaO5lN9JEXjf5kgGd8AyvaNwTi7/o=;
        b=lh6dR5g/E2hoqGVzs7uMtNqn+s6OUEttRs3xqLcrKS34cxI3RefgCOw+bxHwEn4kre
         Io/WhNfy0JBA4m9xedXlneF+tBB0CrIRZHx2eGxI3takUsltBF+8HFEZDkhPlbNNXWEE
         N2l5SFkk3xpFeFFMDfB9bP9bjtPpsLemiNn/HcKep9IYy+zMzbK7rTaEARv6qaOMo4eS
         es816lLArixJRWzr6nzRuMc6AMDr4pYP5qdE6UQmZTVtVxMsi3FF2WvKgeZH66EiYdNw
         PvCwhiprhnXgdAICTavHsJlhbnthmuNLh8HZKl7DtK6nm1MQzT4mBnQMTDezopqzU3vv
         9Hrw==
X-Gm-Message-State: AOAM530LBcmrsqVEvnzkRVNU5SGMdpzFm9HGJm+JdS/mEAkcUmeoPsid
        pJvjYD/qpBBuo0q6G9cd7qV+L8T9s4WZNYb68OBSGY0V2Fg=
X-Google-Smtp-Source: ABdhPJwbxQuBM48AHlpocFdY2a+tDFGIuhQHr0IB7lE5cDKyhoTyK+Hw4d84wglucXL0z99pvWG3ol5JuF0jVy8Uv7Y=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr15959067ejc.100.1643734506390;
 Tue, 01 Feb 2022 08:55:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com> <f06de6c1b2fbd5c5a23b6755197a3683c7d18d2f.1642792341.git.gitgitgadget@gmail.com>
 <220201.86v8xyapj9.gmgdl@evledraar.gmail.com>
In-Reply-To: <220201.86v8xyapj9.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Feb 2022 08:54:54 -0800
Message-ID: <CABPp-BHPZZuGoJO8PXCngBhStBJmDhbyCYOmR+CVZX5wv3O+4w@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] log: clean unneeded objects during `log --remerge-diff`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 1:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Fri, Jan 21 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > @@ -944,7 +945,12 @@ static int do_remerge_diff(struct rev_info *opt,
> >       strbuf_release(&parent1_desc);
> >       strbuf_release(&parent2_desc);
> >       merge_finalize(&o, &res);
> > -     /* TODO: clean up the temporary object directory */
> > +
> > +     /* Clean up the contents of the temporary object directory */
> > +     if (opt->remerge_objdir)
> > +             tmp_objdir_discard_objects(opt->remerge_objdir);
> > +     else
> > +             BUG("unable to remove temporary object directory");
>
> Re the die in 1/10 I don't think this will ever trigger the way this bug
> suggests.
>
> If we didn't manage to remove the directory that'll be signalled with
> the return code of tmp_objdir_discard_objects() which you're adding
> here, but which doesn't have a meaningful return value.
>
> So shouldn't it first of all be returning the "int" like the
> remove_dir_recursively() user in tmp_objdir_destroy_1() makes use of?
>
> What this bug is really about is:
>
>     BUG("our juggling of opt->remerge_objdir between here and builtin/log=
.c is screwy")
>
> Or something, because if we failed to remove the director(ies) we'll
> just ignore that here.

Yeah, I think I'm suffering from leftover bits from earlier versions
since this patch series has been waiting for 17 months now.  I
switched it to

    BUG("did a remerge diff without remerge_objdir?!?");

>
> > +void tmp_objdir_discard_objects(struct tmp_objdir *t)
> > +{
> > +     remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
> > +}
>
> I skimmed remove_dir_recurse() a bit, but didn't test this, does this
> remove just the "de/eadbeef..." in "de/eadbeef..." or also "de/",
> i.e. do we (and do we want) to keep the fanned-out 256 loose top-level
> directories throughout the operation?

It will remove everything below t->path, but leave t->path.  As such,
it'll nuke any of the 256 loose top-level directories that exist.

If someone wants to come along later and measure performance and
determine if leaving those 256 loose top-level directories around
improves things, I think that's fine, but I'm not going to look at it
as part of this series.  I'm more curious about where tmp_objdir
creates the temporary directory; when the intent is to migrate the
objects into the main directory, it should probably be created on the
same filesystem.  When the intent is scratch space, like it is for
--remerge-diff, the tmp_objdir should probably be shoved in /dev/shm
or something like that.  But again, that's outside of this series.
This series already has had a long list of things keeping it from the
light of day; there's no need to add frills to it as part of the
initial submission.
