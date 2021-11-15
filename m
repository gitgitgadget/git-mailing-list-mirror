Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FEC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7BC63215
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbhKOWzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353648AbhKOWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:45:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D548C035421
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:57:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so15551691plf.13
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KF+YZsVwjA0eK7RUB2aUP/ku7fxhgjNIY/VRSO44JU=;
        b=l31i+VrIxS0rC0AEDkcIXyV9enYQ/Jl3UQ1PV1JXOb3a89oDNzbPQnroAr7hZVzgwV
         8mEBb/ExvZ3p8f/fN+SuBTXjDAMlSdebmyBH9DCdd5iETzsAAzF5bp3I5pj2lcycEG+0
         Hv6Xn2IwdwvQXrUq91AZ1c+XUFqkoQzzv5JDbe3l55w4sCAL514dC18c2iMZkndiQ+KZ
         KRnF1dgM7uuN2vKRZjS+Up7ujJt6XHNOmgHuyQQPuRQdJ1TTZI+03AALOEYvjn2WZ+K0
         wD22jZZh6M8cVDVtbhBDHt4lbqZfp0IRIjNrTXN0V/NDu60i9H94xy1KNSeyBrnh5QUk
         +tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3KF+YZsVwjA0eK7RUB2aUP/ku7fxhgjNIY/VRSO44JU=;
        b=3Ru2S72GyuhXyb+gyr+QbknEhGvO7EsVmfQruLtIvRUc061Y60IYdpglpsW83/YueJ
         XdPlRT/vleZjSOOt+nmrVFp/iQYG5heGP681UQ2zjRdzekuyUE3HxCp+Yy7fFJ6wCokx
         RCwSCYPB2tqKkAdBHv1+kqB2/T4svUoqx6eQdnKF/iSJ1MQIZCoWSlUY9a9vV6OsNDgE
         F1x6D2TOwjWxIi7S2b8+hVENXymlbTaUmKV7agDxxWYkWHFWIA8zKrZvok9ZosW/ubGW
         wfnu5bBoa8UBzt91eZyBtFN+FroT4RHf5sKSkDa4M9WA8lRjBbgV0jyBux+F3JN56401
         Ut2w==
X-Gm-Message-State: AOAM532tA9Vt9Ba/2T51DbxcNH4F9oHrI2oFf+AJTzYWoMfZudmkYz7Z
        8e4/BA2/nf6n9SfoLtuQk1nPrQ7NoEMOig==
X-Google-Smtp-Source: ABdhPJxaKBOv8qbffVMg2w1RaqQ5Emd2+oxvlK0MaPeqcpl7dAwAZUaSOBUgdnbUbk5i8iU+eWLGDA==
X-Received: by 2002:a17:903:18b:b0:141:eda2:d5fa with SMTP id z11-20020a170903018b00b00141eda2d5famr38965022plg.63.1637013464191;
        Mon, 15 Nov 2021 13:57:44 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:9bb:b2ac:3919:1528])
        by smtp.gmail.com with ESMTPSA id z7sm5005893pfe.77.2021.11.15.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:57:43 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:57:39 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: add "inherit" option for branch.autoSetupMerge
Message-ID: <YZLX08noFD0MhmIf@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
 <xmqqwnnondba.fsf@gitster.g>
 <YWun9j7L5uNlVHkW@google.com>
 <xmqqee8k19or.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqee8k19or.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.10.16 22:50, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Thanks for the feedback. I've added "--track=direct" and
> > "--track=inherit" flags in V3, which I'll send out shortly. I am a bit
> > skeptical of the value of having "--track=direct" when just "--track"
> > still works, but I'll leave it up to the list to decide.
> 
> Ah, I assumed that with the configuration variable set to inherit,
> you'd make a command line --track to use the upstream of the fork
> point branch as the upstream of the new branch, but if your
> intention is that (1) without --track or --no-track on the command
> line, if configuration is set to inherit, the new branch will track
> the upstream of the original, and (2) with --track on the command
> line, the new branch will track the original without any "inherit"
> magic, then I agree that there is no need for a way to explicitly
> choose between --track={direct,inherit} from the command line.

Yes, I intend for this to be similar to `branch.autoSetupmerge=always`
such that users who prefer this behavior can set it in their global
configs and then not need to remember to pass --track=inherit on the
command line.

> The
> choice would be, for those with remote.autosetupmerge=inherit, to
> use --no-track (to not track anything), --track (to track directly
> the original branch), or say nothing (to inherit tracking), and for
> those without that, --no-track (to not track) and --track (to track
> directly) are the same but there is no way (other than "git -c
> var=val") to do "inherited tracking".
> 
> One advantage of allowing to be explicit is that you do not have to
> remember (or know --- if you are visiting somebody else's repository
> to help them out) how remote.autosetupmerge is configured (or
> unconfigured).  From the command line, without having to worry about
> configured values to interfere, you can control which tracking mode
> is used.


