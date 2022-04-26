Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF523C43217
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 10:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbiDZKZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348868AbiDZKXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 06:23:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C566EB08
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 02:55:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so29680061plk.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvayF3uIyAOIcJiDPI9KuLDI3dsPVSy3OrsP78Lxzik=;
        b=TLUm6i+oTEUdOBguzpmzatbhPDmGpD2X+bR78+oFFeF0mnoYbxIr5bWNL2LqJtniIu
         XueelUdnovN3IZwvxFhh8mhUu+5pF0GPLV8PDj2Umi+QkqQWJtFIdE7dOT8LPrftKl28
         aSAc0paMYCdt178t53JovcB5JKobo9RqQaXrKr2Q5DmM/MJbwhFjjQ5jDIuuKLacM7L2
         s1BHZCtkYr5d+ubF5J9e+f3cxZt23ZWP0CocXI+abhDr88UevSZzJLfAJEZAkJ2auH1/
         bqD2KZYXfkHV3lgoC1jByMAEDT/nsA0kwUchS53gNuQ+VdBsDqQlIIDVLlpYX+T5u1jy
         uVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvayF3uIyAOIcJiDPI9KuLDI3dsPVSy3OrsP78Lxzik=;
        b=mHY//6RqTiedN8gGUTDYDhkqJ7dLh5/RkUTnbXFGujskTn5H49Hqn5F9QozLLTnk/E
         6H/6nq0SQa+7GGom/6VdT0QGWhd695VeruCaxdL8y5moaFdryUcUP/3rm43GwFjiOXQe
         /xYWmgpsFsvUvxjGCVa/srPiu6A6Xwy0lLAhRVNqgGC++Dk3oI4tjxa09jPGGKF8M69E
         R+e1fAr1uNmDg9E3BgPJ7HCJVttLpZEpXFZdxc0qGxzn/VYrERM0nmg4pBSvh4AZlBeA
         +HDDN/qMhuhN4vUdy9pqK/mVv1FJ6Yu588HSR9kL0SzZrxMq+7CfvMPKX/HrAGqSKSH7
         HTOw==
X-Gm-Message-State: AOAM533NK0FkXv499SEE8gXhL6onNJEZSAVdGwkn8q2e3Hc1aoYBCkKG
        sbskL/NCymRKEl40al4xCLLd0f9zNfUuFm/tFjncrwIA8rc=
X-Google-Smtp-Source: ABdhPJzX8paq3kScMzb5eLtLJ2d/i2CYEpL6wstR5b+cYjmHdTNxx33wm2NmrmBDR6/uz7P4sY0Kk8N4Ax1XzBj5AbA=
X-Received: by 2002:a17:903:2309:b0:15d:3251:9aa3 with SMTP id
 d9-20020a170903230900b0015d32519aa3mr3606000plh.165.1650966901407; Tue, 26
 Apr 2022 02:55:01 -0700 (PDT)
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
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com> <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
In-Reply-To: <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Apr 2022 11:54:49 +0200
Message-ID: <CAP8UFD3CppGBFeWjM32AmxNs=SsVcH+tyTC3VJNXb4V-=V9EXQ@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Tapasweni Pathak <tapaswenipathak@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tapasweni,

On Fri, Apr 22, 2022 at 12:29 PM Tapasweni Pathak
<tapaswenipathak@gmail.com> wrote:
> On Fri, Apr 22, 2022 at 2:44 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Wed, Apr 20, 2022 at 1:49 PM Tapasweni Pathak
> > <tapaswenipathak@gmail.com> wrote:

> > > I would like to work on this with a planner, separately, we can see
> > > what should be adapted in mine to have everything go smooth and
> > > GSoC'22 project especially.
> >
> > As you seem interested in other things too, I think it's better to
> > avoid this one for now. It could be a bad experience as it's a really
> > difficult subject, and I think it would be much better for you to
> > start with something easier and smaller.
>
> I must insist; would be interested in a planner and document prep for
> the project, I can see some details
> - https://git.github.io/SoC-2021-Ideas/
> - https://lore.kernel.org/git/pull.989.git.1625155693.gitgitgadget@gmail.com/
> - https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo1Erk/edit
> - https://github.blog/2021-11-15-highlights-from-git-2-34/
> - https://lore.kernel.org/git/CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com/
>
> to set things for the next steps, let me know if you strongly feel to
> not take up the problem right away.

I am not sure what "planner" and "document prep" mean exactly to you,
and what "the problem" is. I replied to your other email and I hope it
helps, but maybe in my replies here and to your other email I am
missing something. In this case please let me know.

We are ok to describe projects in a few sentences or paragraphs, like
in https://git.github.io/SoC-2021-Ideas/ where we describe the
projects we propose, but for GSoC and Outreachy, applicants interested
in a project are those who actually write the proposals which usually
include a timeline.

I am sure not, but it looks to me like you would like us (not you) to
write a full proposal including a timeline.

For example the proposal in
https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo1Erk/edit
which includes a timeline was fully writen by ZheNing Hu, and was then
accepted by us, so that ZheNing Hu could then participate in the GSoC
2021 and start the actual work.

https://lore.kernel.org/git/pull.989.git.1625155693.gitgitgadget@gmail.com/
shows some of the work he did and sent to the mailing list as part of
the GSoC.

https://github.blog/2021-11-15-highlights-from-git-2-34/ is not
especially related to any GSoC.

https://lore.kernel.org/git/CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com/
is a discussion about the Outreachy Winter 2021-2022 round (not GSoC)
where ZheNing Hu accepted to co-mentor with me someone who would work
on continuing Hariom's GSoC 2020 "Unify ref-filter formats with other
\-\-pretty formats" project. As there were no Outreachy applicants
interested in working on this, we proposed this same project to the
upcoming GSoC.

So I don't see any problem that we should take up with the links you
listed. If someone would have it write a full proposal and a detailed
timeline it would be you, not us. Of course, as you propose to work
outside GSoC and Outreachy, we don't require that from you, because
you would not be part of any such official program and wouldn't get
paid.

I hope I don't misunderstand what you said.
