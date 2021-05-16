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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF413C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2761151
	for <git@archiver.kernel.org>; Sun, 16 May 2021 13:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhEPNLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPNLP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 09:11:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A242C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 06:10:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g18so1508672pfr.2
        for <git@vger.kernel.org>; Sun, 16 May 2021 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=G8V4qH8dvkiE8u9ScYeVelm5FQ4zMAZzf27vHWkeC7Y=;
        b=oxy/o1PihY5egGP9uu/xGHFGFolb2MlcKHtrWQUrjX3deWCpiAwgMiqQQiAPJw4lJ2
         9tiC4eVcGrHvJNrMcJ1As1r+Tw+ct9bDv3zegKZptJGyKzCkcpCOqhJ3S9Lc4Xy2xfEb
         oj9FNL8P4iJwQzfes8Xoj4/G4y1OAeVvMbVFVYa36f8jrtt4+4Jxyq3Ln+Qd1KAhY+eW
         79fxk682Zcx0yxtkCN0/3XReT0tA0DzNCDmRxLHQum3rzJobxiJ3YgzZ3jrxKqjIpwDS
         RiSFcZ3guZbTX55oNtothMPxO62HDJW5E+Jznw1fuuTFdVhKAAEbXpmUYcOKwfe6P207
         xvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=G8V4qH8dvkiE8u9ScYeVelm5FQ4zMAZzf27vHWkeC7Y=;
        b=YSd5iXb1as3gzx4eyVLPFKPBMb664tLopTOcjWFnWn+8pxhoK/13axp9nNTlkh3WEb
         CpygOMlXZXk3IVGG/DPApz7gb9z5MgVIy43JfCmZBUKzsWB4Modxy9URmydVyrjejZC7
         rPPYvadjzw0Z3C5u65C0vbFZYuTc5NnBXywopcBM8xqCDM3z2HLN2gMaCzml8WifzsjM
         Lc0bryyqJXEHYBS6mvnVeHGxV33dWOVBfhxfWo/HqmqIzXqL/r7kv87MpdeiI+Xmw+3A
         BX/ERZ9QQrr3+MSZgclUhVaq4YqYg7r+xd3Jhma8T0xDsqqXQpbTnOif0IolYVnWTm9z
         JHkA==
X-Gm-Message-State: AOAM532EP5CpBLx3yYaHf/2a6J/R4y6vkBNWG/ElfBnmJw461b3Tab+v
        DeK4/3hoXSttUZhLr+6JBOeFRrICJxiRLA==
X-Google-Smtp-Source: ABdhPJyE1qcHrMO5GxAtv85HnEZqKIcc4bQLtGscgUTBA23t0txW5no8DSDqPIlcc7pQ7ToVqkj3ug==
X-Received: by 2002:a65:6843:: with SMTP id q3mr25560798pgt.453.1621170600158;
        Sun, 16 May 2021 06:10:00 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id z13sm8249377pgc.60.2021.05.16.06.09.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 06:09:59 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: git repack on shallow clone of large repo (linux kernel) hangs at
 "Enumerating objects"
Message-ID: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
Date:   Sun, 16 May 2021 20:09:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a shallow clone of linux-stable repo [1] on my computer. Now
I'm trying to repack with `git repack -A -d`.

Before repacking, here is the object counts on my clone
(`git count-objects -v`):

> count: 0
> size: 0
> in-pack: 3162206
> packs: 17
> size-pack: 3120393
> prune-packable: 0
> garbage: 0
> size-garbage: 0

And I have 41496 commits (only on master).

And here are relevant config used:

> pack.deltacachesize=120M
> pack.windowmemory=400M
> pack.packsizelimit=650M
> pack.autopacklimit=0

When I trigger repack operation, I expected that all objects on 17 packs
are consolidated into several 650M-sized packs. However, in my case, repacking
was hang at "Enumerating objects" stage, that is I stuck at:

"Eumerating objects: 902036"

I also try to reproduce the issue with other repo, such as with local copy
of GCC repo on my computer [2] using similar config, and the repack succeed
without any errors.

Am I missing something?

[1]: https://github.com/gregkh/linux
[2]: https://github.com/gcc-mirror/gcc

-- 
An old man doll... just what I always wanted! - Clara
