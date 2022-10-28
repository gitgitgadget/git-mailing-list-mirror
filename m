Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EE0C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1U06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJ1U05 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:26:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD61EA562
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:26:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io19so5790704plb.8
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0SJ9sS4xwxTh0LoMXPwZBxK5dwQlM+04JhbLaoP/Tc=;
        b=lEOthgQETwe8X5qfSH8iC4oe9Djh+7JCLGmci0X2e8pZ4JPlnXNQ1aqxc+ISAT4G6L
         96Pm2rpsEzPZTTS27vcjPUWoTW5/88Rj7gWW5rrJ1lRXTvqWgPowI4X2AwcbOT4AN7RX
         LYzZwdQG7eW1Rt9DSnq5vC6wMEZtlTQ0vnmWW9QBZQH3dAnWK9HxZTZc7WlxTObp95Ii
         NDWpj2zyKCNBE8jeoYXPtKVWSVRkPw86Lmapw6rOB3YjO0qTcy7UWD+Sgg6FVpUk2qE8
         p7JYd5bJTmULK+YSi6rT/xAjQaRqkrW/gvm5FaL0YIy/gyWm/VYA5JuCUhDD3dKM9dxJ
         VMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A0SJ9sS4xwxTh0LoMXPwZBxK5dwQlM+04JhbLaoP/Tc=;
        b=N1KxcCX4jHJvLXufL2MI9dGPbcJ1GJci3kAFtCCrDvlZwGJCcvSolSfUcRRz2UfJX0
         tPLSTwVKxkIB9DyfK9giiOkMgjzW0q5EzK+oWMEx+RSv5t8gfSpUS5l8I9B4+bPKqKPJ
         z8Xpq18FYaz3qzjixv3Lz45bRjtA55zni/m8Zw+qY9xsIV/ccwRn4aTGzWWkhL2tRp9l
         vkEg8Itkitt5pdkhfT0NjCi3JsUEDMD45MKz668xOb8Q97X9s5BVAoCAfV4Gtvha9GRc
         W08VD4Z9mTIrMoDDww2tWRK6O+hLxIWwbgCsDzk2gd7VHyIDHIt/hdR73aUjSJ6Oo8M8
         qJiA==
X-Gm-Message-State: ACrzQf3LmqoFKJM7mNTvtZ063RQkSjv4Oi49tirQ5hfWxeWlaorVLegy
        6jSX0aNmeaHT+qhiH167UK0=
X-Google-Smtp-Source: AMsMyM7jCaFYBLbgStnhAob4SEtwn/Al4wfvXSWuTvJh/gEBtkbCoRaajHWeGsHIDPIQOO8AyenG+Q==
X-Received: by 2002:a17:902:d54a:b0:186:e852:6775 with SMTP id z10-20020a170902d54a00b00186e8526775mr796283plf.44.1666988813491;
        Fri, 28 Oct 2022 13:26:53 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b0017a032d7ae4sm1127680plh.104.2022.10.28.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:26:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
References: <20221012135114.294680-1-christian.couder@gmail.com>
        <xmqqilkm9wv6.fsf@gitster.g>
        <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
        <Y1wyVpHprWGxEDi/@nand.local>
Date:   Fri, 28 Oct 2022 13:26:52 -0700
In-Reply-To: <Y1wyVpHprWGxEDi/@nand.local> (Taylor Blau's message of "Fri, 28
        Oct 2022 15:49:42 -0400")
Message-ID: <xmqqwn8jheyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > This feature is, from an end-user's point of view, very similar to
>> > "git prune-packed", in that we prune data that is not necessary due
>> > to redundancy.  Nobody runs "prune-packed" directly; most people are
>> > even unaware of it being run on their behalf when they run "git gc".
>> ...
> If we don't intend to have `git repack --filter` part of our backwards
> compatibility guarantee, then I would prefer to see the implementation
> just live in git-gc from start to finish.

I am OK with that, too.  We do not have to expose the option to
users of pack-objects at all.  Just make "gc" the single entry point
and that should be quite clean.
