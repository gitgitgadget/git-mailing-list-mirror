Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43120C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F45C20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAheu+i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHBBCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBBCT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 21:02:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61205C06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 18:02:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so31060623wrh.10
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJRoOa9Pd7ZmK/HXNicKWCHOF1r0SIkD97D4g5pA2cE=;
        b=vAheu+i8bV+XY5q4tWOTtA2dg+NC1toWCCVUMM65PkgmCtl7Zx1oulE6+vGQTpIl5i
         9SIy8kdp1BYHAYTA2i/yc0DMSV+9Ksy0BEK5vRgnS3VdnH0v/yx2q3/MrgGohJ4wFX1A
         nfKBsKHfJpWWR8Y7dnSFSuWhcKL52CUly0dJznWsRp66p9TSm/EmFQx825yioY+gMeGK
         MfwtgJQ5LRa34G45EeDAzKjCLegAcCxU5pWHLIQsRL5XrtKuFNMq6ZLIZDOA9iYJchyq
         0UGQdbLcUzbIeeM2hPjk/+zBFc1beMO7cynAHQncPUnYiNQ9UHENDY/P82vBIN5RxEQd
         nXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJRoOa9Pd7ZmK/HXNicKWCHOF1r0SIkD97D4g5pA2cE=;
        b=mlR6kSzSHd7cGGhM++EpZS5AnjDCE2D5fGsS7dvki0oOnM2J7Wh+OzRAjdmnDzg3do
         fkJJmmJoBKOX+tiIN30ZZ06yPkTR1QKz+MMUF/vrCdrsllr1wUWYituHa/SnsykbCvbV
         3BaA6ScuBjL5F3v0Dc+fjax7Hp8IYUbGnbVl5jMTMs8YPendaycqm0BcX/rjMCEf4UCa
         qYnElc1jHVK3gb/1WmWuTm28ktvHjrV9L8utegsJx3yDMlD41J5IAnO0PzzPJkL3Sdn5
         10fYi4t981qFA2ikfa0Xj9f6P4CZ5i4RA/AhaRDIwkX6Q5k3hXpat5behnk8LqLGmBiw
         EAQQ==
X-Gm-Message-State: AOAM533tPW59BOOyPekz0KTwMJvIgxnWilwhGvbKkDyU05bqNnHKlsHh
        6pjv8pJyCsK6UojEDhi1HXLwQl3M37I0S3mg9Yg=
X-Google-Smtp-Source: ABdhPJz51s6GLqNKip0SkPKVYJ1CyIXRLwtG2aqmN7J2EST2cQo39D+SI0gN3fHSSFoLdjnfnSoABOaCwmsfEI1g5Lk=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr8603723wro.233.1596330138192;
 Sat, 01 Aug 2020 18:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200801220611.10453-1-martin.agren@gmail.com> <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com>
In-Reply-To: <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 1 Aug 2020 18:02:07 -0700
Message-ID: <CAPx1GvcD80MfjZLiKBrH8BgsvVToZ90C057gk7b4BUzbLMNu2A@mail.gmail.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, wait, I am indeed missing something -- the script itself is
all in single quotes, so the single quotes on the line in question
are wrong.  Never mind!

Chris
