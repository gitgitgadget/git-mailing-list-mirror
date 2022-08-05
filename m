Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D2DC19F2D
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 01:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiHEBl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiHEBly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 21:41:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404BFBC03
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 18:41:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s27-20020a0568301e1b00b00636a832c3a1so1050172otr.12
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 18:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0AeIUcyeKynbs3A17CYR+4I8SwxMwaCWlPt4m3+eCQ=;
        b=CuX2wk7VocsDs0xKTQPZpXhUQKCOMgjB8J9piVJ5cCp+kRdfDRBDZ3q1yCFO1hY2+f
         ZUiF84bM/71u+DVENOSKhTQPSlC/nEwUkGrdy8oNR/UF+gDHqgZta73cwbSzuwDkXvr3
         4zI2ifDry3P/I7m8dyx7LnN5NHcw4fRc7JmSfuMEDUIirgOdM+pvLg/VrX1aCnjc7/mt
         6jifZ8aVp8XsMIoNYNdGPOLCUuF3tFnDTbVK8UtfnXHOggwC3g7Mm5yOvLbHRsqdmQG+
         qN4jJqV7JlQ8rSiwexAnb9FP+BemrQaeyN2aGBkJsGDjJ5bsKznNwQCfE1IybL7XyQ2b
         i7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0AeIUcyeKynbs3A17CYR+4I8SwxMwaCWlPt4m3+eCQ=;
        b=xapMLpednVCmoIaM0nYS2L7pbDADKVD1Rtt347VngtnglcuJoMgEvGzRl+Z4/Av65u
         tZjT590BSHyr6rkn5uevVLD1HoclJ3L4bn3nRiiFb6dA56CPFo2gEW0WFL1UyxEcywSr
         uQ+UKpTi6K/lzIKXweK6eFWuRRkyMHBlp6H1rSbHO8LPUo6M5EAs1zq70gbFVoqD3lU3
         9dmOeoDN0qf5d8it6Dk78nQxncuE4f7rKllr4KoNnwfk6/SOs9Droxl3yeXvrwKSO91c
         WP5tL3rBdWTUcNXeaRQng3L/q7ACqTyFxVZqe1crCcokK8f46VbUNjah4+flVBAbW9/P
         c5uw==
X-Gm-Message-State: ACgBeo1cvBI7yzotUSr2XeZwY+Ry5GJk7YfUEUaVS8b6D+hfSC4VJsZw
        ZZa6e/33/AtB/Iqsx1lXfeW6wus00S3IkrtBLQs=
X-Google-Smtp-Source: AA6agR4p0NtMa5DUPkkiiP+IXNGZzHlvc+UA7ANMMuklUQoPlIlfzgc6R77Y4Bj9yBmyWz3zsXfjNr+tMz97vTbhP2s=
X-Received: by 2002:a05:6830:2b1e:b0:61c:b444:f1a8 with SMTP id
 l30-20020a0568302b1e00b0061cb444f1a8mr1715694otv.31.1659663713589; Thu, 04
 Aug 2022 18:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com>
 <20220729101245.6469-6-worldhello.net@gmail.com> <CAJDSCnOFSnhOU06UHF6T9RT31Gq56BhJn5fQ4_ys2ERrN1stSw@mail.gmail.com>
In-Reply-To: <CAJDSCnOFSnhOU06UHF6T9RT31Gq56BhJn5fQ4_ys2ERrN1stSw@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 5 Aug 2022 09:41:42 +0800
Message-ID: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] refs: avoid duplicate running of the
 reference-transaction hook
To:     Michael Heemskerk <mheemskerk@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 2, 2022 at 8:18 PM Michael Heemskerk
<mheemskerk@atlassian.com> wrote:
>
> On Fri, Jul 29, 2022 at 12:20 PM Jiang Xin <worldhello.net@gmail.com> wrote:
> >
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > If there are references to be deleted in a transaction, we should remove
> > each reference from both loose references and the "packed-refs" file.
> > The "reference-transaction" hook will run twice, once for the primary
> > ref-store (loose references), and another for the second ref-store (i.e.
> > packed ref-store).
> >
> > To avoid duplicate running of the "reference-trancaction" hook, we pass
> > a special "hook-flags" parameter to initialize the second ref-store.
> > The "REF_TRANSACTION_RUN_PREPARED_HOOK" bit is preserved for the
> > transaction of the second ref-store because we may still want to call
> > command "reference-trancaction prepared" for some pre-checks, such as
> > terminate unwanted transaction for the "packed-refs" file.
>
> Can you elaborate on the rationale for continuing to invoke the "prepared"
> reference-transaction hook for the "packed-refs" file? Did you have a specific
> type of check in mind?

Use "reference-transaction prepared" hook command, we can implement
write lock for repositories. We can create a lock file (e.g. "site.lock") inside
a repository or in a parent directory to disable write operations for one
repository, a group of repositories or all repositories. The magic is in the
"reference-transaction prepared" hook command. As a transaction may
be triggered twice, one for packed-refs, and one for loose-refs, we should
make sure the "reference-transaction prepared" command must run for
both transactions on different ref-stores.

BTW, I'm on vacation for the next few days and I will pick up this
topic next week.

--
Jiang Xin
