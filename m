Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACAC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCHW4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHW4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:56:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0065447
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:56:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v11so85165plz.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678316178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8qOH4IUa4bY/vM7rrnezvYYKm3QULCWmIBKT6oT9Rk=;
        b=XrrpqK+QxKeHW7k2qBHin9uabtgTgDqPxuHome0tR/UpGThYOef4A4A4653WfJj5iB
         24w0neRgZ6EDXcyrscwVrT5rLt/c/D4vPpTy6xCPgX0ze8Acy8VK8JIJfuCgYhX+7+QO
         C6yF/f5w0gWGXU2IjpAB7eewj+VowiCcv5THM8tgPQncWIfz7X0F0uciafN14TNt8vQM
         iYCNTLXQ7WyE2QWfMqj7Sdg9sTwPdL2DLW3FwofVZ99kMTKUiXeEqqOLUmBKWHVsn6ei
         SDfvKcCVepzQYG6K2WvIRV3L7fvF39+oVKb1r+SimU/w/gLj+x4o/u3vxEth7yLXDES2
         11Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H8qOH4IUa4bY/vM7rrnezvYYKm3QULCWmIBKT6oT9Rk=;
        b=qXERFSHmcvH/snuMHCgryDbTqAoJitXgIAdSqILX9ts6iciiy0zgO46VFECkpNbPpp
         1y6wfi/YzXb6ZW5DZE9V0+MOZEiOIJD56P0EtnC9Lp7kQ1Z2RP727Xs5pP396fKOV4xM
         BAxhBJ3tcLwF807dv6TSijwpJ0s+dnJCi4xer8PkY18XVQsUCbr+sc/4yIfI0VQxHbI1
         zKhWPfKmWAtnz6ZsAd2owDfUizEU6fylidpCaL6eE8gCGD4530m/AcpoeRBrbv7ODbj9
         bvdtiJARFrIX6u+WANQc4HRC0IhRXmN5xtAKoAVTtfutEd4/JYEZsMkwwvVgpzA1x7c5
         TxBA==
X-Gm-Message-State: AO0yUKX27xyGlnN98txU60pwnBmAWFb6gaaOFscEM1tZPQ2LquqARgUv
        fJjCWCBIYbY4NVHJTktdaO4=
X-Google-Smtp-Source: AK7set+y3J5X6hhTfw4h1pQKuG+AhF70/YjGDuxPS3nhQW/+lSHmpaj02Gec2CnJNBnOUoBQXUNAGQ==
X-Received: by 2002:a17:902:6a81:b0:19d:20f7:daf5 with SMTP id n1-20020a1709026a8100b0019d20f7daf5mr16649561plk.28.1678316178535;
        Wed, 08 Mar 2023 14:56:18 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001994e74c094sm10304716plg.275.2023.03.08.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:56:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH 1/8] ahead-behind: create empty builtin
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
        <xmqqzg8p90mq.fsf@gitster.g> <ZAaH/iCsqdewYrUj@nand.local>
        <7328e095-83c6-dd33-1d36-9220612e99c0@github.com>
Date:   Wed, 08 Mar 2023 14:56:17 -0800
In-Reply-To: <7328e095-83c6-dd33-1d36-9220612e99c0@github.com> (Derrick
        Stolee's message of "Wed, 8 Mar 2023 17:14:37 -0500")
Message-ID: <xmqq4jqusvhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> What I have yet to determine is that 'git for-each-ref' does
> not have significant overhead due to how it's implementation is
> built around listing "all refs that match" versus an explicit
> input list of refs. There's also the concept of '--stdin' that
> would be interesting to interact with.

Yeah, we could add --no-sort to allow streaming better and --stdin
to feed list of refs to work on, if the end-user facing interface
based on --format is what people find reasonable.

> I'll continue to investigate this path and report back when I
> have more of this information. This is as far I as I could get
> today.

Thanks.  It is a very interesting experiment.

