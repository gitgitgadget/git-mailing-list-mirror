Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA2C74A4B
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 12:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCJMi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 07:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCJMip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 07:38:45 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34ACD66A
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 04:38:44 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id n18so5064567ybm.10
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 04:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678451923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IX6n3R9tmypqwMPDlg11PCUPSwGvgS1BjR4qCrYIiY=;
        b=L4j3vOssPe1CnSQlC2fZdOYOSS6HxAapGeDZ2LOl9sJrApdiai7ZkUWMTaMavkORls
         sBCcU61iaL9n3hYH4SPnxhmoODgitCDuLdd2eZm/BTVpPzF5raeUt2cuL9YjIwEKiAyw
         2Cp/T4rLr7miYKQs8gpEOpsh1HqI8ZJT0gjN2xvkGDAzZF7yYAisAr1zBGCY5s+28XZu
         H24Ds/MtySROKDEblQJNRO5q7X1e7X7P22g64q+r61cdfcoZPPXMi7qcjHg+uoQ+NfLd
         7SwRmpTUDZH3Se/AoUNxri5BL3y/sioLq0Z7b0hPw7gLr4Koqt4604EFN6eh+enNcmEq
         qO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678451923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IX6n3R9tmypqwMPDlg11PCUPSwGvgS1BjR4qCrYIiY=;
        b=tDZugC6+jSkqTxZwnEMKaP2FcOjcDucXKbfQHYHqDr6g73bLzYF1gPJ42W9foa7hg5
         U/L4lg1qp8Fk/vBL+iz6uBFdxIwcXWhpsujVlVoaS28BYSgzcb79TYmZG65ZseycdKCw
         QT3RC2fDTluveqj6MtdQYCtugdy4tIXIqB82o6gChxG6sDraYJtMKSUMXVeftiAIO6Of
         YrZiaU8TQAkLkJn7I24nozKHvYIc+TZ3K1/S6rRE4peKj9ot7zxBXnNyraWAjWtPZ3ed
         VaXBvD8u2aouCvIRaHIPyts9DUMDYCDwLtLZxq861H+YvE5bLpGqhEBL4IgpvLbKyW04
         E5Kg==
X-Gm-Message-State: AO0yUKVoHypHc6PmkycHJlsALzQda3ctiCdkE+oPvvQoeTfHuRFZtwvf
        Hx9z5SXG4+Vn8/GkKXOod2YHLjd5LbqXNLbgxIV9iUpLIAY=
X-Google-Smtp-Source: AK7set+S3Ua8PAyB1CxKQTcJibY2phrVZejAOl8h815Kh7NHa1+jKkFagrB09BfS7bhTcrZNjPENWJoQ8JVY4jcsAug=
X-Received: by 2002:a25:8d89:0:b0:b33:531b:3dd4 with SMTP id
 o9-20020a258d89000000b00b33531b3dd4mr95254ybl.1.1678451923493; Fri, 10 Mar
 2023 04:38:43 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com> <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com>
In-Reply-To: <07423D73-8CD9-498B-89E7-7241AC6490D3@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 10 Mar 2023 13:38:32 +0100
Message-ID: <CAP8UFD2qvvjy47=7Zu=jHOHAziG8=vLXje_MW4QrZ-Jrx_wZNA@mail.gmail.com>
Subject: Re: GSoC 2023
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>, Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Thu, Mar 9, 2023 at 6:19=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> On 9 March 2023 3:47:51 pm IST, Christian Couder <christian.couder@gmail.=
com> wrote:
> >
> >Today is supposed to be the deadline for each project to have at least
> >2 Org Admins for GSoC 2023, but it looks like I am the only one and
> >cannot add a second one because of the bugs.
> >
>
> I suppose you should now see me as an Org admin for the 2023 program.

Yeah, I see you as an Org Admin and Victoria and Hariom as mentors.

> I thought I was already in as an Org Admin but I somehow have missed comp=
leting the process. Sorry about that.

No worries. Thanks for doing it!

> >I have emailed gsoc-support@google.com to get support and will see what =
happens.
> >
> >Let me know if you have ideas about this.
>
> The thing is potential mentors need to login to the GSoC portal and accep=
t org member agreement and program rules. After you (or any Org Admin) shou=
ld be able to add that person to the program. Here's the relevant snippet f=
rom Google's mail:

I see. Thanks for figuring that out! I guess I was too focused on the
Firefox login bug, that I thought there were actually more bugs...

> Victoria and Hariom,
>
> Do kindly log into the portal and complete the process and let us know. O=
nce that's done, we'll add you as mentors to the 2023 GSoC program.

Thanks Victoria and Hariom for completing the process too!
