Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76634C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiAXRSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiAXRSp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:18:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB9C061744
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:18:45 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m4so23348391ejb.9
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4zyDaDztf/MaT8jze05rJQTzry2y2d+ufgPQHBWAP+Y=;
        b=bzmaVKkfN/d7eoiWfbTritnnYP/5LQLwkD2rgrpBdogJOZ1XyVzrlkv1wnZAMdutQx
         gl/NkAa8ohV96skhelxajMPwSqyW9Ugaz8v+hoCWhnFVMe1yHFIZaqGDVxu+pdYHCCm0
         5UDD8HEa4+G2pxTcuU5M+ul386hvOojhC3z1IchAsKqZ7AflWr2omacrgpV9i+WAEUhA
         CH0OoDjFCCUq3jK38TRr4gHFfFIT0WkuZjACiHcIIGJ5o84h+DZJOvgNEIidWP2xfsG7
         nI9fe26SIb7kVC3IN6DzYxMYNOszGwnkjpeir0wxOS/0z8nP9CsFJuO2L5qzDecJah25
         cfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4zyDaDztf/MaT8jze05rJQTzry2y2d+ufgPQHBWAP+Y=;
        b=S9pk5qoA5VL587Qysy1luAl/Aq/LMvqbG2atVOWDsAuC2KoQxcQGpA7Dn6CYVunnCN
         idxOP8824cTkxa90RZQBzOW4HmG+du2zGlioQLc0rzPh8m6zRtcPCxLnzpdOYLFFlpr2
         pEhFXxAoGNqixIZIPy+pPdlbSdli3V8hLTDDz1JNK/tCmcqIqrOIlH4KjE55ufn+V7g7
         rN5Wsgi7h9OBPcBTpDwYI5d2gKKl0Jd7x8ugx8zB7563oPUWbJsJhP/0Dh9AetPa+fzi
         fKid+Tw/arwji7/DsqLFL6YNtwIiNBm5iN0M1Id+dmAC4+5TG0+xlhAbJZZ9/FdPMtoY
         ByQQ==
X-Gm-Message-State: AOAM532/oAFsV6NYZcBS1rpyB3KG83Km8oGvAJnRjG8sKoNXx+9dP1Wr
        RjIj04FHjkJY7cs/xirtnO014r9XPJs2y/+KCQw=
X-Google-Smtp-Source: ABdhPJw9lJv7+dcsMQ2+UVQBNv5bDBm3nvVqfweE/51SOXUinrjBMVmGh6YPU8GPC+vO48ob1TwGyPJ6cx4qziXsTOA=
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr13269633ejc.493.1643044723714;
 Mon, 24 Jan 2022 09:18:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
 <220124.868rv5ih93.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.868rv5ih93.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 09:18:32 -0800
Message-ID: <CABPp-BF8oXCNpbXi1xb3Veh_Vi0uDXVX9VNOWMVz_zwjG=earQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have conflicts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 2:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Callers of `git merge-tree --write-tree` will often want to know which
> > files had conflicts.  While they could potentially attempt to parse the
> > CONFLICT notices printed, those messages are not meant to be machine
> > readable.  Provide a simpler mechanism of just printing the files (in
> > the same format as `git ls-files` with quoting, but restricted to
> > [...]
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index 560640ad911..d8eeeb3f306 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -11,6 +11,9 @@
> >  #include "blob.h"
> >  #include "exec-cmd.h"
> >  #include "merge-blobs.h"
> > +#include "quote.h"
> > +
> > +static int line_termination =3D '\n';
>
> But unlike ls-files we don't do anything with line_termination as a !=3D
> '\n', maybe in a later commit?
>
> >  struct merge_list {
> >       struct merge_list *next;
> > @@ -395,7 +398,8 @@ struct merge_tree_options {
> >  };
> >
> >  static int real_merge(struct merge_tree_options *o,
> > -                   const char *branch1, const char *branch2)
> > +                   const char *branch1, const char *branch2,
> > +                   const char *prefix)
> >  {
> >       struct commit *parent1, *parent2;
> >       struct commit_list *common;
> > @@ -449,6 +453,22 @@ static int real_merge(struct merge_tree_options *o=
,
> >               o->show_messages =3D !result.clean;
> >
> >       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> > +     if (!result.clean) {
> > +             struct string_list conflicted_files =3D STRING_LIST_INIT_=
NODUP;
> > +             const char *last =3D NULL;
> > +             int i;
> > +
> > +             merge_get_conflicted_files(&result, &conflicted_files);
> > +             for (i =3D 0; i < conflicted_files.nr; i++) {
> > +                     const char *name =3D conflicted_files.items[i].st=
ring;
> > +                     if (last && !strcmp(last, name))
> > +                             continue;
> > +                     write_name_quoted_relative(
> > +                             name, prefix, stdout, line_termination);
>
> But here it's never \0 or whatever.

Correct, I didn't add any option for changing it.  But why hardcode it
to "\n"?  Leaving it this way makes it easier to change later if folks
say they want NUL-terminated output.  Since the series is RFC and the
output already has changed drastically and appears to be the primary
discussion and disagreement point, I wanted to provide what seemed
like a reasonable suggestion and maintain flexiibility to address
feedback (though who knows -- I might need to just completely redo the
output again in ways much bigger than adding a -z option).
