Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BDAC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE7161261
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhEVLRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 07:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhEVLRp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 07:17:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C5C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:16:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so8677424pjp.4
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p5EIoodyme8MepPJfdQaVnOjyhbtn4qvvoGV8aliQxA=;
        b=Cv8VDG10rSFb4reMhtsX9ae+AZAAtGPkuOcXUjt5vK8Yi5PIZByFkGtjs397/KBtZ3
         1LjqK1Rhj+8CcBJMby0JxfshRlDpW2TtULHZA3nswI+EYJARFvw1lp6AVkMGyDWWLilI
         Ga/62ePlLREn/CIKWBDcOhnbAeCO5qJeRoRft/o+F79ynHGup0B9bEKIRfcNdlwzrakH
         7oI//zEyhRmGvzOqqhVLRiyavtS78umQrgE9z08dj0keOIqn+C8Q8G9OIlpkAkkJrxAe
         p3RXGxeZBYUxKFl2QvE7/VbHkkMtvoZIfa8cyOowX3kDlHKAi5Ses01dzOnFWXWPCCRJ
         bxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5EIoodyme8MepPJfdQaVnOjyhbtn4qvvoGV8aliQxA=;
        b=jZk/p6Y7w+56W7Blwn0/6JNNT7IogysBMXe9+dDOdtZdTRjugush2ooUZfuGR9WIn2
         9iLW/kd03Y727XtowIneaRsDIt8kCcg1Rmdx4HG1rQisUfHHOg16Var/WB51zNoBjYAV
         1JbEAd7nx97jOoTekA3u8M5UVNDxM1lQn3cZePdImfX/moe0arxnIWjHy2s/M/7XKsWG
         ilyw4P15k6/pUVFhRDq2LxC1e5THXIsbUD3RicXH8jqpghoaWHAdLNyZMosb7sbz6sAH
         HolkcHGwB6WlkEOv+qpGKl40omijH70NSkYShtlDR5TaOHnb3vyXpgt8PFjA8/u56o/F
         h9Hg==
X-Gm-Message-State: AOAM5328VFLP31k0hNbP6bYsAEugAoMfEKsg1dBxE8E143kmoAhVdRyf
        cPGhVIpqqjz8hlCwozngf0j25prPqSPrrA==
X-Google-Smtp-Source: ABdhPJxaPG8JWHFsxHZgHi/xE/TfMiV617gEsXr3ALdS68KPQjph0uiZKUpHqPIOBAYNXmKfplomsA==
X-Received: by 2002:a17:90a:fa17:: with SMTP id cm23mr15104437pjb.100.1621682180084;
        Sat, 22 May 2021 04:16:20 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id s14sm7023711pfs.108.2021.05.22.04.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 04:16:19 -0700 (PDT)
Subject: Re: git repack on shallow clone of large repo (linux kernel) hangs at
 "Enumerating objects"
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
References: <c98e51b0-d89b-9170-e3bc-69ac9ec5e114@gmail.com>
 <YKIulliGp8hyf5Y6@coredump.intra.peff.net>
 <158a2f8c-95c0-075a-4cda-6328324c2261@gmail.com>
 <YKOuHLWmJ3jktpyA@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <168567f7-cec1-a4f1-5b2e-b51637ab7668@gmail.com>
Date:   Sat, 22 May 2021 18:16:15 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKOuHLWmJ3jktpyA@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, sorry for long reply.

On 18/05/21 19.07, Jeff King wrote:
> You need "strace -f". The parent repack process spawns pack-objects (via
> the clone() call above), and then waits for it to print the name of the
> generated pack at the end. So it will stall on that read() for quite a
> while, even under normal circumstances.
> 
> -Peff
> 

Now on my clone, git count-objects -v says:

> count: 0
> size: 0
> in-pack: 3469192
> packs: 7
> size-pack: 2181233
> prune-packable: 0
> garbage: 0
> size-garbage: 0

And I have 60211 commits, with the oldest tag available is v3.15-rc3.

Here is excerpt from strace -f just before I triggered SIGINT due to hang:

> 22903 openat(AT_FDCWD, ".git/objects/3b/tmp_obj_24pz93", O_RDWR|O_CREAT|O_EXCL, 0444) = 3
> 22903 write(3, "x\1+)JMU0421d040031Q\320K\316I\314K\327M\313/\312M,"..., 1113) = 1113
> 22903 close(3)                          = 0
> 22903 utime(".git/objects/3b/tmp_obj_24pz93", {actime=1621599665 /* 2021-05-21T19:21:05+0700 */, modtime=1621599665 /* 2021-05-21T19:21:05+0700 */}) = 0
> 22903 link(".git/objects/3b/tmp_obj_24pz93", ".git/objects/3b/816f00a02062692e95a9a756247fca34abb911") = 0
> 22903 unlink(".git/objects/3b/tmp_obj_24pz93") = 0
> 22903 access(".git/objects/3b/819396230eda4ce9be9fbb2c91c13ebb28e8d3", F_OK) = -1 ENOENT (No such file or directory)
> 22903 getpid()                          = 22903
> 22903 openat(AT_FDCWD, ".git/objects/3b/tmp_obj_yrHAe4", O_RDWR|O_CREAT|O_EXCL, 0444) = 3
> 22903 write(3, "x\1\224}y<\324\337\367\377(\205\262E\226\262D\205T\0233\214=\n!\25\205R\22\306\314`"..., 4096) = 4096
> 22903 write(3, "\365\16\236\215!&\37 \v\300\240\334\33r\266/_\317Hg,\333\356w\366\235\307\245<E\347\t"..., 4096) = 4096
> 22903 write(3, "\362\367\267\224Pc\207\252!\240$\"\26\212\204\22\2315\245\255\357j\373f\316G9\352[\r!\326"..., 4096) = 4096
> 22903 write(3, "\305\vC3\253\217\343\17kl>v\200_\226Y\206\247\21@\327mi\310\177{7{i\214w\243"..., 4096) = 4096
> 22903 write(3, "@X\17\213\304\307z\232v\355\313y\316,\342\202p\"\343|x\306\306<\335DM\350\315!m\207"..., 4096) = 4096
> 22903 write(3, "'\253R\33\267\310p\3\332\201\333\316\254'\3114\347\277\0321\35\223\314i\255v\252X{[r\33"..., 4096) = 4096
> 22903 write(3, "\261\341a\252\355\360\356\340\375A$\214\377\336O\311A\215\327\5g2\\\324\332\276\363\323\306S\215\342"..., 4096) = 4096
> 22903 write(3, "s_n83S\326\224]H\271\246-\267\35\32\234\6s!\273\177\30\256k\\eW\355E\264^"..., 4096) = 4096
> 22903 write(3, "E\0266\37\30244Mtk9\310\305\227\370\245\355qwUi\363\237\302\347S\4Xp\342\330\370"..., 4096) = 4096
> 22903 write(3, "v\267\303B\177\232v{\342\353\1\340A\205[\336\266\250_e\346\347e)\212^\241]\263\233\270\323"..., 4096) = 4096
> 22903 write(3, "\325dA\266\333\221\274\32\367\277\271nh\327\276\272C\323-E\242\351\232\352\303]|\335\227\227\200\301"..., 4096 <unfinished ...>
> 22902 <... read resumed>0x5594d878b7b0, 4096) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
> 22903 <... write resumed>)              = 4096

The last write() sequence seems running repeatedly, what it means? Infinite loop?

-- 
An old man doll... just what I always wanted! - Clara
