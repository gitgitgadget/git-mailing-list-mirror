Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3834C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE6761288
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhEKNc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKNc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:32:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78ABC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:31:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k25so18146840iob.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rf74hoRFJvashMeZM5ow7XtCVAkIKU3lngYzyXL77t8=;
        b=gqCU3T7/j6+UmbUyCpPl1XbilSwGWxticK5i/RRegj4Ee1lRjyEVh0P3Ncbpwvb7b+
         AoBYdPxaCq2GIKcwBchc4qb0EvgHiFTJF39YWleCJzDCcRZn7y8mwt7QvVHO3F5ucD6z
         npItIWYnr8ewML1g12RetYCODChRLQhbZF5r+sEngbMum4RX5yfGhvVDbW/iWU5O0plP
         QUczUcfWej3EUlz7UlO5ssJZbQS9GLHzt5Ivvb3yCzkyNccDg0NtiVjKIGES+3t3JgBf
         2+2xfqShYJrOKBMWGivynyNaSDP3B2H8iCqZhJfzMWBJHQrhfi1/jIbR8Pl+wXZGs+Hy
         JH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rf74hoRFJvashMeZM5ow7XtCVAkIKU3lngYzyXL77t8=;
        b=XMJY889CU5Pq12fRAOOE3dGXHxmrIA2bO/0imsh4l+MrucA8dXe25OUw7hK1Z4kNIc
         Y/OP6/B0vAl8amwk9I099kZ1eadZ1VQYeL6ji16NB0T8ex9eZXVDFihZiI9VXY8Zodmv
         sZdrZHwnPePs3H0R+WoMofp/XJOeU4TDe98HrycZPClQCXO/bBbxvCR92h1LFmfJeQtP
         Lnlh9O3FGtEHokmWQI/wSAcxgqdlt4FCxf6sPtFHBvXYLYtcXFR5lJC1fJ0BzM4LeQKu
         8oRy+l66WWCVZLtiHeVpS5FiTnoKUtTsQJ0Jm4WdV7BHkLjcOBWrRgqG6cwLfxYTTdxq
         vp3g==
X-Gm-Message-State: AOAM532j5NCyMbt9hjUOQmeBe/svE5XZQ+v7K0zTb2x9HwoLH4JJlXY/
        Pmn8JdMWXyGSAEcm24Bi7ybAbmGynM/iJw1BQMo7RD0HzbEVF1bf
X-Google-Smtp-Source: ABdhPJwjzdFZMKWa63ORpuXORFJrDrS0EStOUSNDHcE5evD6vNHHo1qwb0nHDfHJND6r9xUWtFldW7/qmk6GmnMkCNU=
X-Received: by 2002:a5e:c00e:: with SMTP id u14mr19225707iol.106.1620739878212;
 Tue, 11 May 2021 06:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
 <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com> <xmqqcztyovf7.fsf@gitster.g>
 <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com>
 <xmqqlf8lmxca.fsf@gitster.g> <CAOLTT8SiEVR62LwuagnpbZ4XxiUMe2M2WPjaorzSJmfERD6BMw@mail.gmail.com>
 <xmqq7dk5mn2s.fsf@gitster.g>
In-Reply-To: <xmqq7dk5mn2s.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 21:31:02 +0800
Message-ID: <CAOLTT8RTtKiCX1EfrMAVdWWxRbpF2nW3ri1NSVQ-tqmpdDUOvw@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Fine, I guess the reason for this mystery is I "push" this branch to github
> > and you haven't done it. That may not be due to the platform. Because I
> > can see no this bug happening when I use a new git repo without "git push",
> > and I test in archlinux or deepin, this bug will happen in these environments.
>
> Sorry, you lost me.  I was talking about what happens in the new
> test you added to t6302 not failing as designed, and there shouldn't
> be "I've pushed but you haven't pushed to GitHub" distinction.  The
> test is running in a brand-new repository just created for the sole
> purpose of running the test after all.
>

Well, there are some expression problems here, I just want to express:
This bug is only triggered after I push and Git adds some config during
the push process. And then those config effort %(push) behavior.

> So in short, the test script added to t6302 in the v4 patch was not
> testing what it was supposed to be testing, as it didn't have the
> configuration items related to %(push) atom necessary to trigger the
> error?
>

Truly.

> That I can believe.  I was starting to worry if there was something
> more subtle going on, but I am glad that it was only an uncooked
> patch submitted without checking.
>

Me too, I want to complain a little bit: this bug is too difficult to locate.

> > I guess you also saw this bug:
> >
> > BUG: ref-filter.c:1544: unhandled RR_* enum
>
> No, I didn't.  I just tried to make sure the new test was truly
> checking the existing breakage by partially reverting the code fix,
> and saw that the new test did not fail.
>

I understand.

> Thanks.

Thanks.
--
ZheNing Hu
