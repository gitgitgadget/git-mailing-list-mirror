Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1DC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B50604D7
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhH3N7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhH3N7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:59:19 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B2C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:58:26 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d6so4212207vsr.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L6R63Mr+QpPxxcwg9hGTj3ZdgltYO7l3UkLKd9n6HAM=;
        b=JuUXGo08zk+BheMjjFSlNtB2fNAe3bLDMu+110N6b5cULgIm5KTVDg5Ue203RAMs8f
         7amsshBC91AwDYUd41PWyUOZanL+StYe1HRH8Jzss3gvZQ9GSzHxmydHDOXrJQ09Ns6S
         X35hqkUOnVUHLA5rbwLu1zNkfjtELzHtqsG8DOfb1Y5pSyGP66JEpazSgLwi+gCLFjWI
         +XbO35JbRp4/TLmtuL5A5UJaQ/5z0nv9iq5hRE3AgzRxrv2dLmQ4+JCfJtqod6osXTor
         cTELx8k18WaveMNBvBI3teS0/Mkt9KAoJFeB3FVqwCLajoucGG+dRLStd5BT7CbQEsxC
         rqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6R63Mr+QpPxxcwg9hGTj3ZdgltYO7l3UkLKd9n6HAM=;
        b=b/LzC8FQxqpUF8694TS9rGIYJbB0l5kD6ru3k3d2j15LsM1mq4bMnBMFDBvpgbQ37N
         d73HmAtrRl4RmN2w+OwjD0l3CM/0gXgZN6+S0Xp/d/KTEB5K5ebZouZDKD496xMIRdOe
         m7sdCSjMEWXifSh4wONIuLA0SYrFSrPs5VSuVW47w1HKjq/eGcEN6sKmbV+Rz5rMwDfT
         172x+S4bL6bFr1RGaXnUxTpBe89b43zJlnEMG1oRCEwFkmwb2sEWN/C1e1qbPHcNeRTh
         7PuE9/rVOQMLwqFMa3NG3bjWWyQvEYoD7/dfejhn8IVw+3LceVlEsVLTwskQITY6VDF4
         lLkA==
X-Gm-Message-State: AOAM533SzvnJKdeK4bcePjn/kp0ByNovElN+HnnrDCm76vmdkHVqy3jJ
        K2uBJNOXg9XHfNLOEy2RT8LzUBTlEZGIs51TZ3NQzA==
X-Google-Smtp-Source: ABdhPJzIZyae4WugSjUHVhD0kd1aGWcHLi+6rj5EwK/iTkOpQWPAOvCSbViMC10OIN2RPpYe+TV9Lb397XwLDs0RS5k=
X-Received: by 2002:a05:6102:5f1:: with SMTP id w17mr14178030vsf.21.1630331905110;
 Mon, 30 Aug 2021 06:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35qr7mq5.fsf@gitster.g> <87tuj7xhqo.fsf@evledraar.gmail.com>
 <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com> <87o89fxd5l.fsf@evledraar.gmail.com>
In-Reply-To: <87o89fxd5l.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 15:58:13 +0200
Message-ID: <CAFQ2z_PCubK9GNjwcwoZ0rmpezFsC+inoks462ysjS1L369UeQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 3:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Aug 30 2021, Han-Wen Nienhuys wrote:
>
> > On Mon, Aug 30, 2021 at 2:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >
> >> Han-Wen: It would be really nice to have this re-rolled sooner than
> >> later, my and Junio's "fixup" commits at the end are a band-aid, but I
> >> already ran into wanting to bisect something between master..seen that
> >> was unnecessarily painful due to the series now not compiling without
> >> the "fixup" commits at the end.
> >
> > I am folding in the __FUNCTION__ fix.
> >
> > However, I thought patches should be sent against the master branch
> > and not against some intermediate  version of 'seen' ?
>
> No, per "Decide what to base your work on" in
> Documentation/SubmittingPatches. See the part about "A new feature
> should be based on `master` in general[...]".
>
> In this case the topic on Junio's side isn't based on "master", hence
> the bisect breakages noted above.
>
> I don't know per the upthread what Junio's intended pace of merging down
> ab/refs-files-cleanup and hn/refs-errno-cleanup is, depending on the
> answer to that perhaps it would be best to wait and re-roll on a new
> master.

It's perf season here, so I don't have a lot of time to work on this.
It's probably the most efficient use of time to back out the reftable
series from seen until the errno refactoring lands in master. I can
rebase the reftable topic then.

> Also for any re-roll of hn/refable, see my
> <877dgch4rn.fsf@evledraar.gmail.com> for notes of other breakages in
> it. I also had the impression based on my
> <87h7jqz7k5.fsf@evledraar.gmail.com> and your reply in
> <CAFQ2z_P8vgY0RRT+XSH9K3VDQt39FLqXx6qfeZqaZPkwhq1w+A@mail.gmail.com>
> back in April/May that the intent was to re-roll this topic in a way
> that would be more split-up as described there.
>
> I don't care much about the exact end-state there, other than:
>
>  1. Trying to land reftable/ in some shape where we're not constantly
>     re-reviewing the "add upstream library" part of it.

Sure, I can send a separate patch series for adding the library.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
