Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0854C761A6
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 00:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDGAYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDGAYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 20:24:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62959D5
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 17:24:48 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5491fa028adso273614257b3.10
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680827088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5plLse/rY8LI9Rn4K4X3bmXZQ7OXfIUIYxmyRDtlzs=;
        b=d9f3iNmLIyNDkShwEQJrCBcgZOV4zE8kKQam01WHFDqSe71O15AhXSJvd5I5vdbg/w
         NvyzzcFgGhRay2mACRrY6WgvvLup0fb3xz/UhsLtG1el2ifVvkwgjsNPtuZaWbuItngC
         ZT/yK0PPcnWPkpDF6Tw6LXsmTp626R9iqLGlRO7ph5Eh0nijFfkAPuPMAY+5dgdsqptq
         u/OI/V6t3DBKXQQnsSzrifXk9AXa8UQOQNHHDI0laxPv8xEwEGZcBKLv28dSrRaXuUbl
         1gAVuwVUH5OXAPVORCaoUVPYM0h7eNBsFdGM5zhJwXqT50pUVj6OJxMMpDc1X6r0UYfm
         A1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680827088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5plLse/rY8LI9Rn4K4X3bmXZQ7OXfIUIYxmyRDtlzs=;
        b=KPj0lf/eMU7UdqgZrLMcTAYTgd9E03Duz2l3cN6kCfOv64V+E7IZ5xcOEjnFsZPgSC
         10wf+MOWNTfknsw4qVUFw6CtIcFbDkGU6lozAjuAe1wf92iWCyylmuDa9Nh+nxc2ojpR
         l0IN1tesMroAEUKzBcxOdHLafg7B9rHdZ8IUoUbhLvw6wMdAiDrJXItD5zk1WVLcXQvI
         6OwJLJQ4lY1FP4ho5qJWom+/8vCHM28Gi4fMHR/F3kuc8WewF0OVU8GoPBUlTm3/aH2E
         FpbnDv6jMniVy9CebmDYKGcghuusMo+bzCwtEOtauguWzIlBap1HVv2H16GRvuJN2UcD
         L9IA==
X-Gm-Message-State: AAQBX9eViP7CvXNDfjORg5pALuKm38sAv8D+99ASrjJ6+sjNqD/K36U7
        AxRJJtE9I6gz0CjW7LxBYkEuxemqhisVqYwDFnc=
X-Google-Smtp-Source: AKy350YNlLgJhWvLGwLzX+zXZcJ0Cw5EVbhYPYyhMx33R1F5xdcQdL0MG83bcxs66zmfrFWjn/Tn/JzhftqPtjhWg5Q=
X-Received: by 2002:a81:c904:0:b0:534:d71f:14e6 with SMTP id
 o4-20020a81c904000000b00534d71f14e6mr56551ywi.9.1680827087957; Thu, 06 Apr
 2023 17:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net> <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
 <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
 <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
 <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
 <87lej7zhpt.fsf@osv.gnss.ru> <xmqq4jpv1pcj.fsf@gitster.g> <877curzb9u.fsf@osv.gnss.ru>
 <CAMP44s2od_=3p8+GF7tSBqQ0KsDaa4qVKXS66BS7L7BJadA_Xw@mail.gmail.com> <87wn2qg7du.fsf@osv.gnss.ru>
In-Reply-To: <87wn2qg7du.fsf@osv.gnss.ru>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Apr 2023 19:24:36 -0500
Message-ID: <CAMP44s32nLHCZmWQ3V5sBL6WZA9qqWXi86c+=Bxt+GQ8fPmFfQ@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 1:39=E2=80=AFAM Sergey Organov <sorganov@gmail.com> =
wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > If the user wants to do it, the tool should help him do it, not
> > pontificate about what is heretic.
> >
> > The user is still going to do it, like with a rebase plugin on
> > Mercurial, or with `git filter-branch` and then merge the result. All
> > the tool is achieving is being annoying by not helping the user.
>
> Yep, and I'm worried by such trends in Git as well. Looks like growing
> influence of software development culture where the user is not
> considered to be intelligent enough to make proper decisions by himself,
> and needs to be thoroughly guided by the tool (designers) all the time.

Which ironically goes against the philosophy of the original author of Git:

> No project is more important than the users of the project. -- Linus Torv=
alds

--=20
Felipe Contreras
