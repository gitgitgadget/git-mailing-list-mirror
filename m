Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E8C43219
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 09:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiKGJaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiKGJaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 04:30:05 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324E1658A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 01:30:04 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-36ad4cf9132so98491187b3.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DU9MUqnMm26W9+byBokX/hpR/d43Ajafth08oYSJkY4=;
        b=H/+lprosScNCLcJBpEQzC0+uB38dR/yYC+bGa3FijirKMpg8EDq19zdxtFhXpWal9P
         FZOwWzng06INo+45DyyJsNr0ZalsvCs4CRvFUkk7GZRcLKnAK5P549qUD0FcYSkXDzR4
         IsH+YdhTwHp8B3ojbiw/MiQ0oDhOc2lIPomzghZvfMIKwgqMj2USLlyetOP77i3QlrhO
         eNklxtQIdhJr3Iwq7Y6nNOy9wazhneC1Dwkg5ezZOr9bMku0L0sL6Te/1gawaJ03xNtu
         uVXx6B4UOrnYp9qktsbDkIiSQpP3hQCSfsRSI9sHwbaG0CFCy83dUblsoy74YJNSo2mI
         gYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU9MUqnMm26W9+byBokX/hpR/d43Ajafth08oYSJkY4=;
        b=wCRL0tOQfIhV+257PhxpuU7JAMfYZmbOYD26YkE5kykMQ7n6VNkcYG9JWLPcKaAME9
         vE1vWgEyLwX5ZdWfco0OUHu9GSDlozbCKi/qW3jH2qhjNv6SEZx3ZZW5F80C2qa8qYR0
         wNZLU3GaQ+5o0648F8vT6Sfm1fN0UY5rum0DnZdYHh58Rp1iFdtHd3kVxEUof42JBbfJ
         Hi0G3/ce0WUBOGjjW8CNBuoekCeYEKqBGBqaekKAJcdgXgMz6rI9phA7s4WC7VZz6dLy
         0d1V96B0d1lyAR8bP8CV6Xcca6OjaAL7cLA4FSWvMD5APwphKlXr94oZniZjOWA1TxYR
         HMZw==
X-Gm-Message-State: ACrzQf0+AkSUqvNBnxKEUe3ZClvjU5Ou3ENzCE9zPMLCdkUZ1NzBMP9I
        Mp0NmnaOnyu8HtJpQngU+16hb3QdHSxnPTi/xJo=
X-Google-Smtp-Source: AMsMyM70el2RvO/kJxQFTaUDFtIhZ6mavK9D3icDW1wIT1hVdF6iEfPghdCOveZSf8BaStpeKo1JT+g2WfufBqWIul4=
X-Received: by 2002:a0d:f683:0:b0:361:5904:d3d5 with SMTP id
 g125-20020a0df683000000b003615904d3d5mr46706265ywf.157.1667813403286; Mon, 07
 Nov 2022 01:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20221025122856.20204-1-christian.couder@gmail.com> <Y1wzgOTiKdBcBba0@nand.local>
In-Reply-To: <Y1wzgOTiKdBcBba0@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Nov 2022 10:29:51 +0100
Message-ID: <CAP8UFD2jjQxMsN7VzticiFkrOSLVK6f-f4R1fZU1wnEBpuHapQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Implement filtering repacks
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 9:54 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Oct 25, 2022 at 02:28:54PM +0200, Christian Couder wrote:
> > So there are only 2 patches now in this v2 series:
> >
> >   - Patch 1/2 is a preparatory patch.
> >
> >   - Patch 2/2 introduces the `--filter=<filter-spec>` option.
>
> One thing that I wasn't clear on in this or the previous round(s) was
> how we handle setting remote.<name>.promisor and partialclonefilter.

Yeah, I agree that it's an interesting question that I overlooked.

> If there is a single remote, then it's obvious that we should set
> promisor to "true" and partialCloneFilter to whatever value of
> `--filter` the user provided when repacking / GCing.

I would be Ok to setting remote.<name>.promisor to true in this case,
but I am not sure we really need to do it.

Maybe the user is mostly interested in reducing the size of the repo
for now and plans to set up a promisor remote afterwards.

Another perhaps better way to handle this would be to just die() if no
remote.<name>.promisor is set to true. This way we can make sure that
users will not forget to set up at least one promisor remote. This
could also give users the opportunity to think about whether their
configured remotes contain all the objects they are going to remove.

About remote.<name>.partialclonefilter I don't think we need to do
anything. Maybe the user would be Ok with having different filters
when fetching and when cleaning up.

> But what happens if there are multiple remotes? Which get the new
> configuration settings modified?

I agree that if we want this feature to modify settings, then there is
no good and simple solution in this case.

> I wonder what breakage happens if we fail to do that (and why such
> breakage isn't yet noticed by CI).

If we want to avoid breakages as much as possible, then die()ing when
no remote.<name>.promisor is set to true seems to be the best
solution, instead of trying to modify settings.
