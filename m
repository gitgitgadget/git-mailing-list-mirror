Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51692C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C3C6024A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhHESj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhHESjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 14:39:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADBBC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 11:39:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so8129291pjn.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=m1HVC8UYTCesYNtLq3QB3e4WO4oqrz1T0WImPJ97Z+U=;
        b=dQPNkbXYywY3345gbtaabSOOJ2hr69Oh+QgHJTWmDra19J2QzOy5HralfTI+YMGkP7
         DJEDKMUQgl/zWhaZkzhCntyZMWcS4U8s0/CZrv2MaUDWqa0O8NnhuGa/B2/IDLnAvTl3
         JvP5izgLDEYGa0v2H54LQDqYLjz3m6cv/QQpzkloHp2zdAvLh0SB42jTViFOr5YuSBxq
         nilmRCadcJ8QqHdAw6iKQYOuNarf+P7lBuN+yvm+PlpibUbAf8VLJn884WKYFd3kUeeY
         s6ft/31TSE6fv17kEDnzk/Sc5m+W6FgM173M+JxDtSJXs6GXu75/EK6GSKVHyU+Uh3QU
         nhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=m1HVC8UYTCesYNtLq3QB3e4WO4oqrz1T0WImPJ97Z+U=;
        b=fNXnvb2ftxU1PHI7zW2i3HurMZ5qFyoHq6r6QOOeq7sfqEHAzhacDODrrz+NmkzOrU
         ABt5B1yDFR96lLhEjsoFdjjPvMfAoU8isD5dEMusXAGfWNNAxGWKvp1GQ5YLJ1JEDhCz
         4m8MyO74wGFIlhxEt4+KugiivamqeX0fFCv2Q4nJrYGAbG1s4tlyRSPial/0Dnr6YUyW
         WKAfnc+LfkCid9lyKPQh0ZIgQK8azf+Q0dUWl/PjQMZoOEXwvQMEqABIeEPGXHYUNsFx
         6Z75KNjj540tYVVudWVPa8cTCQ4eh9+p4KL/RZrUHCBZRB1bPBo4y8RatdXoVmZN+ScC
         xriA==
X-Gm-Message-State: AOAM531f4ICOGYBkQmDLc+pYxdQeSM8fyN5AdEh9nqSmiczQZzJQJh2W
        cg9SnD7vRU7/nMcy5WND9PO2M0XisnCc/g==
X-Google-Smtp-Source: ABdhPJwzRs6/OHbRB1zaNqPXs9qs1VpYcWdGoqNk7M5LOvi+KcQtcHlm2KFW9DIaW2WyIAyy52SvYA==
X-Received: by 2002:a65:638d:: with SMTP id h13mr1538648pgv.178.1628188749870;
        Thu, 05 Aug 2021 11:39:09 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id j5sm8702196pgg.41.2021.08.05.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:39:09 -0700 (PDT)
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
 <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
 <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
 <CANt7McE4N0wv5bik8tSNrdTs-mcL20cJPMP42iPtZqhUpKgirA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Rostislav Krasny <rosti.bsd@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Why do submodules detach HEAD? (was Re: Incorrect and
 inconsistent End-Of-Line characters in .gitmodules ...)
In-reply-to: <CANt7McE4N0wv5bik8tSNrdTs-mcL20cJPMP42iPtZqhUpKgirA@mail.gmail.com>
Message-ID: <m2bl6bvit1.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 00:08:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Rostislav Krasny <rosti.bsd@gmail.com> writes:

> On Wed, Jul 21, 2021 at 10:26 AM Atharva Raykar <raykar.ath@gmail.com> wrote:
>> [...]
>> We want to have idempotence, ie, for a particular revision that is
>> registered by our parent project, we want 'update' to give the same
>> outcome every time, and not be dependent on whatever the state of the
>> branch is. This way we ensure that for a particular commit in the
>> parent project, the submodules will be in the same state for every
>> system in the world, after an 'update' is run.
>
> All this is ok, but there could be other uses of sub-modules. Why not
> to make this behavior configurable?
>
> As a developer I may want to make new commits on those sub-modules and
> always work with latest versions of their particular branches. In the
> detached HEAD mode this is much harder to be done and also an error
> prone operation. Commits that are done in the detached HEAD state may
> easily be lost. [...]

Have you tried running 'submodule update --merge' or
'submodule update --rebase'? Those modes will not detach your
submodule's HEAD.

The Pro Git book has a section that explains a workflow that sounds
similar to what you describe:

https://git-scm.com/book/en/v2/Git-Tools-Submodules

Around halfway down the page, look for the heading "Working on a
Submodule". Does that fit your use case?

> [...] Google is full of questions about how this could be done, i.e. there
> is an essential demand of such a new behavior.

It would be nice if you can share a specific link that captures the
demand you are talking about. When I Googled about this behaviour, I got
a range of different kinds of results, without a clearly voiced demand.
If you can show an example that best represents this demand, the Git
developers here may be able to address it better.
