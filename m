Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A9C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C6D64F1B
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhBYUTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhBYUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:18:21 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1799C061788
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:17:11 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id k13so6929544otn.13
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHPlqcG30ru9V+tzMWO4MVp0tGlRzNyZOvCuMgoEg+c=;
        b=Vydd4PeW0C+JqnNjmTfOgndWIVVRrIZeCRY/Soa3JCt360PsGEF4YyXdlbb7qGXqQM
         2/IBw3NNug3HGzkc7dBVybOrqjUcmpg4nRUBq1U08zDU2D60PHwD/l9pElPp3W7UxDA0
         0QWh577bbL/Q8i6ASJGqdL9GNN+yhzhRgLxxjBsiAjhsOMth8sSl0fgfW7JfR2ndUTDp
         VQld1Y3C0+4Gvmyfu2cpsvJx1mvIw4pQoZI38kCEHTteDZDG7HxquBT6Ld6yiFDMvn5i
         yCdnM0VK5VB6v+mg3nySQx7Ny6wZ0RrUXdud1nwYnxzGvjRjPmuvzXa+2o3PFtjkZneY
         q19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHPlqcG30ru9V+tzMWO4MVp0tGlRzNyZOvCuMgoEg+c=;
        b=qRomBJng3NLNKTahoHJr4siA37EmEktPYDqHaj02iltD7DypAg+aBZr8JpV9cwNgiX
         G8ZKpL3YVYDUDLB3aa2PMmwrYwxxcRekqVYimOdNDkOG9g9nHbrgH28zUQd7Gr/M7fO2
         iG0JoHI/naNCfhQnPlWAaCFegg0jsSnJTMpCZ9/Z+98bCoks6Cr0dF+qiMGdZ716Pkw/
         K5euGRBYNR6t/Z/Bt+rSWzf66IQibw3E5BeUeGDuoHXEsLTV0q6v6z+74+OxglpEouIA
         HqvZHaH7skgCkzxNEBYxs5Pt8pvzvwATcU5lzjB100U3tTthgWKLJRidBXUgNxsZkXIB
         Jcyg==
X-Gm-Message-State: AOAM530OTI/7zwgpSu7h153lxqzpwXlfSeaMBMuGTp+rOiZdthqoQ4Ni
        y54Lr98NvxWQ/tu7wtlJg1ls96k8JC6cG8b/fOs=
X-Google-Smtp-Source: ABdhPJw5ECfjU6OQae3Xdpv7uw7A+OolQRsffEwcYxoxIYtd/XxomNI5JxQWi/a/vP9DpizFJjj1PDUgxIo9yJlKss8=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr3656850otk.162.1614284231184;
 Thu, 25 Feb 2021 12:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20210224175834.GT6564@kitsune.suse.cz> <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
 <20210225182924.GY6564@kitsune.suse.cz> <CABPp-BGdFX6V+GNQ6JVnoY3S9cvA0mL+cKSnAhUhArQbGaD6vw@mail.gmail.com>
 <xmqqv9afud75.fsf@gitster.g>
In-Reply-To: <xmqqv9afud75.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Feb 2021 12:16:59 -0800
Message-ID: <CABPp-BFDmDvaUq4gNBQvBa1AgD8RKmcwHLM-cD+_qeLG1f7FSg@mail.gmail.com>
Subject: Re: Getting an actuallt useful merge base?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 12:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> It's like this
> >>
> >> T
> >> ----o----o----o----o----o----o----o----o----o----o----o----o---(t)---o=
----o----
> >>      \             \     \                                      \\\
> >>       \             \     \                                      \\\
> >>        \             \     \                                      \\\
> >>         \        o----o----o\=CC=B6---o---(s)---o----o----o----o----o-=
---o\=CC=B6\=CC=B6-(a)
> >>          \      /            \      /                                \=
\
> >> S+T  o----o----o----o----o----o----o----o----o----o----o----o----o----=
o\=CC=B6--(b)
> >>     /                                       /                         =
  \
> >> ---o----o----o----o----o----o----o----o----o----o----o----o----o----o-=
---o---(m)
> >>
> >> So (t) is common ancestor for (a) and (b) that merge-base reports but =
it is
> >> only ancestor for files in set T, and does not have files from set S a=
t all.
> >> The common ancestor I am insterested in is (s) which is merge base for=
 both
> >> sets of files.
> >
> > From git-merge-base(1):
> >
> > "When the history involves criss-cross merges, there can be more than
> > one best common ancestor for two commits...When the --all option is
> > not given, it is unspecified which best one is output."
> >
> > Perhaps you want to specify --all to git merge-base, and then perform
> > additional checks on the output to select one yourself?
>
> Ignore me, as it is likely I am just confused, but if we are merging
> (a) and (b), I do not think (s) could be usable as a merge base; it
> may be an ancestor of (a) but is not an ancestor of (b), no?

No, I think you're totally right; I was looking at (t) and (a) rather
than (a) and (b) for some reason.  As you point out, (s) isn't a
merge-base of (a) and (b), so it wouldn't be printed by `git
merge-base --all` either.
