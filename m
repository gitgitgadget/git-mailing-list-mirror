Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE0C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381D42075F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omrq58DU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgI3VGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:06:31 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A19C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:06:30 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j3so1636945vsm.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0x3phd/t9doVw94Su0zhzrfQBNbFU09m//wykHAnOp0=;
        b=Omrq58DUo1PzK0/mcjjlnKqRxMKM19X0YC7CwieigqCrjcjaQXBVn2PR7w8Y72hHQv
         aE/Ems4RnzJmxkg7IrUfE1rt/+deDx4F+JjzByR7DQF76y2GDZFDbg0pjPF0rzbMAheK
         1lkh+PcD+V7Afq6FEpFM40JCwKSvRDwcXgTg44s8fXiJLg/MExRlVe7P97kJ6eovj2XM
         l6L1K7xarrlS90XkpgpHb/t1NYHqt6t4YruIfYoWRqhUtyqzQbeWD3n3QH6xAWCnjRxu
         wHA7/fxhykx0ApRUqEMLlVFGXeNj35pBmpMYAbawo9aAqcsXGkx9SlhTmPisNpAOrGn1
         MLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0x3phd/t9doVw94Su0zhzrfQBNbFU09m//wykHAnOp0=;
        b=pRbrlC4zI4lwqE07ztc9zVZaF8HXW+V6wAeFzvzmxSzdDA6l1DNfo5X7FyojUgqnJy
         MqndDSo+FOF4C+5lU8RCFffed61cSuSJGnTMbjV+9/y4ligyegd5HJnPD4z9ufNpKim6
         CN0l4zheUVj3mQ8AnZnwV6ulqniElOK3KwniC15tsM6UYq1NE/EvhE+5sG+r32RboNti
         +Vo9otJppBl1h/zso9w/ZWXu1PY0m/fxAvpnai8A0V1aiTJwuhWhwnPdwwHmDSQJwRk7
         CJHh577lRd4hSNA7XmeovU4sXW6I300F9hv7HX3SAon/R8e5nGU3EUbXvapfWH7DN6Uy
         EbDg==
X-Gm-Message-State: AOAM532F00MNM9GHOWaelA4QdANneeI/3sPkAvNyqVCtXNOGB0IYwpl9
        cLQkMHjSvJTPQQFrlvOKwAamWx4Zg3z5IBNLvKU=
X-Google-Smtp-Source: ABdhPJxyBe9h+4gXQr2pbQGUYbn9uQLD0zEPFdyfgE428a0VL4H5Pvczy0DbMGnbfZOOldpZSDg97FxN+7yYB66gFB8=
X-Received: by 2002:a67:77c8:: with SMTP id s191mr2970549vsc.38.1601499990075;
 Wed, 30 Sep 2020 14:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200925210740.1939450-1-jacob.e.keller@intel.com>
 <20200925210740.1939450-2-jacob.e.keller@intel.com> <nycvar.QRO.7.76.6.2009301428580.50@tvgsbejvaqbjf.bet>
 <CA+P7+xpDoqspwEG_PABvP33FL-+mo6zXvWxf5FKOiSrydXjBKQ@mail.gmail.com> <xmqqv9fvf018.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9fvf018.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 30 Sep 2020 14:06:18 -0700
Message-ID: <CA+P7+xpGnw6Ht3yVM51HzMFg_xQp5QfJWB6hoOyAD3h=UUiWvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 2:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > Ack.... I swore I fixed this... I'm not sure what happened on my end here.
>
> I do recall adding a SQUASH??? commit on top when I queued the last
> round, but I didn't do so for this round (and the patches changed
> sufficiently enough that the old squash commit no longer applies).
>

Let me send a v4 with this change built in. I remember making it, but
I suspect in the other refactors I accidentally resurrected the
version without it :(
