Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F97FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AB761BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhKQKY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhKQKY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:24:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A39C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:21:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r11so8678036edd.9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eYQswFbgGTMKmXH+andCQ5tNuM/XGFpivxk3uyWDRFY=;
        b=g6FPsphPw8JrDabWLSaRXsk4ZDsALrxg6ROu8fsIxIRR4SLKKHfQmFBraXamPWgWsg
         sU+dRX+GAiSd3gmErsO4V7rtnlhDNxc7+Y1pJFe9qox7js/x5MQM432aRQXWnoNhvSwm
         Z+RfYR7E3Hun4DLCZRKAlhp8Mn0125h+wIONyxIYnxoK1doWpiCO0OR0JrC3qQZGd9nG
         v4e53za1q90hmEM9HZajE8HnOOGSxQUR+VNo4bMdT1F9NEANNCxHy4qqyEZw681FnIGZ
         ZeeiS+hZpTn1MeWusPLDoja3bW4fiIzsImRWR7UXujx64Bc5Ae/Er5Gwi/A0Cd5sDeso
         ZUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eYQswFbgGTMKmXH+andCQ5tNuM/XGFpivxk3uyWDRFY=;
        b=dAyqvTLC9RDbdgRKS7dxRhcWFw1gspzmmaXprti0Mi+G4LyEUcvkYYE4J0jIXEp+B8
         R43RVyoG24aZrdF+znAvpIG289+s6FOBtcY8QgW3yNIbrRs6z4/g29yJlyysGU5edRWu
         FIYSQPYE84Y1hyV/b0635KtleQcJ+Blv0zaWKDVc2gL5rig6r12pSi8WrO6J6mgzfNiv
         IFGEDlVGmDhYPdFbTY3YUPNw9gbQdaC77uwcOdtzSQEYoP2RTlRpEATf8h3pEQH8eRmh
         7TvpO1BY/065zeZKtgb8xBgagSouAVU676pg3GKLgKnnY17yHInyTcT4DbVTvVCRY/1P
         62AQ==
X-Gm-Message-State: AOAM533q8maiuAqZoBqnXjV86J0KHeo0Dk1KJX4gSrMhCSBN1b7WU6YQ
        fbXuT3sftJ7q6JgcD2H2geI=
X-Google-Smtp-Source: ABdhPJzhknExQJnEaJ6hJYuHWMUNV04eAX7aXjBOTbQsIU09QUSFBivNcuZaFAwfVjEDF3p3cD2XKw==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr5039277edz.96.1637144517083;
        Wed, 17 Nov 2021 02:21:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e4sm10092595ejs.13.2021.11.17.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:21:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnI4i-000601-0L;
        Wed, 17 Nov 2021 11:21:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
Date:   Wed, 17 Nov 2021 11:21:02 +0100
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
 <20211117033938.r3wsv3znxva7smgy@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117033938.r3wsv3znxva7smgy@glandium.org>
Message-ID: <211117.86o86j6q0s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Tue, Nov 16, 2021 at 10:18:14PM -0500, Jeff King wrote:
>> On Wed, Nov 17, 2021 at 08:25:55AM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>>=20
>> > * builtin/bugreport.c includes hook-list.h, hence generated files from
>> > it must depend on hook-list.h
>>=20
>> Good catch. This is trivially reproducible with:
>>=20
>>   make clean
>>   make builtin/bugreport.o
>>=20
>> The problem comes from cfe853e66b (hook-list.h: add a generated list of
>> hooks, like config-list.h, 2021-09-26), as you might expect.
>>=20
>> > diff --git a/Makefile b/Makefile
>> > index 241dc322c0..413503b488 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -2222,6 +2222,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLI=
BS)
>> >=20=20
>> >  help.sp help.s help.o: command-list.h
>> >  hook.sp hook.s hook.o: hook-list.h
>> > +builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-li=
st.h
>>=20
>> This fix looks correct. I grepped for other similar cases, but this is
>> the only file that needs it.
>>=20
>> Curiously, the existing hook.c does not seem to include hook-list.h,
>> even though you can see a dependency in the context above. Nor does
>> help.c, which gained a similar dependency in cfe853e66b. Those seem
>> superfluous, but maybe I'm missing something.
>
> Neither does builtin/help.c. This was discussed in the subthread
> starting at https://lore.kernel.org/all/20211115220455.xse7mhbwabrheej4@g=
landium.org/
> and is covered by https://lore.kernel.org/all/patch-v3-19.23-234b4eb613c-=
20211116T114334Z-avarab@gmail.com/
> (to which I responded that the line for hook.o can be removed too)

I've got an updated patch in my just-re-rolled Makefile dependency fixes
series for this isuse, which also addresses the needless "hook.{sp,s,o}
-> hook-list.h" dependency issue:
https://lore.kernel.org/git/patch-v4-19.23-2710f8af6cd-20211117T101807Z-ava=
rab@gmail.com/

Thanks again for looking all of this over & helping to make the Makefile
better.
