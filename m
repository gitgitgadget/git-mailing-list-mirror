Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A5FC7EE22
	for <git@archiver.kernel.org>; Sun,  7 May 2023 22:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjEGWZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEGWZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 18:25:40 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A0100D9
        for <git@vger.kernel.org>; Sun,  7 May 2023 15:25:39 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-192b330a577so1520896fac.3
        for <git@vger.kernel.org>; Sun, 07 May 2023 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683498338; x=1686090338;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu3e/tHcx88FeTLKJ9ICeIElH2pIIL/GOuRIlq+tpxc=;
        b=Zam53+c2VKz8Z+FECwVGMNUs+r9O8VtlB9n3KWO9zXG2ojC7AhZOD3BDCSNGGDn+K2
         bPcdCEII4FpxStVxWUEvpwwG+Af8voT9tDFJnwJj7Jys0eaKTPOoDA40LjwtPQ/GtGD/
         rZusbsRrktIzdqOJyhWlqYAqiw+ksVZ2cet9XAbCC9k2d7WqFha2x81wVOe+9QTrWaw/
         fh3RD35raZ8iyKtBiWxXnLB77MKtqtOyzbAjSIYwq74Gurt475QbJhOsrs9T7lPKYg7n
         wSDEawZEtDu9HjC59GLZOT+iappa/7TL8PaD6iG+6jH3IV2iqQkRVfim6wBO0UiX6hDk
         yxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683498338; x=1686090338;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wu3e/tHcx88FeTLKJ9ICeIElH2pIIL/GOuRIlq+tpxc=;
        b=hOz9dLcUi2uh4jVss5YMvHbY9iwjGJhU7SE/7viyp5GLyzBEeliwWV+njzqotJD7KC
         c4kyWp/Hi3TYQ1VnYdXOuIvJ+mx1bKH8MNLikg1yV7O8D0MZdn/l7YA0P52DP96Iak+v
         JXRSxGJpdMvu/ZXCyYUINr2IRQ+rY5cRBM6KctJ4MppbjLGOiQXYj+hA1OqzysnIqP4C
         5sknXCsywMsH7icTNxIKdz3HR3jO4nKY5Xo+T7LaFiCiaW9ScgfFYHaN5heGtg/6Euc4
         rNLWP3gp3EUdDUdb1rUQ8l2mXEN7cwItK1WuWGzZCx7tNfsDQUh1JQD3lUIX86ugv08M
         jkqg==
X-Gm-Message-State: AC+VfDxyHEuxoqOFF90jKUum3ybN0KAzv9iygRMXqyQ7I8pjV+rF0F+7
        CYOjweM1kO09/o6MYTLhCYGYOi2tLUw=
X-Google-Smtp-Source: ACHHUZ5AQn9dlOXRgItOcVVSp2/tOsoKNHGU0e1WBcXbHdoLlagDPuHxJiAk7Hf1uSsaURCxAVnb4w==
X-Received: by 2002:a05:6870:e14f:b0:184:222:6652 with SMTP id z15-20020a056870e14f00b0018402226652mr2906075oaa.39.1683498338569;
        Sun, 07 May 2023 15:25:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bt11-20020a0568201a8b00b00549f4d87eecsm3438886oob.30.2023.05.07.15.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:25:38 -0700 (PDT)
Date:   Sun, 07 May 2023 16:25:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>
Message-ID: <645825614027d_4e612949f@chronos.notmuch>
In-Reply-To: <CABPp-BE50neqaQbE2tTq_=fEM9j_8-cxgj7xKcSfAunoWjsigw@mail.gmail.com>
References: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
 <CABPp-BE50neqaQbE2tTq_=fEM9j_8-cxgj7xKcSfAunoWjsigw@mail.gmail.com>
Subject: Re: [PATCH] doc: merge: improve conflict presentation docs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 5, 2023 at 6:58=E2=80=AFAM Adam Johnson via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> > -while in "zdiff3" style, it may look like this:
> > +while in the "zdiff3" style, it looks like this:
> =

> The insertion of "the" surprises me.  It reads better without it to
> me, but I don't know if I'm just used to some grammar rule being
> violated or something.  Why is "the" necessary here?

It's not necessary, but the addition of the word "the" suggests a single
well-known term.

If you say "minimalist style", that can refer to a broad range of styles =
that
are generally refered to as of "minimalist" type. On the other hand if yo=
u say
"the Minimalist tyle" it evokes a *single* style that cannot be confused =
with
any other.

In this case it's a single style, so "the" is warranted.

-- =

Felipe Contreras=
