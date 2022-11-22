Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ACBC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiKVSma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKVSm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:42:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FA87545
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:42:24 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A25043F46D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669142541;
        bh=ZA74ZgV0XR1Fed94+8O1s/oLA16xNKqhRfXpD00WxDo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=sbqXxy2jcvn/trnS7Qm9WAumuGfSVnTMOkbTjZ0GbMpRedxEnTYak7keITL04eHPx
         oKKNSwrkDud15b27keLFsnJdLnMCuzqT42BMMsMg+BqwNm9uRVIEBHW3UjkGY97i77
         mqqN+n4lq8H0BfDkXe1e3Hhnr2S6FCAdJ/GfJ4NvIdwJeQDYrDiZmv8I64+g+6ANSi
         pq4dcai83RYBWClq6Hj4r4Z48nCsxY7r8SfXAEuRY8Qty6nO5OZfml64qe1v038Sif
         1jVJzyCf58a8QWovKIm5QVjQBMoWkl4I5UESCcsudiGIfW9K3bD6oX/kF/5HobW2bo
         m4o/SSW8tFV5w==
Received: by mail-lj1-f198.google.com with SMTP id p6-20020a2e8046000000b0027703bb5701so4644655ljg.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA74ZgV0XR1Fed94+8O1s/oLA16xNKqhRfXpD00WxDo=;
        b=6z+umNQaoLEBm4VjSwOxT4CHFVBgexPOoE3boXprDGvSyvaaNz8Bwy+7ikeHLz+KCW
         fuClP65/+3RKZEs2a1hYYF1H1a1PjgnJZceokASTSpUWocGLIuZWs28KEP7aqtoSsg2d
         K4HUchtWsDhdiMVimebaiM0tIwfdD6odVbd3qEfEsXCH/ZHMn5KDaYoDgi7DXTnfkTEH
         gFWarthvlq8Ts/fhkI5wiamxB8hyf1FcmGVSGJPQIALw2R5sB2rgLxQoZIHtf7gj/X+a
         iM/ZquL9unrO72Q5pOWDi7MMFOXDYmx0NJ+ZkaSjxz2lAVx9vw2zn/rxJrudB1pBqewZ
         SlKA==
X-Gm-Message-State: ANoB5pkqUQfdPuXRx+NrrClb6FC4WBEk5crxPRLLPJKWiMtxOasFQ262
        R5DoNaxxmPgvnunKtOqmia1EnwdDZmqUmm03L9FzJJf2jUHFHjTMl6GwNSxivMtC46Tb/xOq+2H
        F7UmxN2vxxh6Azvtn2LFBlHdqI3X5R/Y0E5jaf+iWaXU+yw==
X-Received: by 2002:a19:5e01:0:b0:4a2:2b5d:b95d with SMTP id s1-20020a195e01000000b004a22b5db95dmr8037411lfb.589.1669142540832;
        Tue, 22 Nov 2022 10:42:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6w2xVAVmbLQyQrE98kUeYzmfzKohKSiUGVjrCZRWuDt6d9SQ2wqGwFwEEivx1XKdIizWPw574Bt4qs/Ru4eLk=
X-Received: by 2002:a19:5e01:0:b0:4a2:2b5d:b95d with SMTP id
 s1-20020a195e01000000b004a22b5db95dmr8037403lfb.589.1669142540564; Tue, 22
 Nov 2022 10:42:20 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com>
 <CANYNYEF+Gsas5s7u3rb3CQeFPL1MoCTweA4e3L90vCD0rPsNgg@mail.gmail.com> <CAPig+cS-BWJoWgo3UEk0X6fRjsysR0_23ppn9WX02Gy+ugVdOQ@mail.gmail.com>
In-Reply-To: <CAPig+cS-BWJoWgo3UEk0X6fRjsysR0_23ppn9WX02Gy+ugVdOQ@mail.gmail.com>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Tue, 22 Nov 2022 15:42:09 -0300
Message-ID: <CANYNYEEPZjGEogaSqqCO_qnzLqnrd0d0+z-Nv7v7GhKj_M-x-g@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Nov 22, 2022 at 3:14 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Nov 22, 2022 at 1:04 PM Andreas Hasenack <andreas@canonical.com> wrote:
> > On Tue, Nov 22, 2022 at 2:57 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > We would be happy to take a patch if you're interested in submitting
> > > one. Otherwise, I can submit a patch to fix this case. Let me know
> > > your preference.
> >
> > Can that be a simple PR in https://github.com/git/git/pulls?
>
> The project doesn't take pull requests directly, but GitGitGadget[1]
> will convert a pull request into a mailing list patch. It looks like
> https://github.com/git/git/ is one of the repositories with which
> GitGitGadget works, so presumably it should work. You could probably
> come up with a well-written commit message by paraphrasing your bug
> report.
>
> [1]: https://gitgitgadget.github.io/

Ok, let's see how this goes. I opened a PR in
https://github.com/git/git/pull/1385 and if someone could add the
required /allow, I can take the next steps.

Thanks!
