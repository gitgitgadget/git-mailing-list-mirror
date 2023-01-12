Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D1C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjALJp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjALJoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:44:25 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED55552C50
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:41:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ss4so36055037ejb.11
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDotL6puxMqBwsDKvTZpEw6dMcv4xKP1ZctGf5bj4WY=;
        b=WpFLEpxlfOV/dBoKVFVotVEPPQeoR0Sp6eAeHO42OK8WFBKb4EHY3yCOIUbQvAzt0w
         l3zFvJbNebpzzIuIYWuf6khQ1uuvgWsknVB7Sn74jF+Mo/4TKeT9xrflr5TKPsTrmbKv
         QSGD2x3jeGeSrZFyIxTWyVfy9GWOV9oRvJIAW8fueG58bjbxbtvfYgaHBOCh7NYtR1eS
         dBd+JYcgFDPnDY6UU5gO8+HSiU6Spu3VLfBkEkBmMZxiC+xdjaNZEVUNTCaz9mfAFRrm
         JcBRlD9gCwBK0kkE4sFNc/oCp2Tt1XWKFiaZ7vvxj6DLk8oWhV+I4ZBwlb67MlMmpv2O
         kHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDotL6puxMqBwsDKvTZpEw6dMcv4xKP1ZctGf5bj4WY=;
        b=pRyh+RjHhxEVxTFdrGKmh/d4+vd0rEmlR2gEJwvEEeBal6E10GpwJZgZ1Jj4TE+IeG
         RvO5gqcBlW907Vrhx+cfFzfOVdRjZFiPVjZg6YrJTeaBCUjOKheZT1jK8iWv7vqaQ/8a
         QriFWbpNmbSKWR08u5mcvsS5Qi5cd1dyGjYjvJuTsa/ONnOTpTHYXRksH6gLqJQTvgqY
         pFPzxWlrTkRJZfV9U/dFVHrlMlhcwfzHl6WTaeEnOXS9j/9VWxJMqw/kWp+KD48WcEk3
         LYZmeTzF0OoCjLfMe0GvEcoPA/6AkvmHcbdLxdc43n6qkmiebv53jhwnACYKxXhd4uhd
         k+Ug==
X-Gm-Message-State: AFqh2kqDIQC4aNF+UgHeKi8bDladln66D2Jk5I5o4kZs2Y9Q+bja0ZHj
        zw3UFbTZU9gZARfcGW1QSopTo0GWSYo=
X-Google-Smtp-Source: AMrXdXsmpX1N738OZZbxvHP89pVxNA1c6MsBeRO6mmtO3qyPx4WWpKk1gHvKFH1pwHbX12jFLzjvSQ==
X-Received: by 2002:a17:907:8d01:b0:858:703e:e4e2 with SMTP id tc1-20020a1709078d0100b00858703ee4e2mr8039625ejc.42.1673516514376;
        Thu, 12 Jan 2023 01:41:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0084d4a60b3d6sm4397654ejf.117.2023.01.12.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:41:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFu5p-0006YI-1F;
        Thu, 12 Jan 2023 10:41:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Filip Lipien <aaa@164.ooo>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Date:   Thu, 12 Jan 2023 10:30:39 +0100
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <CANgJU+V8VpM8sL=wmBnuTRzZzz-0hwzj6gP6tGhf5OhGv=K9Gg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CANgJU+V8VpM8sL=wmBnuTRzZzz-0hwzj6gP6tGhf5OhGv=K9Gg@mail.gmail.com>
Message-ID: <230112.86bkn42iou.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 03 2023, demerphq wrote:

> On Sat, 31 Dec 2022 at 19:52, Filip Lipien <aaa@164.ooo> wrote:
>>
>> There are more than one million questions on Stackoverflow related to th=
e usage of Git.
>> This is not normal.
>>
>> Git is in its current state not a tool that's made for humans.
>
> Any tool sufficiently advanced to be useful to experts will from time
> to time surprise beginners who lack context knowledge. That is normal.
> Designing tools to be unsurprising for beginners usually just ends up
> limiting, frustrating or surprising the experts.
>
>> It's realistic to assume, that millions of working hours were wasted due=
 to his ignorance of developer experience.
>> The financial damage goes into the billions.
>
> Yeah, business has adopted it wholesale because it loses them
> billions. That makes sense. Not.
>
>>
>> I hereby request the removal of Junio C Hamano =E6=BF=B1=E9=87=8E=E7=B4=
=94 as the Git Maintainer.
>
> That is just rude. Having a free meal in a restaurant does not give
> you the right to demand the head-cook steps down because you didn't
> like the way it was laid out on the plate.  Whatever it was you
> intended to achieve with this post, this is not the way to go about
> it.
>
> Normally I would ignore a post like this as trolling, but others have
> engaged, and I wanted to express some support for Junio as I know
> these kind of things can get even the thickest skinned hacker down.
>
> So to Junio: Thank you for your contributions. I give you strength to
> ignore the trolls.  I have stated this previously, but thanks again
> for add --interactive, that is a super useful tool which I use and
> appreciate pretty much every single day.

Yes, thanks Junio!

I agree on the "trolling" front, and just to concede part of that
ill-phrased point: As a long-term user & contributor of git I agree that
there's lots of cases where git's UX is bad.

Some have noted in this thread that it's partially inherent complexity,
that's also true. Any tool supporting a DVCS workflow will probably
always be more complex than a CVCS (although I'd argue that's largely an
illusion, as it just pushes complexity for e.g. conflicts outside of the
system).

But part of it is just that git's UX is crappy in places. Often there's
a good reason (e.g. backwards compatibility), but often there isn't.

Now, is that the fault of Junio or this development community? I don't
think so. I think it would be possible to have a maintainer (e.g. with
some BOFH attitude) that would be unreasonably hostile to user
friendlyness.

But it's really not that, it's just more mundane reasons.

E.g.:

* Much of the interface being organically grown (and some committee
  design would have had its own issues, or never gotten off the
  ground).

  Fixing inconsistencies is possible, but runs into backwards
  compatibility, creating more confusion by change etc.

* Lots of cases where the UX could be improved, even trivially. Some
  places where we could add advise(), or otherwise improve/fix messaging
  come to mind (those almost never impact backwards compatibility). But
  working on all of those requires volunteer time etc.

I'd also like Git's UX improved, and don't want anyone to get the
impression that such changes aren't welcome here.

As someone who's pushed for much of that (from the i18n subsystem, to
various new advise() etc.) my experience is that Junio's been very
receptive to those sort of changes, and helpful in getting them accepted
& released.
