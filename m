Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749CECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiIWLm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiIWLmz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 07:42:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8263E9506
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 04:42:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u69so6345pgd.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=WHhKbMD9yw+nP4TmNo3DDFxE7nV5mYmbJBDnhxG31Nw=;
        b=Ozv1DLzfGVhIBllhr3MP/gb2x65vyZGfEbqbYt6/zh79qfKEyj4gEAEY5+9WExNYUq
         jtsksrGOV94SouBS4ox3QL3dZaTlI1X0TRMzW6jNEJVjMAEvfGJkfaxq/6qQIxu01MCx
         tkkg/aQ9JY9LtSYeZ8KW1r2ymObnnj5T2vtbmzrEbTV5NFDcfdXxZ9NIssjF21RO3YI8
         JVWv/ijROPBSdxNV904Vbsbc+H3UbYcJSLXE1wSXJy8tkbWcTOU4+ML9/1vstjfSsT6K
         aIepj/T+2yF2pxwjtMf/dx08ZoxDB4OPRMBVA9ffZ6aJBMjb90arvYj3kCFz7P2OGPeO
         fKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WHhKbMD9yw+nP4TmNo3DDFxE7nV5mYmbJBDnhxG31Nw=;
        b=RKioENLdC6rzPOdUi2fSahOV6CNogATIZxEbwEg5+qQRbiPDg/nYZJGPJ9d1GBOvLf
         aZoJIQnj6Vu2Rd06ouecmVFqAqE+Nn5ENJ44/kEy5j4KTumQWb0bnQl6Qdvd/VqDHE/n
         kE2txePiDzexZBKdHLpZYdZ2ayYxBvcBdBSDZPR3iG51a1d3+SwqbiR9+adHvTi02OgX
         h/H1P0NG6RcjXCP3X4/o+nMu0YMfTB2iaR4J93gRojuSLPewljaFW0wkH4Ze8ht9Pe3F
         HakRRJKhCScaIETOs49cOhXiGMKZtWMT67u2Dqm5wgcxiaZqY4m9k7XDFElu6v/2vL4w
         g/WA==
X-Gm-Message-State: ACrzQf0GyKkzp8XG+GJgxca/bNwJsFQi/DsFSNbO1yNrkjCrVKz2MPeZ
        Jog493IITyayaIS/sC9Dh2ayzBzByX08C8IU/0CwpVc7
X-Google-Smtp-Source: AMsMyM6PmESt77KYZSHiKsznjckeXczyH3lR3qIauM8WN76d1CtEAuqoAFK6jZiRWBPLd/bCV0KdCyO8mJOIK+IzTMw=
X-Received: by 2002:a63:6b04:0:b0:43c:1908:d9c with SMTP id
 g4-20020a636b04000000b0043c19080d9cmr6115036pgc.258.1663933369219; Fri, 23
 Sep 2022 04:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com> <20220923080733.1995862-1-martin.agren@gmail.com>
 <220923.86fsgi4gl6.gmgdl@evledraar.gmail.com>
In-Reply-To: <220923.86fsgi4gl6.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 23 Sep 2022 13:42:37 +0200
Message-ID: <CAN0heSrnN4Vjcj6KDG+DZkZ7_GWz5dex2Qq0To6CGVH7_zux4Q@mail.gmail.com>
Subject: Re: [PATCH v2] cmd-list.perl: fix identifying man sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Sept 2022 at 10:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Thanks for the quick turn-around, this looks good to me in this form.

Thanks for reviewing.

> Now, having written and looked at this with fresh eyes this would be an
> even better & more logical thing to do:

>                 open I, '<', "$name.txt" or die "No such file $name.txt";
>                 while (<I>) {
>         -               if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
>         +               if (/^\Q$name\E\(([0-9])\)$/) {
>                                 $mansection =3D $1;
>                                 next;
>                         }

Right, we know what we want there, so this does look reasonable.

> Anyway, this is more than good enough for now, thanks! There's also much
> bigger issues with the script, and we can leave that all aside from now
> (e.g. if it dies the Makefile doesn't report an error, ouch!).

Martin
