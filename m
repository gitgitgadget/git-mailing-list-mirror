Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F96C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1943420A8B
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAeVwmV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEFQQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729239AbgEFQQv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 12:16:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89317C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 09:16:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i13so2226662oie.9
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EV2pDlB9yt0WotaP3dqhiA+5xbkeAjH5bLnw8p2wWik=;
        b=nAeVwmV+lNrh4TBPIbPWcgfBHs1aIhKFLOB3fr6ouEkQqWu2Qmc3+0p6MFrmxxG1Vn
         gtGCvVsLpwf3oNe9PL4ghmyH6CEt+DL91Wd6Xx+Gby86sZRdLGA7GXgeYrTKOwYD/GW+
         XoKFjhCyfxRSeiZdBGCsv/NWkq9Y2QI5jeRHNr5a6Z70LEivFT9Byt5kMAK0t/RbA+id
         zi/hWeBFeSS1DTrjG2Usq45eHGhp5sPlpFaYJFCh/rbjBK6BEsIKvrjiyMGQGJ++6PPZ
         sNUMKfpPlS++iwuuN7A78mjIv+VOzwuGHRmA2Yx6qW6yMLJXI1esHj7213EXxw1retq/
         9nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EV2pDlB9yt0WotaP3dqhiA+5xbkeAjH5bLnw8p2wWik=;
        b=M+Hy7SRaJUzmgi9dASGYyMe9Io5df5afVx6wvJTwMTNRV0TJ2oWNuKLQzSEAIvtCgL
         VYg/36VhSRXdhCGANCY9Uemgv4gBKqt1yC3BCvlJoNk00/1aqq0yU/2gx9Xcysru1ym2
         GxvauwvBHMYz4qLWpNAbi/f5dSrts8sPiXF3LzkevROuB6IGqitOr9YYsZC5ingA9DRm
         3jXENDFgSshOv9ZCdFExwxkN0dvlmcie/onDO8VMLPf74S/fE/qpuPqUE/1VFNYPcsGt
         djMbNzAWxERAR89ZB2Z6YzfdXSkJAneTx1Ja1vwC+ieB0bZ0I428z+cY+Vnx8kSqpNkQ
         e3qA==
X-Gm-Message-State: AGi0Pua3ZoFKROLIluCQ+ygosuoslNDpl2ZmFRuGLaW5PrC7JSgwerJ7
        CPV9jYjTFyy0zwk7S+asjFQEKzkux8tJJ4lKwAc=
X-Google-Smtp-Source: APiQypKcfuIOOigq2XgOiDhZ605c2KIdDS7CJAOuYb24nyknHOxHLrZm6mbyMo3/6CpK3kXC4iw5bQlgOKBI9x1GUdw=
X-Received: by 2002:aca:5513:: with SMTP id j19mr3120039oib.31.1588781810724;
 Wed, 06 May 2020 09:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com> <20200506080023.12521-3-shouryashukla.oo@gmail.com>
In-Reply-To: <20200506080023.12521-3-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 May 2020 09:16:39 -0700
Message-ID: <CABPp-BG98C1Hmh-MtFS50Ds3vT=RtLu+uj3-tbDCK1UsYWwzKg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] gitfaq: partial cloning a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 1:00 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add issue in 'Common issue' section which covers issues with cloning
> large repositories. Use partial cloning to selectively clone the
> repository.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 875cfa0acd..5dfbb32089 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -244,6 +244,17 @@ I want to change the remote of my repository. How do I do that?::
>  One can list the remotes of a repository using `git remote -v` command.
>  The default name of a remote is 'origin'.
>
> +[[partial-cloning]]
> +The repository I am trying to clone is too big.  Is there an alternative
> +way of cloning it in lesser space?::
> +       A good way to save space when cloning a repository is by using
> +       `partial clones`.  A partial clone will clone the full history of
> +       the repository but will skip out the entities specified by the
> +       `--filter` option one uses in `git clone`.  Any entity which has
> +       not been cloned to save space can be cloned     on-demand (hence this

Looks like you have a tab instead of a space between 'cloned' and 'on-demand'.

> +       presumes that the user has an always-on network connection to the
> +       original repository).  See linkgit:partial-clone[1].
> +
>  Hooks
>  -----
>
> --
> 2.26.2
