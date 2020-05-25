Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F37DC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D632070A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1FBDoFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbgEYR23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbgEYR22 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 13:28:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830BC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 10:28:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so3521909qtv.12
        for <git@vger.kernel.org>; Mon, 25 May 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AV2j+pjNsXTAC6B/5a3EDJqXldmT/ugWbXz/NsaBI0g=;
        b=A1FBDoFsL1jV6KA84JaSU/7n8xRY59SFy9ZJVG3soEL0X3s7SdrV0GPgwAu5QuEf4F
         Rp2/mO3Gr7YvA43xOpDOQlmtwPzhAD9TXSCLYQrBrTVArqwqVz1O55g6WhAukuzt40/C
         hOD8ZFUXoeXm2rw9sgS3M72hG3Ged6NMcOoIYsbyT6CSl+HRLyWQTFXSN0YogZvZPBre
         AdNHxGpYXIdjgXEHo7vxWKDxub4Zu4EJk3MBQCtf7ez3rh+NzpnyyvHaASIY8l9CHBMZ
         zJ347aYYO5NGQ70uRhYp04hRWg4KQPBJqt0vz7NT885hf9YghkMkbxcU4yarXQhGVLyD
         HpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AV2j+pjNsXTAC6B/5a3EDJqXldmT/ugWbXz/NsaBI0g=;
        b=qFI4TsYpt+GdzzETufhRqGOWr6l+VYCgKptbHma7dQvPcdXJX9kzfD0eQecWZuQ/Ir
         J74vDbD9J4/gY0icTKs9fuZeV9NVQK8H65t42mDWbY48pPYFa57IkHfHAeO8rdMuY2oS
         MLH/b2AcdJZJHMNSRKDmISOJM6mw0YrnTdV+SW3RDVqr6G2PwiR6r28Uu1DjrSLhxET5
         2/WnVhAVN01s0c/pfYCcwkzD9kVnLlpMCczMENx0p4DH8zzicRVP8RADDFFfQ/6TX5FQ
         jubr91Yf0MqMzNibcxoyF+PujmtwPh9BEstB9ciaW6hhJwOHFgdiv8YONNyVTKquzUVN
         YSxA==
X-Gm-Message-State: AOAM533RGgjHhUSEflgI1Vyn01+ujvDZsXYIFDIS5QhxY+tUufdwpphk
        xv4W295g1/YNR1/z6onij76kSGBx
X-Google-Smtp-Source: ABdhPJzV3fjSkgrj+TqqajernfzCJKjOeG0puLlnra3Bik2rHpB9wlIVirDyumCXsaQNAIrCLBAkqg==
X-Received: by 2002:aed:221d:: with SMTP id n29mr29054940qtc.286.1590427707513;
        Mon, 25 May 2020 10:28:27 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x41sm4834444qtb.76.2020.05.25.10.28.26
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 25 May 2020 10:28:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: recurse-submodules can remove local changes when switching branches?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net>
Date:   Mon, 25 May 2020 13:28:24 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1788146A-420A-41F9-A286-165F574089BD@gmail.com>
References: <20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net>
To:     Laurence Tratt <laurie@tratt.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurence,

> Le 25 mai 2020 =C3=A0 05:40, Laurence Tratt <laurie@tratt.net> a =
=C3=A9crit :
>=20
> If one creates a new repository, makes a new branch, adds a submodule, =
makes
> local changes to that submodule, then switches to another branch, it =
seems
> that git can silently remove those local changes.
>=20
> Here's an example (the repositories involved are irrelevant other than
> they're small!):
>=20
>  $ git clone https://github.com/ltratt/supuner/
>  $ cd supuner
>  $ git submodule add https://github.com/ltratt/extsmail extsmail
>  $ git checkout --recurse-submodules -b b
>  $ git commit -m "add submodule" .
>=20
> At this point make a local change to extsmail/README.md and confirm =
that
> git has noticed that something in the submodule has changed:
>=20
>  $ git status
>  On branch b
>  Changes not staged for commit:
>    (use "git add <file>..." to update what will be committed)
>    (use "git restore <file>..." to discard changes in working =
directory)
>    (commit or discard the untracked or modified content in submodules)
>          modified:   extsmail (modified content)
>=20
>  no changes added to commit (use "git add" and/or "git commit -a")
>=20
> then change branch (in the supuner repository, not extsmail!):
>=20
>  $ git checkout --recurse-submodules master
>=20
> The switch of branch succeeds without warning me that I have changes =
in my
> submodule. But then:
>=20
>  $ git status
>  On branch master
>  Your branch is up to date with 'origin/master'.
>=20
>  nothing to commit, working tree clean
>=20
> My local changes to the submodule have disappeared entirely.

I believe this is the same bug that was reported in 2018 here:
=
https://lore.kernel.org/git/CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXw=
s4nig@mail.gmail.com/

>=20
> Switching back to `b` does not restore my changes:
>=20
>  $ git checkout --recurse-submodules b
>  On branch b
>  nothing to commit, working tree clean
>=20
> This happens on 2.26.2 and the current master. AFAICS this only =
happens
> because the master branch does not yet have the submodule registered =
in it.
> If it does, "checkout --recurse-submodules" maintains my local changes =
in
> the submodule across the branch switch.

Thanks, this information should be useful for debugging.

Philippe.=
