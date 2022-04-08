Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6AFC433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 19:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiDHT1q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 8 Apr 2022 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbiDHT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 15:27:41 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2821B2FF
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 12:25:37 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id y16so7142239ilc.7
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 12:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p93pTPqA5cpRJvYCUCxsPxTqRXzGFfPfy23XYr+L00M=;
        b=mhi4av+GiEF8TMAmdZP0gO6JOJOLWBprFzlu8WeM6F3lWfmv7muhwO7tB5B+8UPNgV
         GLOwR81OnNlBku5Rg4of0cC/5ALA2hiRNHURuOKBR+aSsbKtuGSsAX+jXcMl/7q8kbfm
         V3QOHbCmKtCCTyaLuU1m3XGOuJBVSoHUSldiYnmqpBOxWhCVe5xq/iMA7XiqAacf21BO
         25UY+lV1JoKVJ8BuFLawrD4lu/hxzQ4cBw3mGRfhVSiyA8N1Ghw79KcxbgygMaInMZa0
         w+PDuhhQ9OZ7Ofws6LbcIQJf889nd2qvSJF7vvy8RrJUcw5GJ6hy1HQuWSK9OKXSDn66
         2VAg==
X-Gm-Message-State: AOAM531qL09/8ogcpbMP/lzDIcZPsYsG8vPYJHWkOrNbeGbNBg1tDECN
        BGkB872h0QGvp7gwmPdvssCUAlBffpJcuWtIzb0=
X-Google-Smtp-Source: ABdhPJyrSTbdA5XTQ5qfAj+qzkrQe6kp+NwVl6nIpCUWW+tDZlA26Oc1vVARgjZ/PAX6f36uAkYTvwzb/KSxD1ACKYQ=
X-Received: by 2002:a05:6e02:20cc:b0:2ca:89ad:461c with SMTP id
 12-20020a056e0220cc00b002ca89ad461cmr2007801ilq.152.1649445936333; Fri, 08
 Apr 2022 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com> <220408.86r167bxra.gmgdl@evledraar.gmail.com>
In-Reply-To: <220408.86r167bxra.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 8 Apr 2022 21:25:00 +0200
Message-ID: <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
Subject: Re: Make commit messages optional
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the risk of bikeshedding.

The case in favor of not allowing empty commit messages by default is
that most of the time, empty commit messages are useless.

I've written my fair share of poor commit messages (-,..., wip, foo).
Sometimes I've fixed that retroactively, sometimes not. The advantage
I see with empty commit messages is that it's more ubiquitous to
"write something better" or "whatever". The downside is I can't git
log --grep '^$' to find them.

On Fri, Apr 8, 2022 at 7:47 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
> I think one of the best things about git's design is how in most other
> areas we've really leaned into that design ethos. I.e. you can commit
> whatever train-of-thought garbage you want, but we make it really easy
> to interactively rebase all of that before pushing (or "finalizing") it.

True. But this is power-user territory. AFAIK, very few users rebase
-i and very few tools support interactive rebasing. Those that do
probably have no problem aliasing git commit to adapt to that workflow
on their own, without different defaults.

> E.g. I wouldn't mind if we made pushes start failing (probably guarded
> by appropriate isatty() checks) if the user was pushing content without
> commit messages, unless some option were overridden, or we could start
> sternly warning about that. Ditto for merging a branch into another one
> (especially if we can see it's the default branch).

I could see this being a potentially nice option but also pretty much
.git/hooks/pre-push.sample but with rev-list --grep '^$'  (which
doesn't appear to work)

> it's not
> a problem that some commit somewhere has an empty message, rather it's
> that such a commit gets "propagated". A better place to check for it is
> then at the point of point of propagation.

I agree in spirit, but also feel obliged to point out the immutability
of commit messages in most user workflows. In such workflows, the
propagation in a sense becomes the point of commiting.

My experience is that in most typical GUI workflows, the writing of a
commit message is not a very high point of friction. These
environments typically instead favor larger commits due to friction of
staging/unstaging. In such situations, it's more important to write a
commit message that at least says *something*.
