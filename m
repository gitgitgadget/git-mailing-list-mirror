Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D20C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhLGNOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhLGNOR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:14:17 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A1C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:10:47 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id l24so26470365uak.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lcweathers.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14UZhiNg8r0Nv3lYF6mEH8UuQqkCLoTGYIKsU6uQRp0=;
        b=FPRWClHusxQUdwqZuxgcd7L1gaJPzhJdtA1WgdN3r8cKx8LInY3tOx/svnjPA149T/
         XHRJwZupE1XRIXrKGqswMHVdhzWu6252oPrJEomzsGjdXAbv0Q+6vauExnDwqNOlzQZd
         jP2FUAt8dYPUs27wBk2R2eryNILJfM2EyHNY7R9COGlkC997Kn61cRJU76fi4rSvql01
         9R5Dv2RAygkCgRpkT/pIcPx5F82cbdC7mdOqyriD/jAd3Sz05+IklCyZutQ53vNfITAb
         YxGry+0zDNXSQxTLrZeAMvNF3OVJBIgCQtDgkTsVBUOqI4i5jDYIUpoCaR5AsQYK8+9g
         HaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14UZhiNg8r0Nv3lYF6mEH8UuQqkCLoTGYIKsU6uQRp0=;
        b=n153jLjJ7x9phCLXBViXaKDkI88OvqWvOlsu8vc7+c9xpQhNY8yRForwyQwurABGG0
         ZQilNl1BfcO9cxQId8kub980F8d4NXguOzEoH/txP2Co3ES/QZbJTRZ3/mo8G8aBNWeX
         LUDzCSAvYTHBq1GTDOW7vfK4NbQe8nkgieYao4/G9p+6PlneeD7y9ZAhX7IO9SVDaofs
         m9B/rig/jIvZPoxnr6IynIsLBILpn1t7rldmZJKaLa1LuYpIfAovQjnwesV/aR3oWP6q
         XNW+UC3CKxdiWdq0vIpgRsamOz8vFubCCzXU4ze90OSS2g6pNpLpF1RMkKOLd2MsG+bS
         98CQ==
X-Gm-Message-State: AOAM532LQTm1PNz2ETpiAhB55oVOG1DObv+0X/wIEkztiyXTSEPAd/xR
        DWkpDvr54LsUp9CDADNpWhLepFN0dn3YuQBYnNhwdQ5JTN4llM1b
X-Google-Smtp-Source: ABdhPJzbtGtYUDibPb6eIAtzMnfTWUoowzxi6NE26f77fYlmyT6tc5LCvMr5boVzh+yc5fMPUyCEM1ljIJzvs7ERyS8=
X-Received: by 2002:a05:6102:50ac:: with SMTP id bl44mr46220715vsb.56.1638882646190;
 Tue, 07 Dec 2021 05:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
 <CAPig+cQSEUguKRfCBLoDfLvH5orAX-_KZ+pZE=h4u2x3N_yNzQ@mail.gmail.com>
In-Reply-To: <CAPig+cQSEUguKRfCBLoDfLvH5orAX-_KZ+pZE=h4u2x3N_yNzQ@mail.gmail.com>
From:   Leland Weathers <leland@lcweathers.net>
Date:   Tue, 7 Dec 2021 07:10:35 -0600
Message-ID: <CAHeq4YwfbcwfzxjmiWJUYxtCAn9wf9AW5kNJ8+ps8dAYOn7ZAA@mail.gmail.com>
Subject: Re: BUG: git bash / python interaction with absolute paths as
 environment variables in Windows
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric, thanks for the pointer. Got it working as expected now.

On Mon, Dec 6, 2021 at 9:16 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Dec 6, 2021 at 10:01 PM Leland Weathers <leland@lcweathers.net> wrote:
> > Issue: Using Git Bash for Windows (2.34.1-64) and Python 3.9.9, a git
> > path is incorrectly prepended to environment variables in Python code.
> >
> > $ echo $TEST_DIR_BROKEN
> > /foo/bar
> > $ echo $TEST_DIR_WORKING
> > foo/bar
> > $ python foobar.py
> > environ: C:/Users/Leland/AppData/Local/Programs/Git/foo/bar
> > environ: foo/bar
> >
> > Is there anything else I'm missing on why the same Python script would
> > read environment variables differently than what is read from Git Bash
> > itself or why the exact same Python code reads the environment
> > variable correctly when run from a command prompt and not in Git Bash?
> >
> > In both cases I am using the same Python virtual environment. Other
> > environment variables (e.g. non-absolute directory paths) appear to be
> > read correctly. I'm assuming that this is a git issue given the
>
> This is probably not specific to Git, but rather a "feature" of MSYS2,
> which Git for Windows happens to employ for its Bash shell. When
> invoking Windows commands from within MSYS2, command-line arguments
> and environment variables on the Unix side which appear to be paths
> will be converted to Windows paths for the sake of the native Windows
> program (since it won't know anything about the Unix paths coming out
> of the MSYS2 environment).
>
> This behavior is documented at [1]; in particular, see the
> "Environment Variables" section.
>
> [1]: https://www.msys2.org/docs/filesystem-paths/
