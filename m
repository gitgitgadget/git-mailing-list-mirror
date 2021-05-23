Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40992C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D332611ED
	for <git@archiver.kernel.org>; Sun, 23 May 2021 11:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhEWLwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhEWLwL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 07:52:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D0C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:50:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ml1-20020a17090b3601b029015f9b1ebce0so371364pjb.5
        for <git@vger.kernel.org>; Sun, 23 May 2021 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KX1GK6BA1/Otf8e+GPQPQRzfPZnykiL1kOWoIL3Yrw4=;
        b=Y6UWM1q4F/y51iLMsLt0V5yIImFXKb2BzAYHk3TxS9/WnXigXhg4CSMRDlqUFVRgeb
         3nOY7FU5Kz2ASWLmJQ85RvTfAxYjPaYCpSmJjna7uhw5TzsN0dc41+LxHeobHQFfSHai
         +x2xZI1qMunVkCoJMX+wXzYJQLzJG7DHS+qe0KuB3q+p72SeWzFrp4uZhg/+JWH8EMmf
         wFV8Olh4JDvRM3dD/1Qmw8uw0yCThI0kbspu6K6bgerXwvGwOZXevAMCv2TbXMeSsxov
         5/b2gcIN1TPWfmTHXmVGwrIUqdpiRgKX+epf9jgw8agz/naQ+yP5pVQ0Rc0lNFgX/kDK
         v9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KX1GK6BA1/Otf8e+GPQPQRzfPZnykiL1kOWoIL3Yrw4=;
        b=T596HM81BDv8USv7XWNklpwSFxB8yMlyfvcXdhOkiFtYvxlZu6/m4BQfWPVhD3AHW6
         TFkI5ajbFJiNS1q3JaZHQJVkWEv9GwAelwKaM08VQpjF5DSarOtjeb+55eNICSTFTb8M
         ZLk6NK/ihQbId0d9g9xj2J9QLDZSjRc2lyRBoZ6g5nNkrvwkUWB3vq/s9sMOHlpyHXuq
         TtyvkddPYkNWR9HmYYMuyybGt/vLwTuxJOeCxiu/UkFgfpYDBcP7Q6Wtk8D3hlokifg9
         PL+6y1gNDY7cRYMmQQRLiiaL1613k4SPwJZ8mTA4dpW9TUrQc/QBuTL4pSudlqpGBcxr
         UWsQ==
X-Gm-Message-State: AOAM531OGHpJ63zUs3t9bAr7VCMeD1jBjEMViql5FJK83PA/F9DGZdKa
        Iyd21bUwkPfBQGCMZuhz0AA=
X-Google-Smtp-Source: ABdhPJxbR/W73bDEnr+BaNZlIoGuQ8eA3aPetZ8lEaMXHAfNunhb2OAXqoEhIhBSotVKwLxdsTxwXg==
X-Received: by 2002:a17:90b:4751:: with SMTP id ka17mr19268119pjb.189.1621770643364;
        Sun, 23 May 2021 04:50:43 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id s23sm12489318pjg.15.2021.05.23.04.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 May 2021 04:50:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <ee246d04-4ae3-1697-0f63-13012c95ed49@gmail.com>
Date:   Sun, 23 May 2021 17:20:39 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E184F0EC-BC4B-48A1-9CB0-C25A3268C208@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
 <ee246d04-4ae3-1697-0f63-13012c95ed49@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-May-2021, at 01:09, Philippe Blain <levraiphilippeblain@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> Le 2021-05-22 =C3=A0 12:42, Atharva Raykar a =C3=A9crit :
>> Hi all,
>> As is tradition, I have started my weekly GSoC blog :)
>> Here is week 1: https://atharvaraykar.me/gitnotes/week1
>>=20
>=20
> I enjoyed reading your first post. About gettext, note that
> if you do not want to hardcode a specific version of gettext
> in your LDFLAGS/CFLAGS, you could use =
'/usr/local/opt/gettext/{include,lib}',
> or rather, the equivalent for M1 Macs, which I guess would be
> '/opt/homebrew/opt/gettext' ? Can't test as I'm on Intel...

Thanks for pointing this out. This worked as well on my M1 Mac.
As Bagas suggested in this thread, using '/opt/homebrew/{include,lib}'
also works, as homebrew symlinks the actual location to that directory.

I'll update my blog entry.

> On a second note, for your information
> the 'configure' build approach is not as well maintained as
> the Makefile-only approach, so it's good to make it work with the =
plain Makefile.

Noted. I realised the real blooper for me that snowballed into my janky
fix was looking at resources on building Git in all sorts of places
online, while not noticing the fact that there was a pretty clear
INSTALL file in the source all along (:

> Cheers and good luck for your internship,

Thanks!

> Philippe.
>=20

