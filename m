Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A99C7619A
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 02:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDICT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 22:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDICT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 22:19:56 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF91421C
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 19:19:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54ef6ca60ceso32152017b3.3
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681006793; x=1683598793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf2goFMf18Ed46ByHUIcPlDWICSPyqv2McAwou4yySs=;
        b=AHM/gHjOaEAKaLFi6tT/MGL0PENteO6TsVTnnp6ajSAbqv5UOMNGsksgf8kuf2k3SM
         zzd1z4Tgc6zBoMCEB91hG8BeH3oBJXfG2FVqpsQT4YLe0uTNRsQgRAvaEFAmExE8ESRZ
         Y3tDGKun+7UlF9pngu7oS+CGF2IXnT1l5+M3tyUp+ASYBuFGAlhxjVkFJq7WCKwHybFx
         Lt4FEnAgRTrBR+c/e5X41E3/iAbDikjVXxcj4R8hcUHhq2qmm7d7n1mslkpZsGAZg5WQ
         lZFjsscZnOKd4McFZXCNqnPsvHh8dU7Yzl33U0fJ6WDiqeODSdd5daw4m9BMdWI5DpWT
         Az4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681006793; x=1683598793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf2goFMf18Ed46ByHUIcPlDWICSPyqv2McAwou4yySs=;
        b=dRv6xoibMtZaqeBNMwfbU1vHofSElORIlMcRWom7pSCZBhZ//1Qgmcr+yMkurW7z/I
         sILU3QvA2dTshnuiAwP19lWx0WNKi2FvIJaDaLiNt8iKvSzESDJVF/GZSBpQrwfkV4Y7
         TLPolQENfJu7DH9EpnMpvBM7W2TsOeGuaYculR6P5+VQeUipfVGvsfY/s4vvTLx5MMEX
         UQgSY7Knfs6bEClWuZJe/jHhCUpyY8xpTYHp2GZdnJMR9GiAbEJqSYzIykYnuD5inD1g
         aN5gYmISlr6jWp0LRtNUKPlYuHBCJ9Btu/50wrEe0VbyA/haVKf49wC6LO7A/bYRDNYr
         wnQQ==
X-Gm-Message-State: AAQBX9fv5IUhitiQdWdIccKYj4OYGm3BXjWx5V2O3UZsZ2LjpBb4ezke
        F7ljEoV1bTBuDZq3CvkOqWY1Qw==
X-Google-Smtp-Source: AKy350Y68HIbga/s1zzLGp05wIXm6hNJsK+8iZkF/ovIJd+YjeyEJmMBGy3fTyHz/Iqwc2T4W8z0qw==
X-Received: by 2002:a81:8352:0:b0:54d:61e0:c821 with SMTP id t79-20020a818352000000b0054d61e0c821mr5151806ywf.24.1681006793513;
        Sat, 08 Apr 2023 19:19:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 84-20020a811957000000b00545a081849csm2034331ywz.44.2023.04.08.19.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 19:19:53 -0700 (PDT)
Date:   Sat, 8 Apr 2023 22:19:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDIgyKDQ2rJT2YEI@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDIUvK/bF7BFqX5q@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2023 at 09:28:28PM -0400, Taylor Blau wrote:
> > I don't think so. While `git rev-list` traverses objects and performs
> > filtering within a revision, `git cat-file --batch-all-objects` traverses
> > all loose and packed objects. It might be difficult to perfectly
> > extract the filtering from `git rev-list` and apply it to `git cat-file`.
>
> `rev-list`'s `--all` option does exactly the former: it looks at all
> loose and packed objects instead of doing a traditional object walk.

Sorry, this isn't right: --all pretends as if you passed all references
to it over argv, not to just look at the individual loose and packed
objects.

Thanks,
Taylor
