Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF0C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 15:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjC2Pf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjC2PfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 11:35:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE75BBE
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:34:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso18920635pjb.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104067;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7p1RXlWr0vu6FzcAamSRpo/e6lUAQxaks6Q/KDhaBs=;
        b=WftokLwVmHQDcNQuAgiF73EjE4Fbdv81bAwwxZLp+rZt1FmI91lP9QvAMCyBBB7jLR
         ca7dfY6zLOzuNAD9nc/n1T0lQAOycvK1dOYFt3/0/DkZ3nfxJNFt0EvDVqsr7PzMHRw9
         65ufHnoGhIMDsLDT6qcWoKXtOu3x6jyq83iYaS2Lh+Uzf33zYC1LWuZ9QpM7lmJvfkrW
         mHumh3YcwUxqtYdkbi34UVM7PW8Ad84glo49gy6620vIP5oYcbqeGjVSS+XXxmP7zUmi
         AaMZq98HwQGyfmlOLAYsXElDv+hCUAcAVp1rfJKHUzpSIAcfEUWAKUItI6FCIgAZAZf4
         rH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104067;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y7p1RXlWr0vu6FzcAamSRpo/e6lUAQxaks6Q/KDhaBs=;
        b=ONnPEz6ckmCDUr3BTCYGe0gJpJjrovBl6zHpe6Xpp8MF1A6imGecDNu87VMVH5CJBm
         2nEI+NpQgjdiM7ecKQJIPCax3hj7qBNhyOJB89tMMKNrAGpiEPDvmCoOREewfJ7CTueY
         br44jd2BErFvJG8XXO2j6V6naD+aButNHfQA406uHGBF7dCJMlNormZIBkbvJAcK/2mP
         9Ca8Q9D6O+W3RO6OmPwOZg9F7N2Cxfe8fzBju0+yVWszJogdMjy8v0ZTW8kQCu36dPXP
         GmzsqOyxEbYEhYkyRtmasF4hLvRxvqYR/mjyJOAZhp52Y8fyy8ZOX3cZGWtGoNdtKpNz
         L39Q==
X-Gm-Message-State: AAQBX9dggqZ7xShYZWT0Ys37/f6DVAEwJG+LDXzZHN7Pq6V+kiDfCk/N
        WT+Op3OjGqGi8VVPEUwxjjs=
X-Google-Smtp-Source: AKy350b+F47Yo+Cv0IQKLt/tjQXdy4ZLpjmAvXVSbuZw5Vou86kRKATk2R3jK3bNeT+1X2s4boXK2Q==
X-Received: by 2002:a17:90b:4d8b:b0:234:bf0:86b9 with SMTP id oj11-20020a17090b4d8b00b002340bf086b9mr20038683pjb.25.1680104067539;
        Wed, 29 Mar 2023 08:34:27 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090ad90300b0023cfa3f7c9fsm1589349pjv.10.2023.03.29.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:34:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
        <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
Date:   Wed, 29 Mar 2023 08:34:26 -0700
In-Reply-To: <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 29 Mar 2023 00:57:45 +0000")
Message-ID: <xmqqh6u3d119.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't care a lot of other folks want to make zsh run the
> testsuite in zsh mode, but I'd think that using sh mode would be
> simpler and less likely to break in general, and would avoid us
> needing to carry a lot of patches to work around various variables
> that are special in zsh mode.  It would also be easier to
> potentially test in the testsuite as well.

While these patches may make it "work" with zsh in its native mode,
because zsh that is running in its native mode is sufficiently
distant from the more POSIXy portable variants of Bourne shells like
dash and bash, I find it hard to justify the cost of maintaining the
resulting codebase to "work" that way.

We need to force our developers to pay attention to rules set by
zsh, like "$0 is not the way to spell the name of the script",
"$status is not usable by end-users", etc.  Making the problem
worse, the rules are enforced only by zsh.  The situation is similar
to the "when to use $(pwd) and when to use $PWD?" rules, which folks
like me without Windows have to spend extra minutes to remember
every time they use one of these constructs, but the number of rules
seem to be much larger as these patches seem to show.

Thanks.

