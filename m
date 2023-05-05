Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D63C77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 05:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjEEFGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 01:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEEFG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 01:06:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D226AC
        for <git@vger.kernel.org>; Thu,  4 May 2023 22:06:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9505214c47fso232742366b.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1683263186; x=1685855186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkGwy6AJvxk/m3p6RLU/LGHvMN1z4kuqZVyz3H0oiOc=;
        b=ZLyLcl+cab1KXVh+MKlVsSnHRAN3sBMzla37zObmCg1jghl2sYuMcwT7rB+UDyOiWz
         O0dvYAGvG8q65iwvMRcc3VJJHQq9FpaW59TZXajrpHLBaJyIfyc2sc4ot6MI2A5k8rhv
         aI3fjdShybKH7oyw4LOtOFzckq9ciwXCpsIP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683263186; x=1685855186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkGwy6AJvxk/m3p6RLU/LGHvMN1z4kuqZVyz3H0oiOc=;
        b=KcYdo1z6JD07fRonNhC5Lqb0IiAEFVuZe+1IhE8r7U459gfahxSVRD1YE0iVCsbt+b
         ARxh0tAjJUfXlP/2tDjaBC90ys/rIDMnwIjXd70f7izNMtbJ+oXVp4tVFnEazMZXgpvk
         8hryLU445egX4zQkyo9eEY8dRBvhMlT4wZzCnF0YsFNlUtR7I71gJ160AtqthYu6J4zW
         z+z+cZ0VrNGWwcA+zq/zgLdNwdGdXfJu1285IVezjZLVmwuxTi6vVM8Esnse3Vij1XHV
         r5c/1aolF5SWXd552pTZxzkVaP+yPPbGhOXQNi/EqbKgl3TUhrfLoQHMyUy4XjFBwTC8
         Gxrw==
X-Gm-Message-State: AC+VfDzhN4kfiKwpSHTo83hCrHOjWwXdYIeacQgdT33RFikGVydzL/DC
        zXjZ7eOtbUAl14t08WQd8WppOM5WjcOuTo+RDrofdzKrRWqrQwEa4zVJ1A==
X-Google-Smtp-Source: ACHHUZ6KF/ut0HbpN8ISPBMtYRUCS2rZnLcNqO3Y4pR6XlBfPCjea+DQ1tu92UidYT5sYMO1NbJJgjk98h3H44A0cVo=
X-Received: by 2002:a17:907:360d:b0:94a:7979:41f5 with SMTP id
 bk13-20020a170907360d00b0094a797941f5mr17942ejc.71.1683263186268; Thu, 04 May
 2023 22:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com> <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
In-Reply-To: <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 5 May 2023 07:06:15 +0200
Message-ID: <CAPMMpoi7+rdQzQPyVB8T9Pb+f332c68QvWLkwBdJZw=BcP0jbQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2023 at 7:01=E2=80=AFAM Tao Klerks <tao@klerks.biz> wrote:
>
> Please let me know whether you would be comfortable with a patch that:
> * Fixed checkout to be more restrictive (except still allowing --force
> at least on a merging state)
> [...]

Having reviewed the commit by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy tha=
t introduced the
"can_switch_when_in_progress" boolean in 2019 (as part of the broader
introduction of "git switch" and "git restore"), it looks like I
should change my proposal here. I thought it made sense to continue to
support --force because we can, but I now think this is wrong,
because:
1. the fact that --force does not work in git switch is *intentional*
2. even though making it work for "merging" states would be trivial,
making it work during rebase would not be
3. the blocking of --force is not a significant inconvenience, as the
error message clearly tells you what to do (--quit), to continue on
your way

So I will set about trying to understand how to make this one-line
change work. I already see that some tests rely on "git checkout -f"
bulldozing through an ongoing merge, so those tests will need to be
adjusted at least.

Are there any recommendations or processes around breaking changes for
the git project anywhere? The specific behaviors that we would be
changing here appear to be undocumented (I've looked through
https://git-scm.com/docs/git-checkout at least and find no mention or
expectation that switching during a merge, or rebase, etc is
supported; nor do I see any explicit mention in
https://git-scm.com/docs/git-switch that it is UNsupported)


ASIDE: I realized today that the warnings in
die_if_some_operation_in_progress() suggest "--quit" (potentially
leaving a conflicted index) and do not mention "--abort". Is there any
objection to beefing up these messages a bit to offer both options?
