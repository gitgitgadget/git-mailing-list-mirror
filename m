Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0610C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570E122282
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilz70xuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgJSR0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgJSRZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:25:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38236C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:25:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k68so313622otk.10
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HET41klFw3Z6q4E6EROf5cNuPK+x5ZkIRPnLDlX4aEU=;
        b=ilz70xucBV9ChEG6J0cr7qC3ddG/ABs1/o3SFUzs623ksCD9y2AZi/a4HURvQfMwS9
         Sj8/khMe47rRaUc58YV8laNxTakiE0UZD28E52iqKWLlgDFd9MtpWCyWTYr6PBwQNEuN
         YlVKzwmDc+xgM781QTlGmlFNd4GJPB7c6Ev1eiZJOpYSAZMwjVwZncumO7UAnL0PZP1A
         W6ouS5O28x1hyRmau3KDGAPhMkjP+KBNPyCNvaiClhEDX5WZ0Fh/0k1KhIpTULb1ngmt
         UdGpMx5N6dzzi2Nc54shxfXVFDlH+Hy3l/ObVI1tEaIuessCS7Enz7TkDpXJThr9vZQ+
         Hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HET41klFw3Z6q4E6EROf5cNuPK+x5ZkIRPnLDlX4aEU=;
        b=t3f9cN9+iTxAF+0nJ7jmuNk/0Ro3mHfPozI2jEHZElYE6Yc5DTEOzjN07OFM+WmGNg
         Dmkihr3C3Xe/ueXJqoKQv8quW1Mw2JasiNR1HZR/xIyW3ZKWizqJUjgbLHDXxrIiqAVN
         mBa4wXKc15cQCq0LMADWfcZJCL0MI9vLbxHUaAEadNBJNnhcHqG8/y03qsZR7DrgjA1s
         1HaeHhL6k3LzfbmKAUpBqoTkNaNciCFhLrSn/GJ7ROIvTJFd32iaOZDplILENCnhJxr7
         BZKKPM5JhpsR9aZnltDyR19gTRo3UBdAg0hBhx1zNisZD4rAjOk0pjbmLFzmsBJmJou/
         1NmA==
X-Gm-Message-State: AOAM533juYAE0Acrrfi4k8+m6AbPJZQOBeI3jOLiFh8euZ9x4DKkQ7MT
        f/HrbPnN+5AF0o9f9pu148b2C5YVr63S6uAgNR4=
X-Google-Smtp-Source: ABdhPJxFSFhMsLvsJqbn8Uofzm7cB6EAg098nm4sTmi/oThXmchkfQD+TLH+eN3WcP9eDOg1nLDlYZ1p3F0s4Ta27Ig=
X-Received: by 2002:a9d:22a3:: with SMTP id y32mr738948ota.210.1603128308544;
 Mon, 19 Oct 2020 10:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com> <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com> <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
In-Reply-To: <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 19 Oct 2020 22:54:57 +0530
Message-ID: <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of subshells
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Oct 2020 at 19:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Charvi
>
> On 19/10/2020 13:55, Charvi Mendiratta wrote:
> > On Sun, 18 Oct 2020 at 21:09, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Hi Charvi
> >>
> >> Congratulations on posting your first patch series.
> >>
> >> On 17/10/2020 08:54, Charvi Mendiratta wrote:
> >>> Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.
> >>
> >> That is an accurate description of why we want to avoid using `cd`
> >> outside of subshells. However this conversion is converting `cd` inside
> >> a subshell to use `git -C`. I think that is worthwhile as it avoids
> >> having to use a subshell but the description should say explain that the
> >> conversion is desirable to avoid the cost of starting a subshell as the
> >> original test does not suffer from the problem described in your commit
> >> message.
> >>
> >
> > Thank you Philip, for corrections . I somewhat able to understand that
> > commit message
> > should be " avoid using cd inside the subshells " because running a
> > shell script itselfs starts
> > a new subshell, please correct me if I am wrong . But still I am
> > unable to get that why you
> > mentioned the description as "cost of starting a new subshell " . Will
> > this not be the same subshell ?
>
> The original test looks something like
> (
>         cd sub &&
>         git something
> ) &&
>
> The commands between the ( and ) are executed in a subshell, any changes
> made to the current directory or shell variables in the subshell do not
> affect the rest of the test script. This is because the subshell starts
> a separate shell process, but creating this separate process has a cost
> associated with it.
>
> The modified test looks like
>         git -C sub something
>
> Here we tell git to change directory before it runs the 'something'
> command, this is more efficient as we don't need to start any extra
> processes - there are no subshells.
>
> So the purpose of this change is not to "avoid using cd inside a
> subshell" but to avoid having to use a subshell at all.
>
> I hope that helps explain what a subshell is and why we want to avoid
> using it if we can, do let me know if you want me to clarify anything.
>

Yes, thanks a lot Philip I understood the reason. I will do the corrections in
commit message and commit body as below :
t7201: using 'git -C' to avoid subshell

Using 'git-C' instead of 'cd' inside of subshell, to avoid the extra process
of starting a new subshell

Please confirm, if any other changes are required .

> Best Wishes
>
> Phillip
>
Thanks and Regards,
Charvi
>
> >> Best Wishes
> >>
> >> Phillip
> >>
> >>>
> >>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> >>> ---
> >>>    t/t7201-co.sh | 10 ++--------
> >>>    1 file changed, 2 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> >>> index 74553f991b..5898182fd2 100755
> >>> --- a/t/t7201-co.sh
> >>> +++ b/t/t7201-co.sh
> >>> @@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
> >>>        git checkout master &&
> >>>
> >>>        mkdir subs &&
> >>> -     (
> >>> -             cd subs &&
> >>> -             git checkout side
> >>> -     ) &&
> >
> > Is there any specific meaning of writing these above two commands in
> > parentheses . Will this not work the same without it ?
> >
> >>> +     git -C subs checkout side &&
> >>>        ! test -f subs/one &&
> >>>        rm -fr subs
> >>>    '
> >>> @@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
> >>>
> >>>        git checkout master &&
> >>>        mkdir -p subs &&
> >>> -     (
> >>> -             cd subs &&
> >>> -             git checkout side -- bero
> >>> -     ) &&
> >>> +     git -C subs checkout side -- bero &&
> >>>        test -f subs/bero
> >>>    '
> >>>
> >>>
> > Thanks and Regards ,
> > Charvi
> >
