Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F638C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 02:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiDUCPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 22:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 22:14:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1691B4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:12:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 21so4673188edv.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQVAsqAznxNu8PCu0eyohV4jWp9RNB39HeNXFqjNeuA=;
        b=GFhyQNrTZutwErdBkSiDPJAgzRS+sjRmC/lVMWOOgo+wkYrwFP6lCoPsKHT5YVIOjU
         9vrzpM55o/MSkFIVdNIm7pjSLZrh2gfJSNM6P0jev1h/EiH0saxX/B1ztO4ogY0JN5+C
         kq8Gxip1HRPG75AS5Fe/AVemilu1dPG+UTl+GbHAeS9lzXaBT+H/7uugWh9yUwY5OgLd
         dPETGLDLCHqzKWW2zcTuFk/VFYbM48Fkgg1/8J+Kku8f5WDrzP9LfyxDjttE61NWqFsH
         zryt2Hm8vulqZCty5/in5xH9Q2IKqekT0b+aGhEtRBJYBu9etSbMBp0hjrGboMRu9NZJ
         aAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQVAsqAznxNu8PCu0eyohV4jWp9RNB39HeNXFqjNeuA=;
        b=DndDblEPcFYmkC4XZnv3jwqytPFFXeKLVtVG56ySo4MCyY6RAhcdMuCw+cXTZdTdrD
         FGGLVBaV0AAzsoQWn+m7aZJaFj+W363/jCTegie+Dn+HNxJB+0+scW+gIgrpGCy2b/tv
         FlF02OjxxoU1tBnwQpHjcVTk89krm6WMwh2HZWxexmzWb0zqXQrUwUlzRlG0a+u/UnhP
         vgyf+7W+Sgh2AHT+VjL9+lg9hhee+0uygZu6zX0NGoQUqZ7fx6LK8dabZDV5VVwef9ah
         AFat35Wp62UMJbaOgJSvl4H+SQaqCKNqo1ZJlyQ2Ky16VORGIEweajfaEiQKCxDWUHEk
         yFLQ==
X-Gm-Message-State: AOAM530ncDqAhT65r7O3Z64/e7pjn9fN16Z+DsSLQYCGMLdPQNnGEa1t
        qbZMACc+AOURz6NkpxmOigy8xc8ljjC2kMEqjDY4DylRFcQ=
X-Google-Smtp-Source: ABdhPJztlNSv8M49CazHxvR8de2RIWittTlAmCCpXz3p3PmFvK8Dc5mjckYgkz+KYTqiS540kKbK+0I/vVeH+/pZZ1A=
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr26988065edd.33.1650507130113; Wed, 20
 Apr 2022 19:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
In-Reply-To: <xmqq4k2otpkb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Apr 2022 19:11:59 -0700
Message-ID: <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
Subject: Re: Corrupt name-rev output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Thomas Hurst <tom@hur.st>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 8:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Thomas Hurst <tom@hur.st> writes:
>
> > I've noticed a series of about 20 commits in the HardenedBSD repository
> > fairly reliably produce garbage names from git name-rev - usually
> > fragments of another commit, sometimes unprintable nonsense.  Sometimes
> > it works just fine...
> >
> > Here's a quick demo showing how to reproduce the problem:
> >
> > % uname -mrs
> > FreeBSD 13.0-RELEASE-p11 amd64
> > % git --version
> > git version 2.35.2
> > % git clone --bare --mirror https://github.com/HardenedBSD/hardenedBSD.git
> > % cd hardenedBSD.git
> > % git rev-list --branches=\* |
> >   git name-rev --stdin --refs=heads/\* |
> >   egrep -v '^[0-9a-f]{40}( \([a-zA-Z0-9_/.^~-]+\))?$'
> > 3eb67b534cab6a78b44b13e4323fd60353003089 (y:    marcel
> > MFC after:      3 days
> > Relnotes:       yes
> > Sponsored by:   ScaleEngine Inc.
> > Differential Revision:  https://reviews.freebsd.org/D3065
> > ~3)
> > 3ac660fc0c6eb0f876972e7e415c89f1ebed1939 (y:    marcel
> > ...
> > Passing these commits into name-rev as arguments finds them under
> > hardened/current/relro~199^2
> >
> > git fsck --full does not reveal or fix anything, and the problem also
> > persists with a build from source from the next branch.
> >
> > I was unable to reproduce on an Ubuntu machine with 2.32.0, so I used
> > that as a starting point for bisection and landed here:
> >
> >   3656f842789d25d75da41c6c029470052a573b54
> >   name-rev: prefer shorter names over following merges
>
> commit 3656f842789d25d75da41c6c029470052a573b54
> Author: Elijah Newren <newren@gmail.com>
>
> Hmph, Elijah, does this ring a bell?

After digging around last night and tonight, this appears to be a poor
interaction with commit 2d53975488 ("name-rev: release unused name
strings", 2020-02-04), which frees shared strings and relies on all
other users of that shared string to update their name, which
apparently seemed to rely on some intricacies of how the algorithm
worked that are no longer valid with my change, resulting in some
use-after-frees (though for some reason valgrind isn't spotting them
for me, which made it harder to track these down).

Reverting 2d53975488 fixes the problem.

Maybe this means we need to have tip_name be a string + a refcount, so
that we can know when we can safely free it?  Adding Rene to the cc
for comments.  Rene: If it helps, there's a slightly simpler
reproduction: clone the repo Thomas mentions, and then instead of his
"rev-list | name-rev | grep" sequence just run:

    git name-rev --refs=heads/\* 3eb67b534cab6a78b44b13e4323fd60353003089
