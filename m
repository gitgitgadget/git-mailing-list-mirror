Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3CC3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLHOw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLHOwY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 09:52:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14A9D2F7
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 06:52:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so4718898ejh.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BK5AI4h1RYa+I66eh18O31OVerpS9KC8kJdwaCLN0Bw=;
        b=b+AvmcaQrmz6bD8oJ7VUFdL2hCforpgdK2LOo9QWm0utThJEVssoEo+ByKCYWGWETu
         MLgwhxAYybgUdj5kFxscNQMT4eo6czBamGFqqkQjNifGpnth09yGnFQGybpWFOOn698h
         WjFLMSpARMNkhKrP97FRKQwZf7Jp7VI/Terfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BK5AI4h1RYa+I66eh18O31OVerpS9KC8kJdwaCLN0Bw=;
        b=fyG4RfdLe/MkIDOt31RjzxR3op6W4b1J18HtuUNxpw5SEBiADQRgYNcMsf18xtZkcb
         SWVc3K02TULgHZVZ9re0jfZok0k1csyHtSUqWO4hcCOXjzW/6upSBSGK+WKmENAsM21d
         POTz4OxAHJR9dxp1FptGXACQwg8weqhGJgIjPNHzKj+kpfHDJxjMrLAqfXTW+feliNUV
         TY/w8Mykm9BgVTGEyj0H+gMPT2x9PzZJzEfK69P03hy3DjtV4XAW190+Aj5OaCZf24Qz
         3JTYiheU7nduwcwvRrncLVzYxpPhjVVdhLOgA4/O2oD+8dO0iXUJkn8tahwdxOpOMXlO
         PIqQ==
X-Gm-Message-State: ANoB5pldiKEjcdAGwfgWKWOzMDZyh/LeaMgVQGHOuUgmacOnA1dcFhBQ
        AUGRl9G6Y/NMsA86lrj6g2AFTPTJnRSZ5pNTKEzWWhdJFBIa4kLfjGE=
X-Google-Smtp-Source: AA0mqf7Dy/VZSOuPVFbXJi8gvVa6HxhYbiEtxbwk9E8xYEFoWKn+PQ1fuT8QJPCJI0Elib/IgkIXAqGI6Gd0iGyeEt0=
X-Received: by 2002:a17:907:a801:b0:7c0:e060:e819 with SMTP id
 vo1-20020a170907a80100b007c0e060e819mr16757901ejc.763.1670511139168; Thu, 08
 Dec 2022 06:52:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
 <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
In-Reply-To: <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 8 Dec 2022 15:52:07 +0100
Message-ID: <CAPMMpoii52KrR2MBpPdSEH8-jc7uMPzi4DH5g2bchwd-RPNTJw@mail.gmail.com>
Subject: Re: Auto packing the repository - foreground or background in Windows?
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2022 at 7:03 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> Instead, the modern recommendation for repositories where "git gc --auto"
> would be slow is to run "git maintenance start" which will schedule
> background maintenance jobs with the Windows scheduler. Those processes
> are built to do updates that are non-invasive to concurrent foreground
> processes. It also sets config to avoid "git gc --auto" commands at the
> end of foreground Git processes.
>
> See [1] for more details.
>
> [1] https://git-scm.com/docs/git-maintenance
>

Thanks Stolee, I've known about the existence of this system for a
while, but I can't quite figure out what's recommended for who, when,
given the doc at https://git-scm.com/docs/git-maintenance

Clearly on Windows, one reason to do "git maintenance start" is to
avoid foregrounded "git gc --auto" runs later. That's a clear enough
benefit to say "frequent users of large repos on windows *should* run
'git maintenance start' (or have some setup process or GUI do it for
them) on those large repos".

Is there a corresponding tangible benefit on MacOS and/or Linux, over
simply getting "git gc --auto" do its backgrounded thing when it feels
like it? Or is there an eventual plan to *switch* from the current
"git gc --auto" spawning to a "git maintenance start" execution when
trigger conditions are met? Are there any *dis*advantages to running
"git maintenance start" in general or on any given platform?

For "my users", I have something like Scalar that can start the
maintenance on the repo where it's needed - but it seems like there
will be lots of users out there in the world who clone things like the
linux repo, which looks like it is big enough to warrant these kinds
of concerns, but it doesn't seem obvious that anyone will ever find
"https://git-scm.com/docs/git-maintenance" and decide to run "git
maintenance start" on their own...

As I noted in another email, I propose to replace "Auto packing the
repository for optimum performance" with something like "Auto packing
the repository for optimum performance; to run this kind of
maintenance in the background, see 'git maintenance' at
https://git-scm.com/docs/git-maintenance." - but I imagine I'm missing
a bigger picture / a long-term plan for how these two mechanisms
should interact.

My apologies if I've missed one or many conversations about this on
the list, but maybe a pointer here can also help me add directional
hints at https://git-scm.com/docs/git-maintenance for "outside users"?
