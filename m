Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49034C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 04:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiBOEbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 23:31:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiBOEbW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 23:31:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F49E6622A
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 20:31:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m17so5270087edc.13
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGfB6013XsvLnKeoebMPDWEtAd6pIQnx1J3Mqa/18lA=;
        b=VRfk9PFctzGAmnijKBAQZDbf6c8Gid8Nv5miflyVb+7QRVCpq8x4X5iDDaV6CiYNpL
         /N66dPFffRLQprjVMS98onugJxQz0RYaBazJMv94CSMLJ9dla+DHbXX2VRER0t07NlgP
         AHvTZuU4tUlmCm9lk4/33qNCTuakeBpjYWp29pnfJGc7PeI7Wgdf0JYYuMv3e0cJbR/R
         LxuWkLvLEvVWwDrAlSwcDcKCuBUHsEAb1XkI3Hky32Gqa+W6XEv0dR5+Q1AyQHjr7htO
         /LvbRNfrFGMh1XizZe5JnaaQcVgdvZ8nbBn5+HghoU6laKKrUc5p62XhG+vrk2+8OUCf
         9bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGfB6013XsvLnKeoebMPDWEtAd6pIQnx1J3Mqa/18lA=;
        b=2e4u7DrSeJO+tKfl64g83ZJKxmskc5NnwVEFb3ElVpZpXgzwPHRoyLYZZzsIiVyAWN
         dz4VEn3Zgrrl1dp3nwpuneztzyhH8o+5exDhNobDAZ+wJCmpN5/ez6JGu1nGHnbAtGnD
         augPE+OR9Kvi0c+Dxl9Ae4GzHZVs5S1JiMvdngo+1pAfQE6tj7FYY4h8Vl70ZRkmItEX
         lR00VI+lzJOPWEx86rPnegh0GgTx22qK6zEQgFCKiiupPfJduhsvWKx5Hd8cNb0CtG1l
         wNqQtJrRLg37vloWPBZkP6UzgQsRkAZBjKhRz+g6W6GIBEB5mbIdWaiK0Fz8MgJ3Jggf
         k/XQ==
X-Gm-Message-State: AOAM533Vj5HoYDkBwKXgDj8G9z74lo/m9m6upDisN8SOfk2RhVjXtwL5
        61gqbineb0M1d/qAqw5I+u1QzEq/iatUHvUrYPE=
X-Google-Smtp-Source: ABdhPJyRnSvNk9IbV8a9eYw8x15cVeTd1bdCXQUYJf8ENPdsioRaYbXaNidz+pnrkVi8egZ8EhEfX+HSqJSZ3vX786I=
X-Received: by 2002:aa7:d316:: with SMTP id p22mr2096680edq.380.1644899472011;
 Mon, 14 Feb 2022 20:31:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
 <xmqqsfsl2utb.fsf@gitster.g>
In-Reply-To: <xmqqsfsl2utb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 20:31:00 -0800
Message-ID: <CABPp-BEhsp4=dzCkSpyu4Bd7Q=hP1Ec6W09-zX2+N+5_-ytk8A@mail.gmail.com>
Subject: Re: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 9:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     if (!core_sparse_checkout_cone)
> > +             for (i = 0; i < argc; i++)
> > +                     if (argv[i][0] == '#')
> > +                             die(_("paths beginning with a '#' must be preceeded by a backslash"));
> > +
>
> Whenever I see an error message like this, where it is clear that
> the command knows the only viable solution is to the issue, and yet
> still refuses to do-what-the-user-clearly-meant-to-do (is there a
> valid reason to copy and paste "# comment" line, which clearly is
> not about choosing which paths to use/ignore, from an existing file
> and feed it to the command?), I question if it should be solved the
> opposite way.
>
> That is, to pretend as if "\" + argv[i] was given and then give the
> user either a warning saying what we did, or an unsquelcheable advice
> message (no need for advice.* config---the user can avoid triggering
> it by learning what the advice message would say, which is to use \#
> when they mean to give a pattern that begins with a pound).

If this were the only special character case, I'd totally agree, but I
do worry a bit that escaping this particular case might lead users to
expect us to escape and fix other special characters from '*?[]!\'.
If users have files with those characters and specify an argument with
one of those, are we to automatically escape them as well?  If we
don't escape the other characters but do escape '#', aren't we being
inconsistent?  And if we do escape those other characters too, aren't
we breaking users who are trying to specify patterns (which is what
non-cone mode is all about)?  Personally, I'd rather drop this patch
than introduce such an inconsistency.
