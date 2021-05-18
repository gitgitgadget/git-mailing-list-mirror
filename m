Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E38C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A176061002
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbhEREcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 00:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhEREcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 00:32:50 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98245C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:31:32 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id l25-20020a4a35190000b029020a54735152so1960007ooa.4
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7PHq6vKfn3MobhbU6W9e0rVCNbgLNdDIly1Fx3K1Yw8=;
        b=XaLfztU+v8g7asRSQlIa+TUYAZCbHZz/xwIGXjK0F2RIquBGzrUOJjPekozML/Udj4
         m5aZrtB3gTk0c/5PCOO2HWBLxz8iVErKjvyhLxFzYBQjobOPAcd5ewl40NKWJEkQPqoq
         l9gSYh7pyKLhjeFc2OaYuQC21TmQVjRhujgMKIIliISXCajZ4rvo8FY+cQ2OcFsKJsj/
         xNnQ/zaGeY+BExnFuEc4NznpA07ZXHV8AU8eKwUmLyDVMhx9JXoCp8bxuPfxOMccwN4N
         Q6usAI1sI0SfbA7yYE7UUt5/h5XsacZ1mNqT/ZjVyNJZEtm2y6U4Jxj9qcVlbZStMxAH
         N2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7PHq6vKfn3MobhbU6W9e0rVCNbgLNdDIly1Fx3K1Yw8=;
        b=O/yBLfyU2+bLuDIaPqXYsPWnvxsUhoullm5Krh4AyYtrJRGZ4cYvMnKzgekwaqakk1
         l64JtOeNxjvUzGSPvnp60fn39860VSynUAYH+Mr4DIDN3LKqTZEy9E8MJMOzJy0GDi4H
         sJECk1ylu25F3fuBBMDa8FDKWeIYVBDTzMxuQ6cEtvydsAbkuUZyTXH5WD6fyplp0to8
         CQGRCo4+6ultNAMOM8xgTU881cHS/imc/fiPMG55Pd15JiDmY/xYyzTIjl/5qMhzgzHW
         jW4jsb+XQh/VHzDWwCHNANETbtLMmGYdku2rkgNf1eHEESJEkRJUNl5frb8LQpK6Mx3o
         6GTw==
X-Gm-Message-State: AOAM533QWz/pv3uN3Sc4XtYdW1DpKJ5q6nKmebNr6cXw0e9/zH0sj35w
        HYxXE26MrTt1Z4ajzcECX5fV0qrs8ozitg==
X-Google-Smtp-Source: ABdhPJwBM5kgdXuQYDoe3PJa8LQTpMacBJcmZhzlUVrfi7jf4Yq41cOhwoi9gtTfSPu3TGG9R6ktiw==
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr2694292ooi.40.1621312292083;
        Mon, 17 May 2021 21:31:32 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d67sm3068654oia.56.2021.05.17.21.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:31:31 -0700 (PDT)
Date:   Mon, 17 May 2021 23:31:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <60a343226a0ab_14d1bc208f8@natae.notmuch>
In-Reply-To: <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net>
Subject: Re: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-17 at 16:48:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
> > This looks much better.
> > =

> > I wonder a good follow-up (hint, hint! :) would be to have
> > exec_man_man() and exec_man_cmd() in builtin/help.c set this dependin=
g
> > on color.ui (so we'd do it by default with "auto").
> > =

> > Then e.g. "git help git" would look prettier than "man git".
> =

> As I mentioned on the patch itself, I'd prefer if Git didn't do this.  =
I
> have my own colors configured and don't want Git to render its man
> output differently from what I have.

It won't.

> Even if I didn't, I wouldn't want Git to change the output of man(1)
> to be different from what's on the system.

That's a preference others don't share.

> I should point out that I have my shell configuration set up to use
> different colors depending on the capability of the terminal, such as
> using a 256-color palette when that's supported and a 16-color palette
> when it's not, so there is literally no configuration that Git can
> provide here that matches my existing settings.

Once again; your configuration is not going to be overridden.

> Additionally, colors tend to pose accessibility problems for a lot of
> people.  I have normal color vision, but because I use a transparent
> background which renders as grey, the standard terminal red is nearly
> illegible for me.  I also know people with colorblindness who have
> problems with various colors or any colors at all.

Their configuration won't be overridden either.

-- =

Felipe Contreras=
