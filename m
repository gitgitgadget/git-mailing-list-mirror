Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B643FC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 04:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiFOETG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 00:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiFOETD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 00:19:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDC35841
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:19:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so880328pjg.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 21:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfcOqpPJPZyXOGKfKXFPO3+78Uh/xUKs7KknOEFZi7Y=;
        b=eJdGZVJ71PhDjliHrfhcAe88F+JUjWxQ1u2OrKuSSpdLRdAqXOI2ZH9oI5SCT2P+Hq
         stzlAgs++17RDjm+Atkxi22q4ijVlZMfyYxhmaM1Wui5zsCYKYhGlwuUuKouZFUoY4oY
         F8Y5bC2AF7joDdLpPBYlY9uyYuhvxYtCaA+oIE07UqNpi3DFQaFl9ESCOaIRdqsQxpkE
         DUzVJ+lDel7MmHDd3qW65X+mxpOCS6AQx/qnbRzX8LNcrPvfyTOYm0gBt4aLVO8Mwyoi
         0bZpPv9ug40VZPCPo5UR3S9gvqTgx03O44a9+NdprNMfmatG85tllmg+qLpAdk+CWbU0
         0hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfcOqpPJPZyXOGKfKXFPO3+78Uh/xUKs7KknOEFZi7Y=;
        b=ZKNO8p26b/BQL540ogFnDmd/SnBln3HnGOhZvYn0AsFpjhY9o2AOfY+7uT+h9Gd/sC
         VfMrzGN8/PqJAeEBNvcTLCHcMf7fhySHzeAVdTtzx+WL1bnE0JS6UJze2BcqkX7DShJi
         MkvHaVG4Hr0HS3Q6BP+AfQE4iDoZ9errM+Kd/erhZpu+foEtd/fBYYqQpv9hfUmSdWpw
         NXmJyYjUcjoUEA3Qs7i1I/NdX6xbXoyEkBWcbkJQhXqrgVhc2Fe7zyfe+hFSof7z8Nx5
         hBqfOiBtjXlR2zg+LdxUagciKGW1rUrc/BojbP06EbQ2t3OAdodEftfm8mMZS0zCuMzR
         2l0w==
X-Gm-Message-State: AJIora/p80l1ubtmI7cH00FPWTOFIdyFQtSrySne8YGJbG4jBGtvty80
        OM4XZnB9NBlDcLREhJePIaBEWUarejwV3fEfzUg=
X-Google-Smtp-Source: AGRyM1tCcy3iFuxAwDZ5evHhGP/ltcLBLFEWwYPRf6psU93wbDsp0cuHTwKgnEw+fHDcGAL8Nhy8lTo9VvMFjBkIt5M=
X-Received: by 2002:a17:90b:1c10:b0:1e8:90bd:d912 with SMTP id
 oc16-20020a17090b1c1000b001e890bdd912mr8022226pjb.233.1655266742572; Tue, 14
 Jun 2022 21:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206091000590.349@tvgsbejvaqbjf.bet> <CANWRddNa1nB9shoppfXuA2yqmd2353HVBopoufkh0SevnVrngA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206102327540.353@tvgsbejvaqbjf.bet> <xmqq5yl8chhz.fsf@gitster.g>
 <CANWRddMXrhs2grTfq9NtHM7KqxaFRejvaXxvDGV90_m=Kmm-uA@mail.gmail.com>
In-Reply-To: <CANWRddMXrhs2grTfq9NtHM7KqxaFRejvaXxvDGV90_m=Kmm-uA@mail.gmail.com>
From:   Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Date:   Tue, 14 Jun 2022 21:18:51 -0700
Message-ID: <CANWRddP3eUNiOTL0Jq_MoTXHUQFP430UcnCJBsm8pyqyVgrV1w@mail.gmail.com>
Subject: Re: Best way to update `HEAD` in mirrored repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 9:11 PM Rodrigo Silva Mendoza
<rodrigosilvamendoza3@gmail.com> wrote:

> Good news Johannes, your patch worked for me as well! Here's a run
> with the patched code.
>
>     $ git --version
>     git version 2.37.0.rc0.dirty
>     $ git clone git@github.com:xvandish/livegrep-fragment.git --mirror
>     $ cd livegrep-fragment
>     $ git symbolic-ref HEAD
>     refs/heads/good_main_5
....

Whoops, botched the output of the first `git symbolic-ref HEAD` call.
It should be:

    $ git symbolic-ref HEAD
    refs/heads/good_main_4

Cheers,
Rodrigo
