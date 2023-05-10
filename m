Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D4C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbjEJXQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjEJXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:16:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3721B7
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:16:46 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38e04d1b2b4so3994636b6e.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683760606; x=1686352606;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5okDOucLgn10NOsFbfOooeQvBGoitgbXBycm4VLb75o=;
        b=KZKyZgx/Rqsm3E/xttHr8FYC1+zZmM/0GKdjVLUfuAC1WP5ITcAcoVY4AyS8Mi4iaZ
         GFORCwr0kjoB7CxyyJbamlehb9NLFhY2yNwO+MiPrU4eSROlSkQ41iFFF3vWG9Nyvwgm
         00we9fkBZnyqHHtDLln3+a4mwgs1VUpAiU/BnrlDgZj2fnrrQU1WqlnQ7+W5yoAIRuOH
         0p4QTDOUVE2aBJMfGc6xnwwZl+kqObt8LuM98xzFsG0MUqB03A3rAJmcp7hVW5/vkSG4
         DaFc3OftplN4afIIJiFj15bTi0jx4sN/8hGqVJQFB8WOaHjrXpqXL6dq8y5XtFSBkKSm
         DoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683760606; x=1686352606;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5okDOucLgn10NOsFbfOooeQvBGoitgbXBycm4VLb75o=;
        b=hlvLCZoYO1WRCI2CGWcMVMNLhC7Im2zsZdhM+3lZL20j1q5YcZ28gXVt5B0xc9Z9MT
         tOzoOH/r1nGp2DMSfxrhYllONXzIlwou5nAUYgn0AOuUgokb9gsxyrPkECKS4qItpieP
         BbJLMRcGxL8bU2LQMf7oSwFgMHyy4YXbh56TYOlvn61CNrI9kWy05SNAw5UwVVfcRnXr
         pX+FGBUV68ndcw/Ral7j8slkNreW6pwek6cYqOeHmUBTOnG4iQCUVp2TYJ0rEcaFN9X4
         YScJJ3KmszaUaAgfDtEVhaOQ0qvzsc7u3c07+7bqOIf1ioJv9XfWUbUnGj4NVatCyYx2
         XNPA==
X-Gm-Message-State: AC+VfDwJwuZGjksbhBfl6fV1QwZThINZV6QLFGfCnuHBMBNg/VZpDcOt
        sRdiT/uku766W66qPD58nM6SS1f2Fwg=
X-Google-Smtp-Source: ACHHUZ4AodvJEM9jDcVUl2NKfgjrHBjEcXeuf1RCM+NoMgYNVxGKP4zWqmlgSGos5jjYNpNxZcYMug==
X-Received: by 2002:a05:6808:3a84:b0:38e:8d7f:c07e with SMTP id fb4-20020a0568083a8400b0038e8d7fc07emr3226760oib.52.1683760606033;
        Wed, 10 May 2023 16:16:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v206-20020aca61d7000000b0038c0a359e74sm2798430oib.31.2023.05.10.16.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:16:45 -0700 (PDT)
Date:   Wed, 10 May 2023 17:16:44 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <645c25dcb590b_7b63e294ea@chronos.notmuch>
In-Reply-To: <xmqqjzxgzua0.fsf@gitster.g>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
 <645995f53dd75_7c6829483@chronos.notmuch>
 <xmqqsfc62t8y.fsf@gitster.g>
 <6459c31038e81_7c68294ee@chronos.notmuch>
 <xmqqjzxgzua0.fsf@gitster.g>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> > Is it though?
> >> 
> >> Yes.
> >> 
> >> If the proposed log message says "as intended", the author thinks it
> >> is.
> >
> > The question is not if the author of the patch thinks this is the way
> > `-s` is intended to work, the question is if this is the way `-s` is
> > intended to work.
> 
> The "author" refers to the author of the "proposed log message" of
> the patch in question, i.e. me in this case.  The author of the
> patch under discussion thinks it is, so asking "Is it?",

This is the full quote:

====
Let's fix the interactions of these bits to first make "-s" work as intended.
====

If instead you meant this:

====
Let's fix the interactions of these bits to first make "-s" work as I intend.
====

Then that's not a rationale, you are essentially saying "let's do X because I
want".

> I am not interested in getting involved in unproductive arguments with you
> (or with anybody else for that matter).

This is the way the review process works and all git developers have to go
trough it.

We all have to convince others our proposed change is desirable.

Your patch is implementing a backwards-incompatible change:

  git diff -s --raw master

That command used not produce any output and after your patch it now produces
output.

Your commit message does not provide a rationale as to why *we* want to
implement this backwards-incompatible change.

"This is the way *I* intend `-s` to work" is not a rationale.

> And it led to unproductive and irritating waste of time number of times, and
> eventually you were asked to leave the development community for at least a
> few times.

That is blatantly false. As a member of Git's Project Leadership Committee, you
should know precisely how many times the committee has excercised this power,
and it hasn't been "a few times", it has been one time.

And this is a smoke screen: your commit message still doesn't provide any
rationale as to why `-s` should work the way *you* intend.

Throwing personal attacks at a reviewer for merely pointing out an issue in the
commit message is far from productive.

-- 
Felipe Contreras
