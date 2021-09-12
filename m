Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F82C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1996108C
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhILLaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhILLaM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 07:30:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E175C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 04:28:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so6540929pgm.12
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IPdRwbTdtK20qojWeQdtufw98NyDxOuN6UfZhagTOvg=;
        b=Hzp4HE/oikUfQPpyXuX8Ijw8cdqEi1BAq7qrI3etFZIyRyLeWg9A8l2aeWZ1fIn/jq
         D99EnwHuf4JzZ7JoeJNadN7EGIfZYV65OrZRwDEujWhH41hNQ22yo8WfjKE8hMW89Cwr
         /uSyMb6iFp1leV739xf1zhGtnv71TFriS+Dc0eEi5WxPPReyXPtiXbPa/HZpBRhAAwtZ
         1R9lM1UZ8nBL99+wiV+G5j2C6yZHPBVjafPuFs/gbDiPLZUC+0cI2nHdrsAw2cwIlT9e
         xBAMhyGE0r9wKu0a1HyCZ0vjLqjqFIAMsO6aNISLAmpTdY/phASNFxNOvx1Z1FpbGIgO
         4x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IPdRwbTdtK20qojWeQdtufw98NyDxOuN6UfZhagTOvg=;
        b=pEC7VjXliIv/m3O6cvBV4+4j2ZtOmfd7XR7HpX/2xBRI1SyVeojI7xsJciWOgdwQ5H
         R+z18TvE6KifjVTzhRQrca3ARjcJz47R5en98OKKxnTJ6mc9Sxi0TXiUVLt9BZr3d5hq
         hzyCq+yGSppCjc8ulU55/DI26eSz3p5sTS973Ep2b8ycAlGlndgRSCpmGF3VxDLeIsGd
         zDS1pvIZF82MM7kAahRJkoriV4nlSMb/OPvW1eNXPjWvt6Xvivm9pFDfZRz4FACNGiTA
         UuHrkjOl1kVzQVdjlJWgptZsYl27e9pjHSpgv/JfME05eqDGYob6PLaT+CyaUHlW+f00
         v1DA==
X-Gm-Message-State: AOAM532Uh0XmonULVE1Dsd5V6zhn2fLvqDX2LizRWIJqkuIpFbsmPD46
        uEuU7PYsa7qIXZE/jZU7BVM=
X-Google-Smtp-Source: ABdhPJw2jiK7D9SOra5mzgWxrP3u3L+HT57PWvz+9ufEsWcBmO9fPO0xvudFMhl99/N+O2LwPdCnQA==
X-Received: by 2002:a63:df0d:: with SMTP id u13mr6276515pgg.417.1631446137551;
        Sun, 12 Sep 2021 04:28:57 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id e5sm3706582pjv.44.2021.09.12.04.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 04:28:57 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
Cc:     Jakub Wilk <jwilk@jwilk.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: git tag -h fatal error with global tag.sort config
Message-ID: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
Date:   Sun, 12 Sep 2021 18:28:54 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I stumbled on Debian bug report [1], and I can reproduce the bug.

In global config (~/.gitconfig), I set:

```
[tag]
	sort = creatordate
```

When I run `git tag -h` inside a Git repository (such as git.git), 
instead of usage summary, I got:

```
fatal: not a git repository, but the field 'creatordate' requires access 
to object data
```

But plain `git tag` works fine.

This bug occurs on v2.33.0 as well as version in the original bug report 
(v2.26.0-rc2) and v2.25.1.

[1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954811

-- 
An old man doll... just what I always wanted! - Clara
