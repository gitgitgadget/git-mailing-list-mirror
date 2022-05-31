Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1DC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbiEaQZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbiEaQZE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:25:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805395DC9
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:25:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so27704699ejc.6
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WID8AmPWhtM27N9DNnfDiSDsUmirgqUtrYvRJFz9Sk=;
        b=YTZJ3IlnPay9NLE6iyHrsLoxLMsCGFN62RboRWr8CNRP4Bbl/tUtsYiZxbw8qB4bjZ
         uKasw4I6cW1tA0yJkT0U6OREjVL6jB/dFa4cyGaeTirnhyBJCz6zyDVMZf7Pdm/H8wCw
         jBuJ+AA4t6PvgxPtlwqTw74/4aerAzUR/HtApp8savjnVVXSBkWp2a9bqDpncyUSTF6a
         0mvjKBTKYqwgWhFoZ9dGjchwJEx3gK8GyYtbkOv7M9TrT2j5hy1QxzTWS51/Iq2tkSSa
         3NnnPNE2Iupdmku8sLlt1x8Vgf7bi256DNHuu2M7DAY8QY2dUAbnQKTYCCt9EtU8so1u
         /l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WID8AmPWhtM27N9DNnfDiSDsUmirgqUtrYvRJFz9Sk=;
        b=XD4qCTk64gGm3suA3zQQvI6cter1L8mg/Vp58M5E+K5vpTczUJUAhYMwmO++PTOkAB
         kC7KipecumXDCKjLDWzHD6pI8JpfJr3hDpkG9b1vZnS+Xb4rXXtGFZV8ejf0kGTr97EJ
         QUnTqTQFRbwj1AKtmynxkEIKqINxBMMENknfomtXWeMN5LiqgDXueDQb8/7Mdbhrzmkz
         k0L8/kD0Qea34NJHo31tF4iIDoNhSoDAvQX60u9x/vAJ1W93POti8T9Ox0w+xMdXzE38
         ph1b9cIVjSlReVoR7kQr3JMe87+euvurhH48wT2KLFwfMFmarPo8zTabNRH/dUt7wnJZ
         qmlQ==
X-Gm-Message-State: AOAM531MwBUC6/R1RdCn+AjxXoRSiplPMhNlgnEQl8G/U6zzyp6kv9EG
        YovbrX/W5tHoRVYMKoqZk4G3m78EJ+Z0jcqiUQ==
X-Google-Smtp-Source: ABdhPJyBV6+SQ4C7us1YF/CopKrAEky0MKKEgDgrj1SwrUxkqx0IVMS6UJlEpavifVnww343cztWDnCUucr/Inb9c9w=
X-Received: by 2002:a17:907:7e88:b0:6fa:55f:881a with SMTP id
 qb8-20020a1709077e8800b006fa055f881amr53684062ejc.476.1654014300750; Tue, 31
 May 2022 09:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <CALOmtcX4+ON7+J7K9X4rSYfWYnkciJdFE=v=Oeb7rUqwRt8_JA@mail.gmail.com>
 <CA+CkUQ8hf5m0GZEwcyqLgxMw1vavYey_R4P7oq8=OXc7iAj6MA@mail.gmail.com>
 <CALOmtcW=2skmUPXpnano=21i38b7sq2MEWQjH5yF2jLacZ8sQw@mail.gmail.com>
 <CA+CkUQ9ZnBXU8E=XKTk95hwM4qtZ1M_nX3LTCr5q5njPG3Es5Q@mail.gmail.com>
 <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
 <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
 <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
 <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com> <CAP8UFD3CppGBFeWjM32AmxNs=SsVcH+tyTC3VJNXb4V-=V9EXQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3CppGBFeWjM32AmxNs=SsVcH+tyTC3VJNXb4V-=V9EXQ@mail.gmail.com>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Tue, 31 May 2022 21:54:24 +0530
Message-ID: <CALOmtcWX0QZYXSH-_+RMwi804bgsC6aENJE8bmgv7+1NGT4Jng@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Tue, Apr 26, 2022 at 3:25 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Tapasweni,
>
> On Fri, Apr 22, 2022 at 12:29 PM Tapasweni Pathak
> <tapaswenipathak@gmail.com> wrote:
> > On Fri, Apr 22, 2022 at 2:44 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > On Wed, Apr 20, 2022 at 1:49 PM Tapasweni Pathak
> > > <tapaswenipathak@gmail.com> wrote:
>
> > > > I would like to work on this with a planner, separately, we can see
> > > > what should be adapted in mine to have everything go smooth and
> > > > GSoC'22 project especially.
> > >
> > > As you seem interested in other things too, I think it's better to
> > > avoid this one for now. It could be a bad experience as it's a really
> > > difficult subject, and I think it would be much better for you to
> > > start with something easier and smaller.
> >
> > I must insist; would be interested in a planner and document prep for
> > the project, I can see some details
> > - https://git.github.io/SoC-2021-Ideas/
> > - https://lore.kernel.org/git/pull.989.git.1625155693.gitgitgadget@gmail.com/
> > - https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo1Erk/edit
> > - https://github.blog/2021-11-15-highlights-from-git-2-34/
> > - https://lore.kernel.org/git/CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com/
> >
> > to set things for the next steps, let me know if you strongly feel to
> > not take up the problem right away.
>
> I am not sure what "planner" and "document prep" mean exactly to you,
> and what "the problem" is. I replied to your other email and I hope it
> helps, but maybe in my replies here and to your other email I am
> missing something. In this case please let me know.

GSoC Timeline. :)
>
> We are ok to describe projects in a few sentences or paragraphs, like
> in https://git.github.io/SoC-2021-Ideas/ where we describe the
> projects we propose, but for GSoC and Outreachy, applicants interested
> in a project are those who actually write the proposals which usually
> include a timeline.
>
> I am sure not, but it looks to me like you would like us (not you) to
> write a full proposal including a timeline.

No, no. not. at. all.
>
> For example the proposal in
> https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo1Erk/edit
> which includes a timeline was fully writen by ZheNing Hu, and was then
> accepted by us, so that ZheNing Hu could then participate in the GSoC
> 2021 and start the actual work.
>
> https://lore.kernel.org/git/pull.989.git.1625155693.gitgitgadget@gmail.com/
> shows some of the work he did and sent to the mailing list as part of
> the GSoC.
>
> https://github.blog/2021-11-15-highlights-from-git-2-34/ is not
> especially related to any GSoC.
>
> https://lore.kernel.org/git/CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com/
> is a discussion about the Outreachy Winter 2021-2022 round (not GSoC)
> where ZheNing Hu accepted to co-mentor with me someone who would work
> on continuing Hariom's GSoC 2020 "Unify ref-filter formats with other
> \-\-pretty formats" project. As there were no Outreachy applicants
> interested in working on this, we proposed this same project to the
> upcoming GSoC.
>
> So I don't see any problem that we should take up with the links you
> listed. If someone would have it write a full proposal and a detailed
> timeline it would be you, not us. Of course, as you propose to work
> outside GSoC and Outreachy, we don't require that from you, because
> you would not be part of any such official program and wouldn't get
> paid.
>
> I hope I don't misunderstand what you said.

I will update will a timeline in the next few weeks (June).

Thank you for the information.
