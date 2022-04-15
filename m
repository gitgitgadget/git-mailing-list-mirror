Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342EC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiDPACL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiDPACJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 20:02:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3CDF8E
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:59:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mm2-20020a17090b358200b001bf529127dfso5397005pjb.6
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=NSJA8B5uIraOtaJG/OtZofaOhdAgixpiM3g2nsv7BC4=;
        b=EMTv7WTJ4UJGMcdQhurTjTia4pSXPvkAX0HP+MVta/xqGiT8swmZzWZT8kSrtz2z2q
         AGiifuFP7F+VXxy2AHaGRqC/2vnH4bAJe2u4rZNHt15rtTl9Jyl8Y1bXGyTlTquROpv9
         7HvUU6PpXIYOC33NtB9NV87s0eafzO117+fBfFyYE6oSx1bqCWmbl3lcznEK+yI21Um6
         9XlmN88hkRwclkwb/jxL4xnNrUEdVBJODsHkSnhDgYN+IXvs7n92WIiUFWnJTZZXqXWv
         kCo4+StdEsqLzJrt2ggeP1hO1HH9BK+/93CFLWqezoHIzf9IfOxIeziIDOAk02K4CH2d
         w1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=NSJA8B5uIraOtaJG/OtZofaOhdAgixpiM3g2nsv7BC4=;
        b=avvJMEBpLzQUMe/kMiHeosRvMVSv204/ZdWe/ygPwJNe3iodvdepcnDibbwWhd2A03
         rOgeirXDu4YkIw20UZrhlvz2j+HR0zOLEToDUrxSF2iOfswFje+2ohme4znonnvrr4B9
         DlH/5W8ya2OoCHgz19N6dQwfPtw9bOq1jDpu8fiegTAFd91SVQq2xWNqlsv+OnSbBUdK
         cSnvPKaeRppLGc4VuH7E/twdd+YnPYjjjN0xBnc44Lu4w12YwqsvbWhST04WGYTfcuSZ
         AVN8/MyYaKc3uGCkIJ43J9QtuadCVXi1SpJjDtjrnmaHaJKn56Ur/OslLUZlsRhEIGY+
         6MPA==
X-Gm-Message-State: AOAM532A4Maegk9SKfMf1XOSQlo5bB39lRdYTrYlJRueAipwF88k+LKd
        dnDTrJhqkCVsa+dqt8Zi1yJubKc8LM8fmQ==
X-Google-Smtp-Source: ABdhPJz8+35UPYxfUkNrl94Sl3cwlsP0lUzFxsHgeqsibcp1L3cscJmUpuxoG+Zin0aLHHBTXtYz+PfMsLNXQw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP
 id m11-20020a17090a858b00b001c65bc8781amr612156pjn.0.1650067178914; Fri, 15
 Apr 2022 16:59:38 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:59:37 -0700
In-Reply-To: <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6l35id99ue.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I wonder if all we need to do is make setup.c a little smarter - we
> recognize bare repos, but *only* if they are contained in a directory
> named `.git/`. This should fix "git init" I think, because even though
> we'd ignore "./ (bare)", we'd recognize `../.git/` and we get the right
> behavior again.
> 
> > It is a separate matter if it makes sense to allow creating a new
> > repository inside a bare repository (it does---that is what the
> > modern submodule layout uses), or to allow an alias to help doing so
> > defined in the top-level bare repository (it probably does---the
> > end-user may want to have a handy way to customize how submodules
> > are configured).  But it seems to tell us that with today's external
> > interface we have for "git init", we cannot take configuration from
> > a shallower level and use it to drive "git init" to create a new
> > repository at a deeper level.

Hah, I forgot that submodules are stored as `.git/modules/foo` and not
`.git/modules/foo/.git`, so this doesn't preserve the existing behavior
for submodules nested > 1 level.
