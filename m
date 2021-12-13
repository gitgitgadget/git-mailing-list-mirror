Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB58C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbhLMVw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhLMVwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:52:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC579C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 13:52:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r25so56220914edq.7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khQGW7nfpe40GG5LMosofqL2ZmCKg2l+qM+eVZ8bvog=;
        b=WjrHvIF21HVI01amSB1ABeiMWlSTJJ3H03m10oZEO/WcHcnRDtOBrKZy0Ks25qAGkG
         aW23v95wMMV8X+s7+3oNg5CTqEEx8fx1edtC4cnC9c+yoqjQJCwdJhbtPeA8W9vgqYuD
         hEm6taTsabrgt+h5sEJHLGZzXHkhyb45ceIl2C5naSPYVw7XzVAfKETsFKqKChVZWKjm
         pPJwZl8orDbt55cYQHB/PA0itEdhwR/0+vWbz1OJWhIkk5X7d0pxCvGFWIKetAzHA21L
         cUTZcpfzc4Vuj5gxl3dS0zGpuAifC7qX4k6d4ue5RrNI8zT8G/61uAZhE1ucqkaOX28w
         +0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khQGW7nfpe40GG5LMosofqL2ZmCKg2l+qM+eVZ8bvog=;
        b=kKKFeFe6JyD57fQEqbKHeQaZzpImF0h/wkmxllJJGp346EajzqypbduStO5az0u/O5
         1rdHV0LW9NFqtn2EonkiEYUnPT1eT3IISEKAhpKTpx2N4duBiDKFpZODnmyRvXV7Eq7u
         MZH36QDIF9wHSvPUx9QXorBktc0fh+FvxcRjsmlAlINplGHCADYcpgScJMylpSFZ0uCo
         vFbSJfq8TKTP+g+MMr0yMCdjURPFOvcLkHupefjJWVZjeKUM+fdxg944w1lcbhjd0/UV
         dvGaHWm6Bb0aYivZVldDeIbyt6ApVZm9rwBgj2gTDCrksvss61jYcRcfDKrQarFma9de
         bU7w==
X-Gm-Message-State: AOAM530zLNLt/S24XXXbCkP+kxdxPIz+QxkPUd7p+wvWsomceNG+EZqx
        P6RkW4sO87maywog7bFom8E0ILxwxK712VcS418TqMiONNGPyA==
X-Google-Smtp-Source: ABdhPJxFCfTfHn00CmMSAN4WuP4HAE/FpNfXzfyn3dqjUqnldvFe0ZcajJMv1EmDMGms4VRW7hioEfMVs8xtnNCtCsw=
X-Received: by 2002:a17:906:390:: with SMTP id b16mr1212469eja.522.1639432373329;
 Mon, 13 Dec 2021 13:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20211211031343.15818-1-jerry@skydio.com> <20211213202826.7051-1-jerry@skydio.com>
 <xmqqlf0ob2o0.fsf@gitster.g>
In-Reply-To: <xmqqlf0ob2o0.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 13 Dec 2021 13:52:42 -0800
Message-ID: <CAMKO5Ctq8kzAvHAXxPVd06_Ko7-GW4CQbUmw7g7Eb7Su_Cp8RQ@mail.gmail.com>
Subject: Re: [PATCH V4] git-apply: add --allow-empty flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> > index a32ad64718..b6d77f4206 100644
> > --- a/Documentation/git-apply.txt
> > +++ b/Documentation/git-apply.txt
> > @@ -14,11 +14,11 @@ SYNOPSIS
> >         [--allow-binary-replacement | --binary] [--reject] [-z]
> >         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
> >         [--ignore-space-change | --ignore-whitespace]
> >         [--whitespace=(nowarn|warn|fix|error|error-all)]
> >         [--exclude=<path>] [--include=<path>] [--directory=<root>]
> > -       [--verbose | --quiet] [--unsafe-paths] [<patch>...]
> > +       [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
> >
> >  DESCRIPTION
> >  -----------
> >  Reads the supplied diff output (i.e. "a patch") and applies it to files.
> >  When running from a subdirectory in a repository, patched paths
>
> Applying: git-apply: add --allow-empty flag
> error: patch failed: Documentation/git-apply.txt:14
> error: Documentation/git-apply.txt: patch does not apply
> Patch failed at 0001 git-apply: add --allow-empty flag
>
> Hmph....  Where did that "| --quiet" thing come from?
>
>
Apologies, I overlooked a dependence on my other patch here:
https://patchwork.kernel.org/project/git/patch/20210427194106.14500-1-jerry@skydio.com/

Let me know if you'd like a clean patch off of master. Please give the
other patch
a look though, as I've addressed outstanding comments.
