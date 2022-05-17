Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7BC4332F
	for <git@archiver.kernel.org>; Tue, 17 May 2022 17:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiEQRDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351287AbiEQRDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 13:03:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BBD3FDAC
        for <git@vger.kernel.org>; Tue, 17 May 2022 10:02:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so32418308lfg.7
        for <git@vger.kernel.org>; Tue, 17 May 2022 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5L6SOo5F/HUI2kufRUrMQPP8m5oy+oLLd7gQZE9ie9E=;
        b=I+y869zvanpaVT6RTyQMvYSlTLIuJp4diOojEYCBJ/IGYZiG6lEvp7B9PivC5nUnJ7
         F5Qj0NtOEZnpvxdaBJ+U1YyBhfV2sBA+/xC9s2LdYejKWg/6ODyKNpZSsOll8QGwSHuT
         331LdvmxapQQRziBmTyu5bIrD6zwJ8aNkJ2BmsqLTVFTBoX0CyAlEYQ8Wc7nmJe3viUn
         Dq2lm9yljnTgdjvSgmixXH5BTrIepy9nPRj3SbitNeLKbFaP6JpnQ9MGE1YnnISBxHmE
         vcTvczgwmP7ojkc/yuPVUEwz+qAk4f/1GaFO4kQ6RbMdscGz5o6AoHPAHSglXYaQqXRf
         wZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5L6SOo5F/HUI2kufRUrMQPP8m5oy+oLLd7gQZE9ie9E=;
        b=YnPu7W1mKY6HHI3I8IMJyss4XDOaRSAnVeA+HM5iqN6oC+b1MiqrYNqlM05kB6tjfV
         wfU2xwXAzmeA6TAb2y4EUoZlQ+Pnu+xFDDT7RhurB1/r1NnJlY2ABKTqVkTZ4GPWxALP
         twPqDeOkr9brEnrsH0M3REV5OpKdqjpgBcCEvirqDH8KvZKzozonVwJ+nuWmF23SueTy
         18mHIHrc0Ci8Or3vbcZEDZSEQadPxAfHff8QchLzBiZ8Mj8msNmoi6bDyD0D2JKRyki5
         nKQ5DQpE1HAdZ6prhpj1J7ERY86j4F3j/WIkstSfyNw74RH1fMyPj99h5NJR/eR2Rod8
         nIvw==
X-Gm-Message-State: AOAM531UU+MHs71yLpBMNwJmp3X5Py/vDplcbgKMAXb9UhvFPvHwVkQy
        KTbmlgLgq39hAQpp6CpOsE5sUy0sIqRAF/th/kFzpQ==
X-Google-Smtp-Source: ABdhPJxVM0XyAy75+pxbdy9VCAvEO9Bg6qqAFJkiVvlMFZCJsnrNEM7MvYfEj0USuQjhDC0u59fUCrjayh4ni6ICops=
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id
 q3-20020a194303000000b00473f5fb27b2mr17399323lfa.626.1652806977127; Tue, 17
 May 2022 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220510220821.1481801-1-tbodt@google.com> <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
 <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
In-Reply-To: <CAN0heSper1O2ZdFq6RE=7znC0o+sFEsd8CBR3ckFtSoZu7Bzfw@mail.gmail.com>
From:   Theodore Dubois <tbodt@google.com>
Date:   Tue, 17 May 2022 10:02:36 -0700
Message-ID: <CAN3rvwBWBPLB+Pm14S5Nb9LOV6ajhT8qMbwi5bBm1pK_8AgN5g@mail.gmail.com>
Subject: Re: [PATCH] getpriority: Only getpriority translation the priority values
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, I have diff.noprefix on.

~Theodore

On Sat, May 14, 2022 at 11:43 AM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> On Sat, 14 May 2022 at 17:11, Alejandro Colomar <alx.manpages@gmail.com> =
wrote:
> >
> > BTW, I had to manually edit the patch.
> > It's the second time I see this (I can't find the other one), your patc=
h
> > didn't apply for the following reason: the a/ and b/ prefixes in the
> > file paths are missing.  Did you use git-format-patch(1) to produce the
> > patch?  Can you reproduce this?
> >
> > I CCd the git mailing list in case they know what's going on.
>
> Sounds like `git format-patch --no-prefix` at play. Or more likely, that
> the `diff.noprefix` config is on. I don't think it can be cancelled out
> by a `--no-no-prefix`, unfortunately. If a script is involved in running
> `git format-patch`, maybe it's not too tedious to make it do
>
>   git -c diff.noprefix=3Dno format-patch ...
>
> to cancel the config. (If that config really does want to be on, that
> is.)
>
> That said, something like
>
>   git am -p0 ...
>
> should help on the receiving side, by way of skipping fewer path
> components when applying the patch.
>
> Martin
