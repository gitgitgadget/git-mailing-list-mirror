Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7142EC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiAXQnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbiAXQn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 11:43:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E30C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 08:43:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a8so22934731ejc.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KfN3yyD7BO6lp4y8oPoCmzpMKtOCXPJ2oMX/i+TIOX4=;
        b=VqNso5XvZTuGAuATFsOP3mt7K+B9CkPw1uJTLSDPhQ1c8YfxiSeMcQTkTD3OwNtBzb
         ETzfllI314pPNwZzDJe1hecY/ymCryGqZkCqsllGb1KJb5uSIaW04pBJr1nhyFsfIwQB
         PDbwMIWLRqQhPi2LsryEvGLcd3lxgJa8tSwPS1cOFucGGdWq0s1Wbh2EuQPcA5Bmdw59
         D7teA5xi1F3qLfbtAf0haaQPbMO0haaj19rla7FKhsYA5hb+jtM4zzRH9FB1GSisExY2
         YQbs+AZ7nYK8ygCDiNYTa3NFWkV67guZqj0Nv2u1KHZqJ7MmCv3oyuUc50/M7XVggTy7
         AA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KfN3yyD7BO6lp4y8oPoCmzpMKtOCXPJ2oMX/i+TIOX4=;
        b=2ZDXUYlv6r334bpKpBDLiYrzV2GGYQGQciDPps+ixVxBXOGCFLMEHTQ4eF8RalyuoS
         P3bWEHWUqsNcD29QPxYMNSXzzRIjmRZzm/a16jfH4rqhqlrcQPfw8/n72AWvrlZWwh/b
         N0lE7R2IDjx8Xkbdj7XETH8xb2tpLhIrrArl0cnNcfhNy7I1ajlt0KPZb3+663FNFXvX
         dxZUlLghIzoDsc7dBOK/j0zGIlHbLzTds5gQAgo6860Mi1W3MHASeyJOaSfCh5T5m8v5
         f4CV72JF8aNfAiPzQ/gw/pPShzbyUy7vx3Xon6B5Jgl/SbTYrOgQA48FKBxgqYEqMKYA
         30ag==
X-Gm-Message-State: AOAM5332g2bdBBai0HcecMARDZ+Vlez+7mihK7Ke90eNwLKXiWiMqRDq
        Yh6YbVdTB6061pTwABok/epquiuFaStuH8QSbhc=
X-Google-Smtp-Source: ABdhPJytlspuBRfIycNuoCuvdUHjRwy/iDT5Tx6ow3rGldSf3afgULtMMLg3JZ9KK468n6kRHSvpDmEI5KutFUpFYDI=
X-Received: by 2002:a17:907:3f20:: with SMTP id hq32mr4466047ejc.613.1643042604213;
 Mon, 24 Jan 2022 08:43:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
 <90488a50-c015-c9c8-e58b-81ccb66feaf6@web.de>
In-Reply-To: <90488a50-c015-c9c8-e58b-81ccb66feaf6@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 08:43:13 -0800
Message-ID: <CABPp-BEfhpTBV1rSXjqhPeNsYUKMTMvg7JaKTPeCb-tjdo+8aw@mail.gmail.com>
Subject: Re: [PATCH 03/12] merge-tree: add option parsing and initial shell
 for real merge function
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 23, 2022 at 12:05 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 22.01.22 um 22:55 schrieb Elijah Newren via GitGitGadget:
...
> > +     /* Check for a request for basic help */
> > +     if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> > +             usage_with_options(merge_tree_usage, mt_options);
>
> This is unnecessary; parse_options() handles -h already.
>
> > +
> > +     /* Parse arguments */
> > +     argc =3D parse_options(argc, argv, prefix, mt_options,
> > +                          merge_tree_usage, 0);
> > +     if (o.real && o.trivial)
> > +             die(_("--write-tree and --trivial-merge are incompatible"=
));
>
> 12909b6b8a (i18n: turn "options are incompatible" into "cannot be used
> together", 2022-01-05) standardized messages of that kind; let's stick
> to that to simplify translation:
>
>                 die(_("options '%s' and '%s' cannot be used together"),
>                     "--write-tree", "--trivial-merge");

Ah, thanks for both the pointers; will fix.
