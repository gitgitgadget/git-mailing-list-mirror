Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33770C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhLKHrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:47:19 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41557 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:47:19 -0500
Received: by mail-pf1-f174.google.com with SMTP id g19so10445734pfb.8
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilAhwFr5l76Wa9nJRvxMNH4efPL0mcrx7rV8asvfeWg=;
        b=mtMmtZfszsP2nlMBc5G02T/mjDW+1DJP3rta+1d5efxl5pTyYWntM10P00tDXJLnix
         daoEOd/6lm/rGLQF1kNsrG6byBvLwAJrZ6GuNxYT/PrF4YGsy602qytTnx4da7hk5M7v
         drWQAVXAH9Cebd8YykesVDiqIff4rAiVDWk/0spSNLOTaWvjfE1tystzcVJs+D61RWG1
         6eOY5MNUa9C6tqNRM2VOuyFronzU2wHD2pN1IXBkJOWcjsHARfYmYADl//Oaw3En8ja0
         NYcEgfQlIiRf6CzGboCTxWQYSqwtxCi4T/aE/qJWTTaJ419XhfyWAirc7jt4m4I775cO
         LtKg==
X-Gm-Message-State: AOAM531fnxO4/8wTipDtpZV+WLNQ6srJqbuOuYVRvQEOl9fP5BksOCHn
        pvkc+JgwS6ZPO0n/nykFZ41IFmMgqeXt9roTpgRPCUb8jMDgAQ==
X-Google-Smtp-Source: ABdhPJwBJM7IYo9Uba1HH6M0jJEUWEYWaa81T5gey93aoEjQIB08+f6/8Wnq+GRhJoeZqWZod8GsbPY/s6qugtso6Nk=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr22617860pfh.67.1639208838559; Fri, 10
 Dec 2021 23:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-14-sunshine@sunshineco.com> <YbMel5UZm9ESM5Jr@coredump.intra.peff.net>
In-Reply-To: <YbMel5UZm9ESM5Jr@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 02:47:07 -0500
Message-ID: <CAPig+cTb9hBu7SPjh-Zeo=5LsbiSa=r43e_yXOpgq_5Ghg0Dcg@mail.gmail.com>
Subject: Re: [PATCH 13/19] tests: apply modern idiom for signaling test failure
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:32 AM Jeff King <peff@peff.net> wrote:
> On Thu, Dec 09, 2021 at 12:11:09AM -0500, Eric Sunshine wrote:
> >       if test -s difference
> >       then
> >               cat difference
> > -             (exit 1)
> > +             false
> >       else
> >               echo happy
> >       fi
>
> ...I'd have said the idiom here is just:
>
>   git diff-tree -r test-rebase test-merge >difference &&
>   test -s difference
>
> The extra "cat" and "happy" are verbose output that we usually skip in
> favor of letting "-x" logging do the talking (and leaving the failed
> state so you can "cat difference" yourself).
>
> That said, I'm OK with this minimal change in the name of keeping creep
> out of the series.

Indeed, there's plenty of odd cruft like this in old test scripts
which could eventually use good cleanups such as the one you suggest
here. But I'm also OK with (indeed prefer) this minimal change for the
present in order to reduce likelihood of reviewer fatigue in this
already lengthy patch series.
