Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B61CC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61520719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="hAU/xj3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZAXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:23:14 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:41545 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgCZAXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 20:23:13 -0400
Received: by mail-il1-f180.google.com with SMTP id t6so145571ilj.8
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eL9b8CS/g/2UEjS7MhM1/IZ498SjMPVYj1vliusqQ3I=;
        b=hAU/xj3cipAxbQ5/uJVer/juCu486BxDT9bsJsk8HptlriJyPtAH4KY/wqaKUdKTwi
         ptheAGYuyz6GJ9MyDKlNo0/L3tWlhv8IkORH2xBVm/N7oymMTfEoUE0tnf1X6dS5gbId
         K251mPwpvebT/G0M5mHMJbIiySBPsBkenlJ46UUS8mHJSX5rQ+yYOhZM03GtYPCCQ3fO
         Et8ZAA6xxIG1qDnsQAfss+STqQ0CVJ/EE4oYt2O0xRKdluLkmlHTDOQzUsYC7yfWFFs+
         +RK7S1xgMussFw/I44T/KLDrPnLrjBhtn171lIEKPHisTcnaLqIsIVOjs2hnRgaSq4CZ
         74iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eL9b8CS/g/2UEjS7MhM1/IZ498SjMPVYj1vliusqQ3I=;
        b=CISt5R4msQP+IWw7duROarf2w5A2/QeNQKbn9fpInkYiRyumXYG+4R2WOWI88wJi/D
         RqjlIP7dfOosoSZbm7lTOVv/3zO5El98ivVARX4jxSwdW5HMTv8X7w+7ajDwwkqROFUk
         ykTABL87ajdPGfuxpszveYgh0y7M+TAfZJIzKHF9W7E256Z2VIygWUBZA9n57g0ciW4Q
         jf8LErzZLFpktWb1zh8Yh7PRlrKSSDYpHF1Drn+q25iJliZG3h1utBxTJjy8AfPCE26A
         BSqFd8SwhaZknkyAp3vr1G/Z4Vp3FSafzmaRaOnqJdOxs8hzAFaqzMBOMX7URVWQLCF0
         qdIA==
X-Gm-Message-State: ANhLgQ1gBc+u6L0UDl0T8lOIVmcEa14soRPUOulHjhdB8N5ikf4v6yJ+
        FEV75ODsSeF2c2iQxfhbEJVJ5gl3GI/l4PhbNo98SQ==
X-Google-Smtp-Source: ADFU+vtsAEDdEQjM0Tv71k8C5IW6biiz2252Xn+5QT0VZpcDsFpzEhgewVogJTvW8rxBpMFAqDEPN9245Zla1WOAytg=
X-Received: by 2002:a92:359b:: with SMTP id c27mr5973510ilf.148.1585182192507;
 Wed, 25 Mar 2020 17:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA8EDABA-A41C-4177-A149-51DCD07C319C@googlemail.com>
In-Reply-To: <CA8EDABA-A41C-4177-A149-51DCD07C319C@googlemail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 25 Mar 2020 17:23:01 -0700
Message-ID: <CAGyf7-FF0aEEiRGjZ_+RuyYnSV5cYn+-Hp5q7dZRADj_VL034g@mail.gmail.com>
Subject: Re: Git doesn't support symlinks
To:     Daniel Malendez <dmalendez@googlemail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 4:38 PM Daniel Malendez
<dmalendez@googlemail.com> wrote:
>
> Hi everyone,
>
> I use `Ubuntu 18.04` with filesystem `ext` and `git 2.26.0`. I want to add a macOS Framework to my git repo, which fails with the following error message:
>
>     $ git add -f /var/opt/project1/Foo.framework/Headers/Interior.h
>     fatal: pathspec '/var/opt/project1/Foo.framework/Headers/Interior.h' is beyond a symbolic link
>
> If I use `$ git add .` it works fine. Is this a bug? This is what `ls` returns
>
>     Foo.framework $ ls -l
>     lrwxr-xr-x  Headers -> Versions/Current/Headers
>     lrwxr-xr-x  Resources -> Versions/Current/Resources
>     drwxr-xr-x  Versions

This didn't add the same thing. What does a "git status" show at this
point? I'd expect it would show "Versions/Current/Headers/interior.h"
as added to the index, not "Headers/interior.h".

>
> This sounds like a bug, correct? If not, I am thankful for any advice! Thanks!
>

It doesn't necessarily seem like a bug, to me; more like a case where
Git could potentially be "smarter" to try and determine that, while
"Headers/interior.h" is beyond a symlink, the target of that symlink
is still in the repository. (Versions/Current _is_ in the same
repository, right?)

>
>
>
> Best Regards,
> Daniel
