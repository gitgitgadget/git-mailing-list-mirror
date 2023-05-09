Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADC8C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjEIQrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjEIQrf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 12:47:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78051738
        for <git@vger.kernel.org>; Tue,  9 May 2023 09:47:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so2449669b3a.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650842; x=1686242842;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w8WZhqIhJUZBBwKkEzHufdci89kDBKjlme/ZxYSgUwE=;
        b=ZJPVhJUB/zl5MlNPOGMKkvDOWtRzREDARwWxtcwIFWqcZHttwnh60cva1vxo9VRDUg
         EqYDoeQ4IgAHhGLAG9Hsa6YXS3dp7/DR0/s0c80ccppdZ0fmecACHayrRDuJy5wRFmJF
         5R+vM8ST6mQHgWodeB85dPvhkI6FBAc8KGJuWOvibNQ79Yea2oNGbFp2hgaxNHXvarbo
         DlCaagdAtSAuN7KQboZp4tDUtKvP6dVra1fHrekQ5eqDRqHcVViIM0V+hf2rWrFJziCb
         UVlUCK/8vJxaSP9NXYA0FNiZujnFR4z+B/dBY78N8QYi6di51eWlqy22/KB9gQaJqUqV
         JBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650842; x=1686242842;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8WZhqIhJUZBBwKkEzHufdci89kDBKjlme/ZxYSgUwE=;
        b=SPuEFuu0VSUXmHkXcu3UQvDIl99K7/JGSgffw+R0qhQhDyucIXYNvHxfInFG8SOVnm
         ftSQSKAmetBcgdOF8gVo5n9iWfi2/AKdEBrYeoCgSvF6xZYjp8UfMJoyhvJvhqVXioGE
         J0vBKsi/EYm83aqPLAOoqRHDngWmrxWD6jGBhumH/X6Ehj441UFwGUQMdIk9iGJDEtyg
         aKgDP8i5Eude9/I92adY97MF6SGNU4lCXLT56OvWts1+18DTGtT8b4KCpfXQJexno+4X
         L6C54qIs4cF6zPG7cHTmvonh3mQjKOB77RtTtg2HVFqklDjCdF4Tg5XoaGoyurE6hHSW
         w+LA==
X-Gm-Message-State: AC+VfDzOefHU4itcJ0O6BiTN6SDuv3FsV+njddLCwUwdag7AWrlglGAC
        NuGY4vLFhoptwMUd1WcnZiU=
X-Google-Smtp-Source: ACHHUZ7NrGheg3svMWTTYiEukvlc35CpXyY+wW/oiSuyATCsZXi0+OlrtnW48dd3bu1h37wDnDHQfg==
X-Received: by 2002:a05:6a20:2443:b0:ff:ccee:8e95 with SMTP id t3-20020a056a20244300b000ffccee8e95mr14040214pzc.48.1683650841940;
        Tue, 09 May 2023 09:47:21 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006413bf90e72sm2012477pfn.62.2023.05.09.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:47:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Adam Majer <adamm@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
        <20230426205324.326501-3-sandals@crustytoothpaste.net>
        <xmqqbkjaqqfp.fsf@gitster.g>
        <20230427054343.GE982277@coredump.intra.peff.net>
        <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
        <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
        <645857d8e8fd7_4e6129477@chronos.notmuch>
        <ZFlr8PWOPRuLuP6E@tapette.crustytoothpaste.net>
        <ZFohLeq1AfdVKqfY@ugly>
Date:   Tue, 09 May 2023 09:47:21 -0700
Message-ID: <xmqqild11mg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>If your history contains mixed and matched hash algorithms, you'll need
>>to be able to verify those commits to the root to have any confidence in
>>a signed commit or tag, which means trusting SHA-1 if you have any SHA-1
>>commits in the repository.
>>
> the history is traversed from the end anyway, so having sha-1 in the
> history is entirely irrelevant for verifying sha-256 commits, assuming
> one may only upgrade the algorithm.

That depends on what is meant by "verify a commit".  If we are only
interested in the tree contents, then the newer commits whose trees
are hashed with a more secure hash algorithm recursively down to the
blobs would lack any weak link hashed by a less secure algorithm.
Most people do not care as deeply how their project tree came to the
shape it has today as they care about what is in the recent trees,
so this is an acceptable stance to take.

If the less secure algorithm becomes so weak that the history, up to
the last commit that was signed by it, can be rewritten arbitrarily,
however, an attacker can lie about why the code that survives to
this day looks the way it does by forging old parts of the history,
and mislead today's developers to do wrong things.  The only way to
prevent that kind of attack is to verify a commit by recursively
making sure not just the commit and its tree, but its parents are
all authentic, and less secure algorithm may make it impossible.

The old history hashed with the old algorithm needs to be kept to
help external references, but I think as a mitigation, those who
care about that part of history can create a copy of the history
hashed with the new algorithm and publish the correspondence between
the two parallel histories to assure the integrity of that part of
the old history.

