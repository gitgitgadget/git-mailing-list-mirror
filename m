Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF194C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB164E57
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSRJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 12:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhBSRJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 12:09:49 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83DC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:09:09 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id q4so5704707otm.9
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kes0IDIh4fS/CettSO37c9LWJpuYoljBsPxvhLvpgZg=;
        b=sFe/K8ncYK5U3LeR0QpaBBXRnPyBCDTqfOxT2J2U3stI+Fko29TeGsE4WrYp2CgZfb
         0SsfoTAXG1nNSQiCwcyqpdUrFhlm9bfv6UmhwQzE+QuvFipmNDjCoyEXFt1+I233MWPl
         wfeTict6G88e0tw4MiWvfUV2035JtTL0uhEoK9WnkNIHjIqgSyFlsqajt2EoLY6z9JFe
         f8l9T9zM1vJpwboFpuxW7pPjbemNH9ujjE/R9qcl9YXARDLisacalCesHCi4tbDjv2Yy
         sEcrai3KMYX1/h6OA6bJxuWCa9qXCpaMy60C21NC/beJ6mTw3Wbpwcin2zk0DVrk6Y8P
         erwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kes0IDIh4fS/CettSO37c9LWJpuYoljBsPxvhLvpgZg=;
        b=d9POJX7XHvBLcEAp/hYeAwdfu4QQWI/vh2f6SisIcTZEBUX+Tc+hMd6pSM4FhFKMgV
         zszxY3H6SwJwVI2O8j+WIfyouzv/GEHJGDn3fxfogm/tKlysLNNgVHU6tVzz23WHXUAH
         g5yFOkrDXV/xRYUfMskKRAu1wYHFbNBolOlVX01bBIsof0sw3GGbWWLytgAJihNT2zNA
         66YawrJ5eDsjZ+7P6NQSXDdMYaPQI5s7B10ORndblHFONPtsSbzyTAfYCMXxzL34X9rL
         qBWTF7xOLmcS07HKVcO6VYu23lKh2ddyDXX01HgM5SIY+L4i+hBfdqbwqLaCaAkTAUG1
         Ff9w==
X-Gm-Message-State: AOAM531QsY794kuouPaAKm76sHQT+xo7MjohSwfMFrkjTb7MhXB+RLNP
        h/7cVkYbm0uie33aK7Ij1b22MG7PAN9WH8YmLgc=
X-Google-Smtp-Source: ABdhPJz3Kt4tG3fpiPmy1CdQ9kUuRCDaYTFrGgX+hdqetBuZJldKweeFYfnY415ena2qaCCca1asPg1LFYAB2mzVh9M=
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr7716934otb.164.1613754548347;
 Fri, 19 Feb 2021 09:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com> <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
In-Reply-To: <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Feb 2021 01:08:55 +0800
Message-ID: <CAOLTT8RAuS5-PgTj4YdvakFV8uA1mfKa-gxBOxnWPcL5Sv0VHg@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,Hariom verma,
I am very glad that you can serve as a possible mentor for GSOC this year!
I am very interested in this "Use ref-filter formats in `git cat-file`".
Where should I start learning? :)
Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, Feb 19, 2021 at 5:32 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > I have just created an Idea page with 2 project ideas:
> >
> > https://git.github.io/SoC-2021-Ideas/
> >
>
> I just saw the "Use ref-filter formats in `git cat-file`" in the ideas li=
st.
> I would love to co-mentor this one, if possible.
>
> Thank,
> Hariom.
