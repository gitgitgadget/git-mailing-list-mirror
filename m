Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9718C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9681C20691
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZzlUAuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgKWXC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbgKWXC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:02:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CDC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:02:55 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so20457890wrx.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9YofQ/R57QkFixuhMhvWS4IwJNsbOFOxGBGbo6hsso=;
        b=qZzlUAuAhLGUMyZCWLGmCVqYPmNg7dyFJzuzFYAWd0IXouvFt2SFDMGMOJgGOYCgBD
         Iyec/RrcJ5BZIbozrCZAVm4byOTerPIu6G8CMBubD3VhijENEF68k2QeXqPNRlEQK/S2
         ueoyHa5mSbhtyzWXDSa1k7RZjIhpfEYF4FEuG96z8TgPPrWL0N8U7GRvWaOsvhgjpU9U
         OW5bVo2vfNDi23B/dag0kFO13Rz5CEjBdOyjELSnL+Nf0yhb7Is/H8MtdCVEdJUfwxd2
         i8vn0enMb4svxWpZN4njvHVVV52/diHGtQp924K0vEDJClPLO22Sx9NFi8oFzhGdAAJ/
         6oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9YofQ/R57QkFixuhMhvWS4IwJNsbOFOxGBGbo6hsso=;
        b=Qnb5c62//Aol+SpZADQnOiGEqc4Cx6LQCBxYY6jlxLYD0c/eieotDjG5xRSL4OQTej
         SYvJ5VW0qVbzMYpJnnlr8YfSaa8fY7FQqCAjqdX3+KfIOAGJmbxTr6bFNwg/E8vyNgJc
         Se/xhZk7NBD0ymGkiR34s2w+II7qQSF/m8idEQ3prOZYKFDrvRfKQZq0kwpkzBIR/kK6
         z+yIdzPw6aSC/jITdaBlDIzM5F4bKK0CHNx2VblaoS30uYDWX6oAR6WI8hKYSREIHQmW
         l5O25fAkxH1lOM8JD5AOsbStjYKdMbzT4ximbpYnfhsVI/P4u7UDTF25LJu1kmA2iuXo
         weqg==
X-Gm-Message-State: AOAM531TjKLaMJOoTDCemz7llcU05uHOEGS6aw5NAhliGusrDxsIhs3i
        BEvfOuRIxzvKEbXZqDI9b4uFmkEcsKy1wYuHFSYi35WKR8nc8g==
X-Google-Smtp-Source: ABdhPJy4b3Q+Vf3dssXIoFRKS+gNjJLDReC0xZJYJF4FLoyZtEwiRB45c2zauEF9kuZBhFQ6Kf/KHy9FK+I66tlRSbw=
X-Received: by 2002:adf:e788:: with SMTP id n8mr1982799wrm.84.1606172573787;
 Mon, 23 Nov 2020 15:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20201123224621.2573159-1-felipe.contreras@gmail.com> <20201123224621.2573159-2-felipe.contreras@gmail.com>
In-Reply-To: <20201123224621.2573159-2-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 17:02:42 -0600
Message-ID: <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     Git <git@vger.kernel.org>
Cc:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 4:46 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> It is very typical for Git newcomers to inadvertently create merges and
> worse; inadvertently pushing them. This is one of the reasons many
> experienced users prefer to avoid 'git pull', and recommend newcomers to
> avoid it as well.
>
> To avoid these problems, and keep 'git pull' useful, it has been
> suggested that 'git pull' barfs by default if the merge is
> non-fast-forward, which unfortunately would break backwards
> compatibility.
>
> This patch leaves everything in place to enable this new mode, but it
> only gets enabled if the user specifically configures it;
>
>   pull.rebase = ff-only.
>
> Later on this mode can be enabled by default.
>
> For the full discussion you can read:
>
> https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

Note: Philip Oakley's address was wrong (fixed now).

-- 
Felipe Contreras
