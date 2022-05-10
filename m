Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F9C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiEJPww (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347245AbiEJPwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 11:52:08 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122722BF3
        for <git@vger.kernel.org>; Tue, 10 May 2022 08:48:07 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id a127so17345708vsa.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u02A/F6Nr6d4Wz0zcqrp4GWqB762ciIV3h8dCIMDTnI=;
        b=oa2K2Nca9HrD/a50U0i0nnMzmXc7I8leT8T6BJbBnKmJzN4o1bG621Ywu0eBVz4omc
         BPl0Gz6ExOuW6dzdnpOzeuX03j83GgYq/ydE+xDVP8GgiPm3/JCvdxa/usfjnOwAnQYw
         Vffw1mTaG61yAMm1P1xSVS7WK16CICux8bSRUWAXffJytVFPTk6Q1v2tygn0VqdOFo1Q
         IXPgvZ77SHacE2FwBc1TSwUiDOBVMmLE9mTUqC8KfADPitEZdK8g0PJhmuRzgPcTtYy8
         UiGa3v8pwezbVCPpQ5iqYsQFlt8z2zw287G85rbpQhOSny/3SYbQ4N3D6hXu3v7J9vHa
         SRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u02A/F6Nr6d4Wz0zcqrp4GWqB762ciIV3h8dCIMDTnI=;
        b=2nOvldLhMHjSxZOBNjcoh3VxvdEJ26qt5EEnrnoYQ4J5g5QvJ9SfDziK7x0k2BA3Qy
         9LULUaDpY2Tv1e8AJk2v2udkdfYr3Zlb+AW2AXhOuXxjO3GWkzDGE2F4DnzNuisvz092
         OKiTdHIgTarRkmTQ04voWmO883E2kFWpOhs38etK+STboFWVrQGBFeB8blwaf/KlRXXN
         ZEG/KFAn7kF7aELjaCBK1oc+wpSFBFXO+pub8dr5uSTOAfvYJ31NHzBzYzvWYzPXQnlk
         59q2LpxdU1CnY/aaGj9k6MmlY5sUeWtcTPPD0TJz/mTBMt5uL4kxsyxK5IcVOlikpAeS
         tX5A==
X-Gm-Message-State: AOAM5322LbEYnYPUIgdRleOe/nkFnaaTFfsLA+1zzSQKfd5XBOW8rnw3
        enSlgy0JCzOO/Ni+FSxRdc++wxOigFZgqOUAQJE=
X-Google-Smtp-Source: ABdhPJwfYqSP5dr4XIkak5YKbh0RvwROub2gtjKan6wAXfzf7esrpGoYgG0nZeKCax4/jA6TMhZMqKWVM/qzEkGMkko=
X-Received: by 2002:a67:c905:0:b0:32c:69bd:18a3 with SMTP id
 w5-20020a67c905000000b0032c69bd18a3mr12360944vsk.5.1652197686665; Tue, 10 May
 2022 08:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220503065442.95699-1-carenas@gmail.com> <20220507163508.78459-1-carenas@gmail.com>
 <a6094881-7e63-7dc6-2fc1-7e5573cfe55b@gmail.com>
In-Reply-To: <a6094881-7e63-7dc6-2fc1-7e5573cfe55b@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 May 2022 08:47:55 -0700
Message-ID: <CAPUEspitjykLSvSwDU7VAQm15Q+J1jPH9xonkmsn2f+mRGxOqg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] fix `sudo make install` regression in maint
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 7:17 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
> On 07/05/2022 17:35, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > A reroll for cb/path-owner-check-with-sudo with most of the suggestions
> > included but planned originally as an RFC, because I am frankly not sur=
e
> > that I read and addressed all of it, but also because after seeing how
> > my only chance to get an official Reviewed-by: Junio vanished I also
> > realized that I wasn't clear enough and careful enough from the
> > beginning to explain the code correctly and therefore had maybe wasted
> > more of the review quota this change should require.
> >
> > Important changes (eventhough most are not affecting the logic)
> > * Document hopefully better which environments are supported and what
> >    to do if you want to test it in one that is not (thanks to dscho)
> > * Removed the arguably premature optimization to try to keep the sudo
> >    cache warm which was actually buggy, as it was also not needed.
> >    The CI does passwordless sudo unconditionally and even when running
> >    it locally it will go so fast that is shouldn't be an issue (thanks
> >    to Phillip)
> > * No longer using the ugly and controversial variable name so now it
> >    will need GIT_TEST_ENABLE_SUDO to be used to enable it on CI (which
> >    is not done in this series, but a run with it enabled on top of
> >    seen is available[1])
> > * Stop the arguing about what is or not a regression worth fixing and
> >    instead document it as one through a test, which would be easy to
> >    fix in a follow up since the code was already provided by Junio
>
> I've had a read of the patches and I agree with Junio's comments on the
> second patch.

Not sure which comments you are referring to, but
I'd implemented Junio's suggestion and removed the "too clever" (uid_t)-1 i=
n v4.

> I'd really like us to avoid sudo in the tests if we can as
> it causes a lot of problems.

Even if it might not seem like it, I agree with you both (and dscho)
too, and if I could come out with a way to do so that would be still
secure, I would do it in a pinch, but I can't (at least until now) and
I don't want for that to hold up this fix so will be publishing soon a
v4 that still uses sudo in the tests, I am afraid.

> Just to let you know I'm going to be off
> the list for the next couple of weeks, so I wont be looking at these
> patches in that time.

Thanks for all your help reviewing them and more importantly improving
them, enjoy your time off.

Carlo
