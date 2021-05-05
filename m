Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3CC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA31613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhEESDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhEESDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:03:33 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574B2C04BE6B
        for <git@vger.kernel.org>; Wed,  5 May 2021 10:46:55 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so662109oon.3
        for <git@vger.kernel.org>; Wed, 05 May 2021 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+Lx5lzvBbX73HFIyR7dLMuYXRIHX1lRmwFRdK3vJa2w=;
        b=msQXwzpjrjGTd/nQXuVuZ840nYK01ubgG/sEEdMStqcDCwSTXsGqMKxjddL/NFp/Y9
         ATacosRSBFfbUMY3N9EeXFsBk/2gvgGNKnmW0o6jy+6kbaE0z8XVy1XcgCEeokvPEZFO
         xtL5k4FJSJiOxXOxkyljIuGlUKVTSm/ggv5MekdI1gy6YnqoVJqeCgK7kCakCaieB5fs
         u6Ntc5v3kBmCYc1goRctaLBiSKzrhLdKk7lXV/VrkncfTUD7SwoAySHDQbnlb3SVew6c
         Mo0IeJogvK9gwMjhKvVoQNhmgGisrywFcW4o7Ic8Lvs13nHieHctjKDNKt1P2/w9tWkI
         8AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+Lx5lzvBbX73HFIyR7dLMuYXRIHX1lRmwFRdK3vJa2w=;
        b=cA44yX7hnBstmQV4QyzQPEN9NsLhRpsUAy8Q2eg2dw+DhdIQTU/3+Q1OcwbazM9agQ
         mx20MRGRhschza7SGevGVtJecP9x5teEWOnRkkVo1kbZgFS5Lj2pY6Bedc7cMLDtCFbb
         5Ub7l9nOj3H3V8E/gVuRY8En2DtA49g+Y267LCIjo3PtVs/qzT2wKul3oyzR5tJq6yJ9
         ycIQ7rbPkKkCFYsPQIfZ5Jlcxa9WtTtv1UwiIjVwcu0iWV4YZKBWSXuWdJOg/eeC6DU0
         U77epBWLvqIh81UXbz/Xc+DaZ+hpHKlr8eK/ISMzAyVf4IiG/nV82xH2pYxBX7VFy8Ue
         LP9w==
X-Gm-Message-State: AOAM533S0VIjTwipuR/QZkJocGDIeDWEWKDVOiyzP9Fsmg7ttBbyKAKh
        7IMmgSj3jEpa70ajs11sbQtiMX+vphx+0w==
X-Google-Smtp-Source: ABdhPJyrS1c8L3dwXr5ThytDLYMl+XWA0wQWenWaCgsTNMuiDF/aJhLjHxgRgjrxJkBKyBT7up0v/A==
X-Received: by 2002:a4a:305:: with SMTP id 5mr25111889ooi.78.1620236814503;
        Wed, 05 May 2021 10:46:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id h2sm5600oop.47.2021.05.05.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:46:53 -0700 (PDT)
Date:   Wed, 05 May 2021 12:46:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <6092da0ccf4e9_1d24520833@natae.notmuch>
In-Reply-To: <877dkdwgfe.fsf@evledraar.gmail.com>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com>
Subject: Re: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> In summary, I think it should be changed to act like this:
>     =

>     |---------------------------+------------------------+-------------=
--------------|
>     | What                      | Now                    | New         =
              |
>     |---------------------------+------------------------+-------------=
--------------|
>     | Switch                    | git switch existing    | git switch e=
xisting       |
>     | Error                     | git switch nonexisting | <no change (=
errors)>      |
>     | Switch with --merge       | git switch -m branch   | git switch -=
-merge branch |
>     | Create                    | git switch -c new      | git switch -=
n new         |
>     | Create from existing      | N/A                    | git switch -=
c new [<old>] |
>     | Move & switch to existing | N/A                    | git switch -=
m new [<old>] |
>     |---------------------------+------------------------+-------------=
--------------|

I'm in favor of this too.

> In its current state I find "git switch" to be unusable. That sounds
> like dramatic hyperbole, but I'm serious.

I concur.

I've tried to use it multiple times, and I always come back to using git
branch / git checkout.

-- =

Felipe Contreras=
