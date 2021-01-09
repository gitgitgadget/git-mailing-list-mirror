Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E8C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41EB23AA7
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 20:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbhAIUQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 15:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAIUQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 15:16:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B76C06179F
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 12:16:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so31298494lfe.12
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thdpGFjFSkTYLdoqnVB8Ba3KTyXGOI9xxW3AoXnlRcA=;
        b=fcmaDhRAwkCvVHGZxU228BOUWhzOYUBX6T5qxJ7gZjanx+E+MYLD4ofwEkgCbgbfMm
         HQS8XUzyt3NjiBMOhQ6NCo8ojdmBpiutbY9pzHggq2amoI21a/B3r/zy/hVswNkQqMjb
         Cz3ZHnXCnp7eY/Dk602KT0SkmYMMarkU8WFbERB6v3vfJ9xH9h67pQy0/zOAjgSNL4sl
         ROh5guK5TbHvg9e7rQBeyHI846w8SsGHpOVhDXltObFZozpJgMQedt5ZIQcfd9TE4g7R
         xNS+UckV55J8lIhyWX8sUZVdoxpImWLJWsssntNi5z1Mnqjfb4Qgq23xcR95mkIz2s3J
         j9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thdpGFjFSkTYLdoqnVB8Ba3KTyXGOI9xxW3AoXnlRcA=;
        b=qo+w3VpwMTJmwBRY6ax3GwjF3rbvl3h2fklgL/GKt/ViG0HQf4m+rfCpHwWAuxUBCY
         lgapTHPbGyA9YJriosUufMKYzDW0bZkSAOrhLIdOo7Gzk21q0xl8FQDpxgchLTmtDY2C
         MD+i5O3QIC5VYsN4T+9pjIJ2E3ibo8kWtYMt+L9GKioNyQ313ozwQFJ3BYJahAOTI2dP
         rajnp51uMGMSFKBReM20M648fU+tXpxAK7NbGBNmE8qmZRHvxIdU0jx3ILDhLwagBnBA
         ajwlBf6Y/ev2FFd5dqxUQmQ2uHS+xJ53dyHK2CbsN4xA3lCf2G+f27+cPd6yY2MVWzO7
         24bA==
X-Gm-Message-State: AOAM533KZZY8qpwP7LhwSUgb/H7VqrGx2lFWaYUthhtk21TwmQQEC5uw
        A0ZPY2i2QdcLGpG6KntY/bAlRIZFKp54fHb4BfS6JA==
X-Google-Smtp-Source: ABdhPJyPSjYSM1Mmu4LLHIvO/4nuoFa7MAoWvRTrzt81MyaNr0ygfiEYZUjpcbo+1AQ55Lg8B3s8zqOWpVaiJBcHQVM=
X-Received: by 2002:a2e:9757:: with SMTP id f23mr4074371ljj.55.1610223369775;
 Sat, 09 Jan 2021 12:16:09 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
 <CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com> <CAH8yC8kdOrramqggwQ0HBLpub8_+7N+kuvfaCHRokamKFjer4Q@mail.gmail.com>
In-Reply-To: <CAH8yC8kdOrramqggwQ0HBLpub8_+7N+kuvfaCHRokamKFjer4Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 9 Jan 2021 17:15:58 -0300
Message-ID: <CAHd-oW48jK7o_L06FR515JvYNB0ZRZ25TR0WktfEpCzgQMGAGw@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     noloader@gmail.com
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 9, 2021 at 4:42 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Sat, Jan 9, 2021 at 7:44 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Sat, Jan 9, 2021 at 12:33 PM Jeffrey Walton <noloader@gmail.com> wrote:
> >
> > > I'm seeing a failed self test with 2.30.0 on Alpine Linux 3.10,
> > > x86_64. Alpine Linux uses Musl and BusyBox, so things may be a bit
> > > sideways because of them.
> >
> > When a test script fails, could you try going into the "t" directory,
> > running the test script with -i -v -x and sending the output?
> >
> > > *** t4129-apply-samemode.sh ***
> >
> > For example you could run the above test script with:
> >
> > $ cd t
> > $ ./t4129-apply-samemode.sh -i -v -x
>
> Thanks Christian and Matheus,
>
> Attached is the redirected output of t4129.

Thanks for sending the output. Yeah, the problem is that the test
doesn't account for the presence of the setgid bit (which is inherited
from a parent dir). Here is the relevant part:

+ diff -u d_mode.expected d_mode.actual
--- d_mode.expected
+++ d_mode.actual
@@ -1 +1 @@
-drwx------
+drwx--S---
error: last command exited with $?=1

A patch fixing this issue was already sent, and it is marked to be
merged to next:
https://lore.kernel.org/git/b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br/
