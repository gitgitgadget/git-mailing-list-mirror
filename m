Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA5C7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjCCS3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCCS3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 13:29:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA830285
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 10:28:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s20so4722924lfb.11
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677868129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZLTD5MHaCozcBroa30WBT9RzT6+2x2XPnB28eTjKwo=;
        b=Ojrro2fq54XEfE0SyOq2LvqBDCIqYmalBh0Hx8H7rxDd7h4YeaAJqUd9RWJCb88S9T
         O9gMYbDB+lmhUT8TjIJebfBS7ktXsrc0c20lRr2SvVChnHwD7vw88/rNZDeYU6aUfFWP
         MVjH0QA0YX8tzC43fVTb8aCF3i02Y7LjN46hHtpBlLhZivTuczSbBgRDgONedAZg5opZ
         RSlYljgxyLTINtakwIwopYzIN1DtTUEyUsepmCtETdgTX8fTtoKDPW1Ie87gmfDNbeR+
         AKwEpk+YFn1/USoGCh9VJPzEKjJdIiLD48xGZ4BE6htRq5oBqQFeJKTF7kSq31kOqZ5A
         52kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677868129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZLTD5MHaCozcBroa30WBT9RzT6+2x2XPnB28eTjKwo=;
        b=Xbm6OrI0uH68Qk9LIwqkgWOzlRJOwYAU4TXpkzRB1894AovznIuQpYxJR/qY1fw96U
         HBiDX7+KQZ2GIVh+jzCeafwE1Eok6rLPVe8KY92q5pmRLDYkIuc39D8CE2ID8GPRDbmO
         9n8/BTV0KbfWIp0MSx6my9KjcPzTBCRkUWTMNRmztfgq0YJBQK4k+3bAjlRBDELmYu2A
         +gRcejbbRKknlr1xJZ3bzALn8f3BtMmW6hDujCSUXBIHJEVPRTH/xbcSoLLeeBNiMN2l
         HwOORFsfZstInHSCkzKw00p9gSmz0zPuhrgDHHFbsbhJLbYy3OtVakygpKeMu8Pxhzfp
         R4cw==
X-Gm-Message-State: AO0yUKXXcNgJkETrt126uQ+q56CQOCsK0aKpvPa7WVghP0dZHrGzkb2m
        0lBKH0coqffK4E2/OEK2AFtqqiQVbMk+Dbi0eKQEDpH9b/M=
X-Google-Smtp-Source: AK7set8O/JVs6Xr9k9Jdb2xSPVCItAsG89clsbN5XMA+W/HUDUaNkTY9232May9sNK4cfqYVTMWnsU7Ed3m8qUaXABY=
X-Received: by 2002:ac2:5934:0:b0:4db:3873:fac1 with SMTP id
 v20-20020ac25934000000b004db3873fac1mr913470lfi.9.1677868129461; Fri, 03 Mar
 2023 10:28:49 -0800 (PST)
MIME-Version: 1.0
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
From:   Peter Hadlaw <hadlawp@gmail.com>
Date:   Fri, 3 Mar 2023 12:28:23 -0600
Message-ID: <CABrPy+EhTzMo4OvWNWFr2yc9KSEOzJBSjoBFRQHdnQcc=A_wXA@mail.gmail.com>
Subject: Re: Let us not call it git blame
To:     Dinesh Dharmawardena <dinesh_dh@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

End of Roman Empire vibes...

On Thu, Mar 2, 2023 at 4:03=E2=80=AFPM Dinesh Dharmawardena
<dinesh_dh@outlook.com> wrote:
>
> Hi
>
> I am writing to you to request that the term blame in git blame be replac=
ed with something that does not sound so blameful. I=E2=80=99m an SRE and w=
e actively try promote a blameless culture as such industry tooling should =
also follow suit imo. Progressively phasing this term out with a better ali=
as would be great.
>
> Cheers
> Dinesh
>
> Sent from my iPhone



--=20
Peter
