Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB15C10F1E
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 21:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLOVRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLOVRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 16:17:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4F54346
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:17:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 124so511069pfy.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG9gQkOQPJHnNhWdA6x8pw/Hibffem7Z0cMEGxsu8ho=;
        b=hEgj51xqauanM4Vee9YEFtbE+xuS3/CNkAFXjK9yDhkAQtKECn0XBR3IQeZfPRDeg5
         pYiVsNRNxCQytkTUx7HcZA1BAj+fTkdRG6/l0IzdStuVjlgxWHPHJK72oYLBjXu0l/4n
         atZuvlV/sdZdRGIlyNZkqM1jRptNubVUvsy2FKRw96xicbEs+zzCw7GP8qSSn0r9nbQe
         MGLnmzcfdtMZkb8QE+fRlHuv1Q3GHoBJ1/ehrouCxWeP2Kanv1aW4I5l9XlKKcSfaLX1
         EhAQ98zZXIEAMi6stGIP90eBKCMo77cBMN6qiDnsG+YIr77IC2Lym6NADo0e5o3S+Rtm
         724A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zG9gQkOQPJHnNhWdA6x8pw/Hibffem7Z0cMEGxsu8ho=;
        b=W8zJq4yRR8zQu4/vsO9aDUvYHw06sB6oz4w8aRGmek+3Q83B9FMNo+QYRyTLIqip/D
         fpNCP75v4ezC3kTyMLIYULaLhROmOFb1tICpAvF5rram5f2HvAHea7ZO/sxmv0BSzmlG
         bWnSpNfR2YJmB8RrIuRcMN4xJacvnLt8m5AVbXnCa2zUNSDHXzdaFb04E9PsYWWVT+40
         vmqzgJhJuidDZ2hx72FG9iBz2cVJxNLwhQz3ndiKZjae9y3kfJm8TmSTXfWMUPyLYYCT
         xPy8bNb2ngxT5ecptmDP7BW2RnXkwNzWfBqbYo5zpMWhHitdr0PArLhKu4RlK3qFzv00
         C6Ug==
X-Gm-Message-State: ANoB5pmV1mzmPXOD9cVXXU4MJpdaTnH2yTD/LC1cFoT58Y1wd0NhoPmN
        Birt7BObl9EewaTU3iluCpk=
X-Google-Smtp-Source: AA0mqf7FhyUY+KXt9MAqPIjQztQHITGiUEUC93qdpwbX9/9SnKoZ5VGbxFmdn5z5wMYph+DMLcf8dQ==
X-Received: by 2002:a05:6a00:1988:b0:577:49da:6074 with SMTP id d8-20020a056a00198800b0057749da6074mr38782061pfl.19.1671139037652;
        Thu, 15 Dec 2022 13:17:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b005767cb32fdasm37561pfb.188.2022.12.15.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:17:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2] Makefile: use sha1collisiondetection by default on
 OSX and Darwin
References: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
        <patch-v2-1.1-3de7cdbd260-20221215T084129Z-avarab@gmail.com>
Date:   Fri, 16 Dec 2022 06:17:16 +0900
In-Reply-To: <patch-v2-1.1-3de7cdbd260-20221215T084129Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 15 Dec
 2022 09:43:05
        +0100")
Message-ID: <xmqqlen8s6xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Let's also use sha1collisiondetection on OSX, to do so we'll need to
> split up the "APPLE_COMMON_CRYPTO" flag into that flag and a new
> "APPLE_COMMON_CRYPTO_SHA1".

That's well reasoned

This leaves these in Makefile:

        # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
        # and do not want to use Apple's CommonCrypto library.  This allows you
        # to provide your own OpenSSL library, for example from MacPorts.

        ifndef NO_APPLE_COMMON_CRYPTO
                NO_OPENSSL = YesPlease
                APPLE_COMMON_CRYPTO = YesPlease
                COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
        endif

Because we only mention what it does to use NO_APPLE_COMMON_CRYPTO
here, without promising anything about what happens otherwise, we
can do this change without breaking any promises ;-)

However there is this bit:

        ifdef APPLE_COMMON_CRYPTO
                LIB_4_CRYPTO += -framework Security -framework CoreFoundation
        endif

So, if one says 

    make NO_APPLE_COMMON_CRYPTO=NoThanks APPLE_COMMON_CRYPTO_SHA1=YesPlease

presumably the end result will fail to link?  I _think_ that falls
into "if it hurts, don't do that", and 

 (1) automatically disabling the latter when the former is set would
     be more confusing than helpful.

 (2) explicitly detecting the situation and issue an error message
     from the Makefile might appear nicer, but if the linker does
     the failing with a messaage fine, that would be sufficient.

so in the end, the posted patch as-is should be fine, I think.
