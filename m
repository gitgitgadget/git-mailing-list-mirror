Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF7EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 23:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjF2XJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 19:09:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE4330E6
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 16:09:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d9372f027so4236a12.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688080163; x=1690672163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XserO4qOkaW26RWfCSsIMDF/Q/YuaP7+GVnASgddcdI=;
        b=fgV0Zz63DbXEOTovcY/2NecLhGh2E7q7WdHpabB9VXwBY8C4Zcq0ZQV0VgZtCVYib4
         13BPFfuMPWesLxZiZOZ3+RLrJIR3Ec9dd8Yhdm5DrUAHWrh+jcbbbN760C+jgfZF2tJ2
         dXp/tpx8FNHXjgAoZ3PGEC7u3PmTLdLwGxyA0V6UVZUx2bxUGproyWuVnfvm4cp8+2QO
         CuHy8euWE4xV7xy6EjMBExy2DmOFiAxQrfgykJS8rfuZA1yVxyIPq8MzPRfX8MLwrc7t
         sb+rXellUfqTRpM2USAuqFJKue+zL6FWKwYwOVTJMOQp253mLOH7RcfvuTVzwFQekrCE
         xqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080163; x=1690672163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XserO4qOkaW26RWfCSsIMDF/Q/YuaP7+GVnASgddcdI=;
        b=FhcpPI/4CcHlvVzBdy1F5RnbQ5Z6e1Ai6KJ4hZ7efgRFWMxsdnJCqxvgg5HzVHDeZ9
         iRvSKyVbi9RqFOIOGJAhZedq93IulM4qCNlvkbxRHnekAs2JdGpc4DGSsq2u59jrZWz2
         FUE0uN+BQoVmCyU20I8qX1X6gEZqj/60+zKk3CW8o5VnCVc2MSi5BZy0w2z5rhYbPnkJ
         ktG4HLEE62wbEysq3Blc8ZFxJ1nl9OP7ptAzGQmHqaUBRML14bpFTT7Z1OG6GT9BEC0C
         k2L6lQRqgazn+oKg9/wwfZPQRjmKu73jtJkS1X/OBJqFukxHbcdyS2T9QACrWAUTwPFG
         DUQA==
X-Gm-Message-State: AC+VfDyidF0r/fSO59RI+l7iROl4ZUNlaRwYndFy78AxbAZV7+4SJC0E
        l8KneYnj/r8NfHVI7VccNQyUgOj62/b7/3O86HQKtw==
X-Google-Smtp-Source: ACHHUZ5u21XIkN8yJLGtB3vOHpsbzBADIpHF5ygZMWX3pIPbPM0AI/irL3vHo6z2RRjPvcgD55ezuNcPRJ8GPxGJ74o=
X-Received: by 2002:a50:934f:0:b0:518:7076:74bc with SMTP id
 n15-20020a50934f000000b00518707674bcmr207496eda.1.1688080162745; Thu, 29 Jun
 2023 16:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
 <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com> <CADE8Naonm+bW_jVvJKmnfZWQyX=0-QVSHxpSaHs1qo+5DsCiPQ@mail.gmail.com>
In-Reply-To: <CADE8Naonm+bW_jVvJKmnfZWQyX=0-QVSHxpSaHs1qo+5DsCiPQ@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 29 Jun 2023 16:09:11 -0700
Message-ID: <CAJoAoZ=X9hwZZ9eN2X=g04k2E6=wZsY1WEKFydMreNJKM3Mzng@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 11:45=E2=80=AFAM Vinayak Dev <vinayakdev.sci@gmail.=
com> wrote:
>
> > On Thu, Jun 29, 2023 at 9:33=E2=80=AFAM Emily Shaffer <nasamuffin@googl=
e.com> wrote:
>
> Hi, thanks for replying!
>
> > > Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
> > > very recently a patch to clean up some headers which probably were
> > > implicitly including trace.h when I wrote this walkthrough. Patches
> > > totally welcome - and if you were working from the reference code in
> > > https://github.com/nasamuffin/git/tree/myfirstrevwalk
> >
> > bah, wrong link, the tutorial points to branch `revwalk` instead of
> > `myfirstrevwalk`, but the offer stands :)
> >
> > > and it's on your
> > > way to rebase and fix that too, I'm happy to update my branch
> > > accordingly too. (If you weren't, don't worry about doing the extra
> > > work, though.)
>
> Sure will! But do you mean open a PR on your fork? I have the patch ready=
,
> and would be very happy to do so, if it is accepted!

Yeah, I think there are two things to fix:

First, a patch to Documentation/technical/MyFirstObjectWalk.txt fixing
the snippets there. (I thought that was what you were offering to
patch in your original mail, I may have been mistaken.)

Second, optionally, a rebased-and-fixed-and-your-attribution-added
branch of the reference impl that I can force-push to nasamuffin/git.
The more I think on it, I don't think the PR will help, since I will
want to just force-push that whole branch so the commit order still
functions as a learning tool. So if you have it even in a branch on
your GitHub or GitLab fork, or a series of patches you'd want to mail
to me, any of those are fine and I'll go ahead and rewrite my branch.


>
> Thanks a lot!
> Vinayak
