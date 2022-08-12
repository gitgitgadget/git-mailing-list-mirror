Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A5C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHLPmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiHLPkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:40:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BB13F06
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:40:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r5so1091829iod.10
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=YyXcx83rqbr1I2DC8YtLNqZrC/txUWAW0Id5J5N8DF8=;
        b=g/oToUGlaixIB2AsH7a9+xJZVIeAX42d95fKylSMK47GaV6eJ/iwYZ8dNw9f5uITFJ
         BOTJUZSwjkYSW8OodG/Vbw6Gkqv5rk/ggU9c6E5gh7w9lfLcamVyQWxx8zFzegc52WoT
         kOpTVKoSyRq2r2NlqMHcwsqBP2pShR60gjONfE0Bd68FyGqW2LYSr4PZf8CrNDF0jXzE
         00VwFVrvK8q/W5/25Q91sWMAC/cM2AFO+Zkw/OnhrbdGHInGsuG43qT6o+mloRLEjYZF
         gT69xbnAVJFJhOFdC93bJvD9+utxbgIIDe1KBebpgd0IG51cgTCLbFqs5fxcdEk9tONu
         UG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=YyXcx83rqbr1I2DC8YtLNqZrC/txUWAW0Id5J5N8DF8=;
        b=pefZ05IpRkHqW3p96CdMfbfNySVJT6/OfAgCakkxkbVabJhqhrEkFL2DZM/+wFY7oi
         pzzMOuviuASNKwkh4ySqco5xXKQzh81uMZiHGJQL2GKmy2JoOZ7lWCJbgHUOh6GG0mgN
         hNxd938V65irFsVpkxb7OmJc8SyMR0dIeONlcoRHHWj64plb6R7QJoAkzMBw+SJ1gbqf
         K5pFPRmjAu1rKXrd1aPEw2ghGuA2CvZCLg/+ETwjWlWp5tSRl6O3vKmrEjwZuwpIN+eO
         2Go8QskAvllMjv4sCktmyUaTiu6r6aBq6XkEXopHlzOpmVsgHKwEdqVivUFCu9d9kSfy
         m/Mw==
X-Gm-Message-State: ACgBeo2lOkehxBeu5Ge7dDam5b1jgMILwD8R35w6WGyXXLLtMAUpsbn/
        GAlDkJIEAtDDg7pEV6YhKnRZYv52LCn5VsMAttM6uAGWaIaFVg==
X-Google-Smtp-Source: AA6agR795apt+9+RDz8iShuPZiFJ9jUF/tV6rklgU5RCAgf6rhkvtAOxQuZIKUsuYyuLhneV455BKUlzEIYS/0+0bvs=
X-Received: by 2002:a05:6638:4909:b0:343:1214:f541 with SMTP id
 cx9-20020a056638490900b003431214f541mr2169450jab.128.1660318838388; Fri, 12
 Aug 2022 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g> <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
In-Reply-To: <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 12 Aug 2022 23:40:27 +0800
Message-ID: <CAOLTT8RVhfzA7RtZHzU+L8XOGhoYr1AEOw4iD0vHb1b84mhtiw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter sparse:buffer=<spec>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
> Another was that it is incredibly expensive to compute the set of
> reachable objects within an arbitrary sparse-checkout definition,
> since it requires walking trees (bitmaps do not help here). This
> is why (to my knowledge) no Git hosting service currently supports
> this mechanism at scale. At minimum, using the stored OID would
> allow the host to keep track of these pre-defined sets and do some
> precomputing of reachable data using bitmaps to keep clones and
> fetches reasonable at all.
>

How about only allowing some easier filter rules?

e.g. https://github.com/derrickstolee/sparse-checkout-example

User A can use --filter=3D"sparse:buffer=3Dclient" to download client/ dire=
ctory,
User B can use --filter=3D"sparse:buffer=3Dservice/list"  to download only
service/list.

cat >filterspec <<-EOF &&
web
service
EOF
User C can use --filter=3D"sparse:buffer=3D`cat filterspec`" to download
web/ and service/.

cat >filterspec <<-EOF &&
service
!service/list
EOF
But user D cannot use --filter=3D"sparse:buffer=3Dservice/list"  to
download service without service/list.

I guess many users can benefit from this...

> The other side of the issue is that we do not have a good solution
> for resolving how to change this filter in the future, in case the
> user wants to expand their sparse-checkout definition and update
> their partial clone filter.
>

I guess we don't really need to maintain this "partial clone filter", we
can even reuse sparse-checkout rules after we first partial-clone, we maybe
should write the first partial-clone filter rules to .git/info/sparse-check=
out
(only when --sparse is used in git clone?)

> There used to be a significant issue where a 'git checkout'
> would fault in a lot of missing trees because the index needed to
> reference the files outside of the sparse-checkout definition. Now
> that the sparse index exists, this is less of an impediment, but
> it can still cause some pain.
>

Agree.

> At this moment, I think path-scoped filters have a lot of problems
> that need solving before they can be used effectively in the wild.
> I would prefer that we solve those problems before making the
> feature more complicated. That's a tall ask, since these problems
> do not have simple solutions.
>

Could you tell me where the problem is? I can start to deal with them :)

> Thanks,
> -Stolee

Thanks.
ZheNing Hu
