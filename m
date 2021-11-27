Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20883C433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbhK0RKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 12:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbhK0RIp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 12:08:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7BC06173E
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 09:05:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so52271811edb.8
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q3eDztH03cJhpgBUlqDskWG2YIwm8ZPlNaGviZtW9Ww=;
        b=N+9t0KplljdJn0wliYqvsJd+eFKPXQaPjBaHzy5uO3ua9asf020/N9A2CX0gBDkXAA
         Yo5Ri7JJUnLd/Vj7Wlwq9tfSmuAOp8kaw0YX3JdhxJDMkN1lAmVFlEKsKt/MgGmyPZfV
         3wXMh3EdwUEqGb9/48vrkg3lTYhkITagouhr4FIufVdf/rQUC4GikNGORw11p1iJ110O
         HCQE8fbYNif/bOuU4DOISyTUVArgJrrr+rg3qg0hYXLXlyi9jN9x7BnB+BMOdNJ/j8fb
         8gszDfq/xh0+K8jpeFMDsU84aDjptLYGzNlXEZtvMD372pBxdT7M3ZTP1RAH1cU8YPMB
         5XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q3eDztH03cJhpgBUlqDskWG2YIwm8ZPlNaGviZtW9Ww=;
        b=hk4gcQGn+VB/p7FJEfd6hbCpDk3ryBx2jquAY636rm0mZUr0QMFhfhJs5D5+0hKPGx
         o9Wk8KesGQE9z5yf8sZiACGTXF9ORRYzgnklC5zHfLI2UQl+mSwcW7u3/C40WWPzTShS
         6JwOOtR6KCJs6/+72VUjUXPNK1Qr78YB6tvgXGY40y2+nNyYejBJl0GWHEJvpLg+Ckev
         4qIsLLEKs6lEDf33qxZ+7C5xvLc64gKNh/lS9qgaq4zYQigvQ6l/yPkpF6u45nKG3Dtv
         +zt2Eg+mxKrOavbrmFq3KXP1OusiE1o+ugJm0C2YO6pOJlvOmT68YjNGqjmMGXzaylWH
         w//w==
X-Gm-Message-State: AOAM530E2zyiVuuwXYcrs/ipAFTVV5ZPBMwxPhSyN6A0BrDdc4CxHttt
        /JjP9Yq93TJMNL4ZGpT+USUQ2PFMsfH7PhY9iy8=
X-Google-Smtp-Source: ABdhPJyA0cF8cB3zd9SxJEejgAvhsw+EirxLvwmAr1KlKpP16opTQ4gm3h8WyXE1CmiY+h+1q97r1o3BVO1gCILt83s=
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr46625233ejy.443.1638032728534;
 Sat, 27 Nov 2021 09:05:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <200ddece05d3d0599b16897ff9533cdfb3324b0c.1637966463.git.gitgitgadget@gmail.com>
 <211127.86zgpphohi.gmgdl@evledraar.gmail.com>
In-Reply-To: <211127.86zgpphohi.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Nov 2021 09:05:17 -0800
Message-ID: <CABPp-BFbmnvtUTW30KjWN6tQECjN=ErKC64oXrCLrb1OmXOZyQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] setup: introduce startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 27, 2021 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > +     /*
> > +      * Get our worktree; we only protect the current working director=
y
> > +      * if it's in the worktree.
> > +      */
> > +     worktree =3D get_git_work_tree();
> > +     if (!worktree)
> > +             goto no_prevention_needed;
> > +
> > +     offset =3D dir_inside_of(startup_info->original_cwd, worktree);
> > +     if (offset >=3D 0) {
>
> Nit: Easier to read as:
>
>     offset =3D [...]
>     if (offset < 0)
>         return;
>
> I.e. the reader can skip that whole "offset >=3D 0" block and anything
> after if it <0, which also reduces the indentation. We run into the
> "return' below.

Whoops; the return should be inside the braces.  I'll fix.

> > +             /*
> > +              * If startup_info->original_cwd =3D=3D worktree, that is=
 already
> > +              * protected and we don't need original_cwd as a secondar=
y
> > +              * protection measure.
> > +              */
> > +             if (!*(startup_info->original_cwd + offset))
> > +                     goto no_prevention_needed;
> > +
> > +             /*
> > +              * original_cwd was inside worktree; precompose it just a=
s
> > +              * we do prefix so that built up paths will match
> > +              */
> > +             startup_info->original_cwd =3D \
>
> TIL you can use backslashes like that in C outside of macros, but it's
> not needed here, better without?

Line is too long without it, so better with it.

>
> > +                     precompose_string_if_needed(startup_info->origina=
l_cwd
> > +                                                 + offset);
> > +     }
> > +     return;
