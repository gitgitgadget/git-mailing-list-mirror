Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B4C433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164F523A9A
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbhAVR1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbhAVQrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:47:25 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD582C06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 08:46:17 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c12so4562638qtv.5
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FD/zgMQ9CSBySpqowqYkQ1RAmW5DAY8Eyr5nUVpZrFc=;
        b=PY0jm9Q1g+JeLLR5RrR35CsP1FBKeu8trhLcIrfD580pgmmZYcl82KsDiRM4vTd09v
         hdugmjX7+SPMSuP5b+8tvCvhqwjf6am0lYXptucQoO2WAgFtRZuCRAMyzCumYtgsgfc/
         5C6cnY9EiRsz9zrbED7EcoJAkPWjECBZeqP+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD/zgMQ9CSBySpqowqYkQ1RAmW5DAY8Eyr5nUVpZrFc=;
        b=fIp3hIZkn7xJvyemS6ZQOpF59nluZUM6cYmj71bUlZoLpQfWYeZYl45h3Vc4YoCWKW
         sX3szHR/JkHUx6Ha+3S/hXFcyR2HZEu4GSaIgvgBJV0K8WFcltu07BVBQIsgkYuzejpZ
         U6lbP8jy9WONwpvQZNGt97oOzth41es8RtHcsJH4ALN1HatLu2gvT/NYWrAE4mN2crys
         qefQXHNQdWlj7KuJqiB7Qzw3C+Dkh6Ydb4VmTDl3RZfdM79xo1CnupV6E5iOSSBhBnrw
         UsC4VniZ1gneZI2jMELiti3FCACDFKDpLyrvmM6/FKHNb7QELdXnYeAJYhpgtyhfLZkY
         kbyw==
X-Gm-Message-State: AOAM5322F8kaF38AREHtDxcDf+JI9mJaGBfmzzXGb9+hC2UqryrMbO2m
        evcaCmVfZL6EDx7KHHw7T2iFY9snq0rx1C+qcIl+6Q==
X-Google-Smtp-Source: ABdhPJyVJ7r6u5kSRbKxMonJlZ6yXd0D3ZG287WkXcajgZKOTbMSAsZC4iaCdWtq/1YAxzLYlr+z+0o2nx7stLqUdjY=
X-Received: by 2002:ac8:5a48:: with SMTP id o8mr1599436qta.269.1611333975255;
 Fri, 22 Jan 2021 08:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120124514.49737-1-jacob@gitlab.com> <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local> <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
 <YAhYHUcdynbWyhwo@nand.local> <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
 <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com> <YAjs1FjELfSdGhI+@coredump.intra.peff.net>
In-Reply-To: <YAjs1FjELfSdGhI+@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Fri, 22 Jan 2021 17:46:04 +0100
Message-ID: <CADMWQoPf9_49LcLT8RuYvQN45h_a3P0LswTPrKXn36rFBnoyig@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great, thanks!

Best regards,

Jacob Vosmaer
GitLab, Inc.

On Thu, Jan 21, 2021 at 3:54 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 20, 2021 at 10:46:29PM +0100, Jacob Vosmaer wrote:
>
> > On Wed, Jan 20, 2021 at 8:45 PM Jeff King <peff@peff.net> wrote:
> >
> > > I also rage-replaced peel_ref() with a function taking an oid so we
> > > never have to do that digging again. Posted separately in its own
> > > thread.
> >
> > That sounds like a good solution. Where does that leave my patch? Do I
> > need to wait for that new commit somehow? I don't know how that works,
> > "contributing to Git" wise.
>
> Nope, you shouldn't need to do anything. The conflict is minimal
> enough that the two can proceed independently, and the maintainer can
> resolve it.
>
> -Peff
