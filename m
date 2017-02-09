Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27011FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbdBIVvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:51:11 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36584 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbdBIVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:51:10 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so1294355pgf.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=thSfOCNdeT9t4emZo0NGzSZg9pGh+kdnoQV8EdwzJ84=;
        b=mKt3HWbcoUCCqWa+dpXyhJmliCTdFsQLqCg5MGSsjll1Bjt/+CIGazKPyKdUN8Lhs1
         IbGP4aXAiDgUY0ESI8TJjWYuzoIeXDCNTwK7gVV50ZV2hPT1PUjohMQneDU/bI9L/Cas
         Pfe3SFbvqk4rC6eCxLdf1kYZuPZsqpVyuCN+/QhtXcrMWrFQ+SJKuOXd9jfUEI3/PExE
         RuqqapHihLpsKmILHH4/dEGgv2/pbXzQH9m/+NTbyYKinEY2yYjTbaKudYAL8n4t9E73
         L040YHjYqynJujDc9wgGFhzxiyLvDhSQnTa8VSeZxcMn6PMKVmfvIRW516G0uIy9z8BV
         CLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=thSfOCNdeT9t4emZo0NGzSZg9pGh+kdnoQV8EdwzJ84=;
        b=n1q8YpuXO6ENh3Ve8dHXnh5vR31Rkg5IG4s5GMc3uP8Q2BjLMTqpiI6bITCQpDMMxu
         Ux/BQpWGus6ynPrn6AiaIxgbQ2AtkgmdaeANRjguPz0i7kC+0XIWBQvXT641KWHk6yzE
         8QDLavu64o7oKxog7SVvzFStkO6ikIXVtPmoe/tjY9LyuRGTmQNIpBJZjKdtn5MVxqg5
         2V7IyfPU7GIUu3Ru21x9zjV5YqYnQ4el4II+v/M2vDShOBinPiUzOKMl57M0twM5hLB5
         JFb9d24mWdjb4M5WpudsYFdob29UXhDJYsH1gQSH/eOvkveXeXb65gxUGABPM6csZklB
         nZIw==
X-Gm-Message-State: AMke39mfknghCkA3w0YPsW63rWm8OEvGU1t6NHb+hUOe8bJ4VqaF7mTyBHttx3VqmNQ7ZA==
X-Received: by 10.98.192.216 with SMTP id g85mr6020191pfk.117.1486677033264;
        Thu, 09 Feb 2017 13:50:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id c18sm31275395pfj.49.2017.02.09.13.50.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:50:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <xmqqh944wmcs.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092201080.3496@virtualbox>
Date:   Thu, 09 Feb 2017 13:50:31 -0800
In-Reply-To: <alpine.DEB.2.20.1702092201080.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 22:05:24 +0100 (CET)")
Message-ID: <xmqqo9ybnie0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 8 Feb 2017, Junio C Hamano wrote:
>
>> How long has "rev-parse --git-path" been around?  Had scripts in the
>> wild chance to learn to live with the "output is relative to the top of
>> the working tree" reality?  I think the answers are "since 2.5" and
>> "yes".
>
> Correct. And the third question is: How did the scripts work around this
> feature?
>
> The answer is obvious: by switching back to `$(git rev-parse
> --git-dir)/filename`.
>
> This is literally on what I spent the better part of Wednesday.
>
> There is just no way you can "fix" this otherwise. As an occasional shell
> scripter, you may be tempted to use `$(git rev-parse --show-cdup)$(git
> rev-parse --git-path filename)`, but of course that breaks in worktrees
> and if you do not use worktrees you would not even know that your
> workaround introduced another bug.

In case it is not clear, I understand all of the above.  

I was just worried about the people who do *NOT* use worktrees and
did the obvious "concatenate --cdup with --git-path" and thought
their script were working happily and well.  By prepending the path
to the (real) location of the .git in the updated --git-path output
ourselves, they will complain, our update broke their script.

If we introduced the fix gently, by (1) warn when "--git-path" is
used but give the current output anyway, while adding the "fixed"
one as another new option, and then (2) remove "--git-path" after
several releases, they will not have to complain, even though they
will see warning until they stop using "--git-path".

There may be gentler alternative ways to transition, and I do not
worry about the specifics of them too much.  I just think we cannot
do this in a single step without harming existing users.


