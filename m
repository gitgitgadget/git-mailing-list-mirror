Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F541ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 05:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiHZFLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 01:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiHZFLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 01:11:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1051A3BD
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 22:11:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f3so299672ilq.5
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kl9SX92270+dkCY+HTOhclE9fXKaT99L2qpQjjWMSyM=;
        b=ZSufhGK67Z01HF34CtByOoBV0df7RYfd8rNAj1IREVofrIqfVjQA0O/knIANaGx5Qt
         4hVGdMI7IE2YaxxchwCTzsRqf9VUwEyjWe0DeZbn3qI+Sum9BP5bMMi5yc8UDKUmYJeW
         6LyPyW87ryVgBnpuueiFSqNlKJcAOxuW0+2lfZLiyHonK4TgW1YCDqqjJOD70Lb4ltAc
         RcOT0hYGB60j4uAa+HQ5y7/jMGfiL5PiKskaPpdip80YzZX5koBXSQP8mjAyY0vkREXy
         VsA7pekb1luKW5dc2QsxJu/UtXAMUHsMqd19ttBCGOkyitdBvWoVcMasHEdqk5bRvvyl
         8nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kl9SX92270+dkCY+HTOhclE9fXKaT99L2qpQjjWMSyM=;
        b=7OcJBfb3nFvrMaPAIzV3TNuVTXsect9nyI0yF/qOHOCiAXRAp+DoSzNKg6ebAGLhPm
         pfOYvtCM6BjoGKiIYHGPkACvSKLqcn/k1sjcjMcoRv4Jdc3LGl4xa+UuNLLNkhGMAmbr
         mfOkErGRJBr0Yp1fNUyTFS0HqjQ8RaXqtX4EFjfcOzJO3jEPRgnlJrXafd0fMdeByxJz
         ZUqDeiUBkzwl7kxDrvy6+wR+olmKYMSA53GKbZF77BqrN4il5tcP6fnqO4dZGoPKGj0A
         Awp1cIliFxkl5YSLdu49GdpMOTCmoyOjCWxE5H0podQfee3gjZRge4jmDi9wPjZJrHqJ
         Pspg==
X-Gm-Message-State: ACgBeo0i8SP8EzhF1YQMiOS8U5gM9Ej+bpJl3Yffe4k4gfwlY9iUx41A
        7adF9PfCdqHrgohb1Q4tqKX6GHYuSGKESLE8Gx9+IuKYeSVFzQ==
X-Google-Smtp-Source: AA6agR5Sq1fejAj1DjsjVb+yXpG5ih8JSedHZN7p+nz/56DL/T1y/ZgFVmfy89djFdmGfnNXBiowlBWVpCU4f03r0B0=
X-Received: by 2002:a05:6e02:2163:b0:2ea:367:f1be with SMTP id
 s3-20020a056e02216300b002ea0367f1bemr3220927ilv.213.1661490670606; Thu, 25
 Aug 2022 22:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g> <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
In-Reply-To: <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 26 Aug 2022 13:10:59 +0800
Message-ID: <CAOLTT8QnHkRkVdcrkYNF40krxVudowymSG20U_tkgZ+A2waZgw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter sparse:buffer=<spec>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C 21:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/8/2022 12:15 PM, Junio C Hamano wrote:
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: ZheNing Hu <adlternative@gmail.com>
> >>
> >> Although we already had a `--filter=3Dsparse:oid=3D<oid>` which
> >> can used to clone a repository with limited objects which meet
> >> filter rules in the file corresponding to the <oid> on the git
> >> server. But it can only read filter rules which have been record
> >> in the git server before.
> >
> > Was the reason why we have "we limit to an object we already have"
> > restriction because we didn't want to blindly use a piece of
> > uncontrolled arbigrary end-user data here?  Just wondering.
>
> One of the ideas here was to limit the opportunity of sending an
> arbitrary set of data over the Git protocol and avoid exactly the
> scenario you mention.
>

I find that sparse-checkout uses a "cone" mode to limit the set of send
data, which can achieve performance improvement. I don't know if we can
use this mode here? With a brief look, it seems that the "cone" mode is
ensuring that the filter rule we add is directory and does not contain some
special rule '!', '?', '*', '[', ']'. But now if we transport the
filter rule to git server,
git server cannot check if the filter rule is a directory, because it invol=
ves
paths in multiple commits. e.g. in 9e6f67, "test" can be a directory, but i=
n
e5e154e, "test" can be a file... I don't know how to solve this problem...

> Another was that it is incredibly expensive to compute the set of
> reachable objects within an arbitrary sparse-checkout definition,
> since it requires walking trees (bitmaps do not help here). This
> is why (to my knowledge) no Git hosting service currently supports
> this mechanism at scale. At minimum, using the stored OID would
> allow the host to keep track of these pre-defined sets and do some
> precomputing of reachable data using bitmaps to keep clones and
> fetches reasonable at all.
>
> The other side of the issue is that we do not have a good solution
> for resolving how to change this filter in the future, in case the
> user wants to expand their sparse-checkout definition and update
> their partial clone filter.
>
> There used to be a significant issue where a 'git checkout'
> would fault in a lot of missing trees because the index needed to
> reference the files outside of the sparse-checkout definition. Now
> that the sparse index exists, this is less of an impediment, but
> it can still cause some pain.
>
> At this moment, I think path-scoped filters have a lot of problems
> that need solving before they can be used effectively in the wild.
> I would prefer that we solve those problems before making the
> feature more complicated. That's a tall ask, since these problems
> do not have simple solutions.
>

I have a good idea that if we can let such path-scoped filters work,
we can apply sparse-checkout with it... Maybe one day, users can
use:

git clone --sparse --filter=3D"sparse:buffer=3Ddir" xxx.git

to have the repo with sparse-checkout results...
Needless to say, this is very tempting.

> Thanks,
> -Stolee

Thanks,
ZheNing Hu
