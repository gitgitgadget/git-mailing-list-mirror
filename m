Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCEC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F1620723
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UqWVxt25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1OqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:46:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46074 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:46:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id l22so11470921oii.12
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXuyn0iU7JGDSur00gOae7BO+FEkpAtQbYVqvSVtkZI=;
        b=UqWVxt25QkYHCXtKL+llwtdnFw/N8Nc0qQqyRWJoKp2LNZ4V/KSLPEt0t+85GkcTRK
         X4SW/GOVO1T+OsrZI6s4IUiPUTNK/CDqjqAXIOrmblPisWWVkh0SoIsQPAT9NW02V7l6
         DitXw/mSX7cpDLZgvw5WXgJQFRjLq1DcDnoGqWvgLu2uFwbxt3equFigaCY3jhgt6sQ0
         pVlHFwTGTbHmgxIE832Rgt2BlEmQ4F+Fgwqshshp0350z3+arbJHuZnljYOr01fmjBvK
         eDKdrf9nu99tt9nQdv9P9RYx5CZBKGh3VR3+zTiyPOnKcmQyyuTMq0KR/Hpe7Ui4M8hp
         tGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXuyn0iU7JGDSur00gOae7BO+FEkpAtQbYVqvSVtkZI=;
        b=D3y/xVrOuRmvyxq9eymOmPawhd1ML1doBo5nI/oK6w9KWF9W4pR7lSqN7eaYyXeMBi
         00u9UO/V1pijNrLjco1mLy+pLDNPpwCuz+G0vOmubQaBdub/RW+R7X1XFSVG5UAe26e8
         b5/x3IR5flkB8cFV1SE5PfDNruUkVHRUZ2Zgejcpv2ZlYwLF/+zyujC/w4wRznwQBrff
         30+3YVUrU+0N56wMTnQ9v6l24f/CVNwYJUfOt+x90H81BKiZYBQf4yEOECYPnTWYp0SM
         6Yc4rvj0/wTDgoe3jcXG58E7aD3KSeUSZEzM01ZHsB1gXgT8aHarSbiolV+hk45o0uqM
         6U/w==
X-Gm-Message-State: ANhLgQ0auH5Vdj/8tu/sH2c/wcBIXHmtzOBZNyImcvvhPrgZEZlS30hI
        DlL8wXAWUHSfDbvsRw8KF9aBQK+Jk2zqIM1a3tao0Koi
X-Google-Smtp-Source: ADFU+vtNa/zPPVzq+gFAaQhEp+ToSLvf4St/CPod09FMsoN1l6H5/Tv6wbgSMiOUeCbCP2R3OusZuTkfN8R/eUAZsMc=
X-Received: by 2002:a05:6808:8cb:: with SMTP id k11mr2409021oij.48.1585406779615;
 Sat, 28 Mar 2020 07:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJTX9qSjnPGKEBDB_ma5QqWOwop5s15kskKQ7EU2ne7VFEBnfA@mail.gmail.com>
 <20200328141814.GA1198080@coredump.intra.peff.net>
In-Reply-To: <20200328141814.GA1198080@coredump.intra.peff.net>
From:   Bastian Buchholz <buchholz.bastian@googlemail.com>
Date:   Sat, 28 Mar 2020 15:50:12 +0100
Message-ID: <CAJTX9qQUDr6qywMjN0=2OL7AFdbkwGRB1zpKj_fi2_=LEdVGBg@mail.gmail.com>
Subject: Re: Git 2.26 rebase.backend change issue
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, the issue we have is the same described in the other thread.
I will try using GIT_EDITOR=: instead.

Thanks!


On Sat, Mar 28, 2020 at 3:18 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Mar 28, 2020 at 09:21:08AM +0100, Bastian Buchholz wrote:
>
> > Just wanted to report that I am running into issues with the git 2.26
> > `rebase.backend` change.
> > I am a maintainer on https://github.com/FredrikNoren/ungit which is a
> > UI for git using a http server / browser architecture.
> > We are using `git rebase` in non interactive mode (e.g. not specifying
> > `-i` or `--interactive`) on the server and with git 2.26 this fails
> > because it seems that it now runs in interactive mode by default. It
> > tries to an editor on `git rebase --continue`.
> > Specifying `-c rebase.backend=apply` fixes our issue see
> > https://github.com/FredrikNoren/ungit/issues/1301
>
> I don't think --interactive is relevant here; the features triggered by
> that option (i.e., the ability to tweak the instruction list) are
> different from the notion that rebase would never interact with the user
> at all.
>
> There's more discussion of this change in the thread at:
>
>   https://lore.kernel.org/git/20200310174017.GA549010@coredump.intra.peff.net/
>
> The simplest fix is likely to set GIT_EDITOR=: in your environment when
> you don't want the user to ever be presented with an editor.
>
> -Peff
