Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0342C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2D460FF0
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFAMXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhFAMXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 08:23:42 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA2C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 05:22:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so13905153otc.6
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=U3forqx8q0pkmyUMx92DXjO+X3TjjeMfVVF0sEWn9xg=;
        b=TSvfZaGJqlzGvgMlIuEzz1oKbfFE938mPlCDz2UjBxhXuF6Fr6ikPav0JoolYRAtN6
         XeszG49rbCk2wjHG58k6TtF/ExsRFsoVNlfjZPgF/5auRVtDJLGt6TobXrBLHtMji6sD
         vPe/l2U/FILX2oc370iIpdjzgpt4SxnKcWnMYxmoG2bzpL+dBVvf/D3At7J7Vl00lSM/
         NHDDnC9i1X5oaPbvToKMDnEVWO2z0mpf9mZ2s0M0lgTLbI0+CABoHd9GKDUHka2Nzls/
         1ZDf6uQS2DwBSLAI7oIUVRQ4fKlKCUcdcBVnQ8brXVZR4TmvbDdmeuxLsD6sVYfLsICg
         HYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=U3forqx8q0pkmyUMx92DXjO+X3TjjeMfVVF0sEWn9xg=;
        b=V0JsTlDP8JP8EgJjfT7hBbUH9Ig/05Qd8kRZ/6zUD671MUiaLX1Bo0CAwrXUvkuHh8
         IBtYDxxTmEV/1uOzVm3d2vFq9Rp9WK3+GMD8++pxmu6R7Ui5eNDHbExm3bIyDdrhB58H
         ifmKmbOS/YFOm27gyLtYgdiBsj2SOf41JePQLZN+ZVuE3RQ13Sv9HBxKsyR2+bIzwRNf
         RHDRmKVuSNp1RLlqePYHoYaWigWFXQdVnWZapdgMaheUL30Dx9Nq+dDVrYf5ZxOlSSv9
         w4JrTWCFziw9nz6NFj42w06Y4CQpWaqKdt2v7YgOBKQN/MbLs7xNap4nN9/dYN3TiB44
         sYlw==
X-Gm-Message-State: AOAM533kXgMHnchVDMHqRb3LsDcJ6qBcnE3Szf4PSSOMoU5fdPHYn1i0
        edRSwzRP3fcqcfbLizZWrcc=
X-Google-Smtp-Source: ABdhPJxKOPwXGVXbHfC+JaszMiGmuqx5XSnmUe+FLFkepJc0tRNo50H9AHhlhdyNvC9Z2GiDTXLleg==
X-Received: by 2002:a9d:4801:: with SMTP id c1mr11811495otf.278.1622550119766;
        Tue, 01 Jun 2021 05:21:59 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l1sm810585oos.37.2021.06.01.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:21:59 -0700 (PDT)
Date:   Tue, 01 Jun 2021 07:21:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b62665df1de_e40952080@natae.notmuch>
In-Reply-To: <YLYcnwZQAEoSQKsG@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLYcnwZQAEoSQKsG@danh.dev>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > > Something is essential when working on constantly integration tree,=

> > > I don't want to make my life hard:
> > > =

> > > * rerere.enabled =3D true
> > > * rerere.autoupdate =3D true
> > =

> > If the defaults make your life hard, then shouldn't we change the
> > defaults?
> > =

> > For starters, which is the command you use? `git merge`? If so, maybe=

> > `git merge` should have a --rerere option to enable rerere. There are=

> > some --rerere-autoupdate, but no --rerere.
> =

> I think both pull, merge, rebase, cherry-pick, revert, checkout,
> switch, apply, am will be affected by rerere.

Yes, I know, but I am talking about you personally. Where do you
absolutely need --rerere?

> > But fine, this is an exception too. The location of programs is not
> > something that can be changed by default.
> > =

> > > And I would like to try new shiny features:
> > > =

> > > * feature.experimental =3D true
> > =

> > Interesting. I didn't know that existed, and I advocated for a
> > similar configuration: core.mode [2].
> > =

> > But if most newcomers can live without it, I'm sure you can too for a=

> > bit.
> =

> The point of trying new shiny features is dogfooding ourselves and
> report bugs early, if any.

Yes, and more developers should turn this flag on, but it's not
*essential*, so you can live one month with it off. Either way I don't
think it matters for the purpose of this experiment if you have it or
not.

> > > >   3. Every day you can add 1 additional configuration (and update=
 it the
> > > >      next day).
> > > >   4. The moment you add a 4th configuration you lose.
> > > =

> > > So, my baseline already requires 8 key-value pairs (ignoring alias =
and
> > > pull.rebase). I'm lost already.
> > =

> > With the exceptions I think you only need these:
> > =

> >  * rerere.enabled =3D true
> >  * rerere.autoupdate =3D true
> =

> OK, let's start there.

Excellent.

-- =

Felipe Contreras=
