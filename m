Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF4FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A80120732
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbgKDRDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:03:35 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34720 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731607AbgKDRDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:03:35 -0500
Received: by mail-ej1-f65.google.com with SMTP id o9so28689918ejg.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoUCDcsnbEpJ2pH4+naH9GV4w2OYMsssMUs+daxUzO4=;
        b=aQeallli7pIENdFeqkNsCcZqc0XKrvu48v5s86ZthCE8q1WDZCp+NSad0IMPiYfMz3
         EdJsgnKsxok9ZqiCpR63Th3xtiE2F9LsZrpoHx9tf4vz4QeMuV6L3WVsvakqq1fLFNON
         T+x77d9+9tJM9M4Y3kLaB9IOaxpa1ujvXLM9e4pfYRuJLJulv6bVFaOyQUQOflEuCSps
         +YqC0XP7DkqWhXRw7KMXQ0wKgLOl84afx7ipqqnQmQzBUvBNZyyViD2LFa1ZgV2wQrPX
         b/jm9KgCrmPWyWNZmT98moYM2SSYIuQ6QqYUeB9HCHbacmojC+y3sCX1mobwBBL89n7F
         r1NA==
X-Gm-Message-State: AOAM530JXAHLnpLZowE48KG8KbpxMSb8Tm+4eynwoRzVBe5cC2IOFWAZ
        Bx2irtis0mjfD5HKvOq9crndhF73H9DVF9JcH6Y+trLw
X-Google-Smtp-Source: ABdhPJzcuJ4BfQXcdIIf81N13cdyu556EYICZqJFSOeAnGezHfRtnIF5wErwlWqjYJ2SEjqz5wsN5MCTGv1NrEeQS/0=
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr25350340ejb.202.1604509413357;
 Wed, 04 Nov 2020 09:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20201104132428.GA2491189@coredump.intra.peff.net> <20201104132737.GB3030146@coredump.intra.peff.net>
In-Reply-To: <20201104132737.GB3030146@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Nov 2020 12:03:22 -0500
Message-ID: <CAPig+cT8BTTwcORWB1zNWFy8DaohyibWFxojDiU-Na933abRqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] format-patch: tie file-opening logic to output_directory
To:     Jeff King <peff@peff.net>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 8:27 AM Jeff King <peff@peff.net> wrote:
> In format-patch we're either outputting to stdout or to individual files
> in an output directory (which maybe just "./"). Our logic for whether to

s/maybe/may be/

> open a new file for each patch is checked with "!use_stdout", but it is
> equally correct to check for a non-NULL output_directory.
>
> The distinction will matter when we add a new single-stream output in a
> future patch, when only one of the three methods will want individual
> files. Let's swap the logic here in preparation.
>
> Signed-off-by: Jeff King <peff@peff.net>
