Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EFC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbjD0FqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0FqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:46:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24122D79
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:46:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a5197f00e9so62863365ad.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682574362; x=1685166362;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYVzjspa9VwEt0nqnIrd7rdJU9C5cuRsZWVSS83Km04=;
        b=QHovULRVV6wvyeXc4em1D8nx2wqNA+4FXlXM8LJokqJpA7rmqwQTSOUDymee7F2rZi
         57OuwNuhbVzrgjCpQ5s4lHVveZGRXcK8ab7q3DOwmh6/QrB7k0n9SpUDRKq/FR2mjmTv
         PUmbMvwfKYByobVq1oo6wC5qyPAEUy/ZqCjVll+hTGgT7ZXXm1Ha4nj0eWwzgb4O1yXn
         gcg754QuRb9DqyWlUsb6IGP934n4EpVJM5ckniAhB7LWJEEWf2jLTftc5XbR+GkjbfJv
         sVRdmEKSVw0+UIKGdN69Nuirg2kb6RUJsddJpU4l6o38RFcU/HJWvYGR2cnzl0VsSjpy
         XApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682574362; x=1685166362;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYVzjspa9VwEt0nqnIrd7rdJU9C5cuRsZWVSS83Km04=;
        b=RePs9B92Oq5ogrAPUaudE/Q1sN4+IEwirJtFhL9fRCqOJbRNXWN6+GyR0rNI3WuxBC
         3HYOujBrRZat5R8YR08pAvEjTjzD41mj/mG4yaSWJe+dYUj9P8ggVXeQbe8RVdv57Z1/
         HtLUQrIV2b7RnKMKNhPzs5uKahwwV7jtCrtZA/aQE9EVNE/K7ItO7zFz8Yjsa1SctTpM
         D+Y0//EVs9U4qzifAzrZflQSAkqWcDrs+KtYVvNR7RUqwW3/Xk/JL1k4hevCxUfjlWCy
         gm2gtc8F0RjyQXVyRW5e6uQEzuNYsrHQdjyO7/HWxDqWOd2Yq4p+aLRV2cB57DgxLna8
         tmFA==
X-Gm-Message-State: AC+VfDwEOmrsuRo0Xq1ojf1lyHPwuhRiPj+EsH/QWWxy2STCosVqONwo
        k0SNDwnB4QxvVuS0c7Hp2/tZ96oC3R8=
X-Google-Smtp-Source: ACHHUZ6UVbozCT/TlSB/YKcgbQyING5ibY8kJhYzqb5Bnk+KikpApC3zc9dEnIz1qTqBsnFtE0gAaw==
X-Received: by 2002:a17:902:cec7:b0:1a6:9d98:e763 with SMTP id d7-20020a170902cec700b001a69d98e763mr481438plg.26.1682574362122;
        Wed, 26 Apr 2023 22:46:02 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001a52abb3be3sm10844753plb.201.2023.04.26.22.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:46:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
        <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com>
        <xmqq5y9lc9ep.fsf@gitster.g>
        <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com>
Date:   Wed, 26 Apr 2023 22:46:01 -0700
In-Reply-To: <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Thu, 27 Apr 2023 00:29:12 +0200")
Message-ID: <xmqqwn1xnahy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Maybe "HEAD position was" fits for both usages.  This is how it would
> look like:
> ...
> I think, if there are no objections or better suggestions, I'll re-roll
> with "HEAD was at". 

But does it convey the more important point?  The reason why "HEAD
WAS at" may matter is because the user is about to lose history
leading to it.  I wonder if we want to be more direct and alarming,
e.g.

    $ git checkout -
    About to lose history leading to 2efe05c commit-a
    HEAD is now at 7906992 commit-b

Whichever phrasing you end up using, I think the order of messages
should be made consistent between the two cases.  That is,

> Maybe "HEAD position was" fits for both usages.  This is how it would
> look like:
>
>    $ git checkout -
>    HEAD position was 7906992 commit-b
>    HEAD is now at 2efe05c commit-a

Here "git checkout" reports the lost HEAD and then the end result.

>    $ git worktree add test --detach && git worktree remove test
>    Preparing worktree (detached HEAD 2efe05c)
>    HEAD is now at 2efe05c commit-a
>    HEAD position was 2efe05c commit-a

But here "git worktree add" reports the end resultfirst and then
reports the lost HEAD.  It probably should report them in reverse.

Thanks.

