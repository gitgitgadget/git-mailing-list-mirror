Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A7C433F5
	for <git@archiver.kernel.org>; Sun, 29 May 2022 21:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiE2VPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 17:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2VP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 17:15:29 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F520BDF
        for <git@vger.kernel.org>; Sun, 29 May 2022 14:15:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x137so16199743ybg.5
        for <git@vger.kernel.org>; Sun, 29 May 2022 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=bVvsvzkPB1AyUvXh5B/W6sMXzF0BKa5AgWUoUTy5kkU=;
        b=enBB4RCky1GTTiEwsVyhRRS/kTVlJ0833EOgEBaFKJ3JDtKG0j9ulML5OsZxiwpLc7
         9GMV8/O1pOA8KMH7WTLpcsJt8ZiMhKkgGpUT8PEm9XNXCs9KBM7e2AvyFB99w+UaKYVl
         wIwSmSj7EhTDXKNXEPnHiWiUF+mY24E2lXj67Hol5XO5oxM8Z2eZzCPAEibFtYm1x3d0
         pJKhabxzEaMMTxNhL0KeQqu5U6KTeC8C+0JnLcDXYoiWgI7PxgHD07xl5odOPs9K+qR9
         xLYlQ/QMhYjB8dxfJalY/UKzyFoecxFuL8TRrREJ3j9TJ9Dz7G5HA8HIfG0DfxeRNOM8
         Ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=bVvsvzkPB1AyUvXh5B/W6sMXzF0BKa5AgWUoUTy5kkU=;
        b=ZmbTITbJzEdxKqUwh2+SfrpmI7YgMew1PcS7vRJqJuuqipwFLR7uIRGzqvYKze+5aZ
         ArJbOsTA9G3Da0vRnzpWloHKWYCahaxpoUf0p/SslgtvCY1crsENPQBlMgVSWUD/kGim
         xHtXmfsVXkkC9XnluAu8wi7p+iaI7fjIop8q3r5fb7Yu1/8FVmCViPMub22s5DtP8vVN
         /ckoPotm8WqG8vXKXUM1CIuz2SQMlN+/vEUeN3NwGowoWLnkAufvtRkmT3NltrWL/ten
         2KJxOMPmL2psF2rLTnD+cuoQL83QjxWDbKWZhgam8EkNaecyAiHxBvvX1x/Gj53oO9/+
         2r2g==
X-Gm-Message-State: AOAM531x+2NJxUoTcIKL1mKdDpGRdj5pEE2vBHklIrLomEjeSxPJtjli
        kJl0nd+Zy3v54dpST2RghkmDdPtRu9e4hqYWzKz0RVnt
X-Google-Smtp-Source: ABdhPJxh3bsW9bIWkw+hAwrigdIhmoLdQGuyQzkmKB5NCu2BKPIWRasTL9yw1TjIfiDeBv2UKnvpL+QxDhNJT2Fbnms=
X-Received: by 2002:a25:5503:0:b0:65c:5bcb:bb83 with SMTP id
 j3-20020a255503000000b0065c5bcbbb83mr8980803ybb.405.1653858926964; Sun, 29
 May 2022 14:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
 <xmqqh758yz4u.fsf@gitster.g>
In-Reply-To: <xmqqh758yz4u.fsf@gitster.g>
Sender: rcdailey@gmail.com
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sun, 29 May 2022 16:15:16 -0500
X-Google-Sender-Auth: JSu7hNgZYYmJKOjBPMQV_mE77-M
Message-ID: <CAHd499BX_8fP=BdJW8cuZnwJFoqxrsiLCZ45Ke12MOsaj7M-Dw@mail.gmail.com>
Subject: Re: Excluding paths with wildcard not working with add -p
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 29, 2022 at 1:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> Does this command
>
>     git add -p -- . ':^*.cs'
>
> work as you expect?

yes I can confirm this works.
