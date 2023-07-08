Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E0EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 12:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGHMm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHMm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 08:42:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B71CEC
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 05:42:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso29988015e9.1
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688820176; x=1691412176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGM0cWETgQOn4lhkNaYqZXvoBb9yPVWkiMT7Pyxa1p8=;
        b=Ge+EUR220/xzleGOtk0Qdz7hVYLsh8+oMLQ9STGo4o2ZcbF8ygZbh3RjC/b4+wTpsP
         dLwhLN26u6pT+X1sIJFKwql0adFQuS8EhQKEOa11ifJpByUZimvKn2+WyMbqAaSCv3y0
         /6wCoR3bQs6ipv+cSFi7wFxLk09vxzaBvEkQiqKlt4GSRDc3g/gvj2N3NJA6nbL/0n0t
         rEHnbaXUajDl/lnlI8IlK5y0CpFnMokJB3qHgeptMrH4B/LTtxkGaeu9htdR6zfmsbbB
         qjmCkGa5tClGxb+/JvvQJj8vz/p1FvNQ11DyUh2T8RV+tnxXvwuqb6YLsQAgeY1hCBN4
         2XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688820176; x=1691412176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGM0cWETgQOn4lhkNaYqZXvoBb9yPVWkiMT7Pyxa1p8=;
        b=VDo7raO5Ti90Hpcy6oi2H9/FWxremQNV3uPT+Ssnp17Hiya3G6Hg7ObXpRLSd2QCDt
         gAX70Tm+kTq2nk+NJLz10M8cvoIAwzu+rYhhdj9Xj10QD2juVzf2bnBf7J+nTGRfy1iQ
         rcKk+yTWvzyGM6iTyjHnH4p+4BRAkCF+e7vFqrl/kYsUx317do3qoY0qMARhk/xom5Hp
         dxSTeG1az8lGxt6EouF8hp1spdIr6m3R4fzMNpaoJsd3Rzhg83yCMFHsUqXFs3G00OtL
         UQQTLuJSiq9uuQV/p7oH7t4o3ALKhewUltegG3dyTR5YL8/Z8mNSSgKf9zx5SWJjFHsK
         ttHQ==
X-Gm-Message-State: ABy/qLYX9wV8ZSaNlfQIXShG2gFY6Xc8+ufSKTb8K6vVKp2uUoa+KuYB
        YdbrXm54onTu1/DxYSSztZ8=
X-Google-Smtp-Source: APBJJlEl3u9vfZm8qT3HzGWNk5fMASYeo8Gx9PybikTAudDvFoLiurmOwrQ8tLEzY+COsQCWms5Llw==
X-Received: by 2002:a1c:e915:0:b0:3fb:b5dc:dab1 with SMTP id q21-20020a1ce915000000b003fbb5dcdab1mr5313279wmc.39.1688820175617;
        Sat, 08 Jul 2023 05:42:55 -0700 (PDT)
Received: from archP14s ([193.32.126.227])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003f9bd9e3226sm5114841wmm.7.2023.07.08.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 05:42:55 -0700 (PDT)
Date:   Sat, 8 Jul 2023 13:42:53 +0100
From:   Matthew Hughes <matthewhughes934@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Hughes <mhughes@uw.co.uk>, git@vger.kernel.org
Subject: Re: Expected behaviour for pathspecs matching attributes in
 subdirectories
Message-ID: <20230708124253.6g2sl2diipqfma7g@archP14s>
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
 <xmqq7crddjtq.fsf@gitster.g>
 <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
 <xmqqjzvcbvqd.fsf@gitster.g>
 <CAEzX-aCnp0avSbMdyFQz=3s4-hjdeVwnndR5b7UeZo4oNMnv7A@mail.gmail.com>
 <xmqq1qhjbpoz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qhjbpoz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2023 at 10:23:56AM -0700, Junio C Hamano wrote:

> I think in this case the common prefix optimization in "ls-files.c"
> is broken.  If we disable it like the attached illustration patch,
> we will see that pathspecs that end with "sub" or "sub/" behave the
> same way, which is what I think people would expect.

Thanks, this also revealed a temporary workaround for me, just add a pathspec
that ensures there's no common prefix but also matches nothing:

    $ git ls-files -- ':(attr:labelA)sub/sub/' 'not/a/real/path'
    sub/sub/fileA

I might have a look into that optimization and see what changes might be made,
but given I am unfamiliar with the code-base this might not be the most
productive search.
