Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC6C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C6261352
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhEMJcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhEMJcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:32:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1D7C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:31:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so34081932ybe.2
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UHSWrzzxVyG5NyniOtAnWuHjPWm0EnFu/L+B/uk6pvU=;
        b=WPb8q+8Tfl4IAndbahTlISkQYGpKDAcDSSq8cngxv21hpscuz6s2fkATqk0bObW7Xu
         96NerdxidREQZdATCuGFnRj4inawnkOvpYu95/CBbe+YFtD7svQz7kLEXrETx6rIwvCN
         Dw+ydK0QM2Lg6MPDcYzxUq39xglIoYKZF5ImUpHpBszSta2qDKNjKToQ1SR0/dinb0Pc
         W0L6O/7I2c7fn5bamr16JbKJAC16z2HyWiE0uXuPsdtPiDF3BbNQOcJtFi7JAE3t/cBV
         6Ikc2ddep8hdJN3Emj1vQ5JhQfAVl2Lbl6L2RsHKY2QxBUQmqcv0RzdhBRjd+JxHjiM0
         EDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UHSWrzzxVyG5NyniOtAnWuHjPWm0EnFu/L+B/uk6pvU=;
        b=d0uoJlM8OOzFIyd0Jokswnib9N2kQ602Dk733cmX9F5dhCDGXwbpfkDEZMF5Ffkag0
         MwEHzRiYxpOc/fSm6bEmuV2lCFh/FmZiRF1MFvm6tiLJ6/C0UcP3iSyvHwYq7tSXuWJQ
         XD3tYHp9nVkUexjpnIXAKWAO3GYeK4OSpHlISFH302qpGA6YmobTup2/VPD/x1WvwP4b
         TB6r3y/91pRLNNzbm4dR+DxfNJp3QQBSvjpO/8omudjk5ZiRku86ypQPjkB7CFOJaFyT
         n5rMKt4H3NspjjEg8vvvbg5pTQ9aGwF6EyJmNmJbraarE37flLttIOw6cyCP4SOCFLlS
         6tmg==
X-Gm-Message-State: AOAM5335f/qyqC4J6i1rTaTJuU8FDL4KUu+NS0CQS1R1JJeRUWqU+Pl+
        dJ2M45+uNgCbPAPc/zJBvquBGAiOfFch7N14i5hdGCl9fQ==
X-Google-Smtp-Source: ABdhPJxyFLYxPIunchIAnpiOjQOo2EMPZ5y51RdXFEaem75C5XRQ3RaXHNHiv5YI4COtgEq5VH6UkFsGvG4RzuRkwxA=
X-Received: by 2002:a25:19d7:: with SMTP id 206mr24091093ybz.483.1620898288707;
 Thu, 13 May 2021 02:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
 <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org> <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
In-Reply-To: <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
From:   Alexandre Remy <alexandre.remy.contact@gmail.com>
Date:   Thu, 13 May 2021 11:31:18 +0200
Message-ID: <CAKToE5DEL1ZFwUbvcC-M3y-3mSVsVgMXDig4G=jcKbc-nJ_GnQ@mail.gmail.com>
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and windows
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have an additional question, does double-quotes be safely used in
both windows (that's ok) and linux shell  for pathspecs (git status --
"src/test.js") in case of spaces in the path?

Le jeu. 13 mai 2021 =C3=A0 10:05, Alexandre Remy
<alexandre.remy.contact@gmail.com> a =C3=A9crit :
>
> Thank you, that was that. I was misled by the doc and the single-quote
> which indeed is specific to the linux platform.
>
> Thank you again for your prompt reply.
>
> Le jeu. 13 mai 2021 =C3=A0 09:49, Johannes Sixt <j6t@kdbg.org> a =C3=A9cr=
it :
> >
> > Am 13.05.21 um 08:57 schrieb Alexandre Remy:
> > > Hi,
> > >
> > > I do not understand why the same command works on linux and not on
> > > windows. Is the pathspecs syntax differ or there is a problem on the
> > > git windows version?
> > >
> > > * On windows (git version 2.31.1.windows.1)
> > >
> > > git status -- 'src/test.js'
> > > On branch master
> > > nothing to commit, working tree clean
> > >
> > >
> > > * On linux (wsl: git version 2.25.1)
> > >
> > > git status -- 'src/test.js'
> > > On branch master
> > > Changes not staged for commit:
> > >   (use "git add <file>..." to update what will be committed)
> > >   (use "git restore <file>..." to discard changes in working director=
y)
> > >         modified:   src/test.js
> > > A classic git status gives the same result between linux and windows
> > > (with correct file detected).
> >
> > Which shell did you use to invoke the Windows version? If it was from
> > CMD or PowerShell, then you must not put the name in single-quotes:
> >
> >    git status -- src/test.js
> >
> > The reason is that the single-quote does not have a special meaning for
> > CMD and PowerShell like it does for a POSIX shell.
> >
> > -- Hannes
