Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C95C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE8207D8
	for <git@archiver.kernel.org>; Tue, 19 May 2020 11:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQsiFUhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgESLjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESLjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 07:39:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0AC08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 04:39:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n15so3187854pfd.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HkHTzt7wmvIJm/gihYSp5v+H9oZP7Zcws6y1/RaTXGI=;
        b=EQsiFUhqiG7WmTb4cZfNDlL0VUHo9yepMQRzUpsdbvU6AyJkAFP/HUyPVWaqVgOd9i
         wszAZCWO52c9VOXnxrOkQ/4c8AZuGN2InPfcPu1uKeqlm1FPtIDnV30t/wQZRjPyDVmJ
         BZtucYsM97s/RK83LglnAeY9Ak7S4HwD0gx0bU8qiNcvutrml/wlXOukx/6jaqT2xuJ8
         ub6bswN9bjvRU61gGaTw50dXJQwRtTZy8e/oWofQkiZmvtyEvaOU4eAVxYFLCsa58KUB
         E0EeS75h6JU7KEstLs0luxaZWpRNLHOlzBWy1KOUUJ7Ap/2SOiuQ2+QKpfWOn0X20Xpz
         eNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HkHTzt7wmvIJm/gihYSp5v+H9oZP7Zcws6y1/RaTXGI=;
        b=DLDXijUNTdSERxIFOJQDHd6i0JNviupP7d6/xHLI927czmF+d3+a7hN8JY2vjmflvY
         6BlZPYhTHDiLyQy97GaFOECyVoUWhLKtgsDMz5W2D2hc0SwCv+9ipRLYKwiDMmaXdXOV
         dqT/wCExklFr9WFLgkLVeTF5n16wiMdlaWWNq+X6Pc29jcGtiSIlR7p4p4CBT0NQZ9im
         5xEvFt/8OJ/VzsGHHRV1HjVK0mSfPxy/WzHdH5zlrObIKssczaAza8Zdheec+Te+y9xX
         omcECwYPFJPV+mCaiJYnx3Nh2TZAOMUUcY1Pvjqur8BqSdACVVIfzeEu1dbWWC+L3ihL
         hbRg==
X-Gm-Message-State: AOAM531QlR/GnbQtsWKSzWf87UyIz07agNWQJ5uAsYM0asWYGNS/sn2x
        IBJZOgL5DbJRILqOG1jUxU4=
X-Google-Smtp-Source: ABdhPJxkC/3VchtXKyzGCengqk19xYrSw/KQGcCG+H4v4Z1ui9iQS2choOwBSUZuwaPmeLi6nMT2eQ==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr22360305pff.1.1589888363226;
        Tue, 19 May 2020 04:39:23 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id m9sm9982756pgd.1.2020.05.19.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:39:22 -0700 (PDT)
Date:   Tue, 19 May 2020 18:39:20 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Darren Tucker <dtucker@dtucker.net>, git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5703: replace "grep -a" usage by perl
Message-ID: <20200519113920.GA2051@danh.dev>
References: <20200518100356.29292-1-dtucker@dtucker.net>
 <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
 <20200518153025.GD1980@danh.dev>
 <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
 <20200519005645.GD1999@danh.dev>
 <CAP8UFD2vYwnwgNWX3tg5w-7kCg3kzNscVbnk0DJfSD4UV-D0hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2vYwnwgNWX3tg5w-7kCg3kzNscVbnk0DJfSD4UV-D0hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-19 09:13:19+0200, Christian Couder <christian.couder@gmail.com> wrote:
> On Tue, May 19, 2020 at 3:00 AM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:

> 
> >     We can also copy-and-paste code from t4019,
> >     to avoid introduce perl to this test.
> 
> This might be a good idea.

Probably we need 2 patches, one to libify the current usage in t4019,
one to replace "grep -a" usage in t5703.

Consider this is floating for a long time, I think we can hold this
for the time being, until after 2.27.0 released.

> >  t/t5703-upload-pack-ref-in-want.sh | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> > index a34460f7d8..92ad5eeec0 100755
> > --- a/t/t5703-upload-pack-ref-in-want.sh
> > +++ b/t/t5703-upload-pack-ref-in-want.sh
> > @@ -49,15 +49,18 @@ test_expect_success 'setup repository' '
> >
> >  test_expect_success 'config controls ref-in-want advertisement' '
> 
> At least you should add the PERL prereq to the test with something like:
> 
> test_expect_success PERL 'config controls ref-in-want advertisement' '

Well, that's is not t/README says:

 - PERL

   Git wasn't compiled with NO_PERL=YesPlease.

   Even without the PERL prerequisite, tests can assume there is a
   usable perl interpreter at $PERL_PATH, though it need not be
   particularly modern.

And, there're a lot of tests using perl without PERL prereq:

	$ git grep -l '[        ]perl ' 't/t????-*.sh' | wc -l
	55
	$ git grep -l PERL 't/t????-*.sh' | wc -l
	35


-- 
Danh
