Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDD21F42D
	for <e@80x24.org>; Thu, 19 Apr 2018 23:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeDSXSE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 19:18:04 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:45213 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeDSXSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 19:18:03 -0400
Received: by mail-wr0-f177.google.com with SMTP id u11-v6so18153996wri.12
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=drIyq0UuZoahxhvw+4113SVk9QGuMmshYknY0eZUkjE=;
        b=RU10JmXcBWuQrd4Slhb5AiW+htL9QFxVFE+mLk6OTlzXxNNeHCBqkDqLUE4ZbSmm8O
         NtsZ9ZBnpJZtP3zGxf5AJmS02JOx4Q7gJR18KDjBkpGqlLoR9KmaahJyYkw7YcfCv6o0
         xPy43cJCksgypiWYruAuk718SdsBZFLq7qn2bBPVzWs53qLHokdvJuvJ22YpNdG2fBr6
         BYJocxkghT82T56hNLgr55/SMa9tiH9C8UR61dH9iCleagSAJhBPrX0ouwJuCvY7Xmz0
         6O8UOrdMcO6qo0QwnUof+f8rUww6iZR28oKXNUuec+9BRp+JeC9wlbJboGt8zcJAJUWq
         d3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=drIyq0UuZoahxhvw+4113SVk9QGuMmshYknY0eZUkjE=;
        b=j9tg6dL0xGspSoI9lwTT3gRXgGN9cAFUI2U4SseQuRw8BjwPt4L3hXy8GL6ZaxSWZm
         2XjlrSSzLAgvTnF6KRKvDv3grYwgwzCbCk04rk0fId4sTUl/zjb9JVt6b4/6zo6aTPRr
         xvstCNrqrYhO2Ttj+wAGS7GiOlXVd5962aRYKGBl/XH4/lLgpViwsAGBOGhgspwSkuYz
         7c1oIfYDVZM9tMRlBiA8nr6DdD9bM61vy80VS1oWbERwDowAjNu8bp/7ooMNtZyos4/P
         TMrkyFl8SVRcxU+4JmzsXJyc9f2XMh4VlfcAUhGIZ6kTbYKsKT+7wI+JezVRz3SQ4JKB
         RIXw==
X-Gm-Message-State: ALQs6tAbkf+aTJml910oMQJtwT92VZDAgjTw2uuyLPMEsiGYgdje2ehO
        bZJhTzrNgdUgl3XIUXsHXQ8=
X-Google-Smtp-Source: AIpwx48KctOKIQdbFt4HPtyUoxGFyrqp2iHw0MgFSUzoD7aZdU26OHR1iqcs+0ja2p+PIb+bkRR4Vg==
X-Received: by 10.28.46.208 with SMTP id u199mr324428wmu.99.1524179881482;
        Thu, 19 Apr 2018 16:18:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c124sm245568wmd.36.2018.04.19.16.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 16:18:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
References: <20180412210757.7792-1-kgybels@infogroep.be>
        <20180412210757.7792-2-kgybels@infogroep.be>
        <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1804182251070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqy3hkfais.fsf@gitster-ct.c.googlers.com>
        <20180419213322.GA19500@infogroep.be>
Date:   Fri, 20 Apr 2018 08:18:00 +0900
In-Reply-To: <20180419213322.GA19500@infogroep.be> (Kim Gybels's message of
        "Thu, 19 Apr 2018 23:33:22 +0200")
Message-ID: <xmqq1sfaeqfr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Gybels <kgybels@infogroep.be> writes:

>> > In other words, you scolded Kim for something that this patch did not
>> > introduce, but which was already there.
>
> I didn't feel scolded, just Junio raising a concern about maintainability of
> the code.

FWIW, I didn't mean to scold, either.

Rather I was pointing out that the code already maintains the number
of remaining children, which means that a more portable abstraction
than poll(), if we desired to have one, would merely be one step
away, as we already know that at least need that information to help
Windows.

> There is another issue with the existing code that this new
> "xpoll" will need to take into account. If a SIGCHLD arrives
> between the call to check_dead_children and poll, the poll will
> not be interupted by it, resulting in the child not being reaped
> until another child terminates or a client connects. Currently,
> the effect is just a zombie process for a longer time, however,
> the proposed patch (daemon: graceful shutdown of client
> connection) relies on the cleanup to close the client connection.

Good analysis.  That consideration may mean that xpoll() as I
suggested is useless as a possible more portable abstraction (or,
"an abstraction that is implementable easily in both POSIX and
non-POSIX world"), but I suspect we would still want to have an
internal "portable" API that serves the purpose similar to how we
wanted POSIX poll() to serve.  The place the patch is touching is
not the only place poll() is used in the codebase, and other places
(and future ones we would add) may benefit from having one.

Thanks for being constructive.


