Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C5C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 10:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444863AbiDVKcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350582AbiDVKcA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 06:32:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2F54BF9
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 03:29:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so13504525lfg.7
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVgvY8K65ZK8QJoisoQ0Vs+3YJPa5rWbX0wBU0LM8RI=;
        b=a6w8E2bwHmAp2CHf7mNfRq5LXkYsno+knOYL3jjGJf5ju7AYZsmt9+Tlc7VONdiXbx
         VQAy/lp/AUE8zhIMNT/lq4BeROL3UooukTUb4MYcCvrNt1h/8Ru17YDcmxG05V6ANWMq
         p1TMTq1aHZUzPJBRjpQQ9mBpQ3sOjEIFBEPQTfoYvf1Z+uTfAZURYD+gGVCYPLX6jGGF
         DW/77DHWDR5HX5uLsNEfeDesyeLLU7hXBResEGulagWdji1xnZiX4qlK2cP4NosPRDWf
         5/WT+TbH13rc7aGkf41LsrdvSVhe60y5MwoVOpdIlH1erQ6adyConlMsryvGsxUap2X2
         j0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVgvY8K65ZK8QJoisoQ0Vs+3YJPa5rWbX0wBU0LM8RI=;
        b=HVoxRwQgz/zqZ8Kn4UCr50wnBWSFBv0MTClweEGRDUtaD525eUrG2dU2ITtXraWvkS
         UehlOHfKJsQ4t8zioarI4rnF0GtKQMy2/PJ2whR3aqzj4KZ0cQ+RQJfK+AUD17dOyHdj
         ASi7ZMMO/SvrRSe5XDZx3BczXayY20uCTXSzjxeXATIVZQIOzE0ak5D4uwctJdcoE0vZ
         QTKVZvKIrLIEVJ/iry22eDFAHK1iHVL7e+0FZsA4pB9+eNvAXT/e6+zdHpDVodr5POcj
         bQCjjg2RiCxf/3lW+8AG0NQOVt5H8MJAAx36tdkDX5wa6R+SFinYx6WL0VpV2GaPi9lp
         K/WQ==
X-Gm-Message-State: AOAM531vmTSEadE9Iv7UnPzvOReBO/gWfgdi3gXLImcRmhBW1sy5E3Yd
        eC2WjvZ8RDoKaEE7ZfoesSpQB4MpOWZ5bMN0NQ==
X-Google-Smtp-Source: ABdhPJx6ijFEvxs9gkTyKD6fAG2+HSNF3zXfciOYwzmyvbzkK/g20EEbNgG9UbBGpsLw/x7/ofbUhkYqDEcLyvoy1eY=
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id
 e12-20020a19674c000000b004483f49e6d5mr2628277lfj.518.1650623345137; Fri, 22
 Apr 2022 03:29:05 -0700 (PDT)
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
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com> <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
In-Reply-To: <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Fri, 22 Apr 2022 15:58:28 +0530
Message-ID: <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, Apr 22, 2022 at 2:44 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 1:49 PM Tapasweni Pathak
> <tapaswenipathak@gmail.com> wrote:
> > On Wed, Apr 20, 2022 at 1:45 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > On Tue, Apr 19, 2022 at 1:54 PM Tapasweni Pathak
> > > <tapaswenipathak@gmail.com> wrote:
>
> > > Maybe you could work on continuing ZheNing Hu's work on the "Use
> > > ref-filter formats in `git cat-file`" GSoC 2021 project, which is a
> > > bit related. This is a very difficult task though, as it requires
> > > dealing with tricky performance issues. And the changes you make might
> > > conflict with those made by someone working on the "Unify ref-filter
> > > formats with other pretty formats" GSoC 2022 project.
> >
> > I would like to work on this with a planner, separately, we can see
> > what should be adapted in mine to have everything go smooth and
> > GSoC'22 project especially.
>
> As you seem interested in other things too, I think it's better to
> avoid this one for now. It could be a bad experience as it's a really
> difficult subject, and I think it would be much better for you to
> start with something easier and smaller.

I must insist; would be interested in a planner and document prep for
the project, I can see some details
- https://git.github.io/SoC-2021-Ideas/
- https://lore.kernel.org/git/pull.989.git.1625155693.gitgitgadget@gmail.com/
- https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo1Erk/edit
- https://github.blog/2021-11-15-highlights-from-git-2-34/
- https://lore.kernel.org/git/CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com/

to set things for the next steps, let me know if you strongly feel to
not take up the problem right away.
>
> > > Now if we don't find a good applicant for this latter project, you
> > > might of course work on it. The selected Proposals and Applicant will
> > > be known on May 20 though. So if that would be your prefered project,
> > > you would have to wait until then and hope that we don't select
> > > anyone.
> >
> > Happy to take it up, if it remains open.
>
> Great! Let's see on May 20 if it's still open and you haven't found
> anything else to work on in the meantime.
>
> > > See: https://lore.kernel.org/git/xmqq35iaz6n3.fsf@gitster.g/
> > >
> > > I think he wants someone to add a `train` command to `git rerere`
> > > based on what "contrib/rerere-train.sh" does.
> > >
> > > As you can see "contrib/rerere-train.sh" is a 102 line long shell
> > > script, so converting it to a new `train` command in
> > > "builtin/rerere.c" seems like a not very difficult and not too big
> > > task (especially if done the same way as the script). Junio will
> > > likely be involved in this, as it looks like he is interested in it.
> >
> > Can I take it up immediately, if Junio is not working on it?
> > ++gitster@pobox.com. Hi Junio. Do you suggest otherwise?
>
> I don't want to speak for him, but I don't think he is working on it.
> In fact, as he suggested it for a GSoC, I think he doesn't plan to
> work on it soon. Also he might not answer often to emails that aren't
> also sent to the mailing list.
>
> So if you want to work on it, I would suggest starting right away. You
> can of course send an email on the mailing list to let people know
> that you want to start working on this and to check if anyone is
> already working on it or has suggestions about it.

++git@vger.kernel.org. :)
>
> > > Another thing that was discussed recently is that the git-scm.org web
> > > site could be converted to not use Heroku anymore. If you prefer
> > > working on this kind of web oriented thing, this could be another
> > > possibility.
> >
> > I have worked a lot on web-based projects, SAAS, IAAS, PAAS, FAAS,
> > would it be better to share a proposal of comparison of those keeping
> > git-scm.org in mind, or is it pre-decided where git-scm.org will make
> > its new home/work?
> >
> > This shouldn't take more than 3 working days with no downtimes.
>
> Nice that you have some experience in this!
>
> I added Taylor in Cc as he is involved in this and might answer your
> questions much better than me. Now if you are interested in it, I
> suggest starting right away and perhaps also sending an email to the
> mailing list asking your questions and asking for advice there.

Hi Taylor. Great if you can let me know what you want to see
happening, and if we can discuss tech specifications, you have already
decided or plan to.
