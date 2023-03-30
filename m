Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B1C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 10:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjC3KQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjC3KQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 06:16:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD993D6
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 03:15:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id le6so17585400plb.12
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171350;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uKyxduTYIjYRSTpUZw3nDatzt3GVoi5yeS6EQO8oqw0=;
        b=Ld3HEq4FIib+s8h021FpZxdBtENctOWi+zYWJOiy0IWClmrZYRP81WLBVMaKeF6zub
         GY5ZmXMXkhZB8ZmGTrks0SxBhiFr+x3TTYiDnG+NNstT0ZvhOQndY2Ocxhzhkdt8cPxS
         YO18efJDLFXBpputXjmFaY7MJ4ht/PwinCfvcZ+EB+JrhdbB6XGk3MsMprKvwQEC2sKr
         pl/57pdD8L8HFrcn8FO0eTi1Nqg9jw5HVaGlRsREqCyK+B8xf74Mo9n9gbwoEModgYz7
         Vp20/WbIJJrwuRC2G1nR1i3A5hcdsbWwIHKeJVl50ekPTLJXbku/veJWVT2lY40KHrWO
         +NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171350;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKyxduTYIjYRSTpUZw3nDatzt3GVoi5yeS6EQO8oqw0=;
        b=GyIeuJ7pluBk/g/dkn1804xIz+jKvwArqJo/SRGMRjq8b9W6D6PItlyhcGj0cskjwi
         Mx9DAtfvkaXBn2Ys+owh6Vl33exdDoJRt6hDkPLtpAH9Ih62ta4kPOyThbV0Uk/zmUjq
         d0mHd5NVvkbc1ItTc+gdXMiq61NEFzMwLCqfkeVGwR8Dvw28FqZtTrsiGo3QxWq328Sr
         W+HyqYJiIf0SZJWj0/8R7rj3kf47EV/hHZLBcjlsYvS1NRVIU6Ib3n4x4jl6dK7WALlN
         5Hy6Vwup5FG5pnjfxMKNn+W/AT48GrYVYPphafA4ZvTW7utreI4PwKp8iyecwRpFgo9m
         HgMw==
X-Gm-Message-State: AAQBX9dUi9iGnP0DcKrSUqWBqPxQQp1141hjhtqnqxrF/NW5xs/OEe8y
        oXc9v0bf2nUzGTQOegiXQnwBJhEbRPA=
X-Google-Smtp-Source: AKy350aRWa5X0xT2Jjw+Q4AZeIBWeG/U+CGrJkyX8YT+NR5j4WqkfPAmXG7X+k2Bg4ugLNvkrRpzcw==
X-Received: by 2002:a17:90b:1c03:b0:240:883:8ff8 with SMTP id oc3-20020a17090b1c0300b0024008838ff8mr26468612pjb.3.1680171349284;
        Thu, 30 Mar 2023 03:15:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090a300b00b0023fcece8067sm2893870pjb.2.2023.03.30.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:15:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
        <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
        <xmqqh6u3d119.fsf@gitster.g>
        <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
Date:   Thu, 30 Mar 2023 03:15:48 -0700
Message-ID: <xmqqa5zu4ka3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> While these patches may make it "work" with zsh in its native mode,
>> because zsh that is running in its native mode is sufficiently
>> distant from the more POSIXy portable variants of Bourne shells like
>> dash and bash, I find it hard to justify the cost of maintaining the
>> resulting codebase to "work" that way.
>
> Why do we follow POSIX anyway?

It is not what we follow that is at the primary issue.

The criteria is more about what our developers are expected to be
familiar with, and what is reasonable to force our developers to
become sufficiently familiar with.  Even among POSIXy Bourne
variants, dash being stricter than bash already gives some new
folks, who only know bash, things to learn to avoid.  But at least
what they learn through such an effort would help them write more
portable scripts.  It is my impression, however, that zsh in its
native mode is even further out and away, pushing it on the other
side of the line of being reasonable to force our develoerps to
adjust to.  What they will learn through such an effort would be
more of "what to do when you are forced to use zsh" than "how to
write your shell script portably".

> In truth all the patches regarding shell portability have been along
> the lines of: "this code makes $x shell work, doesn't break other
> shells, and isn't against POSIX". In some cases even when the Austin
> group disagreed on what POSIX actually said, we did whatever worked in
> most shells.

One aspect that is missing in the above is the extra burden on our
developers.

> Is there some sort of predisposition against zsh?

There isn't.  If somebody makes the tests to also work with csh or
/bin/sh on SunOS, I would pretty much say the same thing.  The
end-result may work perfectly well, but the cost to maintain it
working over the long haul may be too high for our developers.
