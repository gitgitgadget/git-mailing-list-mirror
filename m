Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D495CC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjARXUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARXUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:20:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4764DA4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:20:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jm10so602489plb.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1qtzoK/1hJWR66sKkWb11hVrFwGXVcGCbIPQWJDxM8=;
        b=LvI1U0BuTNPv/xb90LQWzKjU1ROJ+6xvm1uz22vxbs7wqV2H14kd4V8EHgWoXDrDg0
         bwINBPA0VcIP7vf1lg6Mx5dM+FHbvAlcXOg6EJwuHhjM+RartxcKm2hUmTUMTTJy/ePb
         Zh9ZgH0EgapPnslNDHJqncIEQSoX0TXHFwCTcUZAWO0ukJHkC7bboGMTk/iayc7kzmkt
         1rcJDC4coXL9yk7DIg+FPUZatojY8L/kAlpXnfUdxabwFIm38OrnW6WciECrdn0pgAX+
         mFUZxk0EL49yxQBCXvDoiuHaVvid+AaHbAqozN6Tb+W5QDv6TVo+QNSaiUDa7mOjOm86
         L6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1qtzoK/1hJWR66sKkWb11hVrFwGXVcGCbIPQWJDxM8=;
        b=XtjhHZue7ZmcAlsz/xLT7DtFlSQhZ9exSIqQl9HUwap4IFEtox6a34RECBK9me5QB+
         se/tE3gjhmGF+RmLym+ZJqP5Vo0nEdLmOauzMKekHifZWnEqFZwpKHX+HPFzi152NMxp
         6DiqowuJe4K/AF6vZGLXLFhBsvdzGgyHIz9Rw/MyRH3lkDjWvUwAIxYgNvVBRAIqalxa
         wcY5MN4DHHqRGkFtxIbr1PqcszUejfFmeFA8h06rbHm7VupoiE5Mf9st839lGzYFwL+A
         44/U6GtpvAWQEzW9zKA4Aceb/WSNL+Zr1ZoWWf4Hf87w8gcQA/mtRGSsJMP6V5LSG9Bz
         yipg==
X-Gm-Message-State: AFqh2kq7JCQEkhea4Oqy3J81wzJKjpMXxLmYScPcnLtpK7SbligYnEoM
        zg3PnxE23MO1wn9wOtHlMdM=
X-Google-Smtp-Source: AMrXdXuVbu2PpbzDwMyVheS/HzyoeLUqgEPpYXIjCKAemVAK2tjueK9o7M4l9An9SpIbbEq0TcBLmQ==
X-Received: by 2002:a17:902:a9c5:b0:194:60c3:482f with SMTP id b5-20020a170902a9c500b0019460c3482fmr23367675plr.26.1674084035345;
        Wed, 18 Jan 2023 15:20:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00178143a728esm23548881plm.275.2023.01.18.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:20:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
        <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
        <xmqqedrs8igj.fsf@gitster.g>
        <230118.86o7qwxg4e.gmgdl@evledraar.gmail.com>
        <xmqqedrr6cnp.fsf@gitster.g>
        <230119.86h6wnwihp.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 Jan 2023 15:20:34 -0800
In-Reply-To: <230119.86h6wnwihp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 19 Jan 2023 00:03:48 +0100")
Message-ID: <xmqq7cxj4egt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> I'd rather see your reroll with the above addition of UNLEAK() than
>> without it, to fix the breakage.
>
> I don't mind that UNLEAK() being in-tree until a better fix for that
> leak, but doesn't the v5 I sent also address this?
>
> The issue was that I mis-marked a test as passing, when it only passed
> depending on my local compiler (-fsanitize=leak is fickle
> sometimes). Now that we're not marking that test as leak-free there's no
> need for the UNLEAK() for now, no?
>
> Or is there some edge case I didn't spot/notice?

The top-level singleton instance of "filter" that is used once and
never grows unbounded is a perfect use case for UNLEAK().  And with
it, the test DOES get leak-free, so it would be appropriate to keep
the PASSES variable added to the script (until it gets broken
again).

Or did you have any other uses of tools with leaks in the script,
other than the one that is fixed with the UNLEAK()?
