Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED536C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CB422403
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 22:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKCW2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 17:28:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44728 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCW2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 17:28:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id w1so19107929edv.11
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 14:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/oGimBfplFQAVv3pG6XlDqm4VIbl32krxfR9KE8bJM=;
        b=eI9FeF5S6IWod09/JejwkwIA2v9fLe9IaQHi8zQ0wCGoo/t1Srmr70eP2oUjyKB8rO
         EXLYA1ztltvH8hZ/OC0EWF8UkdyepsOBLp1NQ0bEJnH/ZPxDG0IfyvkwyJGFDiTKwV8X
         KOpnh0SHJD3fSLz6BxVhHFxlL9KtvX2N12ZotdJA0cAA/h6WMd2mRECRdUjQS+zzHWmk
         IB40vRCjQvhmrle73MUWjdeRQ6bwItkC3wEyWqmYC+nd6Ap1uCNpRMEWXNS00cSF4ubN
         Mnx5hvg0+0kdPQfmmxkOZbBpeTVRiabJMMHccg368aucPOiUyX4W5GE5kjMvBmCga+Hf
         XmNA==
X-Gm-Message-State: AOAM533jQNuJ/fz83Vw66dFc9pFeGrNA83Tb2KWotMoRsEEwiM/+2zVb
        icKjCIpLDUiwXoUp9Kqmzs1GcE5GKhaWRjxJ9tYa8Pq7
X-Google-Smtp-Source: ABdhPJwMRZfab/thpLszvFhXRGhTJibp1+2Kl75r88N1clQjAIUYuEm7l7OnwL/JQr3EZy8Gi3Wlb7qmIaNoD9NmQk0=
X-Received: by 2002:aa7:c716:: with SMTP id i22mr22889854edq.94.1604442486488;
 Tue, 03 Nov 2020 14:28:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
 <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com> <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
In-Reply-To: <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Nov 2020 17:27:55 -0500
Message-ID: <CAPig+cSbNGdRA11cMCugJH1HtY65smfuE9ThARX0EvuQZnA5rA@mail.gmail.com>
Subject: Re: [PATCH 2/3] maintenance: use launchctl on macOS
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 4:22 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/3/2020 1:45 PM, Eric Sunshine wrote:
> > It's not clear whether or not this is saying that git-maintenance will
> > dynamically adapt to work with modern and older 'launchctl'. A glance
> > at the actual code reveals that it knows only about modern
> > 'bootstrap'. Perhaps this could be a bit clearer by saying that it
> > only supports modern versions, and that support for older versions can
> > be added later if needed. (For those of us who are stuck with 10-20
> > year old hardware and OS versions, 2015 isn't that long ago.)
>
> Yes, this is a strange place to be. How far do we go back to support
> as many users as possible? How many users will be simultaneously
> stuck on an old version of macOS _and_ interested in updating to this
> latest version of Git? Is that worth the extra functionality to detect
> the the OS version and change commands?

I don't think this patch series needs to answer these questions
provided that it doesn't close the door to someone adding
older-version support down the road. My review comment was more about
the commit message being clearer about the choice -- supporting only
recent 'launchctl' -- being made by this series. (And perhaps the
documentation could mention that it requires a reasonably modern
'launchctl'.)

> This makes me realize that I should update the documentation to give
> pointers for how to view the schedules for each platform:
>
> - Windows: Open "Task Scheduler"
> - macOS: 'launchctl list | grep org.git-scm.git'
> - Others: 'crontab -l'

Good idea.

I haven't looked at the documentation, but if it doesn't already, I
wonder if it should give examples of how to set these up by hand or
how to customize the ones created by git-maintenance itself. I was
also wondering if git-maintenance could have a mode in which it
generates the template file(s) for you but doesn't actually
activate/install it, instead providing instructions for
activation/installation. That way, people could modify the scheduling
file before actually activating it. However, this may all be outside
the scope of the patch series, and could be done later if desired.
