Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A40C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4467064EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBZG2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBZG2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:28:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF5C061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 22:27:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id jx13so1927192pjb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 22:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiwCXYzLcM5l1FGgeKFPzilSttlrFDdVlB3DIhX80FY=;
        b=IjeUZg932443QCFc5qzKThw0+qbALn7XHD8yFiiGfbhb6pIAwUqCu3ck/lalV9iZx8
         CA/Uvg45bDHo7fTUx8kTG/ULxO9tMYxgomt4Wg4VqACYZDcOk50uenMStPSnPpNFkwwY
         duJzBhhKVvFWjjZjOHUL/l4bD/CVeSsFvsyCV+0KXjHmji58pabSMflCu369i3c5NrX7
         5Tx3A01yY3tXeJZYTr1Q3NxItk6gFMLpUV3p1ap1aQKj6Bxb5o6e+MkS1Po5r8yF8T8y
         McYYf99U83sirVC5KeYV5pb7MldOyTttTVr+1xEFFHYMoEiM7JZDHyGq3s8z5nuY56Vl
         ILwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiwCXYzLcM5l1FGgeKFPzilSttlrFDdVlB3DIhX80FY=;
        b=TF6wO8KfDnvHv3c2YHmHW5L9uz3Faqywfv3LWcpntzB8TDMcaC42PHOOksM46x8XAv
         LzMCMgJLxaJ10cYe5jov6ojjuF0r1HGcew3ceLu/4t4MUzVl6r82vhzFGldOHQ3O0l7I
         JqTmSbmy/RKs0/N2lUfETEH/qXhuJMOXGukutNr5ymWKUjdFyQEpFGe/yh1l4fCgsLUj
         tpxmKSRau4SMvyijeEjC9dyeGgWnkCZZOSKjNzSp3J7XT6hbWnxl5JW6uZMynwAqFnEU
         fjfSpX9fSHQ2qLiPP1xqZOaiAdJ6ncVgxbbDF/3/iAvIq2lDmgbVixZBxzFda7EnEK0z
         kdQw==
X-Gm-Message-State: AOAM533KsNkayLwkU+kbawaq/zjOXkBq4R+CGGqJzdeilxHSVsHfn11O
        +4X8xjonXdPSy5gxSEcSOaMHgEjHFy6l2cOFbLUNjBNmJb0=
X-Google-Smtp-Source: ABdhPJyieuAl9WuwkTyUmwg6g9YlIPY5ZAgQK7Rh0HShayC6QPkzhufrVq4hJqFruUaAjUa5vIy6dq4M/wkKcCWU62E=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr1843112pjb.137.1614320850754;
 Thu, 25 Feb 2021 22:27:30 -0800 (PST)
MIME-Version: 1.0
References: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
In-Reply-To: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 26 Feb 2021 07:27:19 +0100
Message-ID: <CAN0heSptkHY3A0MHEDwfaMQ0cqhhGwg7hTy70NOsMcp-otROSg@mail.gmail.com>
Subject: Re: [PATCH] convert: fail gracefully upon missing clean cmd on
 required filter
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Steffen Prohaska <prohaska@zib.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 25 Feb 2021 at 19:18, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> This assertion and the one above it are not really necessary, as the
> apply_filter() call bellow them already performs the same checks. And

s/bellow/below/

> when these conditions are not met, the function returns 0, making the
> caller die() with a much nicer message. (Also note that die()-ing here

Makes sense. I noticed one thing:

> -       assert(ca.drv);

If ca.drv is NULL ....

> -       assert(ca.drv->clean || ca.drv->process);
> -
>         if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))

... the return value will be 0, so this will trigger ...

>                 die(_("%s: clean filter '%s' failed"), path, ca.drv->name);

... and we'll dereference NULL to grab the name.

It seems like you could leave that first assertion and your new tests
would still pass. Hitting an assertion is arguably better than wandering
off into undefined behavior. (What will probably happen is ca.drv->name
will effectively also be NULL, because it's at the top of the struct.
Some implementations will format this as "(null)", others will crash.)

As you note, and my reading agrees, you can't really have ca.drv be NULL
here. So this is like, if and when we grow a bug somewhere and actually
do have NULL, maybe we would rather hit that "assert" than go
dereferencing NULL.

Martin
