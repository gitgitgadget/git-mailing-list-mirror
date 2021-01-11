Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24874C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA8122795
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbhAKPhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAKPhH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 10:37:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED5C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 07:36:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id bd6so7539733qvb.9
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 07:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AgJKbQcZJp66EfPtMIksUPsvMH9e0epzh7cNzioG0N4=;
        b=NeNtgkbpWEhdLli+1guDsG/UQQAC9bHjVvfNtD3GWy9s18biBlpk5fcw03FTjY6rE9
         2ud68zy/gSCKEYF/YOIAacQJZC6PZJts5DrbALX7FngkzoHwj/PIWXJXlYB4gYsR8TWh
         FnkCD56EyhYtj2C0KH6ZaZZTXdDtYfVKDMl3KvIhr+al7P91Sg4GwgTvar5nu+v9F7xJ
         TYlJ8jWqubHLAV469wFR96yMlBhXgrCKZ5n91eB36f+Co3hAKfxu4SYNkUAXZUR5YP3H
         edzy/qeLW2GGrq17v2JyXzqdOm097EfNW2CZhw/qXOB3rUdPWgs/G42x4b/cspTIG1UE
         dsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AgJKbQcZJp66EfPtMIksUPsvMH9e0epzh7cNzioG0N4=;
        b=gq5E8anGEEahj5ZhmtQgDA/+E42EXWoeHtqy0nLGxdXsWsNlBJLIeQv8LwCZB5f9hk
         25E3RKhOaREA1laZtxH/TRgeRtr6fYZE7bd0jASDh+v1WotEBa8F0+1MavO4aAsyiFST
         ue3kjdig8CdhLlrmS9zr2/3MNOmm0xOuEqkbJ9KVgWa8G1/JOV/EJ2R7ANOIegc0Hj35
         lkf/VPKiaQpnxxu0z0DG47t3BGl59bK6YYDGIw+R+BdM/xMpFahs0vfCQvcNWAyMjkEE
         zFEQ3F4KW2aiDWk8q2ywYy+Ros4T/EkNQYpZT4Gc05xQl61JMigiQ1BpHkxsy6opd64P
         rrvA==
X-Gm-Message-State: AOAM532njLeX7ZQizLapC2jcK2Nvqf1mKyz/K2mfaIfV1+WpA/PsCiul
        n1vZ94hgys2ck9GjePLarNmSL1wiIHSP6A==
X-Google-Smtp-Source: ABdhPJyV0xOCEalwJKbJ8zoODl8AOq2bAUv4VKQ3yc3//azV4nLMEr0XmHQvJwGeJYY4GhpWvAXNZA==
X-Received: by 2002:a05:6214:4d4:: with SMTP id ck20mr88033qvb.54.1610379386098;
        Mon, 11 Jan 2021 07:36:26 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id p6sm7913202qtl.21.2021.01.11.07.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:36:25 -0800 (PST)
Subject: Re: Fwd: error: 'submodule' does not have a commit checked out
To:     Aleksey Midenkov <midenok@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAF8BazBFsR5yQ0M5wscCfE-KuXTGZ=i4-1gP9NZZvjCfAD5NrQ@mail.gmail.com>
 <CAF8BazC1kEV+s7vDSAkqcvjYVTCyDaw8gi0ZHpH7K+3Q4CAczA@mail.gmail.com>
 <CAF8BazDLhgtgt1jCD7B64ytguF-NYL60nDS9F8nxbRhhbfX7Cg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f8443c4c-2a1a-0f58-1086-9d19ae447074@gmail.com>
Date:   Mon, 11 Jan 2021 10:36:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAF8BazDLhgtgt1jCD7B64ytguF-NYL60nDS9F8nxbRhhbfX7Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aleksey,

Le 2021-01-11 à 09:44, Aleksey Midenkov a écrit :
> I used to update last commit with new changes:
> 
> git commit --amend .
> 
> The project has several submodules:
> 
>   e116c89a58af750421d82ece13f80516d2bde02e extra/wolfssl/wolfssl
> (v4.3.0-stable-596-ge116c89a5)
> a746c3af449a8754e78ad7971e59e79af7957cdb libmariadb (v3.1.3-121-ga746c3a)
> b6b02ed516f92055127d416370799d91a82754ea
> storage/columnstore/columnstore (columnstore-1.5.3-1-14-gb6b02ed5)
> -d172e86c16224b4e0229ca6f102e662a2315aeff storage/maria/libmarias3
> -bba5e7bc21093d7cfa765e1280a7c4fdcd284288 storage/rocksdb/rocksdb
> -ae4e58ba031587039c8830f2f8ca51fa9fb7d6eb wsrep-lib
> 
> Now it fails with this message:
> 
> git commit --amend .
> error: 'storage/maria/libmarias3' does not have a commit checked out
> fatal: updating files failed
> 
> How to use amend without specifying explicit paths without
> initializing submodules? I don't need to amend submodules and would
> prefer them ignored in my commits.
> 
> git --version
> git version 2.27.0
> 
> Works as expected in 2.19.1


I can reproduce the behaviour. It was introduced in f937bc2f86
(add: error appropriately on repository with no commits, 2019-04-09),
in Git 2.22. I think that commit and the rest of that topic,
4ab701b2ee (Merge branch 'km/empty-repo-is-still-a-repo', 2019-05-09),
are sound.

For your use case, if you want to amend the latest commit and include
changes from all tracked files, you can simply do

     git commit --amend --all

or shorter:

     git commit --amend -a

The only difference with what I think you wanted to achieve is that
any *new* files will not be added by '-a', only changes to already tracked
files are included. If you have new files that you also want included, then
you would need to 'git add' them separately.

Reading the doc for 'git commit' [1], it appears that

     git commit --amend --only

would also work if you want to only include changes to files that were
already modified in the commit you are amending. I haven't testes that
though.

Hope that helps,

Philippe.


[1] https://git-scm.com/docs/git-commit
