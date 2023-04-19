Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD92C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjDSQHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjDSQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 12:07:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582EE1980
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 09:07:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b87d23729so54378b3a.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681920435; x=1684512435;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Icc5fT5yQmsqxx/csCCgfJrYRYus4+EdQKbOPCs5FhQ=;
        b=f0VqABiV9g6GabpcXO8sekYMY9kWhMooJibcIpzUMscTdN0g0KXfC/qZNJa7VjUiLb
         PpUoAFt0Vk4pVM/8exLe7HL07flcRGaJ0iQeeXm9B74KO0KgHRQmz9dtGx2bv3aAroOE
         W4IOpfeeCrnllJF5rS73ytgXAF+DzJcI1DMrcBuXnfMKzaJkiD9gANt4wFcTPU83JNN1
         r+AmI5++JVB5ZqiMFw3XdILflsLv2/PSB+032bpIVKMd8umX+rcUb3pjH/sS8YQnrz91
         IgHPRN1pRg6jUREmT4Daq4TdLlJvQVZW3eCMdsxSkTe2R1IfELHSJuWeqU0mppLJMfoe
         8VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920435; x=1684512435;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Icc5fT5yQmsqxx/csCCgfJrYRYus4+EdQKbOPCs5FhQ=;
        b=W7Q5d92oexVraQjY1Vjb5G3tfYX5tdXvuLOvfEyZYtGNs7GMTLWvEP9SemQqY0ZIBY
         WUGeIzrvC50dL7y7Q5H7XUly0/AsLahpFM4qT4cGnRa3W2ypAjwvKER6JAR81vxXP5/k
         12KELA7Op4EGRiutz4QaSWc9F1zan+ECs97xk3WyDLybUi02qvMyq9WrEtcOeoVV1+7U
         E1/YfXXTtDHa/a1r+OYg/BVYYmdI8ORpVDbs6IWKsMfWeTmBy2lAr7CFolAspd1czC03
         UOsP4gWTBLEI6zNSAKljEgNDcyuw6vBrCAVQ36eyxSPBVKJcrqmqJvoY6St7RTHWk+Lp
         Fx8w==
X-Gm-Message-State: AAQBX9dwd35XRxX6bf7FUPGHCPFp/+IiWisFQlWCUyaVwX5DxZNj/pgV
        HbmL9aAK/9p2vfd+LMUMwxk=
X-Google-Smtp-Source: AKy350YJJ54zawvuXUI2zhigbsuWgdZfp6pKBiTteiOXuMDnas3pAkwoyFyFjiqvd2jprC5EYjIKtw==
X-Received: by 2002:a17:903:1110:b0:1a6:dba5:2e3b with SMTP id n16-20020a170903111000b001a6dba52e3bmr6788595plh.29.1681920434121;
        Wed, 19 Apr 2023 09:07:14 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709027e4e00b001a664e49ebasm11438481pln.304.2023.04.19.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:07:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Samuel Ferencik <sferencik@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
        <xmqqk03jcwxz.fsf@gitster.g>
        <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
        <xmqq7cuamjmu.fsf@gitster.g>
        <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
Date:   Wed, 19 Apr 2023 09:07:13 -0700
In-Reply-To: <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de> (Johannes
        Schindelin's message of "Wed, 19 Apr 2023 14:22:50 +0200 (CEST)")
Message-ID: <xmqq354vama6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > 2. casing (use of `/i`)
>>
>> My preference is to do this case sensitively (in other words, start
>> stupid) and if somebody wants to use "/i", add it later after the
>> dust settles.
>
> I strongly disagree with this. This feature is meant for Git users, who I
> must assume based on my experience would expect the value to be
> case-insensitive. I.e. they would expect both `linux` and `Linux` to
> match. Let's not make this feature harder to use than necessary!

[jc: Read below with 'os' replaced with 'uname-s' or any of your
favorite. This message does not take any position on that part of
the discussion.]

I am OK with the above position, if we make sure that all other
includeIf conditions are compared case insensitively, and if we make
sure there is no existing "/i" includeIf conditions.  Then those who
want to differentiate can later add "/casesensitive" option.

But I do not want to see a system where some of the conditions are
compared case insensitively while some other conditions are compared
case sensitively.  The end-users will then be forced to remember
"the condition 'os' can be spelled in any case permutation, but the
condition 'xyzzy' needs to be spelled in the right case".  It would
not be obvious to end users when they need to use "/i" variant in
such a system.

Unlike 'gitdir' whose value is arbitrarily chosen by the users and
the projects (where folks use both FooBar and foobar and want them
to mean different things), the vocabulary of "os" is limited and I
agree with you that it is very likely for any user to expect that
any case permutations of "linux" would mean the same thing.  But
spelling "windows" and have it match even when the official name of
the system may be "Windows" should be the choice made by the end
user, and the "/i" suffix in "os/i" is a way for them to express it.

You might be able to talk me into adding only "os/i" added without
adding "os", though.  I do not see much point in doing so, other
than that we can say "we do not take any position on what case
permutation is the right and official way to spell the name of each
system".

Thanks.



