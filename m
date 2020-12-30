Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B5C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FBB216C4
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3HaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 02:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3HaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 02:30:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B748C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 23:29:35 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l11so35876705lfg.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 23:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qmSwChIOEjOXd1BuX5bdvjYt9gRW+1xglMb8VLoMGz8=;
        b=ZfrQQfBOZoPZCepxuJGx9t6V1q8dAtfwr8xWyrq6+QyDu+3U6jk0Xrn0kQ0eedq5Jc
         Q/QSv/c8jaVm04ZR9Hg1pmznULcbJR5tNou3Y6SwgGk2ccP/eZDpTsGZ0BjDW5UpFzTL
         6sjoGEu9mYXfKCWByorVzJRhlNLi+OHghiHL3T5IRkWEv9W+0CxOx3Px9pezQxYS6Ijk
         WIkjkAAZCPE/ZX6aqyyfr1pLHtgRCI8vhadA/OYewGlEa5+KNEXAghOijWIHpz3Z+MQp
         fwNdDR6NuaWYONFn0r8Ek+uHDIuaLnPdFvelvlbQ28nbidvoo9s5RzNUKHsEhmPnZfBc
         7peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qmSwChIOEjOXd1BuX5bdvjYt9gRW+1xglMb8VLoMGz8=;
        b=OI/kKaNYg1zipIDwo6Ld37KmiEZuUKsht8pKSxr3qLxFMh6IjNpxJEqIUEXc52mLDD
         c33HPUs0t4+09aPTaaI28JEwiLhcJ2WcK0ICL92B47v2+W8dAXR8mNpTfz8mH20rdN7l
         JZF/WGlP8p2ez/gww36k44h+zt6x1HOPATASog2kqWWZf3rG4Ag6LvfD1XZK+wEcOTYB
         q5CRU3lQc5qECJZovbFxGx9+8yUk1yjKA4FjwWSahU5TsdrOtw/gr+rzFeKGqytpWiX0
         ZBwQFHxHZ3qfpYUf1bDv7aGhCXilghyEIHPzcqfet3Za68vjhvkjKwbaeCAqM7qJFtwN
         752A==
X-Gm-Message-State: AOAM5304LeTpcngBdxb64+zDe/ErzaG0EzYsU3/QuvR/inOw6f379sCr
        sbVve9OlEKgXTpYy1kjobD2uJv9yI9cnyg==
X-Google-Smtp-Source: ABdhPJz+EgoUBBRtanNJFOS0Xc9hrIArxmOlx6wend5EHX1x6DhVVgtG/u50F6iiGZCO2NDv2aNpIw==
X-Received: by 2002:a05:651c:551:: with SMTP id q17mr24761722ljp.311.1609313373676;
        Tue, 29 Dec 2020 23:29:33 -0800 (PST)
Received: from [192.168.21.150] ([81.23.177.213])
        by smtp.gmail.com with ESMTPSA id h126sm5847881lfd.44.2020.12.29.23.29.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 23:29:33 -0800 (PST)
Subject: git show submodule
From:   =?UTF-8?B?0JzQuNGF0LDQuNC7INCf0LDQstC70L7QstC40Ycg0KHQuNC00L7RgNC10L0=?=
         =?UTF-8?B?0LrQvg==?= <motherlode.muwa@gmail.com>
To:     git@vger.kernel.org
References: <ab49430e-5a9f-5910-e048-7f07dca8f898@gmail.com>
Message-ID: <4ddc481f-7d03-e225-13a0-d5fd33456c43@gmail.com>
Date:   Wed, 30 Dec 2020 11:29:32 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ab49430e-5a9f-5910-e048-7f07dca8f898@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru-RU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

git show dose not work with file-submodule. Try this series of commands:

cd /tmp/
git clone https://github.com/abdes/submodule-docker-dev-workflow.git
cd submodule-docker-dev-workflow
git show ee83dd336f27315d14a7ad6ad934897a61e49623:LICENSE | head -n 1 # 
good
git show ee83dd336f27315d14a7ad6ad934897a61e49623:server # bad

My output:

$ cd /tmp/
$ git clone https://github.com/abdes/submodule-docker-dev-workflow.git
Клонирование в «submodule-docker-dev-workflow»…
remote: Enumerating objects: 110, done.
remote: Total 110 (delta 0), reused 0 (delta 0), pack-reused 110
Получение объектов: 100% (110/110), 24.76 KiB | 313.00 KiB/s, готово.
Определение изменений: 100% (56/56), готово.
$ cd submodule-docker-dev-workflow
$ git show ee83dd336f27315d14a7ad6ad934897a61e49623:LICENSE | head -n 1 
# good
The MIT License (MIT)
$ git show ee83dd336f27315d14a7ad6ad934897a61e49623:server # bad
fatal: bad object ee83dd336f27315d14a7ad6ad934897a61e49623:server

It would be convenient for me so that I could see the revision of the 
submodule through git show. Without using the git submodule status command.

Happy New Year,
Mikhail Pavlovich Sidorenko.
