Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6736C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 16:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMQNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCMQNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 12:13:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEFAAD00
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 09:13:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-53916ab0c6bso251311897b3.7
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678723980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUhfAxG7YML0Y+SD5hg6+Lre3aMlJBfybIXycfoSVSQ=;
        b=ACgUwKQu8Jn8jNmgn3uABrMqvgSiXo26PW+KqrjkDOt8d+kVhPqaZSCHQd3G9+wwyj
         xl6AjC7beZsCmS4Wujp+MBtD7KYTSAljhPM3bOsFZdUUoDU5k6PGfsmg62rCt6i9Sqlu
         ZLDmVPmWLmPWewGA1L0JUkLiMK6+7ISQ/mRwV/EI16QyJMdqO5xbnZxY/AZwPiq9Z/KD
         1bfK6u6bUf+z2O8yjxXmYV+0L1qy2Lik4bugXiy754n/RgpD87he/AsIqRXPEPBWjHgg
         UiKIZ/Guk91BoFI81s8x17hxim/D5F5MDLApDMW1NfOT1yH0g73F1zU7+iuU12jOpIs5
         T4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678723980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUhfAxG7YML0Y+SD5hg6+Lre3aMlJBfybIXycfoSVSQ=;
        b=2KLPuVxBoF0LLsC6XSghBsm4O+y5noCrnbyORHGSq7fva01Ky+yq74Q2Qs/XhkWnRU
         UbGBR83SJoWtNefLyHPkXISt2wLphB06tW/58xFsMBsAX4F2UlgO4TkYipgO7H233WZd
         GMuJEyZXUNlz2sClOBNfUvQ4QMsDqScLhhQIUMmFKgPiBwVVCPKF89V91OywzOHCCK6r
         YPG4O6D2xnLl3uDadGGMbvvdLfVrmU6Hus68hEsiYdFEvqXX8E0LiDT9IIYJM6Tvye09
         KTBanlSFS9r/Y9mCqXOgYvlu1ndZXf7geRfpMH6BWILJ5m0ldJtA4ffrbGD0HSxnhAxT
         b6qQ==
X-Gm-Message-State: AO0yUKWq5PdttHOZ4cSXWN2zMgDqtGf+LVc4dIXWk6GzhEk+7J6NnyGx
        5xusCsYaqq+5WU+jNSz0gczd0VOmjhUNuEeNy9K46yK+
X-Google-Smtp-Source: AK7set/1SxSwH1u9sU1Hhdhxaf/RCfxIm2z0bibTrJBBIFOxXr/1mWcPczj6HLGfADcDgEYH10ncGZHaQHMX9RugHcg=
X-Received: by 2002:a81:b206:0:b0:52f:184a:da09 with SMTP id
 q6-20020a81b206000000b0052f184ada09mr8238436ywh.2.1678723980561; Mon, 13 Mar
 2023 09:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <20230225180325.796624-4-alexhenrie24@gmail.com>
 <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk> <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
 <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk> <CAMMLpeTUbG+b89acan-GXGS4H=J7aQupbK8zdxwNg__U_We2dw@mail.gmail.com>
 <f8dc5bd3-b325-1e11-6e2d-6d202271f9ff@dunelm.org.uk>
In-Reply-To: <f8dc5bd3-b325-1e11-6e2d-6d202271f9ff@dunelm.org.uk>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 13 Mar 2023 10:12:48 -0600
Message-ID: <CAMP44s268c22-_+=Nzw0LBWG-=mt3nUBEOP-4MGoRpB6_w1JYw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2023 at 9:38=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 12/03/2023 20:57, Alex Henrie wrote:

> > More voices would be helpful here. Does anyone else have an opinion on
> > how likely it is that the default rebase-merges mode will change in
> > the future? Or on whether rebase.rebaseMerges should be allowed to
> > affect --rebase-merges in order to facilitate such a change?
>
> Getting other's views would indeed be helpful

My view is that we shouldn't make assumptions about what is going to
happen in the future. Most of the UI design warts of Git come
precisely from the fact that somebody in the past did not think
something in the future would happen, and when it does the excuse to
not do what's sensible in the UI is "it's too late now".

I would vote for whatever is more flexible to whatever happens in the
future, not something that seems to make sense now, but adds yet more
inertia and later on becomes yet another wart in the list of "oh, if
only we had considered that back in 2023".

Cheers.

--=20
Felipe Contreras
