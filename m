Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33DBC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLWA4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 19:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWA4m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 19:56:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7820988
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 16:56:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m4so3574672pls.4
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1nl2OxyUC8WUoZR1lBZyl4mu5QNhnE+2bZjJIeqC3o=;
        b=NhS5vTWr/ja0hjXopHYYNgikHwsq7Rhdpgf8KKO5RzcM2ejZzrp0qGxI7QQL32AIWj
         iq+OL4BXtJIGPBKTF53wM1GJi4q1bt2pz7q8ep3tszUPzYR68SwOTkAfpkoU0ToCsjWw
         tMAqCb9Tf+3Gtl2RCppdUma10BK2V4vxeDLhPK53GjqNd7/9O784TudhrbXOXw2K2Xat
         ajusyDkUztLNuSp8IiEddtHvXu/JtwJHddsi+Rti100sAq0pmxrKSVZ+glSjTEEM/uKP
         rxrt17qOZPd5+Jrd7OKVH+3BZvkBGVzhQjhMzCSX1KQYNQ2seLTTdp0EDyY/OFqKn6i3
         oJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1nl2OxyUC8WUoZR1lBZyl4mu5QNhnE+2bZjJIeqC3o=;
        b=0umiVkLVkWSWMlMakSsCervqMbwS1JCvAQUobzk46r9hhnU8HpjGjJjlAWqXOdXJg3
         AU+bcR5PauhClYfkI6hOp+WXXZVE1TZh8kuf1sUtECyRuMhXbEfGNuglKMeZgmLIpKgR
         nw+TykBoeLE1q8Lqc/QdJ4v4Nhsez+7+rRHsF03cjzv+rm+xG1LeecZk/q+ftdDQf0jE
         Rkb/NmJ74QysqECxwN5itypwRXZeT1iE4VWhA0f/iwBnIRVgVyMevAMTr4GcAYPQ/WVa
         Yma3ohaWNedqj6xVNu8d0GZZy3/ROURipdTn4zZ4BxYxEao7ZFkKOGzKgsiWC0FB4DpS
         A5TA==
X-Gm-Message-State: AFqh2kpqxmT8y0V7eRBHhVVMSrDtTrPUirbXO3pPE/7FJDigAOZzOjGV
        uKnzMU4mAfzSp9npyCPqrJVlwxOmNqdZZA==
X-Google-Smtp-Source: AMrXdXsqSM68xlbWd5A2mLopL9jusa58jJeKaT4vQl+7mafxx6MRcPzwPb0vc2qv22y1usrzVwO6+A==
X-Received: by 2002:a17:902:d891:b0:189:d979:22a with SMTP id b17-20020a170902d89100b00189d979022amr8331166plz.29.1671757000628;
        Thu, 22 Dec 2022 16:56:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b0019254c19697sm1028419pls.289.2022.12.22.16.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 16:56:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
        <xmqqy1r4usjy.fsf@gitster.g> <20221222185804.GE3411@szeder.dev>
Date:   Fri, 23 Dec 2022 09:56:39 +0900
In-Reply-To: <20221222185804.GE3411@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 22 Dec 2022 19:58:04 +0100")
Message-ID: <xmqq3597rl88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Dec 19, 2022 at 09:48:49AM +0900, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>> >       $ git grep '\stest_oid ' -- ':/t/*.sh'
>> >       $ git grep 'echo "\?$(test_oid ' -- ':/t/*.sh'
>>  ...
>> I found these examples in the log message a bit annoying to see, as
>> experiments are not affected by any grep.patterntype), but they may
>> fail for folks on stricter platforms.
>
> Please feel free to amend the commit message as you see fit.  Usually
> I would do that myself as I'm rather picky of my commit messages, but,
> alas, I'm not versed in portability issues of regexes, so I'm not sure
> what the right regexes would be.

I guess ERE would give us enough expressiveness to say "zero or one"
without relying on GNU extension.  Saying "Any whitespace" concisely
as "\s" would require PCRE (i.e. "grep -P") but because use of it is
optional, the best we could do is "[ ]" (in the [bracket]), one is
TAB and the other is SPACE).

But reading the message again, they are what the author of the patch
did to observe the current codebase, so I think being faithful to
what you did would be fine ;-)

In any case, thanks for cleaning it up.


