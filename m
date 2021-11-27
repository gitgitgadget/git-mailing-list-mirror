Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD5C433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhK0TWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbhK0TUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 14:20:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8782C061574
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 11:16:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y12so53180070eda.12
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iCqlMhFN8BmzbXCHyoSQQmVwPLBnlVPF2NHaRtilO0M=;
        b=TvIjF0ouN3svkT/KYGJHRLpj7JF3C3EXFk7W2dQAPyoFUtGIyRi4uTyoBFE3IWrw2+
         TK3yXnxfNZUCo+D+FA7jFX4EkaVQuzL1W6nF1qo09z+dgGPwxEdj4Aa1/Fs8NYZ4GkU/
         B1VUABZLf5P2jdMbexM63BUWI3BuvigC8D5/RN1bobpJsFW6pP1wrGa6LaiLL755ETLj
         mgjfVw4KyiJoP8WK8/zNhJ+tqcKPo/jGiWtn7M92miHcLU385G1tPhAFMmvUmRV1b/UG
         OkxJDe+ClU98WDu6clLPPt9ijKicmu28Zid3eRN7yHzcmrbpIe/rZDPgjqI9Tm89Qe6v
         GbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCqlMhFN8BmzbXCHyoSQQmVwPLBnlVPF2NHaRtilO0M=;
        b=SdMnJoIXwB6YIQ7CCwtKHD5pF+/6MSdyJ3w1L73oc8OBqMdliW0MFT+ljcuOHh769n
         cW4fklyYR1U7qdYVVq7FTBl7hViRa1Kn0Ed/SBt7cAoUmiaXiLFa9XXE76Ker6rJSccv
         sKb0loXGmcM+SQdhigpsCYUTyP5h1X3kZYsvmlqDClg3tJ8aTnyXkCo55wFSBvLafbBQ
         diLn5kqmLjaXpoaldUu0QOTcUulMV6EBBxggEeiIJqpJvn/QOzjJwWhOxpnfPv3/DAPv
         g+FfdY7I+eG0zEuB3rgpFLq0kAS4PwTLc4OzVn4wkj9nr98Tv28byL1QjbpP1wboMJNv
         aavg==
X-Gm-Message-State: AOAM533BHZ56iBAE7HjWWrrJKoLeKD1kCBANnygt7w7mrEMOToq9PLG8
        25zW0no3uTtby6uc/IJ3x8Ws6PMkF51PiIk7FkI=
X-Google-Smtp-Source: ABdhPJwbdKleces7UxdRouzXilVkwjhztox0DP2fjhN5NGh2WjxYlO1SA1WMEUwYfcZM9e4DNp+rFyIfQYYIM3Mnsz4=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr48845009ejc.74.1638040605329;
 Sat, 27 Nov 2021 11:16:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com> <4b0044656b0ebe81db60f605a184948f728c4b9d.1637966463.git.gitgitgadget@gmail.com>
 <211127.864k7xj38p.gmgdl@evledraar.gmail.com>
In-Reply-To: <211127.864k7xj38p.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Nov 2021 11:16:33 -0800
Message-ID: <CABPp-BEXghA4rZCx10hCWWNjtPLkMWXAXU6YNbA4JMZ8WmVPfA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] t2501: add various tests for removing the
 current working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 27, 2021 at 2:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Nov 26 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +             # Although we want pwd & git status to pass, test for exi=
sting
> > +             # rather than desired behavior.
> > +             if [[ $works =3D=3D "success" ]]; then
>
> Wasn't "[[" bash-specific or something? In any case a more regular "if
> test "$works" =3D "success" would work here.

Thanks; will fix.

> > +                     pwd -P &&
>
> I wonder if this is doing what we want everywhere cf. 482e1488a9b
> (t0001: fix broken not-quite getcwd(3) test in bed67874e2, 2021-07-30),
> but haven't looked much/thought about it.

I can change to `test-tool getcwd` for the obscure platforms; thanks
for the tip.

> > +test_expect_success 'checkout does not clean cwd incidentally' '
> > +     test_incidental_dir_removal failure git checkout init
> > +'
> > +
> > +test_expect_success 'checkout fails if cwd needs to be removed' '
> > +     test_required_dir_removal failure git checkout fd_conflict
> > +'
> > +
> > +test_expect_success 'reset --hard does not clean cwd incidentally' '
> > +     test_incidental_dir_removal failure git reset --hard init
> > +'
> > +
> > +test_expect_success 'reset --hard fails if cwd needs to be removed' '
> > +     test_required_dir_removal failure git reset --hard fd_conflict
> > +'
> > +
> > +test_expect_success 'merge does not clean cwd incidentally' '
> > +     test_incidental_dir_removal failure git merge reverted
> > +'
>
> This testing the current behavior (and below) looks much better, thanks!

:-)
