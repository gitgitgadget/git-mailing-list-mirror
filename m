Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73744C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B41B20708
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 09:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h1tOTZbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgA2JQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:16:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45128 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgA2JQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 04:16:32 -0500
Received: by mail-vs1-f66.google.com with SMTP id v141so6327579vsv.12
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TPnwVfKRppQWMGRyl6yUJft9gtckuV5FhSB2Yyw3g0=;
        b=h1tOTZbJ5pNrz1suqLoLXLFw8KlSeuxaS72D7gR1/r3m5HWkn+8ZxnkIY9RRS699ky
         L0P0NBk9hXaJE+LLNmyJW9fGffBVQPc+vYLHW7ZxmSGGEBtTXIdNnaWqR4wBV9lMTg4v
         kXdxoo1/WD2/jkDxrESK584uuoc+eRNfApMSV16hOuy7JDIwnRsspVgqinwVmwOJPlMG
         KL8TCQqLiXxDPvgF50KwJ/iifocg3QoU4EoRwZtCvLMd345vV6+pNlmpZUh1+5tRLmIn
         LEGan7jvQ8rTiZCb5wH4dlDkDQzpTbSEoL3HUVm9uVFDdM4qKG8ocgsUCjDKQ42uroc5
         vhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TPnwVfKRppQWMGRyl6yUJft9gtckuV5FhSB2Yyw3g0=;
        b=HsPA2wcOY6ghCvmXEc8Q/o52naMPlgAlDpv2P4B0rCgDFhenxanq/K558aW5CCHtaz
         4D7pEN9p3nIvG0AaiQtXXXuwaBAFqsW3n3GH5YEEMq8CVNzpJwWaDJ9WE0CZx35UGshs
         67OR2xsQqfBEFkL0DfoJ/nyaQtNJxDAjF/248l2nuNUirXVQAZSLbkE0EvCnEd5AlOv9
         82RDMa+yiuKJtRWzGpYzhpWhXshsxz/lgYNQguIXJEoB9zX0eN8iXEcSRd4RkrWbwm9R
         Qecg+tHpXICApEkHsLkAJMuKr46P9dAopqrmamJ/nN8zS3wO48h5hTcYrs7X18R9h9+f
         SxzA==
X-Gm-Message-State: APjAAAUsjKu8BYckxH3s8SVZWzjMhowgReua9yebUt+VQEPddyoSX4AH
        FVcONvO0/guynUEZfO3TZk6nMjBdSkNeWdmgh3Qyxw==
X-Google-Smtp-Source: APXvYqyzeFpzeJUHJERgMTXSIKuur+QtiC4JTAgedVraCidMwFGPBgQ10OTNw31nnw/uZKh9mFDK2gN/XHnh5gnnh6U=
X-Received: by 2002:a67:fc09:: with SMTP id o9mr16271094vsq.75.1580289390634;
 Wed, 29 Jan 2020 01:16:30 -0800 (PST)
MIME-Version: 1.0
References: <965b587f5834c88532476b56da95ead605d16000.1580110970.git.bert.wesarg@googlemail.com>
 <xmqqv9ou6983.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9ou6983.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 29 Jan 2020 10:16:19 +0100
Message-ID: <CAKPyHN0V6m4fP=0Yktgr+m+dPq3r2HrWC-ddTKJ6y3TVF4GSMQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] remote rename/remove: gently handle
 remote.pushDefault config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 7:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index 082042b05a..bbff8c5770 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -737,6 +737,7 @@ test_expect_success 'rename a remote' '
> >       git clone one four &&
> >       (
> >               cd four &&
> > +             test_config_global remote.pushDefault origin &&
> >               git config branch.master.pushRemote origin &&
> >               git remote rename origin upstream &&
> >               test -z "$(git for-each-ref refs/remotes/origin)" &&
>
> You cannot use test_config and test_config_global inside a subshell,
> as they rely on test_when_finished to rewind their effect, which
> cannot be used inside a subshell.  As you are doing "global" config,
> there is no reason to make "git config --global" call in a particular
> repository anyway, so just do this upfront as the first thing in the
> test sequence.  There are a few others in this file.
>
> Tentatively I applied the following fix-up on top of the series to
> unblock tonight's integration cycle.
>
> Thanks.

Thanks. Will squash them and re-roll.

Bert

>
>  t/t5505-remote.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index bbff8c5770..dda81b7d07 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -734,10 +734,10 @@ test_expect_success 'reject adding remote with an invalid name' '
>  # the last two ones check if the config is updated.
>
>  test_expect_success 'rename a remote' '
> +       test_config_global remote.pushDefault origin &&
>         git clone one four &&
>         (
>                 cd four &&
> -               test_config_global remote.pushDefault origin &&
>                 git config branch.master.pushRemote origin &&
>                 git remote rename origin upstream &&
>                 test -z "$(git for-each-ref refs/remotes/origin)" &&
> @@ -761,10 +761,10 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
>  '
>
>  test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
> +       test_config_global remote.pushDefault other &&
>         git clone one four.2 &&
>         (
>                 cd four.2 &&
> -               test_config_global remote.pushDefault other &&
>                 git config remote.pushDefault origin &&
>                 git remote rename origin upstream &&
>                 test "$(git config --global remote.pushDefault)" = "other" &&
> @@ -773,10 +773,10 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but ignores
>  '
>
>  test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
> +       test_config_global remote.pushDefault origin &&
>         git clone one four.3 &&
>         (
>                 cd four.3 &&
> -               test_config_global remote.pushDefault origin &&
>                 git config remote.pushDefault origin &&
>                 git remote rename origin upstream &&
>                 test "$(git config --global remote.pushDefault)" = "origin" &&
> @@ -823,10 +823,10 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
>  '
>
>  test_expect_success 'remove a remote' '
> +       test_config_global remote.pushDefault origin &&
>         git clone one four.five &&
>         (
>                 cd four.five &&
> -               test_config_global remote.pushDefault origin &&
>                 git config branch.master.pushRemote origin &&
>                 git remote remove origin &&
>                 test -z "$(git for-each-ref refs/remotes/origin)" &&
> @@ -847,10 +847,10 @@ test_expect_success 'remove a remote removes repo remote.pushDefault' '
>  '
>
>  test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
> +       test_config_global remote.pushDefault other &&
>         git clone one four.five.2 &&
>         (
>                 cd four.five.2 &&
> -               test_config_global remote.pushDefault other &&
>                 git config remote.pushDefault origin &&
>                 git remote remove origin &&
>                 test "$(git config --global remote.pushDefault)" = "other" &&
> @@ -859,10 +859,10 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but ignores
>  '
>
>  test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
> +       test_config_global remote.pushDefault origin &&
>         git clone one four.five.3 &&
>         (
>                 cd four.five.3 &&
> -               test_config_global remote.pushDefault origin &&
>                 git config remote.pushDefault origin &&
>                 git remote remove origin &&
>                 test "$(git config --global remote.pushDefault)" = "origin" &&
