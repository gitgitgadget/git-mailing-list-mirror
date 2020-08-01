Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA5C433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 04:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09824206DA
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 04:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFt9xem7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgHAEhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 00:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHAEhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 00:37:05 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E6C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 21:37:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l84so16040966oig.10
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 21:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dTcPTjffLeXTVx70K9paGlv2zRwoxvX22HauoNZm6VI=;
        b=nFt9xem7TwHntz8+hl+GNwP8Xb9MSRzHkkBQLuxPyffZDV6tlRwONw2LzClxPEhoNT
         TCDWMkPczKQpEbwoALm9+hFQr9H+3Zi+o0VGI00LFTXuw/MlQpO6Rvl6F2PClbP34gp1
         vgs9zB/J33zDgxX960pPjtRfWOM/krKQNPwJfB7uwYlylUfIgHscYhLy/iS7xdfSbkBG
         6+xFBXYmjqOE2O2zV71dFEtgHETnR17kMVAFVVw4Z79xL8irHj+oJV2Te5qcR/fCXMSO
         Wwn1rTUhlA75jiyI8yDA8yQ8AYx3USi/chXbTnVwI1SbRh85j9kqI5MQ0PqHhLE+i1Yk
         9ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dTcPTjffLeXTVx70K9paGlv2zRwoxvX22HauoNZm6VI=;
        b=NRiAnvDDHayYGhG01zDrs3AaWMZqEwZYx9zTZZeknDkPrfThd3RP6VAH/lf8B+TfMx
         Zxn3DkJf2aZvCRnLjus3Yg85Vdq5zN1WRDCoc5llqPja6euwcZyp9VnR+/zZ2mrTim6d
         U6Ivm2GbB7qY6DqkM6tnYTZqENaJyOBoL04ElXJVv1d7lDv+7vNepUXrIYNb0HKRujXA
         w/+2HJORw0/cGw8x/LzaEdrbyDZ+KGsA5U0mvyhhr1u5IbBkVwjtp6zlb526PcEw1Mdf
         mgqNhgvARYyGkBuG4sAeYn7lJTzyzeZVYSc23BsSvbCOgTT7G0+lsYnaLAIqS35vDepM
         /YuA==
X-Gm-Message-State: AOAM532xpkZIkFZX12xDR64hEO6BuFqvorDF+yFX4JoR3cW2H+Bv7/U3
        51rgwLpl0FzM+A72OZfi0bOVjPpvij9Gg2OCsC5IuAl2
X-Google-Smtp-Source: ABdhPJyfItevD7gAIYrRvWyb1mGYpbsMOO6WOmb1gwzG/G9YfKtK67uR1ztThwcC0f4m2vvxnOLGqsr1PAutUGfLNH0=
X-Received: by 2002:aca:6289:: with SMTP id w131mr4982882oib.122.1596256622888;
 Fri, 31 Jul 2020 21:37:02 -0700 (PDT)
MIME-Version: 1.0
From:   Nicholas Hsiang <xianghongai@gmail.com>
Date:   Sat, 1 Aug 2020 12:36:50 +0800
Message-ID: <CAEcaDL=BrqFf7bwJ0cVWK-+vUKLmuihhKr8m0_w2CCSNfA9LEw@mail.gmail.com>
Subject: Chinese characters are garbled, setting utf-8 is also garbled
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

There are some problems here.

I have configured the character encoding in .gitconfig:

```yaml
[core]
  quotepath =3D false
[gui]
  encoding =3D utf-8
[i18n]
  commitencoding =3D utf-8
  logoutputencoding =3D utf-8
```

and Git Bash configed: Options > Text > Locale: zh_CN, Character set: UTF-8

However, when executing `git pull/reset/status`, Chinese characters
still appeared garbled.

```bash
Xiang@Xiang MINGW64 /c/me/front-end-note (master)
$ git reset --hard df576e2
HEAD is now at df576e2 doc: =E7=90=9B=E3=83=A5=E5=8E=96 ES5 =E7=BC=81=D1=84=
=E5=A3=99
```

`git pull`:

```bash
Xiang@Xiang MINGW64 /c/me/front-end-note (master)
$ git pull
Updating df576e2..bd2894b
Fast-forward
 AngularJS/assets/AngularJS-Component-LifeCycle.png | Bin 0 -> 154433 bytes
 AngularJS/chapter/Components.md                    |   2 +
 AngularJS/chapter/Scopes.md                        |  18 ++-
 ESLint.md                                          | 118 ++++++++++++++
 NPM.md                                             | 173 +++++++++++++----=
----
 React/Context.md                                   |   3 +
 React/Refs.md                                      |  47 ++++++
 React/react-architecture.png                       | Bin 0 -> 56624 bytes
 React/react-lifecycle-methods-diagram.png          | Bin 0 -> 41677 bytes
 React/=E9=8D=97=E5=BF=9A=E7=9A=9F.md                                    | =
 33 ++++
 i18n =E7=91=99=EF=BD=85=E5=96=85=E9=8F=82=E8=A7=84=EE=94=8D.md            =
                   |  76 +++++++++
 =E6=B5=A0=EF=BD=87=E7=88=9C=E9=90=A9=EE=86=BC=E7=B6=8D=E9=8F=82=E5=9B=A6=
=E6=AC=A2=E7=BC=81=E6=92=B4=E7=80=AF.md                        |  15 ++
 =E5=A8=A3=E5=8D=9E=E5=8F=86=E9=90=9E=E5=97=9A=D0=92ES6/9.JavaScript=E6=B6=
=93=EE=85=A0=E6=AE=91=E7=BB=AB?md           |  13 +-
 13 files changed, 426 insertions(+), 72 deletions(-)
 create mode 100644 AngularJS/assets/AngularJS-Component-LifeCycle.png
 create mode 100644 ESLint.md
 create mode 100644 React/Context.md
 create mode 100644 React/Refs.md
 create mode 100644 React/react-architecture.png
 create mode 100644 React/react-lifecycle-methods-diagram.png
 create mode 100644 React/=E9=8D=97=E5=BF=9A=E7=9A=9F.md
 create mode 100644 i18n =E7=91=99=EF=BD=85=E5=96=85=E9=8F=82=E8=A7=84=EE=
=94=8D.md
 create mode 100644 =E6=B5=A0=EF=BD=87=E7=88=9C=E9=90=A9=EE=86=BC=E7=B6=8D=
=E9=8F=82=E5=9B=A6=E6=AC=A2=E7=BC=81=E6=92=B4=E7=80=AF.md
```

`git status`:

```bash
Xiang@Xiang MINGW64 /c/me/front-end-note (master)
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   =E6=B5=9C=E5=A4=8E=EE=86=91=E6=B6=93=E5=BA=A2=E5=B8=B0=
=E7=BB=B1?md

no changes added to commit (use "git add" and/or "git commit -a")
```

`git log` command is correct:

```bash
Xiang@Xiang MINGW64 /c/me/front-end-note (master)
$ git log --oneline -3
bd2894b (HEAD -> master, origin/master) i18n
73dceea =E4=BB=A3=E7=A0=81=E7=9B=AE=E5=BD=95=E6=96=87=E4=BB=B6=E7=BB=93=E6=
=9E=84
89121aa =E6=9B=B4=E6=96=B0 NPM
```

My environment:

- windows 10 home chinese edition
- git version 2.28.0.windows.1

This problem did not appear in the previous version, and we look
forward to fixing it.

Thanks

Xiang 2020/8/1
--=20
Live Long and Prosper.
