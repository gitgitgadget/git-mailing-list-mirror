Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B1C678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjCGSMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjCGSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:12:12 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104385B06
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:07:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n6so15042871plf.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212451;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tj0Pxl3RpqvYUO+mLWY1h6lqTYjemTQWNfRMyXi49LA=;
        b=JhjnAuRAAWLuH6Di8G1BvoW1GrGyNMJRDnd2Rqjly9RRUuE+deokWLnePmJWZ4YA9v
         cBdqJ7KCoJxJGLWqRiENnaHSasoiMifqWRLu7LWPtaTFDgt9Lct87E94sXHiievivuRz
         ewCa+OHdXFGadctGr6AyqXJIe28LBqzzC0srT6OhxVSQarnSEHEc29q/uuQb3BzWsO5o
         K2z9QFv4JOrGIt1xvArIiSriZa917/jOUPiOh3tAiX9S/8ij7EXZ4NdHwWTdNiIpm3mo
         q4oVCbfnugJtxRtYZPnUgB4cVLSpA/p6WOBc7iTfVt8Errt/Xd5KmsbpwcEc9Cd/DYka
         cYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212451;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tj0Pxl3RpqvYUO+mLWY1h6lqTYjemTQWNfRMyXi49LA=;
        b=V0fH89k5MkpDHX0ycYcNIkfa3zzMiRYAtshVNF0Q6hMcieeYvNqEApGXy1NrtjwKLk
         b1sWSaUzuwL8O9QScrja7NRS9V6vkp05H9EH611Yf9Hb3ptycp1U8h0RepnXb7rxWUra
         557cEKspupW9ZoL83DkUnwTuCe59C2QBe+uUGs0BxJEJqLKNwWO6BP7n4SKh1sdCWxM5
         dXkma4XGu9JWNcasFsv6oi7SLPfmRf/CC86QrwNvM9gJgbmd2KAKUmOdPHxLHSFMmpiW
         is26IaNlw2JMi1MPGipYWmcoKQylGsGTDfpcAZ81u1jys0IR2bRSyTFaF/yLatpoHRQA
         cA9A==
X-Gm-Message-State: AO0yUKUGPWCe+kDDIvpSipioGjRkftL1NTxlJOIQrkb3hj3A2jcjGdUc
        eHM14M/gaGO5MtBPatz5x8o=
X-Google-Smtp-Source: AK7set8yBio1Xm05IYWXgW4K+SQL8iF9C6/nlTshtzEeGmn6fCuKG92wVxKssFI9IWqnSsy7uQ2nzA==
X-Received: by 2002:a05:6a20:6a1c:b0:c3:2bef:bd62 with SMTP id p28-20020a056a206a1c00b000c32befbd62mr16656463pzk.1.1678212451215;
        Tue, 07 Mar 2023 10:07:31 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k1-20020aa78201000000b005cdbd9c8825sm8210154pfi.195.2023.03.07.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:07:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: When exactly should REBASE_HEAD exist?
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
Date:   Tue, 07 Mar 2023 10:07:30 -0800
In-Reply-To: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de> (Stefan
        Haller's message of "Tue, 28 Feb 2023 13:55:20 +0100")
Message-ID: <xmqqo7p4zb8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> writes:

> The reason why I am asking this is: I'm using lazygit, which, during
> interactive rebases, shows a combined view of the real commits that were
> already applied, and the remaining commits that are yet to be applied
> (it gets these by parsing rebase-merge/git-rebase-todo); something like
> this, when I set the 2nd commit to "edit":
>
>   pick   4th commit
>   pick   3rd commit
>          2nd commit  <-- YOU ARE HERE
>          1st commit
>
> This is great, but ...

Stepping a bit, how does our "git status" fare here?  It shows what
step in a sequence "rebase -i" the user who got control back (due to
"break", "exec sh", "edit" or a conflicted "pick") is in.  Or at
least it tries to.  Does it suffer from the same "great, but ..."?

If it works better than how lazygit shows, perhaps how it computes
the current state can be reproduced, or better yet, the current
state it computed can be exposed, and it can be prototyped by
parsing "LC_ALL=C git status -uno" output, perhaps?
